import 'package:flutter/material.dart';

class SalesSummaryCard extends StatelessWidget {
  final Map<String, dynamic> salesSummary;

  const SalesSummaryCard({Key? key, required this.salesSummary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sales Date: ${salesSummary['sales_date']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Total Sales: UGX ${salesSummary['total_sales']}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
