import 'package:flutter/material.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> course;
  const CourseDetailsScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['title']),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(course['thumbnail']),
            const SizedBox(height: 12),
            Text(
              course['fullDescription'],
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text('📘 Syllabus', style: header),
            ...course['syllabus']
                .map<Widget>((s) => ListTile(
              title: Text("Week ${s['week']}: ${s['title']}",
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(
                (s['topics'] as List).join(', '),
                style: const TextStyle(color: Colors.white70),
              ),
            ))
                .toList(),
            const SizedBox(height: 12),
            Text('🧠 Requirements', style: header),
            ...course['requirements']
                .map<Widget>((r) => Text("- $r",
                style: const TextStyle(color: Colors.white70)))
                .toList(),
            const SizedBox(height: 12),
            Text('👩‍🏫 Instructor', style: header),
            Text("${course['instructor']['name']} — ${course['instructor']['bio']}",
                style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            Text('⭐ Reviews', style: header),
            ...course['reviews']
                .map<Widget>((r) => ListTile(
              title: Text(r['user'],
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(r['comment'],
                  style: const TextStyle(color: Colors.white70)),
              trailing: Text("${r['rating']}/5",
                  style: const TextStyle(color: Colors.amber)),
            ))
                .toList(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                child: const Text("Enroll Now"),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xFF1E1E2C),
    );
  }
}

final header =
const TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold);
