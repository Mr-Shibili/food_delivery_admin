import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:admin_food_delivery/controller/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import '../model/category_model.dart';

class CategoryController with ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  bool isEdit = false;
  TextEditingController categoryController = TextEditingController();
  String? selectedImagepath;
  String? selectedCategory;

  File? logos;
  List<CategoryModel>? categoriesData = [];

  Future<void> pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    final token = await SharedPriference().getApiToken();
    try {
      if (image != null) {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(Api.addImage),
        );
        request.headers['Authorization'] = 'Bearer $token';
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            image.path,
          ),
        );
        var response = await request.send();
        var responsed = await http.Response.fromStream(response);
        if (response.statusCode == 200) {
          var body = jsonDecode(responsed.body);
          selectedImagepath = body['data']['imageurl'];
          log(response.statusCode.toString());
        } else {
          log('error');
        }
      }
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
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

  Future<void> addCategory(context) async {
    final token = await SharedPriference().getApiToken();
    Response? responseCategory;
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      indicator(context);
      if (categoryController.text.isNotEmpty && selectedImagepath != null) {
        Map<String, dynamic> requestBody = {
          "categoryname": categoryController.text,
          "imageurl": selectedImagepath,
        };

        responseCategory = await http.post(
          Uri.parse(Api.categoryAdd),
          headers: header,
          body: json.encode(requestBody),
        );
      } else {
        showSnack(context: context, text: 'Add all data', error: true);
      }

      if (responseCategory!.statusCode == 200) {
        Navigator.pop(context);
        showSnack(context: context, error: false, text: "Category Added");
        categoryController.clear();
        selectedImagepath = null;
        getAllCategory();
      } else {
        showSnack(context: context, text: 'Something went wrong', error: true);
      }
    } catch (e) {
      Navigator.pop(context);
      log(e.toString());
    }
  }

  Future<void> editCategory(String id, context) async {
    final token = await SharedPriference().getApiToken();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      Map<String, dynamic> requestBody = {
        "id": id,
        "categoryname": categoryController.text,
        "imageurl": selectedImagepath,
      };
      http.Response response = await http.put(
        Uri.parse(Api.editCategory),
        headers: header,
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        log('edited ');
        categoryController.clear();
        selectedImagepath = null;
        showSnack(context: context, text: 'Edited Category', error: false);
        getAllCategory();
      } else {
        log('something went wrong');
        showSnack(context: context, text: 'Something went wrong', error: true);
      }
    } catch (e) {
      log(e.toString());
      showSnack(context: context, text: 'no response', error: true);
    }
  }

  Future<void> getAllCategory() async {
    final token = await SharedPriference().getApiToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(Api.getCategories),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> tempList = responseData['data']['categories'];

        categoriesData =
            tempList.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        log('error');
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  Future<void> deleteCategory(String id, context) async {
    final token = await SharedPriference().getApiToken();
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      String deleteUrl = 'http://3.110.170.212:8000/category/delete?id=';
      final response =
          await http.delete(Uri.parse(deleteUrl + id), headers: header);
      getAllCategory();
      if (response.statusCode == 200) {
        log(response.statusCode.toString());

        showSnack(context: context, text: 'Deleted', error: false);
      } else {
        log(response.body);
        showSnack(context: context, text: 'Something went wrong', error: true);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
