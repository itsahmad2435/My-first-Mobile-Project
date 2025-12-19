import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../drawer.dart';

class PaymentScreen extends StatefulWidget {
  final String productName;
  final double amount;
  final String? paymentMethod; // optional parameter

  const PaymentScreen({
    super.key,
    required this.productName,
    required this.amount,
    this.paymentMethod,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String selectedMethod;
  bool isProcessing = false;

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('history');

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.paymentMethod ?? 'Credit/Debit Card';
  }

  void handlePayment() async {
    setState(() => isProcessing = true);

    await Future.delayed(const Duration(seconds: 2));

    String? key = _dbRef.push().key;
    if (key != null) {
      await _dbRef.child(key).set({
        'title': widget.productName,
        'price': widget.amount.toStringAsFixed(2),
        'method': selectedMethod,
        'timestamp': DateTime.now().toString(),

        // 🔹 Rider addition
        'status': 'Pending',        // initial order status
        'riderId': 'RIDER_UID',     // replace with actual rider UID if needed
      });
    }

    setState(() => isProcessing = false);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Payment Successful! 💳"),
        content: Text(
          "Your payment of Rs. ${widget.amount.toStringAsFixed(2)} "
              "for ${widget.productName} has been processed.\n\nIt is saved in your History.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget paymentOption(String method, IconData icon) {
    bool isSelected = selectedMethod == method;
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
      title: Text(method),
      trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.blue) : null,
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              child: Column(
                children: [
                  paymentOption('Credit/Debit Card', Icons.credit_card),
                  const Divider(height: 1),
                  paymentOption('UPI / Google Pay', Icons.qr_code_2),
                  const Divider(height: 1),
                  paymentOption('Cash on Delivery', Icons.money),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                "Total Amount: Rs. ${widget.amount.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock),
              label: isProcessing
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
                "Pay Now",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: isProcessing ? null : handlePayment,
            ),
          ],
        ),
      ),
    );
  }
}
