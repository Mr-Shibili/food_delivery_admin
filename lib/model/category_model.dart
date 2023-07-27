class CategoryModel {
  final String? name;
  final String? logo;
  final String? id;
  CategoryModel({required this.name, required this.logo, required this.id});

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) => CategoryModel(
      name: json['categgoryName'], logo: json['imageurl'], id: json['id']);
}
