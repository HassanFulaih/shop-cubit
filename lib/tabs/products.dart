import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/product_item.dart';
import '../cubit/shop_cubit.dart';
import '../cubit/shop_state.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavSuccessStatus) {
          if (!state.changeFavourites.status)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Could not change favourites'),
              ),
            );
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return cubit.shopData == null || cubit.categoriesData == null
            ? const Center(child: CircularProgressIndicator())
            : ProductItem(
                shopData: cubit.shopData!,
                categoriesData: cubit.categoriesData!,
                favorites: cubit.favorites,
                changeFavorites: cubit.changeFavorites,
              );
      },
    );
  }
}
