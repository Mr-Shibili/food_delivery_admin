import 'dart:developer';

import 'package:admin_food_delivery/controller/product_controller.dart';
import 'package:admin_food_delivery/controller/product_crud.dart';

import 'package:admin_food_delivery/screens/home/widgets/drawer.dart';
import 'package:admin_food_delivery/screens/product/view_product.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'add_product.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    final pro = context.read<ProductController>();
    final providercrud = context.read<ProductCrud>();
    pro.getProducts();

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Consumer<ProductController>(builder: (context, provider, _) {
                final list = provider.productData;
                return GridView.builder(
                  itemCount: list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 6 / 2.1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) => Container(
                    decoration: kboxStyle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          await providercrud.getAProduct(list[index].id!);
                          // ignore: use_build_context_synchronously
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              log(providercrud.product!.sizeandprice
                                  .toString());
                              return ViewForm(
                                  data: providercrud.product!,
                                  size: providercrud.product!.sizeandprice);
                            },
                          );
                        },
                        child: Row(children: [
                          CircleAvatar(
                            minRadius: 25,
                            backgroundImage:
                                NetworkImage(list[index].imageurl![0]),
                          ),
                          kwidth,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list[index].productname!,
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                "₹ ${list[index].baseprice!}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          )
                        ]),
                      ),
                    ),
                  ),
                );
              }))),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProduct(isedit: false),
                ));
          },
          child: const Text('Add Product')),
    );
  }
}
