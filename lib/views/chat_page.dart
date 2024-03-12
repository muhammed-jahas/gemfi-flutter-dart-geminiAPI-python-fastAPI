import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:gemini_chat/resources/app_colors.dart';
import 'package:gemini_chat/utils/chat_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChatPage extends StatefulWidget {
  String? message;
  ChatPage({
    super.key,
    this.message,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatManager chatManager = ChatManager();

  @override
  void initState() {
    chatManager.initializeWebSocket();
    chatManager.channel.stream.listen((event) {
      chatManager.onMessageReceived(event);
      setState(() {});
    });
    chatManager.imagechannel.stream.listen((event) {
      chatManager.onMessageReceived(event);
      setState(() {});
    });
    forwardmessage(widget.message!);
    super.initState();
  }

  forwardmessage(String message) {
    if (!chatManager.isLoading) {
      if (message.isNotEmpty) {
        final textMessage = types.TextMessage(
          author: chatManager.user,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: message,
        );

        chatManager.addMessage(textMessage);
        final jsonMessage = {
          "text": message,
        };
        debugPrint("Sending text message: $jsonMessage");
        chatManager.sendMessage(jsonMessage);
      } else {}
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'GemFi',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.appBarColor1,
        actions: [
          Image.asset(
            'assets/images/gemfy-icon.png',
            height: 30,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Chat(
        messages: chatManager.messages,
        onAttachmentPressed: () => showImageSelectionDialog(context),
        onSendPressed: _handleSendPressed,
        
        showUserAvatars: false,
        showUserNames: true,
        user: chatManager.user,
        theme: const DefaultChatTheme(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          inputBorderRadius: BorderRadius.zero,
          receivedMessageBodyTextStyle: TextStyle(
            color: Colors.white,
          ),
          primaryColor: AppColors.primaryColor,
          secondaryColor: Color.fromARGB(255, 46, 46, 46),
          attachmentButtonIcon: Icon(
            Icons.image,
            color: Colors.white,
          ),
          inputBackgroundColor: AppColors.greydark,
          seenIcon: Text(
            'read',
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
        ),
      ),
    );
  }

  showImageSelectionDialog(BuildContext context) async {
  final TextEditingController textController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;

  await showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            color: AppColors.greydark,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               
                selectedImage != null
                    ? Container(
                        padding: EdgeInsets.all(20), // Add padding here
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), // Add border radius here
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12), // Add border radius here
                          child: Image.file(
                            File(selectedImage!.path),
                           
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : SizedBox(),
                selectedImage == null
                    ? Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: IconButton(
                          onPressed: () async {
                            final result = await picker.pickImage(
                              imageQuality: 70,
                              maxWidth: 1440,
                              source: ImageSource.gallery,
                            );
                            if (result != null) {
                              setState(() {
                                selectedImage = result;
                              });
                            }
                          },
                          icon: Icon(Icons.add_photo_alternate_outlined, size: 40),
                        ),
                    )
                    : SizedBox(), // Replace with an empty SizedBox to maintain the layout
               
                Container(
                  height: 60,
                  color: AppColors.borderColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: textController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide.none),
                              hintText: 'Message',
                              hintStyle: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (textController.text.isEmpty && selectedImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter text or select an image'),
                                ),
                              );
                              return;
                            } else if (textController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please enter text'),
                                ),
                              );
                              return;
                            } else if (selectedImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select an image'),
                                ),
                              );
                              return;
                            }
                            _handleImageSelection(selectedImage!, textController.text);
                            Navigator.pop(context);
                          },
                          icon: CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


  void _handleSendPressed(types.PartialText message) {
    if (!chatManager.isLoading) {
      if (message.text.isNotEmpty) {
        final textMessage = types.TextMessage(
          author: chatManager.user,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: message.text,
        );

        chatManager.addMessage(textMessage);
        final jsonMessage = {
          "text": message.text,
        };
        debugPrint("Sending text message: $jsonMessage");
        chatManager.sendMessage(jsonMessage);
      } else {}
      setState(() {});
    }
  }

  void _handleImageSelection(XFile result, String text) async {
    final bytes = await result.readAsBytes();
    final jsonMessage = {
      "text": text,
      "image": base64Encode(bytes),
    };

    debugPrint("Sending image message: $jsonMessage");

    final image = await decodeImageFromList(bytes);

    final message = types.ImageMessage(
      author: chatManager.user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      height: image.height.toDouble(),
      id: const Uuid().v4(),
      name: basename(result.path),
      size: bytes.length,
      uri: result.path,
      width: image.width.toDouble(),
    );

    // Add the image message to the chatManager.messages list
    chatManager.addMessage(message);

    // Update the chatManager.isImage flag to true
    chatManager.isImage = true;

    // Update the UI to show the selected image
    setState(() {});

    // Send the message
    chatManager.sendMessage(jsonMessage);
  }
}
