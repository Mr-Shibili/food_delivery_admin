import 'dart:io';

import 'package:admin_food_delivery/controller/category_controller.dart';
import 'package:admin_food_delivery/screens/category/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class AddCategory extends StatelessWidget {
  AddCategory({super.key, this.index});
  String hint = 'Category name';
  String? index;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CategoryController>();

    return Scaffold(
      appBar: AppBar(
        title: provider.isEdit == false
            ? Text('Add Category')
            : Text('Edit Category'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(children: [
            InkWell(
              onTap: () async {
                print('clicked');
                provider.pickImage();
              },
              child: Consumer<CategoryController>(builder: (context, pro, _) {
                return Container(
                    height: 100,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[200]),
                    child: pro.selectedImagepath == null
                        ? const Icon(Icons.camera_alt)
                        : Image.network(
                            pro.selectedImagepath!,
                            fit: BoxFit.cover,
                          ));
              }),
            ),
            khight,
            CustomTextField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category';
                  }
                  return null;
                },
                hint: hint,
                controller: provider.categoryController),
            khight,
            ElevatedButton(
                onPressed: () {
                  if (provider.isEdit == false) {
                    provider.addCategory(context);
                  } else {
                    provider.editCategory(index!, context);
                    Navigator.pop(context);
                  }
                },
                child: provider.isEdit == false
                    ? Text('Add Category')
                    : Text('Update'))
          ]),
        ),
      ),
    );
  }
}
