import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/home.dart';
import 'screens/products.dart';
import 'screens/feedback.dart';
import 'screens/about.dart';
import 'screens/contact.dart';
import 'screens/history.dart';
import 'drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase initialize
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizza Online App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginScreen(), // Start from Login
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/products': (context) => ProductsScreen(), // ✅ const hata diya
        '/feedback': (context) => FeedbackScreen(),
        '/about': (context) => AboutScreen(),
        '/contact': (context) => ContactScreen(),
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}
