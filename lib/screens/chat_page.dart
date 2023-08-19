import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieverUsername;
  final String recieverUserId;
  const ChatPage({super.key,
  required this. recieverUsername,
  required this.recieverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        leading: Row(
          
          children: [
            IconButton(onPressed:() {  
            Navigator.of(context).pop();
            }
            , icon: const Icon(Icons.arrow_back)),
           const  SizedBox(width: 1,),
          
      const  ClipRRect(
              child: CircleAvatar(backgroundColor: Colors.green,
              
            ),
            ),
           // const SizedBox(width: 10,)
          ]
        ),   
        
        title:  Text(widget.recieverUsername),
      ),
    );
  }
}
