import 'package:flutter/material.dart';
import '../models/subject_model.dart';
import '../controllers/auth_controller.dart';
import 'detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late AuthController _auth;

  @override
  void initState() {
    super.initState();
    _auth = AuthController();
  }

  @override
  Widget build(BuildContext context) {
    List<SubjectModel> subjects = SubjectModel.getSubjects();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.logout();
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _auth.userName ?? 'User',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text('Student', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('My Subjects', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: subjects.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Text(subjects[index].icon, style: const TextStyle(fontSize: 30)),
                      title: Text(subjects[index].name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(subjects[index].instructor),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(subject: subjects[index]),
                          ),
                        );
                      },
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