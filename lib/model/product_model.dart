class ProductModel {
  final String? productname, calories, categoryid, typeid, id;
  num? baseprice;
  List? sizeid = [];
  List? imageurl = [];
  final bool? availablity;
  ProductModel(
      {this.id,
      this.productname,
      this.calories,
      this.categoryid,
      this.typeid,
      this.imageurl,
      this.sizeid,
      this.baseprice,
      this.availablity});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        productname: json["name"],
        calories: json['calories'],
        availablity: json['availablity'],
        categoryid: json['categoryid'],
        typeid: json['typeid'],
        baseprice: (json['baseprice']),
        sizeid: List.from(json['sizeid']),
        imageurl: List.from(json['imagelink']),
      );
}

// enum Sizes { regular, small, medium, large, thers }
