import 'package:flutter/material.dart';
import 'admin_analytics_screen.dart';
import 'admin_request_received_screen.dart';

class AdminMapScreen extends StatefulWidget {
  const AdminMapScreen({super.key});

  @override
  State<AdminMapScreen> createState() => _AdminMapScreenState();
}

class _AdminMapScreenState extends State<AdminMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0), // Add padding for spacing
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminAnalyticsScreen()),
                );
              },
              child: Text('Dashboard', style: TextStyle(color: Theme.of(context).primaryColor),),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestListScreen()), // Navigate to Map Screen
                );
              },
              backgroundColor: Theme.of(context).primaryColor, // Customize button color
              child: const Icon(Icons.map, color: Colors.white), // Map icon inside button
            ),
            const SizedBox(height: 8), // Space between button and text
            const Text(
              'Request Form',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
