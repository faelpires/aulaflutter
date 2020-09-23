class ProductModel {
  int id;
  String name;
  String brand;
  String url;
  int categoryId;

  ProductModel({
    this.id,
    this.name,
    this.brand,
    this.url,
    this.categoryId,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brand = json['brand'];
    url = json['url'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    data['name'] = this.name;
    if (this.brand != null) data['brand'] = this.brand;
    if (this.url != null) data['url'] = this.url;
    data['categoryId'] = this.categoryId;

    return data;
  }

  static List<ProductModel> fromMapList(dynamic mapList) {
    List<ProductModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = ProductModel.fromJson(mapList[i]);
    }
    return list;
  }
}
