import 'dart:developer';
import 'package:advertisement_application_flutter/ui_screens/client_side/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../global/widgets/button.dart';
import '../../global/widgets/text_field.dart';
import '../../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../home_screen.dart';
import 'admin_analytics_screen.dart';
import 'admin_map_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
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
      body: Center( // Center everything vertically
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Align widgets in the center
            children: [
              const Text(
                "Admin Login",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 50),
              CustomTextField(
                hint: "Enter Admin Email",
                label: "Admin Email",
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
            ],
          ),
        ),
      ),
    );
  }

  goToAdminDashboard(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AdminAnalyticsScreen()), // Replace with Admin Dashboard Screen
  );

  _login() async {
    final user = await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("admin")
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        log("Admin Logged In Successfully");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminMapScreen()),
        );
      } else {
        log("Invalid admin credentials");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid admin credentials. Please try again.")),
        );
      }
    } else {
      log("Login failed");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid admin email or password")),
      );
    }
  }
}
