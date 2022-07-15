class Favourites {
  bool status;
  String message;
  Data? date;

  Favourites({
    required this.status,
    required this.message,
    required this.date,
  });

  factory Favourites.fromJson(Map<String, dynamic> json) {
    return Favourites(
      status: json['status'],
      message: json['message'],
      date: json['data'] == null ? null : Data.fromJson(json['data']),
    );
  }
}

class Data {
  final int from;
  final int currentPage;
  final List<FavData> data;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String pervPageUrl;
  final int to;
  final int total;

  Data({
    required this.from,
    required this.currentPage,
    required this.data,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.pervPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(json) {
    return Data(
      from: json['from'] as int,
      currentPage: json['current_page'] as int,
      data:
          (json['data'] as List).map((item) => FavData.fromJson(item)).toList(),
      lastPage: json['last_page'] as int,
      lastPageUrl: json['last_page_url'] as String,
      nextPageUrl: json['next_page_url'] as String,
      path: json['path'] as String,
      perPage: json['per_page'] as int,
      pervPageUrl: json['prev_page_url'] as String,
      to: json['to'] as int,
      total: json['total'] as int,
    );
  }
}

class FavData {
  final int id;
  final Product product;
  FavData({
    required this.id,
    required this.product,
  });

  factory FavData.fromJson(json) {
    return FavData(
      id: json['id'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final String description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory Product.fromJson(json) {
    return Product(
      id: json['id'],
      price: json['price'],
      oldPrice: json['oldPrice'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
