import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../drawer.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('feedbacks');

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      final feedbackData = {
        'message': _feedbackController.text.trim(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      _dbRef.push().set(feedbackData).then((_) {
        _feedbackController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Your feedback has been submitted!")),
        );

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Thank You! 🎉"),
            content: const Text("Your feedback has been submitted successfully."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error submitting feedback: $error")),
        );
      });
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feedback 💬"),
        backgroundColor: Colors.redAccent,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We’d love your feedback!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Help us improve by sharing your thoughts. Your feedback matters to us.",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    labelText: "Your Message",
                    hintText: "Type your feedback here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 6,
                  validator: (val) => val!.isEmpty ? 'Please enter your feedback' : null,
                ),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
