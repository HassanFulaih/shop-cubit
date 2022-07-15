class Categories {
  bool status;
  CategoriesDataModel data;

  Categories({
    required this.status,
    required this.data,
  });

  factory Categories.fromJson(dynamic json) {
    return Categories(
      status: json['status'],
      data: CategoriesDataModel.fromJson(json['data']),
    );
  }
}

class CategoriesDataModel {
  final int currentPage;
  final List<DataModel> catData;

  CategoriesDataModel({
    required this.currentPage,
    required this.catData,
  });

  factory CategoriesDataModel.fromJson(dynamic json) {
    List<DataModel> data = [];

    json['data'].forEach((item) {
      data.add(DataModel.fromJson(item));
    });

    return CategoriesDataModel(
      currentPage: json['current_page'],
      catData: data,
    );
  }
}

class DataModel {
  final int id;
  final String name;
  final String image;

  DataModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory DataModel.fromJson(json) {
    return DataModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
}
