import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yummy_app/screens/inventory_screen.dart';

import '../models/product.dart';

class InventoryService {
  final String api = 'http://localhost:8000/api';
  final BuildContext? buildContext;

  const InventoryService({this.buildContext});

  Future<List<dynamic>> fetchProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/product'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }Future<List<dynamic>> fetchSales() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/sales'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<void> saveProduct(
      {required String name,
      String? description,
      required double price,
      required int quantity,
      String? imageUrl}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$api/product'),
      headers: {
        "Authorization": "Bearer ${prefs.getString('userToken')}",
        'Content-Type': 'application/json'
      },
      body: jsonEncode(
        {
          "name": name,
          "description": description,
          "price": price,
          "quantity": quantity,
          "imageUrl": imageUrl
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Navigator.push(
        buildContext!,
        MaterialPageRoute(builder: (context) => const InventoryScreen()),
      );
    } else {
      throw Exception("Failed to add product");
    }
  }

  Future<void> processSale(dynamic sale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$api/process-sale'),
      headers: {
        "Authorization": "Bearer ${prefs.getString('userToken')}",
        'Content-Type': 'application/json'
      },
      body: jsonEncode(sale),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      // Navigator.push(
      //   buildContext!,
      //   MaterialPageRoute(builder: (context) => const InventoryScreen()),
      // );
    } else {
      throw Exception("Failed to add product");
    }
  }
}
