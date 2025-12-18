import 'package:flutter/material.dart';
import '../drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Pizza online 🍕"),
        backgroundColor: Colors.redAccent,
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome
              Text(
                "Welcome to Pizza Express!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Pizza Express is your go-to app for delicious, hot, and fresh pizzas delivered right to your doorstep. "
                    "Our goal is to bring joy through every slice and make ordering pizza a seamless experience for everyone.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.5),
              ),
              SizedBox(height: 25),

              // Mission
              Text(
                "Our Mission",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "To deliver the most delicious pizzas in the fastest time possible while maintaining the highest quality and customer satisfaction.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.4),
              ),
              SizedBox(height: 20),

              // Vision
              Text(
                "Our Vision",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "To become the leading pizza delivery app in the region, known for exceptional taste, reliability, and innovation.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.4),
              ),
              SizedBox(height: 20),

              // Values
              Text(
                "Our Values",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("• Quality: We use only the freshest ingredients."),
                  Text("• Speed: Fast delivery without compromising quality."),
                  Text("• Customer Happiness: Your satisfaction is our top priority."),
                  Text("• Innovation: Bringing new pizza flavors and features."),
                ],
              ),
              SizedBox(height: 25),

              // Features
              Text(
                "App Features",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("• Browse pizzas with images and prices."),
                  Text("• Place orders in just a few clicks."),
                  Text("• Submit feedback and rate our pizzas."),
                  Text("• Secure and easy payment options."),
                  Text("• Track your order in real-time."),
                ],
              ),
              SizedBox(height: 25),

              // Team
              Text(
                "Meet the Team",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Our dedicated team ensures every pizza is made with love and care. "
                    "From chefs to delivery personnel, everyone works together to provide the best experience.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800], height: 1.4),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/3.jfif'),
                      ),
                      SizedBox(height: 6),
                      Text("Ahmad\n(Developer)", textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/4.jfif'),
                      ),
                      SizedBox(height: 6),
                      Text("Ali\n(Chef)", textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/5.jfif'),
                      ),
                      SizedBox(height: 6),
                      Text("Sara\n(Delivery)", textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Closing
              Center(
                child: Text(
                  "Thank you for choosing Pizza Express! 🍕",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
