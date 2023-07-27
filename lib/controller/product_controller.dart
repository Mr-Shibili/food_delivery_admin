import 'dart:convert';
import 'dart:developer';
import 'package:admin_food_delivery/controller/shared_pref.dart';
import 'package:admin_food_delivery/model/food_types.dart';
import 'package:admin_food_delivery/model/product_get_model.dart';
import 'package:admin_food_delivery/model/product_model.dart';
import 'package:admin_food_delivery/model/size_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../api/api.dart';
import '../model/category_model.dart';

class ProductController with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController calorieController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String? selectedCategory;
  String? selectedtype;
  List<CategoryModel> categoriesData = [];
  List<ProductModel> productData = [];
  List<FoodTypeModel> foodTypes = [];
  List<SizeTypeModel> sizeTypes = [];
  Set filters = {};
  List? productimage = [];
  bool available = true;

  Future<void> getCategories() async {
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
        //  log(categoriesData.toString());
        notifyListeners();
      } else {
        log('error');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getProducts() async {
    final token = await SharedPriference().getApiToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(Api.getProduct),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> tempList = responseData['data']['products'];

        productData = tempList.map((e) => ProductModel.fromJson(e)).toList();
        log(tempList[0].toString());
        //
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
          productimage!.add(body['data']['imageurl']);
          // log(response.statusCode.toString());
        } else {
          log('error');
        }
      }
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  Future<void> showSnack({context, String? text, bool? error}) async {
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

  void selectSize(bool selected, SizeTypeModel size) {
    if (selected) {
      filters.add(size.sizeid);
    } else {
      filters.remove(size.sizeid);
    }
    print(filters);
    notifyListeners();
  }

  void switchbutton(bool value) {
    available = value;
    print(available);
    notifyListeners();
  }

  void clear() {
    productimage!.clear();
    selectedCategory = null;
    selectedtype = null;
    filters.clear();
    notifyListeners();
  }

  void selectCategory(value) {
    selectedCategory = value;
    notifyListeners();
  }

  void selecttype(value) {
    selectedtype = value;
    notifyListeners();
  }

  Future<void> addProduct(context) async {
    final token = await SharedPriference().getApiToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final data = ProductModel(
        productname: nameController.text,
        calories: calorieController.text,
        availablity: available,
        baseprice: double.parse(priceController.text),
        categoryid: selectedCategory,
        imageurl: productimage,
        sizeid: filters.toList(),
        typeid: selectedtype);

    Map<String, dynamic> requestBody = {
      "productname": data.productname,
      "calories": data.calories,
      "availibility": data.availablity,
      "categoryid": data.categoryid,
      "typeid": data.typeid,
      "baseprice": data.baseprice,
      "sizeid": data.sizeid,
      "imageurls": data.imageurl
    };

    try {
      indicator(context);
      http.Response response = await http.post(
        Uri.parse(Api.addProduct),
        headers: headers,
        body: jsonEncode(requestBody),
      );
      final data = jsonDecode(response.body);
      //log(data.toString());
      //log(response.statusCode.toString());

      if (response.statusCode == 200) {
        clear();
        getProducts();
        Navigator.pop(context);
        showSnack(
            context: context, error: false, text: "Product added successfully");
      } else {
        if (context) {
          showSnack(context: context, text: data['err'], error: true);
        }
      }
    } catch (e) {
      Navigator.pop(context);
      showSnack(context: context, text: e.toString(), error: true);
    }
  }

  Future<void> getType() async {
    final token = await SharedPriference().getApiToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(Api.getType),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> tempList = responseData['data']['foodtypes'];
        foodTypes = tempList.map((e) => FoodTypeModel.fromJson(e)).toList();
        // log(foodTypes.toString());
        notifyListeners();
      } else {
        log('error');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getSize() async {
    final token = await SharedPriference().getApiToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(
        Uri.parse(Api.getSize),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> tempList = responseData['data']['sizes'];
        sizeTypes = tempList.map((e) => SizeTypeModel.fromJson(e)).toList();
        // log(sizeTypes.toString());
        notifyListeners();
      } else {
        log('error');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
