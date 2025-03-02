import 'dart:developer';
import 'package:advertisement_application_flutter/ui_screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../global/widgets/button.dart';
import '../global/widgets/text_field.dart';
import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'map_screen.dart';
import 'client_side_screen.dart';
import 'home_screen.dart';

class SignInScreenUi extends StatefulWidget {
  const SignInScreenUi({super.key});

  @override
  State<SignInScreenUi> createState() => _SignInScreenUiState();
}

class _SignInScreenUiState extends State<SignInScreenUi> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text("Login",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(height: 50),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              controller: _password,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "Login",
              onPressed: _login,
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () => goToSignup(context),
                child:
                const Text("Signup", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SignUpUiScreen()),
  );

  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MyHomePage()),
  );
  goToClientScreen(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ClientSideScreen())
  );

  _login() async {
    final user = await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

      if(userDoc.exists) {
        bool isFirstTime = userDoc["firstTimeLogin"] ?? true;

        if(isFirstTime) {
          await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
            "firstTimeLogin" : false,
          });
          log("User Logged In");
          goToClientScreen(context);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MapScreen()),
          );
        }
      }
    } else {
      log("Login failed");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email or password")),
      );
    }
  }
}
