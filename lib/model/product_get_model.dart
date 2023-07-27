class GetProductModel {
  GetProductModel({
    required this.status,
    required this.error,
    required this.pid,
    required this.name,
    required this.calories,
    required this.availibilty,
    required this.categoryname,
    required this.typename,
    required this.sizeandprice,
    required this.imagelink,
    required this.baseprice,
  });
  late final int status;
  late final String error;
  late final String pid;
  late final String name;
  late final String calories;
  late final bool availibilty;
  late final String categoryname;
  late final String typename;
  late final List<Sizeandprice> sizeandprice;
  late final List<String> imagelink;
  late final num? baseprice;

  GetProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    pid = json['pid'];
    name = json['name'];
    calories = json['calories'];
    availibilty = json['availibilty'];
    categoryname = json['categoryname'];
    typename = json['typename'];
    sizeandprice = List.from(json['sizeandprice'])
        .map((e) => Sizeandprice.fromJson(e))
        .toList();
    imagelink = List.castFrom<dynamic, String>(json['imagelink']);
    baseprice = (json['baseprice']);
  }
}

class Sizeandprice {
  Sizeandprice({
    required this.sizeid,
    required this.name,
    required this.pricerange,
  });
  late final String sizeid;
  late final String name;
  late final String pricerange;

  Sizeandprice.fromJson(Map<String, dynamic> json) {
    sizeid = json['sizeid'];
    name = json['name'];
    pricerange = json['pricerange'];
  }
}
