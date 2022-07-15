class Search {
  bool status;
  String? message;
  SearchDataModel? data;

  Search({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      status: json['status'],
      message: json['message'],
      data:
          json['data'] == null ? null : SearchDataModel.fromJson(json['data']),
    );
  }
}

class SearchDataModel {
  final int currentPage;
  final List<SearchItemModel> searchData;

  SearchDataModel({
    required this.currentPage,
    required this.searchData,
  });

  factory SearchDataModel.fromJson(dynamic json) {
    return SearchDataModel(
      currentPage: json['current_page'],
      searchData: json['data'].map<SearchItemModel>((item) {
        return SearchItemModel.fromJson(item);
      }).toList(),
    );
  }
}

class SearchItemModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final String description;
  final bool inFavorites;
  final bool inCart;

  SearchItemModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.inFavorites,
    required this.inCart,
  });

  factory SearchItemModel.fromJson(json) {
    return SearchItemModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
