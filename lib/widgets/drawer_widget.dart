import 'package:flutter/material.dart';
import 'package:yummy_app/screens/add_inventory_screen.dart';
import 'package:yummy_app/screens/daily_sales_report_screen.dart';
import 'package:yummy_app/screens/inventory_screen.dart';
import 'package:yummy_app/screens/low_stock_report_screen.dart';
import 'package:yummy_app/screens/monthly_sales_report_screen.dart';
import 'package:yummy_app/screens/sales_by_product_report_screen.dart';
import 'package:yummy_app/screens/sales_report_screen.dart';
import 'package:yummy_app/screens/sales_screen.dart';
import 'package:yummy_app/services/auth_service.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService(context: context);
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text("Menu"),
          ),
          ListTile(
            title: const Text('Inventory'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const InventoryScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Add Inventory'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddInventoryScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Sales Window'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SalesWindow(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Sales Report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SalesReportScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Daily Sales Report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const DailySalesReportScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Monthly Sales Report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MonthlySalesReportScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Low Stock Report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LowStockReportScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Sales By Product Report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SalesByProductReportScreen(),
                ),
              );
            },
          ),
          ListTile(
              title: const Text('Logout'),
              onTap: () {
                authService.logoutUser();
              }),
        ],
      ),
    );
  }
}
