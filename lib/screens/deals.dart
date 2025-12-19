import 'package:flutter/material.dart';
import '../drawer.dart';
import 'payment.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> deals = [
      {
        "name": "Family Deal",
        "price": "1999",
        "image": "assets/1.jpeg",
        "desc": "2 Large Pizzas + 1.5L Drink. Best for family dinner."
      },
      {
        "name": "Couple Deal",
        "price": "1499",
        "image": "assets/2.jpeg",
        "desc": "1 Medium Pizza + Garlic Bread + Drink."
      },
      {
        "name": "Student Deal",
        "price": "999",
        "image": "assets/6.jpeg",
        "desc": "1 Small Pizza + Fries + Drink."
      },
      {
        "name": "BBQ Deal",
        "price": "1799",
        "image": "assets/7.jpeg",
        "desc": "BBQ Chicken Pizza + Wings + Drink."
      },
      {
        "name": "Cheese Lover Deal",
        "price": "1699",
        "image": "assets/8.jpeg",
        "desc": "Cheese Burst Pizza + Cheese Dip + Drink."
      },
      {
        "name": "Party Deal",
        "price": "2999",
        "image": "assets/9.jpeg",
        "desc": "3 Large Pizzas + 2 Drinks. Perfect for parties."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pizza Deals 🔥"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: deals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final deal = deals[index];

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.asset(
                        deal["image"]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: Text(
                      deal["name"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      deal["desc"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "Rs. ${deal["price"]}",
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              productName: deal["name"]!,
                              amount: double.parse(deal["price"]!),
                              paymentMethod: "Cash",
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                      ),
                      child: const Text("Order Deal"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
