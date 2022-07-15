import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/fav_item.dart';
import '../cubit/shop_cubit.dart';
import '../cubit/shop_state.dart';
import '../models/favourites_model.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return cubit.favouritesData!.date == null
            ? Center(child: Text(cubit.favouritesData!.message))
            : state is! ShopGetFavLoadingStatus
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cubit.favouritesData!.date!.data.length,
                    itemBuilder: (context, index) {
                      final FavData fav =
                          cubit.favouritesData!.date!.data[index];
                      return FavItem(model: fav.product);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  )
                : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
