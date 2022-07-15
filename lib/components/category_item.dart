import 'package:flutter/material.dart';

import '../models/categories_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.model}) : super(key: key);

  final DataModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Center(
          child: Image.network(
            model.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              //fontSize: 10,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
