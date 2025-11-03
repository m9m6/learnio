import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'course_details_screen.dart';
class LearningTab extends StatefulWidget {
  const LearningTab({super.key});

  @override
  State<LearningTab> createState() => _LearningTabState();
}

class _LearningTabState extends State<LearningTab> {
  late Future<List<dynamic>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = _loadCourses();
  }

  Future<List<dynamic>> _loadCourses() async {
    final raw = await rootBundle.loadString('assets/courses.json');
    final data = json.decode(raw);
    return data['courses'];
  }

  // Open details using the course object loaded from `assets/courses.json`.
  void _openCourseDetails(Map<String, dynamic> course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CourseDetailsScreen(course: course),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _coursesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load courses'));
        }
        final courses = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final c = courses[index];
            return GestureDetector(
              // only allow tap navigation when the course contains details
              onTap: c['hasDetails'] ? () => _openCourseDetails(c as Map<String, dynamic>) : null,
              child: Card(
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: Image.network(
                    c['thumbnail'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    c['title'],
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "${c['shortDescription']}\n${c['level']} • ${c['duration']}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
