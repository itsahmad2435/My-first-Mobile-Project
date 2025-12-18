import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../drawer.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('messages');

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      final messageData = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'message': _messageController.text.trim(),
        'timestamp': DateTime.now().toIso8601String(),
      };

      _dbRef.push().set(messageData).then((_) {
        // Clear form
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();

        // SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Your message has been sent!")),
        );

        // Dialog
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Message Sent!'),
            content: const Text('Thank you for reaching out. We will contact you soon.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error sending message: $error")),
        );
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Get in Touch',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Your Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val!.isEmpty ? 'Please enter your email' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    labelText: 'Your Message',
                    prefixIcon: Icon(Icons.message),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (val) => val!.isEmpty ? 'Please enter your message' : null,
                ),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    label: const Text("Send Message"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
