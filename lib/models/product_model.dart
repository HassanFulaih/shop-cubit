class HomeProduct {
  final bool status;
  final ProductData data;

  HomeProduct({
    required this.status,
    required this.data,
  });

  factory HomeProduct.fromJson(dynamic json) {
    return HomeProduct(
      status: json['status'],
      data: ProductData.fromJson(json['data']),
    );
  }
}

class ProductData {
  final List<BannerModel> banners;
  final List<ProductModel> products;

  ProductData({required this.banners, required this.products});

  factory ProductData.fromJson(json) {
    List<BannerModel> banners = [];
    List<ProductModel> prodcts = [];

    json['banners'].forEach((item) {
      banners.add(BannerModel.fromJson(item));
    });

    json['products'].forEach((item) {
      prodcts.add(ProductModel.fromJson(item));
    });

    return ProductData(
      banners: banners,
      products: prodcts,
    );
  }
}

class BannerModel {
  final int id;
  final String image;

  BannerModel({
    required this.id,
    required this.image,
  });

  factory BannerModel.fromJson(json) {
    return BannerModel(
      id: json['id'] as int,
      image: json['image'] as String,
    );
  }
}

class ProductModel {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final bool inFavorite;
  final bool inCart;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.inFavorite,
    required this.inCart,
  });

  factory ProductModel.fromJson(json) {
    return ProductModel(
      id: json['id'] as int,
      price: json['price'] as dynamic,
      oldPrice: json['old_price'] as dynamic,
      discount: json['discount'] as dynamic,
      image: json['image'] as String,
      name: json['name'] as String,
      inFavorite: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
