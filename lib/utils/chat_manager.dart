import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatManager {
  List<types.Message> messages = [];
  final types.User user = const types.User(id: 'user');
  final types.User bot = const types.User(id: 'model', firstName: 'Gemini');
  bool isLoading = false;
  bool isImage = false;
  late WebSocketChannel channel;
  late WebSocketChannel imagechannel;



  void initializeWebSocket() async {
    try {
      channel =  IOWebSocketChannel.connect('ws://echoes-ai.onrender.com/ws');
      imagechannel = IOWebSocketChannel.connect('ws://echoes-ai.onrender.com/ws/image-chat');
      // ignore: unnecessary_null_comparison
      if (channel.sink.done != null) {
        debugPrint('WebSocket connected at: $channel');
      // ignore: unnecessary_null_comparison
      }else if(imagechannel.sink.done != null){
         debugPrint('WebSocket connected at: $channel');
      }else {
        debugPrint('WebSocket connection failed.');
      }
    } catch (e) {
      debugPrint('WebSocket connection error: $e');
    }
  }

  void addMessage(types.Message message) {
    if (message is types.TextMessage || message is types.ImageMessage) {
    messages.insert(0, message);
    isLoading = true;
      // channel.sink.add(message.text);
      messages.insert(
        0,
        types.TextMessage(
          author: bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: "",
        ),
      );
    }
  }

  // void onMessageReceived(response) {
  //   debugPrint("Received message: $response");
  //   if (response == "<FIN>") {
  //     isLoading = false;
  //   } else {
  //     if (response is String) {
  //       final newTextMessage = types.TextMessage(
  //         author: bot,
  //         createdAt: DateTime.now().millisecondsSinceEpoch,
  //         id: const Uuid().v4(),
  //         text: response,
  //       );
  //       messages.insert(0, newTextMessage);
  //       print(messages);
  //     } else if (response is types.ImageMessage) {
  //       messages.insert(0, response);
  //     }
  //   }
  // }
  void onMessageReceived(response) {
  debugPrint("Received message: $response");
  if (response == "<FIN>") {
    isLoading = false;
  } else {
    if (response is String) {
     
      if (messages.isNotEmpty && messages.first is types.TextMessage) {
      
        final lastMessage = messages.first as types.TextMessage;
        final newTextMessage = types.TextMessage(
          author: lastMessage.author,
          createdAt: lastMessage.createdAt,
          id: lastMessage.id,
          text: lastMessage.text + " " + response, 
        );
        messages.removeAt(0); 
        messages.insert(0, newTextMessage);
      } else {
     
        final newTextMessage = types.TextMessage(
          author: bot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: response,
        );
        messages.insert(0, newTextMessage);
      }
    } else if (response is types.ImageMessage) {
      messages.insert(0, response);
    }
  }
}
  void sendMessage(var jsonMessage) {
    if(isImage){
      imagechannel.sink.add(jsonEncode(jsonMessage));
      debugPrint("Message sent: $jsonMessage");
       isImage = false;
    }else{
        
       channel.sink.add(jsonEncode(jsonMessage));
    debugPrint("Message sent: $jsonMessage");
    }
   
  }
}
