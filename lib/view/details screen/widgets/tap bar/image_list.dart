import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider_mersal/model/produt_model.dart' as Product;


class ImagesList extends StatelessWidget {
    final List<Product.Image> images;
  const ImagesList({super.key, required this.images});

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        GridView.custom(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 0,
            pattern: const [
              WovenGridTile(1),
              WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(8), // Add rounded corners
              child: Image.network(
                images[index].url,
                fit: BoxFit.cover, // Ensure images fit tiles
              ),
            ),
            childCount: images.length, // Ensure the list length matches
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
