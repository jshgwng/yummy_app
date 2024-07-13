import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesCardWidget extends StatelessWidget {
  final Map<String, dynamic> sale;

  const SalesCardWidget({
    Key? key,
    required this.sale,
  }) : super(key: key);

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
            Text('Total Amount: \UGX ${sale['total_amount']}'),
            Text('Payment Mode: ${sale['payment_mode']}'),
            Text(
              'Date: ${formatDate(sale['created_at'])}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
