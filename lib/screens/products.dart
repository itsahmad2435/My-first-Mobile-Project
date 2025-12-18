import 'package:flutter/material.dart';
import '../drawer.dart';
import 'payment.dart';

class ProductsScreen extends StatelessWidget {
  final Map<String, String>? prefillData; // 🔹 Optional prefill data

  const ProductsScreen({super.key, this.prefillData});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> products = [
      {
        "name": "Margherita Pizza",
        "price": "899",
        "image": "assets/1.jpeg",
        "desc": "Classic cheese and tomato pizza, always a favorite."
      },
      {
        "name": "Pepperoni Pizza",
        "price": "1099",
        "image": "assets/2.jpeg",
        "desc": "Spicy pepperoni with gooey mozzarella cheese."
      },
      {
        "name": "Veggie Delight",
        "price": "749",
        "image": "assets/6.jpeg",
        "desc": "Loaded with fresh veggies and cheese."
      },
      {
        "name": "BBQ Chicken Pizza",
        "price": "1299",
        "image": "assets/7.jpeg",
        "desc": "Grilled chicken with tangy BBQ sauce."
      },
      {
        "name": "Cheese Burst Pizza",
        "price": "1149",
        "image": "assets/8.jpeg",
        "desc": "Extra cheesy pizza for all cheese lovers."
      },
      {
        "name": "Mexican Pizza",
        "price": "1199",
        "image": "assets/9.jpeg",
        "desc": "A spicy mix of corn, jalapenos and cheese."
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pizza Online 🍕"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            // 🔹 If coming from History Edit, use prefillData
            final isPrefilled = prefillData != null && prefillData!['name'] == product['name'];
            final displayPrice = isPrefilled ? prefillData!['price']! : product['price']!;
            final paymentMethod = isPrefilled ? prefillData!['method']! : "Cash"; // optional default

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
                        product["image"]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: Text(
                      product["name"]!,
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
                      product["desc"]!,
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
                      "Rs. $displayPrice",
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
                        // 🔹 Navigate to PaymentScreen with prefilled or normal data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              productName: product["name"]!,
                              amount: double.parse(displayPrice),
                              paymentMethod: paymentMethod, // optional
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      ),
                      child: const Text("Order Now"),
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
