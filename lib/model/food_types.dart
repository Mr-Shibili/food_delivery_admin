class FoodTypeModel {
  final String? typeid;
  final String? name;
  final String? imageurl;
  FoodTypeModel({
    this.typeid,
    this.imageurl,
    this.name,
  });

  factory FoodTypeModel.fromJson(Map<dynamic, dynamic> json) => FoodTypeModel(
      name: json['name'], typeid: json['typeid'], imageurl: json['imageurl']);
}
