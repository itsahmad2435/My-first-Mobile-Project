import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // 🔹 Drawer Header with Gradient + Background Image
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: const AssetImage('assets/9.jfif'), // <-- Added your photo
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Pizza Online App',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            // 🔹 Drawer Items
            _buildDrawerItem(context,
                icon: Icons.home, title: 'Home', route: '/home'),
            _buildDrawerItem(context,
                icon: Icons.local_pizza, title: 'Products', route: '/products'),
            _buildDrawerItem(context,
                icon: Icons.payment, title: 'Payment', route: '/payment'),
            _buildDrawerItem(context,
                icon: Icons.feedback, title: 'Feedback', route: '/feedback'),
            _buildDrawerItem(context,
                icon: Icons.info, title: 'About', route: '/about'),
            _buildDrawerItem(context,
                icon: Icons.local_offer, title: 'Deals', route: '/deals'),
            _buildDrawerItem(context,
                icon: Icons.contact_mail, title: 'Contact', route: '/contact'),
            _buildDrawerItem(context,
                icon: Icons.contact_mail, title: 'Rider', route: '/rider'),
            _buildDrawerItem(context,
                icon: Icons.history, title: 'History', route: '/history'),
            _buildDrawerItem(context,
                icon: Icons.visibility, title: 'Developer Vision', route: '/developer'),

            const Divider(thickness: 1, color: Colors.grey),

            // 🔹 Logout with Firebase
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              hoverColor: Colors.red.withOpacity(0.1),
              onTap: () async {
                await FirebaseAuth.instance.signOut(); // Firebase logout
                Navigator.pushReplacementNamed(context, '/login');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("You have been logged out.")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Drawer Item Builder
  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon, required String title, required String route}) {
    return ListTile(
      leading: Icon(icon, color: Colors.orangeAccent),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      hoverColor: Colors.orange.withOpacity(0.1),
      onTap: () {
        Navigator.pop(context); // Close drawer
        Navigator.pushNamed(context, route);
      },
    );
  }
}
