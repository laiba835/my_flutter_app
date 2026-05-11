import 'package:flutter/material.dart';
import '../models/subject_model.dart';

class DetailScreen extends StatelessWidget {
  final SubjectModel subject;

  const DetailScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject.name),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.blue.shade100,
              child: Center(
                child: Text(subject.icon, style: const TextStyle(fontSize: 80)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildInfo(Icons.description, 'Description', subject.description),
                  const SizedBox(height: 15),
                  _buildInfo(Icons.schedule, 'Schedule', subject.schedule),
                  const SizedBox(height: 15),
                  _buildInfo(Icons.person, 'Instructor', subject.instructor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(IconData icon, String title, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}