import 'package:flutter/material.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({Key? key}) : super(key: key);

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedCategory = "General";

  final List<Map<String, String>> _complaints = [
    {
      "title": "Complaint 2",
      "message": "Details about the complaint registered",
      "status": "Unresolved",
      "date": "01/01/2025"
    },
    {
      "title": "Complaint 3",
      "message": "Details about the complaint registered",
      "status": "Resolved",
      "date": "01/01/2025"
    },
  ];

  void _submitComplaint() {
    if (_subjectController.text.isEmpty || _messageController.text.isEmpty) return;

    setState(() {
      _complaints.insert(0, {
        "title": _subjectController.text,
        "message": _messageController.text,
        "status": "Unresolved",
        "date": DateTime.now().toString().split(" ")[0].replaceAll("-", "/")
      });
      _subjectController.clear();
      _messageController.clear();
      _selectedCategory = "General";
    });
  }

  Widget _buildComplaintCard(Map<String, String> complaint) {
    bool resolved = complaint["status"] == "Resolved";
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(complaint["title"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Icon(Icons.more_vert),
          ],
        ),
        const SizedBox(height: 8),
        Text(complaint["message"]!, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: resolved ? Colors.green.shade100 : Colors.red.shade100,
                border: Border.all(color: resolved ? Colors.green : Colors.red),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                complaint["status"]!,
                style: TextStyle(color: resolved ? Colors.green : Colors.red, fontSize: 12),
              ),
            ),
            Text(complaint["date"]!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text("Complaints"),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Complaints", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 12),
          TextField(
            controller: _subjectController,
            decoration: InputDecoration(
              hintText: "Subject",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: ["General", "Academic", "Facility"]
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: (val) {
              setState(() {
                _selectedCategory = val!;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _messageController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Your Message Here...",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submitComplaint,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            child: const Text("Submit Complain"),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _complaints.length,
              itemBuilder: (_, i) => _buildComplaintCard(_complaints[i]),
            ),
          ),
        ]),
      ),
    );
  }
}
