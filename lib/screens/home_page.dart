import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';
import 'my_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 61, 57, 175),
        title: const Text("Home page"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  MyProfile()));
              },
              icon: const Icon(Icons.person)),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator());
          }
          return ListView(
              children: snapshot.data!.docs
                  .map<Widget>((doc) => _buildUserListItem(doc))
                  .toList(),);
        });
  }

  //build individual user list Item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final url = data['profileUrl'];
    //display all users except current
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        leading:  CircleAvatar(
         backgroundImage: NetworkImage(url),
        ),
        
        title:  Text(data['username']?? 'no username',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 23
        ),),
        subtitle:const  Text('chats here'),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  ChatPage(
                recieverUsername: data['username']??'no username',
                recieverUserId: data['uid'],
              )));
        },
      );
    } else {
      return Container();
    }
  }
}
