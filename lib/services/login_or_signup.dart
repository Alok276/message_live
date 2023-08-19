import 'package:flutter/material.dart';
import 'package:message_live/screens/login_page.dart';
import 'package:message_live/screens/sign_up.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login and signup page
  void togglepages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglepages);
    } else {
      return SignUpPage(onTap: togglepages);
    }
  }
}
