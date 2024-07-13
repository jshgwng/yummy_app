import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yummy_app/screens/inventory_screen.dart';

import '../models/product.dart';

class ReportsService {
  final String api = 'http://localhost:8000/api';
  final BuildContext? buildContext;

  const ReportsService({this.buildContext});

  Future<List<dynamic>> inventoryReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/inventory-report'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> salesReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/sales-report'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> detailedSalesReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/detailed-sales-report'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> dailySalesReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/daily-sales-summary'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> monthlySalesReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/monthly-sales-summary'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> salesByPaymentMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/sales-by-payment-mode'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> bestSellingProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/best-selling-product'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> lowStockAlert() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/low-stock-alert'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> salesByProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse('$api/sales-by-product'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> dailySalesTrendAnalysis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('$api/daily-sales-trend-analysis'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<dynamic>> monthlySalesTrendAnalysis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse('$api/monthly-sales-trend-analysis'),
        headers: {"Authorization": "Bearer ${prefs.getString('userToken')}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data["data"]);
      return data["data"];
    } else {
      throw Exception('Failed to load album');
    }
  }
}
