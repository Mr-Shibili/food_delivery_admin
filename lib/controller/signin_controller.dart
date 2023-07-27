import 'dart:convert';

import 'package:admin_food_delivery/controller/shared_pref.dart';
import 'package:admin_food_delivery/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../api/api.dart';

class SignInController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    //'Authorization': 'Bearer your-token',
  };
  Future<void> showSnack({context, String? text, bool? error}) async {
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

  Future<void> signInWithEmailAndPassword(
      {required BuildContext context}) async {
    Map<String, String> requestBody = {
      "username": emailController.text,
      "password": passwordController.text,
    };

    try {
      indicator(context);
      http.Response response = await http.post(
        Uri.parse(Api.signIn),
        headers: headers,
        body: json.encode(requestBody),
      );
      final data = jsonDecode(response.body);

      emailController.clear();
      passwordController.clear();
      print(response.body);
      if (context.mounted) {
        Navigator.pop(context);
      }
      if (response.statusCode == 200) {
        // log(data['err']);
        final String token = data['data']['accesstoken'];
        await SharedPriference().setApiToken(token);

        if (context.mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }
      } else {
        if (context.mounted) {
          showSnack(context: context, text: data['err'], error: true);
        }
      }
    } catch (e) {
      // Navigator.pop(context);
      showSnack(context: context, text: e.toString(), error: true);
    }
  }

  Future<void> signOut() async {
    await SharedPriference().deleteToken();
  }
}
