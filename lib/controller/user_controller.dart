import 'dart:convert';
import 'dart:developer';

import 'package:admin_food_delivery/controller/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';

class UserController with ChangeNotifier {
  Future<void> showSnack(
      {required context, required String? text, required bool? error}) async {
    final snackBar = SnackBar(
      backgroundColor: error == true ? Colors.red : Colors.green,
      content: Text(text!),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  indicator(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> getAllCategory() async {
    final token = await SharedPriference().getApiToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(Api.getCategories),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> tempList = responseData['data']['categories'];

        // userDatas = tempList.map((e) => User.fromJson(e)).toList();
      } else {
        log('error');
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }
}
