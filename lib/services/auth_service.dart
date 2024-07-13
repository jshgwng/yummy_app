import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yummy_app/screens/home_screen.dart';
import 'package:yummy_app/screens/login_screen.dart';

class AuthService {
  final String api = 'http://localhost:8000/api';
  final BuildContext context;

  const AuthService({required this.context});

  Future<void> registerUser(String name, String email, String password) async {
    try {
      final url = Uri.parse('$api/register');

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(<String, String>{
            'name': name,
            'email': email,
            'password': password
          }));

      // "data":{"user":{"id":4,"name":"Ogwang Joshua","email":"jjogwang@gmail.com","email_verified_at":null,"created_at":"2024-07-12T07:26:05.000000Z","updated_at":"2024-07-12T07:26:05.000000Z"},"token":"5|iAafOVd6pKwgFTil7BVxhjj5NNOuAKT1Wr8xECCK8e601330"}}
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["data"]["token"]);
        final token = data["data"]['token'];
        final user = data["data"]['user'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userToken', token);
        await prefs.setString('userData', jsonEncode(user));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print(response.body);
      }
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final url = Uri.parse('$api/login');

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        final token = data["data"]['token'];
        final user = data["data"]['user'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userToken', token);
        await prefs.setString('userData', jsonEncode(user));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print(response.body);
      }
    } catch (e) {
      print('Error $e');
    }
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken') != null;
  }

  Future<void> logoutUser() async {
    try {
      final url = Uri.parse('$api/logout');

      // final response = await http.get(url,
      //     headers: {'Content-Type': 'application/json'}
      // );

      // "data":{"user":{"id":4,"name":"Ogwang Joshua","email":"jjogwang@gmail.com","email_verified_at":null,"created_at":"2024-07-12T07:26:05.000000Z","updated_at":"2024-07-12T07:26:05.000000Z"},"token":"5|iAafOVd6pKwgFTil7BVxhjj5NNOuAKT1Wr8xECCK8e601330"}}
      // if (response.statusCode == 200) {
      //   final data = jsonDecode(response.body);
      //   print(data["data"]["token"]);
      //   final token = data["data"]['token'];
      //   final user = data["data"]['user'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('userToken');
        await prefs.remove('userData');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
    } catch (e) {
      print('ERROR: $e');
    }
  }
}
