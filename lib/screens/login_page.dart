import 'package:flutter/material.dart';
import 'package:message_live/components/my_button.dart';
import 'package:message_live/components/text_edit.dart';
import 'package:message_live/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.toString(),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      //logo
                      FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Image.asset(
                            "assets/images/login.png",
                            fit: BoxFit.cover,
                          )),

                        const SizedBox(height: 15,),
                      //welcome Text
                      const Text(
                        "Welcome",
                        style: TextStyle(
                            color: Color.fromARGB(255, 61, 57, 175),
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //email
                      TextEdit(
                          hintText: "Email",
                          obscureText: false,
                          textEditingController: emailController),

                      const SizedBox(
                        height: 15,
                      ),

                      //password
                      TextEdit(
                          hintText: "Password",
                          obscureText: true,
                          textEditingController: passwordController),
                      //sign_in button
                      const SizedBox(
                        height: 30,
                      ),
                       MyButton(
                        text: "Sign in",
                        onTap: signIn,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //New user
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("New User?"),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                "Create Account",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
