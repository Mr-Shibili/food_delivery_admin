import 'dart:developer';

import 'package:admin_food_delivery/constants.dart';
import 'package:admin_food_delivery/controller/category_controller.dart';
import 'package:admin_food_delivery/model/category_model.dart';
import 'package:admin_food_delivery/screens/category/add_category.dart';
import 'package:admin_food_delivery/screens/category/widget/category_card.dart';
import 'package:admin_food_delivery/screens/category/widget/custom_text_field.dart';
import 'package:admin_food_delivery/screens/home/widgets/drawer.dart';
import 'package:admin_food_delivery/screens/product/add_product.dart';
import 'package:admin_food_delivery/screens/product/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  Categories({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryController>().getAllCategory();
    final provider = context.read<CategoryController>();
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text('Categories'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Consumer<CategoryController>(builder: (context, controller, _) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.categoriesData!.length,
              itemBuilder: (context, index) {
                if (controller.categoriesData!.isEmpty) {
                  return const Center(child: Text('No data'));
                } else {
                  final List<CategoryModel> result =
                      controller.categoriesData!.reversed.toList();

                  return CategoryCard(
                    data: result[index],
                    index: index,
                  );
                }
              });
        }),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            provider.isEdit = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCategory(),
                ));
          },
          child: const Text('Add Category')),
    );
  }
}
