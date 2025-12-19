import 'package:flutter/material.dart';

void main() {
  runApp(const DeveloperVisionApp());
}

class DeveloperVisionApp extends StatelessWidget {
  const DeveloperVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const DeveloperVisionScreen(),
    );
  }
}

class DeveloperVisionScreen extends StatelessWidget {
  const DeveloperVisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Developer Vision"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔹 Image
            Image.asset(
              'assets/9.jfif', // assets folder me rakhna zaruri
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            // 🔹 Developer DNA / info
            const Text(
              "Developer: Ahmad Nisar\n"
                  "Role: Flutter / Firebase Developer\n"
                  "Project: Pizza Online App\n"
                  "Version: 1.0.0\n"
                  "Unique ID: 44-AN-2025",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
