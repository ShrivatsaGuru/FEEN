import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: const Color(0xFF3A7CE0),
        title: const Text('Announcements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Announcements',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A7CE0),
              ),
            ),
            const Divider(color: Color(0xFF3A7CE0)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Dummy items
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Color(0xFF3A7CE0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  'Announcement Title',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Icon(Icons.more_horiz),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'New Announcements come here.',
                          ),
                          const SizedBox(height: 8),
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '01/01/2025',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
