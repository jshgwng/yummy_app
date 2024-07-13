import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yummy_app/screens/login_screen.dart';
import 'package:yummy_app/services/auth_service.dart';
import 'package:yummy_app/services/inventory_service.dart';
import 'package:yummy_app/widgets/drawer_widget.dart';

import '../widgets/sales_details_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? _token;
  final inventoryService = const InventoryService();

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  void _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("userToken"));
    setState(() {
      _token = prefs.getString('userToken');
    });

    if (_token == null) {
      _redirectToLogin();
    }
  }

  void _redirectToLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      switch (value) {
        case 'Logout':
          // client.logout(context);
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Logout',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: FutureBuilder<List<dynamic>>(
        future: inventoryService.fetchSales(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No sales data available'));
          } else {
            final sales = snapshot.data!;
            return ListView.builder(
              itemCount: sales.length,
              itemBuilder: (context, index) {
                return SaleDetailsWidget(sale: sales[index]);
              },
            );
          }
        },
      ),
    );
  }
}
