import 'package:flutter/material.dart';

class FeedbackFormTab extends StatefulWidget {
  const FeedbackFormTab({super.key});

  @override
  State<FeedbackFormTab> createState() => _FeedbackFormTabState();
}

class _FeedbackFormTabState extends State<FeedbackFormTab> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _feedbacks = [];

  void _submitFeedback() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        _feedbacks.add(_controller.text.trim());
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Write your feedback...',
              labelStyle: const TextStyle(color: Colors.black54),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.black54),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitFeedback,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: _feedbacks.isEmpty
                ? const Center(
              child: Text(
                'No feedback yet 💬',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            )
                : ListView.builder(
              itemCount: _feedbacks.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey.shade100,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.comment,
                        color: Colors.black54),
                    title: Text(
                      _feedbacks[index],
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
