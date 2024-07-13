import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300, // Fixed width
        height: 400, // Fixed height
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              item['imageUrl'],
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text color for visibility
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['description'],
                    style: const TextStyle(
                      color: Colors.white, // White text color for visibility
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: UGX${item['price']}',
                    style: const TextStyle(
                      color: Colors.white, // White text color for visibility
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Quantity: ${item['quantity']}',
                    style: const TextStyle(
                      color: Colors.white, // White text color for visibility
                    ),
                  ),
                  const Spacer(),
                  // Text(
                  //   'Created At: ${DateTime.parse(item['created_at'])}',
                  //   style: const TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.white, // White text color for visibility
                  //   ),
                  // ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   'Updated At: ${DateTime.parse(item['updated_at'])}',
                  //   style: const TextStyle(
                  //     fontSize: 12,
                  //     color: Colors.white, // White text color for visibility
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
