import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Map<String, dynamic> eventData;

  const EventCard({required this.eventData, Key? key}) : super(key: key);

  void _makeAction(String link) {
    // Implement your action here
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          if (eventData['image'] != null)
            Image.network(
              eventData['image']!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventData['name'] ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      eventData['date'] ?? 'No Date',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      eventData['description'] ?? 'No Description',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                if (eventData['button'] != null)
                  ElevatedButton(
                    onPressed: () => _makeAction(eventData['link'] ?? ''),
                    child: Text(eventData['button'] ?? 'No Action'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}