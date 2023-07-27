import 'dart:convert';
import 'dart:developer';
import 'package:admin_food_delivery/controller/product_controller.dart';
import 'package:admin_food_delivery/controller/shared_pref.dart';
import 'package:admin_food_delivery/model/product_get_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';

class ProductCrud with ChangeNotifier {
  GetProductModel? product;
  Future<void> getAProduct(String id) async {
    final token = await SharedPriference().getApiToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print(token);
    try {
      final response = await http.get(
        Uri.parse(Api.getAProduct + id),
        headers: headers,
      );
      // log(id);
      // log(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final tempData = responseData['data'];
        log(responseData.toString());
        log(tempData.toString());
        // List<dynamic> tempDataSize = responseData['data']['sizeandprice'];
        // print(tempDataSize.toString());
        // print(tempData.toString());

        product = GetProductModel.fromJson(tempData);
        // List<Sizeandprice> tempsize =
        //     tempDataSize.map((e) => Sizeandprice.fromJson(e)).toList();

        log(product.toString());

        // log(response.statusCode.toString());

        notifyListeners();
      } else {
        log('error');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> showSnack(
      {required context, required String? text, required bool? error}) async {
    final snackBar = SnackBar(
      backgroundColor: error == true ? Colors.red : Colors.green,
      content: Text(text!),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  indicator(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> deleteProduct(String id, context) async {
    final token = await SharedPriference().getApiToken();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      final response =
          await http.delete(Uri.parse(Api.deleteProduct + id), headers: header);
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        showSnack(context: context, text: 'Deleted', error: true);
      } else {
        log(response.body);
        showSnack(context: context, text: 'Something went wrong', error: true);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
