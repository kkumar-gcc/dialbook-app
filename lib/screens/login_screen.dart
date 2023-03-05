import 'package:edumate/providers/google_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "DialBook",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(2.0),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      Colors.black,
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(
                      context,
                      listen: false,
                    );
                    provider.googleLogin(context);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                  ),
                  label: const Text(
                    "Sign In with Google",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
