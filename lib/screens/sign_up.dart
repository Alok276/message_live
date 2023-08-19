import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message_live/components/text_edit.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  File? _profileImage;
  var downloadUrl = '';

  //pickupimage
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  void signUp() async {
    //confirmation of passwords
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
        emailController.text,
        passwordController.text,
        //usernameController.text,
      );

      final user = _auth.currentUser;

      if (user != null) {
        // Update the username in the user's document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'username': usernameController.text
          //'email': emailController.text,
          // You can add more fields as needed
        });

        if (_profileImage != null) {
          var profileImage = DateTime.now().millisecondsSinceEpoch.toString();
          var storageRef = FirebaseStorage.instance
              .ref()
              .child('driver_images/$profileImage');
          var uploadTask = storageRef.putFile(_profileImage!);
          var snapshot = await uploadTask;
          downloadUrl = await snapshot.ref.getDownloadURL();
          //print(downloadUrl);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'profileUrl': downloadUrl
            //'email': emailController.text,
            // You can add more fields as needed
          });
        }
       }
    } catch (e) {
      SnackBar(content: Text(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(children: [
                  const SizedBox(
                    height: 45,
                  ),
                 
                  //add an profile image
                 GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(80),
                      ),
                      width: 150,
                      height: 150,
                      child: _profileImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image.file(
                                _profileImage!,
                                fit: BoxFit.cover,
                              ),
                            )
                          :const Center(
                              child: Icon(Icons.add_a_photo),
                            ),
                    ),
                  ),

                  const SizedBox(height: 15,),
                  
                  //sign up text
                  const Text(
                    "Create Account",
                    style: TextStyle(
                        color: Color.fromARGB(255, 61, 57, 175),
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //username
                  TextEdit(
                      hintText: 'username',
                      obscureText: false,
                      textEditingController: usernameController),

                  //email
                  const SizedBox(
                    height: 20,
                  ),

                  TextEdit(
                      hintText: 'Email',
                      obscureText: false,
                      textEditingController: emailController),

                  //password
                  const SizedBox(
                    height: 20,
                  ),

                  TextEdit(
                      hintText: 'Enter Password',
                      obscureText: true,
                      textEditingController: passwordController),
                  //connfirm password
                  const SizedBox(
                    height: 20,
                  ),

                  TextEdit(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      textEditingController: confirmPasswordController),
                  //sign_up button
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    text: "Next", //"Sign Up",
                    onTap: signUp,
                  ),
                  //already a user sign in
                  const SizedBox(
                    height: 30,
                  ),
                  //New user
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text("Already a User?"),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Sign in",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ])
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
