import 'package:eleven_ai/screens/content/dashboard.dart';
import 'package:eleven_ai/screens/user/login_screen.dart';
import 'package:eleven_ai/screens/user/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (user != null) {
            if (user!.emailVerified) {
              return const Dashboard();
            } else {
              return const VerifyEmailScreen();
            }
          } else {
            return const LoginScreen();
          }
        } else {
          return const LoginScreen();
        }
      },
      stream: auth.authStateChanges(),
    );
  }
}
