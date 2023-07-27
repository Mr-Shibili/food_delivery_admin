import 'dart:developer';
import 'dart:io';

import 'package:admin_food_delivery/constants.dart';
import 'package:admin_food_delivery/controller/category_controller.dart';
import 'package:admin_food_delivery/controller/product_controller.dart';
import 'package:admin_food_delivery/model/category_model.dart';
import 'package:admin_food_delivery/model/product_get_model.dart';
import 'package:admin_food_delivery/model/product_model.dart';
import 'package:admin_food_delivery/screens/category/widget/custom_text_field.dart';
import 'package:admin_food_delivery/screens/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key, required this.isedit, this.data});
  final _formKey = GlobalKey<FormState>();
  final bool isedit;
  late final GetProductModel? data;
  @override
  Widget build(BuildContext context) {
    final controllerread = context.read<ProductController>();
    controllerread.getCategories();
    controllerread.getType();
    controllerread.getSize();
    return Scaffold(
        appBar: AppBar(
          title: isedit == true ? Text('Edit Product') : Text('Add Product'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    khight,
                    // InkWell(
                    //   onTap: () {
                    //     controllerread.pickImage();
                    //     print('HIIHIIHIHIHHIHI');
                    //   },
                    //   child: Container(
                    //     height: 100,
                    //     width: 90,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color: Colors.green[200]),
                    //     child: controllerread.images.isEmpty
                    //         ? const Icon(Icons.add_a_photo_outlined)
                    //         : Image(image: FileImage(File('')), fit: BoxFit.cover),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () async {
                        print('clicked');
                        controllerread.pickImage();
                      },
                      child: Consumer<ProductController>(
                          builder: (context, pro, _) {
                        return Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green[200]),
                            child: pro.productimage!.isEmpty
                                ? const Icon(Icons.camera_alt)
                                : Image.network(
                                    pro.productimage![0]!,
                                    fit: BoxFit.cover,
                                  ));
                      }),
                    ),
                    khight,
                    // Consumer<ProductController>(builder: (context, control, _) {
                    //   return Wrap(
                    //     children: List.generate(controllerread.productimages.length,
                    //         (index) {
                    //       log(control.productimages[index].path);
                    //       // var img = File(control.productimages[index].path);
                    //       return Stack(
                    //         children: [
                    //           Container(
                    //             width: 80,
                    //             height: 100,
                    //             child: Image.file(
                    //                 File(control.productimages[index].path)),
                    //           ),
                    //           Positioned(
                    //             top: -15,
                    //             right: -15,
                    //             child: IconButton(
                    //               icon: Icon(Icons.remove_circle),
                    //               color: Colors.red,
                    //               onPressed: () {
                    //                 control.deleteImage(index);
                    //               },
                    //             ),
                    //           ),
                    //         ],
                    //       );
                    //     }),
                    //   );
                    // }),
                    khight,
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter product name';
                        }
                        return null;
                      },
                      hint: 'Product name',
                      controller: controllerread.nameController,
                    ),
                    khight,
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                          type: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Price';
                            }
                            return null;
                          },
                          hint: 'Base price',
                          controller: controllerread.priceController,
                        )),
                        kwidth,
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: Consumer<ProductController>(
                                builder: (context, pro, _) {
                              if (pro.categoriesData.isEmpty) {
                                return Text('loading...');
                              } else {
                                return DropdownButton(
                                    value: pro.selectedCategory,
                                    hint: const Text('Categories'),
                                    onChanged: (value) {
                                      print(value);
                                      pro.selectCategory(value);
                                    },
                                    items: pro.categoriesData
                                        .map<DropdownMenuItem>((value) {
                                      return DropdownMenuItem(
                                        value: value.id,
                                        child: Text(value.name!),
                                      );
                                    }).toList());
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                    khight,
                    Row(
                      children: [
                        Expanded(
                            child: CustomTextField(
                          type: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter calorie';
                            }
                            return null;
                          },
                          hint: 'Calories',
                          controller: controllerread.calorieController,
                        )),
                        kwidth,
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: Consumer<ProductController>(
                                builder: (context, pro, _) {
                              if (pro.foodTypes.isEmpty) {
                                return Text('loading...');
                              } else {
                                return DropdownButton(
                                    value: pro.selectedtype,
                                    hint: const Text('Types'),
                                    onChanged: (value) {
                                      print(value);
                                      pro.selecttype(value);
                                    },
                                    items: pro.foodTypes
                                        .map<DropdownMenuItem>((value) {
                                      return DropdownMenuItem(
                                        value: value.typeid,
                                        child: Text(value.name!),
                                      );
                                    }).toList());
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                    khight,
                    Consumer<ProductController>(builder: (context, pro, _) {
                      return Wrap(
                        spacing: 8,
                        children: pro.sizeTypes.map((size) {
                          return FilterChip(
                            showCheckmark: false,
                            label: Text(size.name!),
                            selected: pro.filters.contains(size.sizeid),
                            onSelected: (bool selected) {
                              pro.selectSize(selected, size);
                            },
                          );
                        }).toList(),
                      );
                    }),
                    khight,
                    Consumer<ProductController>(builder: (context, contr, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          contr.available == true
                              ? const Text('Available')
                              : const Text('Unavailable'),
                          kwidth,
                          Switch(
                            value: contr.available,
                            onChanged: (value) {
                              contr.switchbutton(value);
                            },
                          )
                        ],
                      );
                    }),
                    khight,
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (isedit == true) {
                              log('edit ');
                            } else {
                              await controllerread.addProduct(context).then(
                                  (value) => _formKey.currentState!.reset());
                            }
                          }
                        },
                        child: isedit == true
                            ? Text("Edit Product")
                            : Text('Add Product'))
                  ],
                )),
          ),
        )));
  }
}
