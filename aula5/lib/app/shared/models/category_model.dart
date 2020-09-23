class CategoryModel {
  int id;
  String name;

  CategoryModel({this.id, this.name});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  static List<CategoryModel> fromMapList(dynamic mapList) {
    List<CategoryModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = CategoryModel.fromJson(mapList[i]);
    }
    return list;
  }
}
