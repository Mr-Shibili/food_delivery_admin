class SizeTypeModel {
  final String? sizeid;
  final String? name;
  final String? pricerange;
  SizeTypeModel({
    this.sizeid,
    this.pricerange,
    this.name,
  });

  factory SizeTypeModel.fromJson(Map<dynamic, dynamic> json) => SizeTypeModel(
      name: json['name'],
      sizeid: json['sizeid'],
      pricerange: json['pricerange']);
}
