import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/bloc_observer.dart';
import 'cubit/login_cubit.dart';
import 'cubit/search_cubit.dart';
import 'cubit/shop_cubit.dart';
import 'cubit/init_cubit.dart';
import 'cubit/init_state.dart';
import 'helpers/cache.dart';
import 'helpers/dio.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/on_boarding.dart';
import 'styles/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      await CacheHelper.init();
      DioHelper.init();
      return runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider<InitCubit>(
              create: (context) => InitCubit()..takeCachedData(),
            ),
            BlocProvider<LoginCubit>(
              create: (context) => LoginCubit(),
            ),
            BlocProvider<ShopCubit>(
              create: (context) => ShopCubit()
                ..getShopData()
                ..getCategoriesData()
                ..getFavouritesData()
                ..getUserData(),
            ),
            BlocProvider<SearchCubit>(
              create: (context) => SearchCubit(),
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InitCubit, InitState>(
      listener: (context, state) {},
      builder: (context, state) {
        InitCubit cubit = InitCubit.get(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: theme,
          home: cubit.onBoarding
              ? (cubit.token.isNotEmpty ? const HomePage() : LoginPage())
              : const OnBoardingPage(),
        );
      },
    );
  }
}
