import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ui_screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF4C8C91),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
