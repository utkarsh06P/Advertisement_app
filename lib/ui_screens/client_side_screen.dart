import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'map_screen.dart';
import 'home_screen.dart';

class ClientSideScreen extends StatefulWidget {
  const ClientSideScreen({super.key});

  @override
  State<ClientSideScreen> createState() => _ClientSideScreenState();
}

class _ClientSideScreenState extends State<ClientSideScreen> {
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _autoRequestedController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.6),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.2), // Always visible border
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Form Widget')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration("Name"),
                  validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                ),
                SizedBox(height: 0.01.sh,),
                TextFormField(
                  controller: _numberController,
                  decoration: _inputDecoration("Number"),
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                  value!.isEmpty
                      ? 'Enter your number'
                      : null,
                ),
                SizedBox(height: 0.01.sh,),
                TextFormField(
                  controller: _emailController,
                  decoration: _inputDecoration("Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                  value!.isEmpty
                      ? 'Enter your email'
                      : null,
                ),
                SizedBox(height: 0.01.sh,),
                TextFormField(
                  controller: _purposeController,
                  decoration: _inputDecoration("Purpose"),
                ),
                SizedBox(height: 0.01.sh,),
                TextFormField(
                  controller: _autoRequestedController,
                  decoration: _inputDecoration("Auto requested"),
                ),
                SizedBox(height: 0.01.sh,),
                TextFormField(
                  controller: _commentsController,
                  decoration: _inputDecoration("Comments"),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor, width: 1.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _images.isEmpty
                        ? const Center(child: Text('Tap to add images'))
                        : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(_images[index], width: 100,
                              height: 100),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle form submission
                      print('Form submitted');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen()),
                      );
                    }
                  },
                  child: Text('Submit', style: TextStyle(color: Theme.of(context).primaryColor),),
                ),
                ElevatedButton(
                  onPressed: () {
                    _auth.signOut();
                    print("User Logged Out");

                    // Navigate to HomeScreen (or LoginScreen)
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()), // Change to your login/home screen
                          (route) => false, // Remove all previous routes
                    );
                  },
                  child: Text('Log out', style: TextStyle(color: Theme.of(context).primaryColor),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}