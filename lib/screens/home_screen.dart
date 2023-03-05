import 'package:edumate/resources/firestore_methods.dart';
import 'package:edumate/screens/login_screen.dart';
import 'package:edumate/screens/welcome_screen.dart';
import 'package:edumate/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingIndicator();
          } else if (snapshot.hasData) {
            return const WelcomeScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something Went Wrong!'),
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
