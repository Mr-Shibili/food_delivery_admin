import 'package:admin_food_delivery/controller/product_controller.dart';
import 'package:admin_food_delivery/controller/product_crud.dart';
import 'package:admin_food_delivery/model/product_get_model.dart';
import 'package:admin_food_delivery/screens/product/add_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class ViewForm extends StatelessWidget {
  const ViewForm({
    super.key,
    required this.data,
    required this.size,
  });

  final GetProductModel data;
  final List<Sizeandprice> size;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProductCrud>();
    final provider = context.read<ProductController>();
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            khight,
            Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green[200]),
                child: Image.network(
                  data.imagelink[0],
                  fit: BoxFit.cover,
                )),
            khight,
            Row(
              children: [Text('Product Name : '), Text(data.name)],
            ),
            khight,
            Row(
              children: [const Text('calories : '), Text(data.calories)],
            ),
            khight,
            Row(
              children: [
                Text('Availability : '),
                Text(data.availibilty.toString())
              ],
            ),
            khight,
            Row(
              children: [Text('Category : '), Text(data.categoryname)],
            ),
            khight,
            Row(
              children: [Text('Type : '), Text(data.typename)],
            ),
            khight,
            Row(
              children: [
                Text('Price: '),
                Wrap(
                  direction: Axis.horizontal,
                  children: size
                      .map(
                          (item) => Text(" ${item.name} - ${item.pricerange} "))
                      .toList(),
                ),
              ],
            ),
            khight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddProduct(isedit: true),
                          ));
                    },
                    child: Text('Update')),
                ElevatedButton(
                    onPressed: () {
                      controller
                          .deleteProduct(data.pid, context)
                          .then((value) => provider.getProducts());
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
