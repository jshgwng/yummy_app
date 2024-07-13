import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yummy_app/services/inventory_service.dart';
import 'package:yummy_app/services/auth_service.dart';
import 'package:yummy_app/widgets/drawer_widget.dart';

import '../models/product.dart';
import '../widgets/item_card_widget.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  InventoryScreenState createState() => InventoryScreenState();
}

class InventoryScreenState extends State<InventoryScreen> {
  // late Future<Product> futureProduct;
  // final inventoryService = InventoryService();
  @override
  void initState(){
    super.initState();
    // futureProduct = futureProduct();
  }
  @override
  Widget build(BuildContext context) {
    final inventoryService = InventoryService(buildContext: context);

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
        title: const Text("Inventory"),
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
      body: Center(child: FutureBuilder<List<dynamic>>(
        future: inventoryService.fetchProduct(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ItemCard(item: snapshot.data?[index]);
              },
            );
          } else if (snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ))
    );
  }
}
