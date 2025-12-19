// lib/screens/rider.dart
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../drawer.dart';

class RiderScreen extends StatefulWidget {
  const RiderScreen({Key? key}) : super(key: key);

  @override
  State<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<RiderScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('orders');
  List<Map<dynamic, dynamic>> _ordersList = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value;
      final List<Map<dynamic, dynamic>> tempList = [];

      if (data != null && data is Map<dynamic, dynamic>) {
        data.forEach((key, value) {
          tempList.add({'key': key, 'data': value});
        });
      }

      setState(() {
        _ordersList = tempList.reversed.toList();
      });
    });
  }

  void _updateStatus(String key, String newStatus) {
    _dbRef.child(key).update({'status': newStatus});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order status updated to $newStatus')),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.orange;
      case 'On the way':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rider - Orders"),
        backgroundColor: Colors.redAccent,
      ),
      drawer: const AppDrawer(),
      body: _ordersList.isEmpty
          ? const Center(child: Text("No orders available"))
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _ordersList.length,
        itemBuilder: (context, index) {
          final item = _ordersList[index];
          final key = item['key'];
          final data = item['data'] as Map<dynamic, dynamic>;
          final status = data['status'] ?? 'Pending';

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundImage:
                AssetImage(data['image'] ?? 'assets/9.jfif'),
              ),
              title: Text(data['productName'] ?? 'Unknown Pizza'),
              subtitle: Text('Status: $status'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price: Rs.${data['amount'] ?? '-'}"),
                      const SizedBox(height: 4),
                      Text("Customer: ${data['customerName'] ?? '-'}"),
                      const SizedBox(height: 4),
                      Text("Address: ${data['address'] ?? '-'}"),
                      const SizedBox(height: 4),
                      Text(
                          "Payment: ${data['paymentMethod'] ?? 'Cash'}"),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () =>
                                _updateStatus(key, 'Pending'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            child: const Text('Pending'),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                _updateStatus(key, 'On the way'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: const Text('On the way'),
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                _updateStatus(key, 'Delivered'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text('Delivered'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
