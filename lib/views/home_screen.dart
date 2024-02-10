import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:gemini_chat/resources/app_colors.dart';
import 'package:gemini_chat/views/chat_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // gotoCreatePromptScreen();
    super.initState();
    
  }
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GemFi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/gemfy-logo.png',
                        height: 100,
                      ),
                      SizedBox(height: 20),
                      HomeDefaultCard(
                          info:
                              "🎲 Let's play a game! Pick a category:\nTrivia, Word Puzzles, or Riddles."),
                      HomeDefaultCard(
                          info:
                              "🏕️ What are the top travel destinations for 2024?"),
                      HomeDefaultCard(
                          info:
                              "📚 Can you recommend the best new books of 2024?"),
                      HomeDefaultCard(
                          info: "💡 What are the emerging tech trends ?"),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            color: AppColors.appBarColor1,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.image),
                ),
                Expanded(
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Message',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage(message.text!);
                  },
                  icon: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 12,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void gotoCreatePromptScreen() async {
    await Future.delayed(Duration(seconds: 2));
    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CreatePromptScreen(),));
  }
  
   void sendMessage(String message1) async {
  if (message1.isEmpty) {
    print('Message is Empty');
  } else {
    final result = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ChatPage(message: message1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
    
    // Clear the input field when returning from ChatPage
    message.clear();
  }
}


 
   
}

class HomeDefaultCard extends StatelessWidget {
  String? info;
  HomeDefaultCard({
    super.key,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ChatPage(message: info),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: AppColors.greydark,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.borderColor,
                width: 1,
              )),
          child: Text(
            info!,
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
