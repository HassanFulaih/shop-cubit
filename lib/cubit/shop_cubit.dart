import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../helpers/dio.dart';
import '../models/categories_model.dart';
import '../models/change_fav_model.dart';
import '../models/favourites_model.dart';
import '../models/login_model.dart';
import '../models/product_model.dart';
import '../tabs/category.dart';
import '../tabs/favorites.dart';
import '../tabs/products.dart';
import '../tabs/search.dart';
import '../tabs/settings.dart';
import 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
    emit(ShopBottomNavStatus());
    // if (currentIndex == 1) {
    //   getSports();
    // } else if (currentIndex == 2) {
    //   getScience();
    // }
  }

  Map<int, bool> favorites = {};

  HomeProduct? shopData;

  void getShopData() {
    emit(ShopGetLoadingStatus());
    DioHelper.get('home', token: appToken).then((value) {
      shopData = HomeProduct.fromJson(value.data);
      if (shopData != null)
        shopData!.data.products.map((element) {
          favorites.addAll({element.id: element.inFavorite});
        });
      emit(ShopGetSuccessStatus());
    }).catchError((error) {
      log('error: $error');
      emit(ShopGetErrorStatus(error));
    });
  }

  ChangeFavourites? changeFavourites;

  changeFavorites(int id) {
    emit(ShopChangeFavLoadingStatus());

    favorites[id] = !(favorites[id] ?? false);
    emit(ShopChangeFavStatus());

    DioHelper.post(
      'favorites',
      token: appToken,
      data: {'product_id': id},
    ).then((value) {
      changeFavourites = ChangeFavourites.fromJson(value.data);

      if (!changeFavourites!.status)
        favorites[id] = !favorites[id]!;
      else
        getFavouritesData();

      log('success change fav: ${value.data}');
      emit(ShopChangeFavSuccessStatus(changeFavourites!));
    }).catchError((error) {
      log('error: $error');
      emit(ShopChangeFavErrorStatus(error));
    });
  }

  Categories? categoriesData;

  void getCategoriesData() {
    emit(ShopGetCategoryLoadingStatus());
    DioHelper.get('categories', token: appToken).then((value) {
      categoriesData = Categories.fromJson(value.data);
      emit(ShopGetCategorySuccessStatus());
    }).catchError((error) {
      log('error: $error');
      emit(ShopGetCategoryErrorStatus(error));
    });
  }

  Favourites? favouritesData;

  void getFavouritesData() {
    emit(ShopGetFavLoadingStatus());
    DioHelper.get('favorites', token: appToken).then((value) {
      favouritesData = Favourites.fromJson(value.data);
      log(value.data.toString());
      emit(ShopGetFavSuccessStatus());
    }).catchError((error) {
      log('error: $error');
      emit(ShopGetFavErrorStatus(error.toString()));
    });
  }

  Login? userData;

  void getUserData() {
    emit(ShopUserDataLoadingStatus());
    DioHelper.get('profile', token: appToken).then((value) {
      userData = Login.fromJson(value.data);
      log(value.data.toString());
      emit(ShopUserDataSuccessStatus(userData!));
    }).catchError((error) {
      emit(ShopUserDataErrorStatus(error.toString()));
      throw error;
    });
  }

  List<Widget> screens = [
    const Products(),
    const Category(),
    const Favorites(),
    Search(),
    Settings(),
  ];

  List<String> titles = const [
    'Shopella',
    'Category',
    'Favorites',
    'Search',
    'Settings',
  ];
}
