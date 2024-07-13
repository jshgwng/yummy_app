import 'package:flutter/material.dart';

class SalesItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final TextEditingController quantityController;

  const SalesItemWidget({
    super.key,
    required this.item,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              item['imageUrl'],
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Price: UGX.${item['price']}'),
                  const SizedBox(height: 8),
                  Text('Available Quantity: ${item['quantity']}'),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 80,
              child: TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
