import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../models/categories_model.dart';
import '../models/product_model.dart';
import 'category_item.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.shopData,
    required this.categoriesData,
    required this.favorites,
    required this.changeFavorites,
  }) : super(key: key);

  final HomeProduct shopData;
  final Categories categoriesData;
  final Map<int, bool> favorites;
  final Function(int id) changeFavorites;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: shopData.data.banners.map((product) {
              return Image.network(
                product.image,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              //height: 250,
              initialPage: 0,
              reverse: false,
              scrollDirection: Axis.horizontal,
              //viewportFraction: 1,
              //aspectRatio: 2.0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categoriesData.data.catData.length,
                    itemBuilder: (context, index) {
                      return CategoryItem(
                        model: categoriesData.data.catData[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.0 / 1.4,
              padding: const EdgeInsets.all(2),
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              children: List.generate(
                shopData.data.products.length,
                (index) {
                  final model = shopData.data.products[index];
                  return Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Center(
                              child: Image.network(
                                model.image,
                                //width: double.infinity,
                                height: 190,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (model.discount != 0)
                              Container(
                                color: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: const Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    const TextStyle(fontSize: 13, height: 1.3),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '${model.price.round()}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  if (model.discount != 0)
                                    Text(
                                      '${model.oldPrice.round()}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () => changeFavorites(model.id),
                                    icon: Icon(
                                      favorites[model.id] == true
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: favorites[model.id] == true
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
