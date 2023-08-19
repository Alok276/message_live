import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({super.key, required this.text,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 100,
          height: 40,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 61, 57, 175),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.white),
            ),
          )),
    );
  }
}
