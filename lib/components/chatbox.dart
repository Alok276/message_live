import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final String hintText;
  final TextEditingController messagecontroller;
  final bool obscureText;
  const ChatBox(
      {super.key,
      required this.hintText,
      required this.messagecontroller,
      required this.obscureText,});

  @override
  Widget build(BuildContext context) {
    return 
      TextField(
        obscureText: obscureText,
        controller: messagecontroller,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 61, 57, 175),
              )),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 61, 57, 175),
              )),
          fillColor: Colors.grey[100],
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      );
  }
}
