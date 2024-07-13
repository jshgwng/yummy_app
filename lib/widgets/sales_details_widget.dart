import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaleDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> sale;

  const SaleDetailsWidget({
    super.key,
    required this.sale,
  });
  String formatDate(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sale ID: ${sale['id']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Total Amount: UGX ${sale['total_amount']}'),
            Text('Payment Mode: ${sale['payment_mode']}'),
            Text(
              'Date: ${formatDate(sale['created_at'])}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            // Text(
            //   'Updated At: ${DateTime.parse(sale['updated_at'])}',
            //   style: const TextStyle(
            //     fontSize: 12,
            //     color: Colors.grey,
            //   ),
            // ),
            const Divider(),
            const Text(
              'Sale Details:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...sale['sale_details'].map<Widget>((detail) {
              final product = detail['product'];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product: ${product['name']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Image.network(
                        //   product['imageUrl'],
                        //   fit: BoxFit.cover,
                        // ),
                        Text(product['description']),
                        Text('Unit Price: UGX ${detail['unit_price']}'),
                        Text('Quantity: ${detail['quantity']}'),
                        Text('Total Price: UGX ${detail['quantity'] * detail['unit_price']}'),
                        // Text(
                        //   'Created At: ${DateTime.parse(detail['created_at'])}',
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                        // Text(
                        //   'Updated At: ${DateTime.parse(detail['updated_at'])}',
                        //   style: const TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
