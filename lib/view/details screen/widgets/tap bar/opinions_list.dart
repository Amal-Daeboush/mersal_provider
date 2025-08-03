 import 'package:flutter/material.dart';
import 'package:provider_mersal/core/constant/styles.dart';
import 'package:provider_mersal/model/ratings_model.dart';


import '../card_opinion.dart';

class OpinionsList extends StatelessWidget {
    final List<RatingModel> ratings;  final String? message;
  const OpinionsList({super.key, required this.ratings, this.message});

  @override
  Widget build(BuildContext context) {

    return 
    ratings.isEmpty? Center(
      child: Text(message??'لا يوجد تعليقات بعد',style: Styles.style1,),
    ):
    ListView(
      children: [
        ListView.separated(
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(height: 1,),
          ),
          physics:const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: ratings.length,
          itemBuilder: (context, index) =>  CardOpinion(ratingModel: ratings[index],),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
 