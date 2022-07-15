import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/dio.dart';
import '../models/login_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordShown = true;

  void changeVisibility() {
    isPasswordShown = !isPasswordShown;
    emit(ChangeVisibilityState());
  }

  Login? userItem;

  void userLoginOrRegister({
    String? name,
    required String email,
    String? phone,
    required String password,
    required String type,
  }) {
    emit(LoginLoadingState());
    DioHelper.post(
      type,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      log(value.data.toString());
      userItem = Login.fromJson(value.data);
      emit(LoginSuccessState(userItem));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      log(error.toString());
    });
  }
}
