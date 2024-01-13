import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:gemini_chat/utils/chat_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
 
  final ChatManager chatManager = ChatManager();
 


@override
  void initState() {
    chatManager.initializeWebSocket();
    chatManager.channel.stream.listen((event) {
      chatManager.onMessageRecieved(event);
      setState(() {
        
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('GemChat', style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.black87,
      ),
      body: Chat(
      messages: chatManager.messages,
      onAttachmentPressed: _handleImageSelection,
      onSendPressed: _handleSendPressed,
      showUserAvatars: false,
      showUserNames: true,
      user: chatManager.user,
      theme: const DefaultChatTheme(
        backgroundColor: Colors.black,
        inputBorderRadius: BorderRadius.zero,
        receivedMessageBodyTextStyle: TextStyle(
          color: Colors.white,
        ),

        secondaryColor: Color(0xFF1c1c1c),
        attachmentButtonIcon: Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
        ),
        inputBackgroundColor: Color(0xFF1c1c1c),
        seenIcon: Text(
          'read',
          style: TextStyle(
            fontSize: 10.0,
          ),
        )
      ),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    if(!chatManager.isLoading){
      final textMessage = types.TextMessage(
        author: chatManager.user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: message.text,
      );

      chatManager.addMessage(textMessage);
      setState(() {
        
      });
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery
    );
    if(result !=null){
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: chatManager.user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),

      );
      chatManager.addMessage(message);
    }
  }
}
