import 'package:belal/screens/chat_page.dart';
import 'package:belal/screens/registre_page.dart';
import 'package:belal/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(chatApp());
}

class chatApp extends StatelessWidget {
  const chatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SigninPage.id: (context) => SigninPage(),
        RegistrePage.id: (context) => RegistrePage(),
        ChatPage.id: (context) => ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: SigninPage.id,
    );
  }
}
