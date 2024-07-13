import 'package:flutter/material.dart';
import 'package:yummy_app/services/inventory_service.dart';

import '../widgets/sales_item_widget.dart'; // Import the ProductService

class SalesWindow extends StatefulWidget {
  const SalesWindow({Key? key}) : super(key: key);

  @override
  _SalesWindowState createState() => _SalesWindowState();
}

class _SalesWindowState extends State<SalesWindow> {
  final _productService = const InventoryService();
  late Future<List<dynamic>> _futureProducts;
  final Map<int, TextEditingController> _quantityControllers = {};

  @override
  void initState() {
    super.initState();
    _futureProducts = _productService.fetchProduct();
  }

  @override
  void dispose() {
    for (var controller in _quantityControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitSales(List<dynamic> items, String selectedPaymentMethod) {
    double totalAmount = 0;
    final sales = items.map((item) {
      final quantity = int.tryParse(_quantityControllers[item['id']]?.text ?? '0') ?? 0;
      final totalPrice = quantity * (item['price'] ?? 0);
      totalAmount += totalPrice;
      return {
        'product_id': item['id'],
        'quantity': quantity,
        'unit_price': item['price'],
        'amount': totalPrice,
      };
    }).toList();

    // Print the sales data (you can replace this with actual submission logic)
    // print('Sales: $sales');

    final body = {
      "total_amount": totalAmount,
      "payment_mode": selectedPaymentMethod,
      "items": sales
    };

    print(body);
    _productService.processSale(body);
  }
  Future<void> _showPaymentMethodDialog(List<dynamic> items) async {
    String? selectedPaymentMethod = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Payment Method'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Credit Card'),
                  onTap: () {
                    Navigator.of(context).pop('Credit Card');
                  },
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  child: const Text('Cash'),
                  onTap: () {
                    Navigator.of(context).pop('Cash');
                  },
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  child: const Text('Mobile Payment'),
                  onTap: () {
                    Navigator.of(context).pop('Mobile Payment');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedPaymentMethod != null) {
      _submitSales(items, selectedPaymentMethod);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Window'),
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
          for (var item in items) {
            _quantityControllers[item['id']] = TextEditingController();
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return SalesItemWidget(
                item: item,
                quantityController: _quantityControllers[item['id']]!,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _futureProducts.then((items) {
            _showPaymentMethodDialog(items);
          });
                },
        child: const Icon(Icons.check),
      ),
    );
  }
}
