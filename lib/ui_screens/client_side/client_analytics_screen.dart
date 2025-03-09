import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../classes/Autos.dart';
import 'client_map_screen.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<Auto> autos = [];
  List<Auto> filteredAutos = [];
  List<String> availablePinCode = [];
  String? selectedPinCode;
  DateTime lastRefreshed = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1)); // Simulating API call

    List<Auto> mockData = [
      Auto(id: "1", driverName: "John", driverPhone: "1234567890", pincode: "110001", cpm: 2.5, status: "active", lastActive: "Today"),
      Auto(id: "2", driverName: "Doe", driverPhone: "0987654321", pincode: "110002", cpm: 3.0, status: "inactive", lastActive: "Yesterday"),
      Auto(id: "3", driverName: "Smith", driverPhone: "1122334455", pincode: "110001", cpm: 2.8, status: "active", lastActive: "Today"),
    ];

    setState(() {
      autos = mockData;
      availablePinCode = mockData.map((e) => e.pincode).toSet().toList();
      filteredAutos = selectedPinCode == null
          ? mockData
          : mockData.where((auto) => auto.pincode == selectedPinCode).toList();
      lastRefreshed = DateTime.now();
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Data refreshed successfully")),
    );
  }

  void handlePinCodeSelect(String? pinCode) {
    setState(() {
      selectedPinCode = pinCode;
      filteredAutos = pinCode == null
          ? autos
          : autos.where((auto) => auto.pincode == pinCode).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("MMMM d, yyyy, h:mm a").format(lastRefreshed);
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("MY HOLDINGS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0.02.sh, 0),
            child: IconButton(
              icon: isLoading ? const CircularProgressIndicator() : const Icon(Icons.refresh),
              onPressed: isLoading ? null : fetchData,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0 , 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Holdings as on $formattedDate", style: const TextStyle(color: Colors.grey)),
            SizedBox(height: 0.03.sh),
            Row(
              children: [
                const Text("Filter by PinCode: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: selectedPinCode,
                  hint: const Text("Select PinCode"),
                  onChanged: handlePinCodeSelect,
                  items: availablePinCode.map((pinCode) {
                    return DropdownMenuItem(value: pinCode, child: Text(pinCode));
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 0.03.sh),
            SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStatCard("Total Autos", "${autos.length}", Icons.directions_car),
                _buildStatCard("Active Pincodes", "${availablePinCode.length}", Icons.location_on),
                _buildStatCard("Average CPM", filteredAutos.isNotEmpty ? (filteredAutos.map((e) => e.cpm).reduce((a, b) => a + b) / filteredAutos.length).toStringAsFixed(2) : "0", Icons.edit),
              ],
            ),
            ),
            SizedBox(height: 0.06.sh),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: filteredAutos.length,
                itemBuilder: (context, index) {
                  Auto auto = filteredAutos[index];
                  return SizedBox(
                    height: 0.14.sh,
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color: const Color(0xFF09142E), // Background color #09142e
                      child: ListTile(
                        title: Text(
                          auto.driverName,
                          style: const TextStyle(color: Colors.white), // White text
                        ),
                        subtitle: Text(
                          "Phone: ${auto.driverPhone}\nPincode: ${auto.pincode}\nCPM: ${auto.cpm}",
                          style: const TextStyle(color: Colors.white70), // Slightly lighter white for readability
                        ),
                        trailing: Chip(
                          label: Text(
                            auto.status.toUpperCase(),
                            style: const TextStyle(color: Colors.white), // White text inside the Chip
                          ),
                          backgroundColor: auto.status == "active" ? Colors.green : Colors.red, // Green for active, Red for inactive
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()), // Navigate to Map Screen
                );
              },
              backgroundColor: Theme.of(context).primaryColor, // Customize button color
              child: const Icon(Icons.map, color: Colors.white), // Map icon inside button
            ),
            const SizedBox(height: 8), // Space between button and text
            const Text(
              'Maps',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatCard(String title, String value, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
    child: GestureDetector(
      onTap: () {}, // Bubble effect without button functionality
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16.0), // Padding inside the card
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFF09142E), // Background color
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text Column (Title + Value)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 6), // Space between title & value
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              // Icon Widget
              Padding(
                padding: const EdgeInsets.only(right: 8.0), // Padding to keep icon inside card
                child: Icon(icon, size: 32, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

