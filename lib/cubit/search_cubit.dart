import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../helpers/dio.dart';
import '../models/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  Search? search;

  void getSearch(String value) {
    emit(GetSearchLoadingStatus());
    DioHelper.post(
      'products/search',
      data: {'text': value},
      token: appToken,
    ).then((value) {
      search = Search.fromJson(value.data);
      log(search.toString());
      emit(GetSearchSuccessStatus());
    }).catchError((error) {
      emit(GetSearchErrorStatus(error.toString()));
      throw error;
    });
  }
}
