import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../core/constant/app_colors.dart';

Widget customLoadingIndictor() {
  return const LoadingIndicator(
    indicatorType: Indicator.ballBeat,

    /// Required, The loading type of the widget
    colors: [AppColors.primaryColor],

    /// Optional, The color collections
    strokeWidth: 1,

    /// Optional, The stroke of the line, only applicable to widget which contains line
    //backgroundColor: AppColors.backgroundColor,

    /// Optional, Background of the widget
    // pathBackgroundColor: AppColors.backgroundColor

    /// Optional, the stroke backgroundColor
  );
}
