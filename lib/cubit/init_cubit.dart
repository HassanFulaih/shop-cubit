import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/cache.dart';
import 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  InitCubit() : super(ThemeInitialState());

  static InitCubit get(context) => BlocProvider.of(context);

  bool onBoarding = false;
  String token = '222';
  //b676yF4HQTAGtP9bYNM2kjAw3VZ6vd63Ar7dr7jQvhISokVKIK5K3Emr4tiPctOBgBlZhV

  void takeCachedData() {
    bool? onB_ = CacheHelper.getData('on_boarding');
    String? token_ = CacheHelper.getData('token');

    if (onB_ != null) {
      onBoarding = onB_;
    }
    if (token_ != null) {
      log('token: $token_');
      token = token_;
      //appToken = token_;
    }
  }
}
