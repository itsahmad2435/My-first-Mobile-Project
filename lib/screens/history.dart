import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../drawer.dart';
import 'products.dart'; // ✅ Import correct

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('history');
  List<Map<dynamic, dynamic>> _historyList = [];

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  void _fetchHistory() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value;
      final List<Map<dynamic, dynamic>> tempList = [];

      if (data != null) {
        if (data is Map<dynamic, dynamic>) {
          data.forEach((key, value) {
            tempList.add({'key': key, 'data': value});
          });
        } else if (data is List) {
          for (int i = 0; i < data.length; i++) {
            if (data[i] != null) tempList.add({'key': i.toString(), 'data': data[i]});
          }
        }
      }

      setState(() {
        _historyList = tempList.reversed.toList();
      });
    });
  }

  void _deleteEntry(String key) {
    _dbRef.child(key).remove();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange; // Pending
    }
  }

  void _editOrder(String key, Map<dynamic, dynamic> oldData) {
    final TextEditingController titleController =
    TextEditingController(text: oldData['title']);
    final TextEditingController priceController =
    TextEditingController(text: oldData['price']);
    final TextEditingController methodController =
    TextEditingController(text: oldData['method']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Order"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Pizza Name"),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: methodController,
                decoration: const InputDecoration(labelText: "Payment Method"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _dbRef.child(key).update({
                'title': titleController.text.trim(),
                'price': priceController.text.trim(),
                'method': methodController.text.trim(),
              });

              Navigator.pop(context); // Close dialog

              // ✅ Open ProductsScreen with prefilled data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductsScreen(
                    prefillData: {
                      'name': titleController.text.trim(),
                      'price': priceController.text.trim(),
                      'method': methodController.text.trim(),
                    },
                  ),
                ),
              );
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History 📜"),
        backgroundColor: Colors.redAccent,
      ),
      drawer: const AppDrawer(),
      body: _historyList.isEmpty
          ? const Center(
        child: Text(
          "No orders found!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _historyList.length,
        itemBuilder: (context, index) {
          final item = _historyList[index];
          final key = item['key'];
          final data = item['data'] as Map<dynamic, dynamic>;
          final status = data['status'] ?? 'Pending';

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data['title'] ?? "Unknown Pizza",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _statusColor(status).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                  color: _statusColor(status),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            tooltip: 'Cancel Order',
                            onPressed: status == 'Accepted'
                                ? null
                                : () => _deleteEntry(key),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            tooltip: 'Edit Order',
                            onPressed: () => _editOrder(key, data),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text("Price: Rs. ${data['price'] ?? '-'}",
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text("Payment Method: ${data['method'] ?? '-'}",
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(
                    "Ordered On: ${data['timestamp'] != null ? data['timestamp'].toString().split('.')[0] : '-'}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
