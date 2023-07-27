import 'package:admin_food_delivery/constants.dart';
import 'package:admin_food_delivery/screens/home/widgets/drawer.dart';
import 'package:admin_food_delivery/screens/product/product.dart';
import 'package:admin_food_delivery/screens/users/users_screen.dart';
import 'package:flutter/material.dart';

import '../category/category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        centerTitle: true,
      ),
      drawer: const SideMenu(),
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                  height: 120,
                  width: 175,
                  decoration: kboxStyle,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''),
                      khight,
                      Text('Products'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Product(),
                      ));
                },
              ),
              InkWell(
                child: Container(
                  height: 120,
                  width: 175,
                  decoration: kboxStyle,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''),
                      khight,
                      Text('Categories'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Categories(),
                      ));
                },
              ),
            ],
          ),
          khight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                  height: 120,
                  width: 175,
                  decoration: kboxStyle,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''),
                      khight,
                      Text('Users'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPage(),
                      ));
                },
              ),
              InkWell(
                child: Container(
                  height: 120,
                  width: 175,
                  decoration: kboxStyle,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(''),
                      khight,
                      Text('History'),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Categories(),
                      ));
                },
              ),
            ],
          )
        ]),
      ),
    );
  }
}
