import 'package:flutter/material.dart';
import 'package:yummy_app/services/inventory_service.dart';
import 'package:yummy_app/services/reports_service.dart';
import 'package:yummy_app/widgets/sales_summary_widget.dart';

import '../widgets/sales_card_widget.dart';
import '../widgets/sales_item_widget.dart'; // Import the ProductService

class MonthlySalesReportScreen extends StatefulWidget {
  const MonthlySalesReportScreen({Key? key}) : super(key: key);

  @override
  _SalesReportWindowState createState() => _SalesReportWindowState();
}

class _SalesReportWindowState extends State<MonthlySalesReportScreen> {
  final _productService = const ReportsService();
  late Future<List<dynamic>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = _productService.monthlySalesReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Report'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          final items = snapshot.data!;
          print(items);
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SalesSummaryCard(salesSummary: items[index],);
            },
          );

          // return Text('${items}');
        },
      ),
    );
  }
}
