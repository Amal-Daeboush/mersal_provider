
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


import '../constant/app_colors.dart';
import '../constant/app_image_asset.dart';
import 'status_request.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final bool isLoading;
  final Future<void> Function() onRefresh;
  const HandlingDataView(
      {super.key,
      required this.statusRequest,
      required this.widget,
      this.isLoading = false,
      required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading && isLoading == true
        ? CustomRefreshHandlindDataView(
            onRefresh: onRefresh,
            statusRequest: statusRequest,
           icon: Icons.offline_bolt,)
        : statusRequest == StatusRequest.offlineFailure
            ? CustomRefreshHandlindDataView(
                onRefresh: onRefresh,
                statusRequest: statusRequest,
                  icon: Icons.offline_bolt,)
            : statusRequest == StatusRequest.failure
                ? CustomRefreshHandlindDataView(
                    onRefresh: onRefresh,
                    statusRequest: statusRequest,
                      icon: Icons.offline_bolt,)
                : widget;
  }
}

class HandlingDataViewRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final Future<void> Function() onRefresh;

  const HandlingDataViewRequest(
      {super.key,
      required this.statusRequest,
      required this.widget,
      required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? CustomRefreshHandlindDataView(
            onRefresh: onRefresh,
            statusRequest: statusRequest,
           icon:Icons.local_dining)
        : statusRequest == StatusRequest.offlineFailure
            ? CustomRefreshHandlindDataView(
                onRefresh: onRefresh,
                statusRequest: statusRequest,
             icon: Icons.offline_bolt,)
            : statusRequest == StatusRequest.serverFailure
                ? CustomRefreshHandlindDataView(
                    onRefresh: onRefresh,
                    statusRequest: statusRequest,
                    icon:Icons.severe_cold_rounded)
                : widget;
  }
}

class CustomRefreshHandlindDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final IconData icon;
  final Future<void> Function() onRefresh;
  const CustomRefreshHandlindDataView({
    super.key,
    required this.statusRequest,
    required this.icon,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: AppColors.primaryColor,
      onRefresh: onRefresh,
      child: ListView(
        children: [
          SizedBox(
            height: Get.height / 3,
          ),
       
          Center(
              child: Icon(
            icon,
     size: 50,
           
          ))
        ],
      ),
    );
  }
}
