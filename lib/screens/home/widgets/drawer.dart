import 'package:admin_food_delivery/controller/signin_controller.dart';
import 'package:admin_food_delivery/screens/auth_page.dart';
import 'package:admin_food_delivery/screens/category/category.dart';
import 'package:admin_food_delivery/screens/home/home_screen.dart';
import 'package:admin_food_delivery/screens/product/product.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: const Icon(Icons.dashboard),
            press: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            },
          ),
          DrawerListTile(
            title: "Categories",
            icon: const Icon(Icons.category),
            press: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Categories(),
                  ));
            },
          ),
          DrawerListTile(
            title: "Products",
            icon: const Icon(Icons.shopping_cart),
            press: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Product(),
                  ));
            },
          ),
          DrawerListTile(
            title: "Coupons",
            icon: const Icon(Icons.discount),
            press: () {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => AddProductPage(),
              //     ));
            },
          ),
          DrawerListTile(
            title: "History",
            icon: const Icon(Icons.history),
            press: () {},
          ),
          DrawerListTile(
            title: "Users",
            icon: const Icon(Icons.supervised_user_circle_rounded),
            press: () {},
          ),
          DrawerListTile(
            title: "Sign Out",
            icon: const Icon(Icons.logout),
            press: () {
              SignInController().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthPage(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
