import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/constant/app_image_asset.dart';

class ImagesList extends StatelessWidget {
  const ImagesList({super.key});

  @override
  Widget build(BuildContext context) {
    List images = [
      AppImageAsset.im1,
      AppImageAsset.im2,
      AppImageAsset.im3,
      AppImageAsset.im1
    ];
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
              child: Image.asset(
                images[index],
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
