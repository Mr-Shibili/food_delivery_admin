import 'package:admin_food_delivery/controller/signin_controller.dart';
import 'package:admin_food_delivery/screens/product/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = context.read<SignInController>();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Log In",
                  style: TextStyle(),
                ),
                khight,
                CustomTextfield1(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Username";
                    } else if (value.length < 8) {
                      return 'Minimum 8 character';
                    } else {
                      return null;
                    }
                  },
                  password: false,
                  hint: "User Name",
                  controller: provider.emailController,
                  inputType: TextInputType.emailAddress,
                ),
                khight,
                CustomTextfield1(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    } else if (value.length < 8) {
                      return 'Minimum 8 charecter';
                    } else {
                      return null;
                    }
                  },
                  password: true,
                  hint: "Password",
                  controller: provider.passwordController,
                  inputType: TextInputType.text,
                ),
                khight,
                ElevatedButton(
                    onPressed: () {
                      provider.signInWithEmailAndPassword(context: context);
                    },
                    child: Text('Sign in')),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
