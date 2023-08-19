import 'package:flutter/material.dart';
import 'package:message_live/screens/home_page.dart';
import 'package:message_live/screens/my_profile.dart';
import 'package:message_live/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:message_live/services/gate_auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    //  home: GateAuth(),
     // home: HomePage(),
     home: MyProfile()
    );
  }
}
