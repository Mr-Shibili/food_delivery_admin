import 'dart:io';

import 'package:admin_food_delivery/model/category_model.dart';
import 'package:admin_food_delivery/screens/category/add_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controller/category_controller.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.data,
    required this.index,
  });
  final CategoryModel data;

  final int index;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryController>(context, listen: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            kwidth,
            Container(
              height: 50,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[200]),
              child: data.logo == null
                  ? const Icon(Icons.fastfood_rounded)
                  : Image.network(
                      data.logo!,
                      fit: BoxFit.cover,
                    ),
            ),
            kwidth,
            Text(data.name!),
            const Spacer(),
            IconButton(
                onPressed: () {
                  provider.categoryController.text = data.name!;
                  provider.selectedImagepath = data.logo!;
                  // provider.logos = data.logo;
                  provider.isEdit = true;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCategory(index: data.id),
                      ));
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  provider.deleteCategory(data.id!, context);
                },
                icon: const Icon(Icons.delete_rounded))
          ],
        ),
      ),
    );
  }
}
