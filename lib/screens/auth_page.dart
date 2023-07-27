import 'package:admin_food_delivery/screens/auth_signin.dart';
import 'package:admin_food_delivery/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../controller/shared_pref.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: SharedPriference().getApiToken(),
        builder: (context, snapshot) {
          //log in
          if (snapshot.hasData) {
            return HomeScreen();
          }

          //not log in
          else {
            return LogInScreen();
          }
        },
      ),
    );
  }
}
