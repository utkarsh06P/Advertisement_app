import 'package:flutter/material.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  List<Map<String, String>> requests = [
    {"sno": "1", "clientName": "John Doe", "clientComment": "This is a detailed comment about the request, explaining the concerns and details that should be considered."},
    {"sno": "2", "clientName": "Jane Smith", "clientComment": "Another detailed comment that requires attention with specific instructions for follow-up."},
  ];

  List<bool> isExpandedList = []; // Tracks expanded state

  @override
  void initState() {
    super.initState();
    isExpandedList = List.generate(requests.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request List"),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
            return GestureDetector(
              onTap: () {
                setState(() => isExpandedList[index] = !isExpandedList[index]);
              },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                color: const Color(0xFF09142E),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "# ${request['sno']}",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Client Name: ${request['clientName']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Comment: ${request['clientComment']!}",
                        maxLines: isExpandedList[index] ? null : 2,
                        overflow: isExpandedList[index] ? null : TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
