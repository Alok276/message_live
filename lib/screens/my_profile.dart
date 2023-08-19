import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message_live/screens/login_page.dart';
import 'package:message_live/services/auth_service.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
   
  const  MyProfile({
  super.key,});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  //getting the instance of auth
final uid = FirebaseAuth.instance.currentUser!.uid;



  //sign out the user
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => const LoginPage(
                  onTap: null,
                ))));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: myProfile(context)
    );
  }

  
  Widget myProfile(BuildContext context){
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  return FutureBuilder<DocumentSnapshot> (
    future: users.doc(uid).get(),
  builder:
  (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if(snapshot.hasError){
      return const Text("Something went wrong");
    }
    if(snapshot.hasData && !snapshot.data!.exists) {
      return const Text("Document does not exist");
    }
    if(snapshot.connectionState == ConnectionState.done){
      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
      return Builder(
        builder: (context) {
          return Container(
            child: Column(children: [
              const SizedBox(height: 35 ,),
              Center(
                child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(80),
                          ),
                          width: 140,
                          height: 140,
                          child:
                               ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image.network(data['profileUrl'],
                                    fit: BoxFit.cover,
                                  )
                                  ),
                                ),
              ),
                 const SizedBox(height: 20,),
                Text(data['username']),
                const SizedBox(height: 20,),
                Text(data['email']),
          
                    ],),
          );
                }
              );
            }
            return const Text('laoding');
          }
          );
        }
        }
