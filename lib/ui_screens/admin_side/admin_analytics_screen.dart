import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class AdminAnalyticsScreen extends StatefulWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  State<AdminAnalyticsScreen> createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
  List<Map<String, dynamic>> autos = [];
  DateTime lastRefreshed = DateTime.now();
  bool isLoading = false;

  Future<void> fetchData() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1)); // Simulated API call

    List<Map<String, dynamic>> mockData = [
      {"id": "1", "pincode": "110001", "status": "active", "cpm": 2.5},
      {"id": "2", "pincode": "110002", "status": "inactive", "cpm": 3.0},
      {"id": "3", "pincode": "110003", "status": "active", "cpm": 2.8},
    ];

    setState(() {
      autos = mockData;
      lastRefreshed = DateTime.now();
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Admin analytics data has been updated.")),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    int totalAutos = autos.length;
    int totalActivePincodes = autos.map((auto) => auto['pincode']).toSet().length;
    int totalActiveAutos = autos.where((auto) => auto['status'] == "active").length;
    double averageCpm = autos.isNotEmpty
        ? autos.map((auto) => auto['cpm']).reduce((a, b) => a + b) / autos.length
        : 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADMIN DASHBOARD"),
        actions: [
          IconButton(
            icon: isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.refresh),
            onPressed: isLoading ? null : fetchData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All autos data as on ${DateFormat("MMMM d, yyyy, h:mm a").format(lastRefreshed)}"),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard("Total Autos", "$totalAutos", Icons.directions_car),
                  _buildStatCard("Active Pincodes", "$totalActivePincodes", Icons.location_on),
                  _buildStatCard("Average CPM", averageCpm.toStringAsFixed(2), Icons.bar_chart),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : autos.isEmpty
                  ? const Center(child: Text("No data available", style: TextStyle(color: Colors.white)))
                  : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.2,
                  ),
                itemCount: autos.length,
                itemBuilder: (context, index) {
                  final auto = autos[index];
                  return SizedBox(
                    height: 0.10.sh,
                    width: 0.15.sw,
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color: const Color(0xFF09142E),
                      child: ListTile(
                      title: Text(
                           "Auto ID: ${auto['id']}",
                           style: const TextStyle(color: Colors.white),
                           ),
                           subtitle: Text("Pincode: ${auto['pincode']}\nStatus: ${auto['status']}\nCPM: ${auto['cpm']}",
                                      style: const TextStyle(color: Colors.white70
                        ),
                      ),
                    ),
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blueAccent),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
