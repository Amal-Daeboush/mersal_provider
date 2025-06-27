import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/view/authentication/register/controller/register_controller.dart';

class FoodTypeDialog extends StatelessWidget {
  final RegisterController controller;
  const FoodTypeDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("اختر أنواع الطعام"),
      content: SizedBox(
        width: double.maxFinite,
        child: GetBuilder<RegisterController>(
          builder:
              (_) => ListView(
                shrinkWrap: true,
                children:
                    controller.foodtypes.map((type) {
                      return CheckboxListTile(
                        title: Text(type.title),
                        value: controller.selectedFoodTypeIds.contains(type.id),
                        onChanged: (val) {
                          if (val == true) {
                            controller.selectedFoodTypeIds.add(type.id);
                          } else {
                            controller.selectedFoodTypeIds.remove(type.id);
                          }
                          controller.update(); // يحدث GetBuilder
                        },
                      );
                    }).toList(),
              ),
        ),
      ),
      actions: [
        TextButton(
          child: Text("تم"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
