import 'package:admin_food_delivery/constants.dart';
import 'package:admin_food_delivery/controller/category_controller.dart';
import 'package:admin_food_delivery/controller/menu_controller.dart';
import 'package:admin_food_delivery/controller/product_controller.dart';
import 'package:admin_food_delivery/controller/product_crud.dart';
import 'package:admin_food_delivery/controller/signin_controller.dart';
import 'package:admin_food_delivery/screens/auth_page.dart';
import 'package:admin_food_delivery/screens/home/home_screen.dart';
import 'package:admin_food_delivery/screens/product/product.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MenuAppController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => SignInController()),
        ChangeNotifierProvider(create: (context) => ProductCrud()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Admin Panel',
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: const AuthPage(),
      ),
    );
  }
}
