import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/class/status_request.dart';
import 'package:provider_mersal/view/authentication/register/controller/register_controller.dart';
import 'package:provider_mersal/view/food%20types/controller/food_types_controller.dart';

class AddFoodTypeDialog extends StatelessWidget {
  final FoodTypesController controller;

  const AddFoodTypeDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final existingIds = controller.myfoodtypes.map((e) => e.id).toSet();
    final availableFoodTypes = controller.foodtypes
        .where((type) => !existingIds.contains(type.id))
        .toList();

    int? selectedId;

    return AlertDialog(
      title: Text("اختر نوع طعام واحد"),
      content: SizedBox(
        width: double.maxFinite,
        child: StatefulBuilder(
          builder: (context, setState) {
            if (controller.statusRequestgetFood == StatusRequest.loading) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              shrinkWrap: true,
              children: availableFoodTypes.map((type) {
                return RadioListTile<int>(
                  title: Text(type.title),
                  value: type.id,
                  groupValue: selectedId,
                  onChanged: (val) {
                    setState(() {
                      selectedId = val;
                    });
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: Text("تم"),
          onPressed: () {
            if (selectedId != null) {
              Navigator.of(context).pop();
              controller.addFoodType(context, selectedId.toString());
            } else {
              Get.snackbar("تنبيه", "يرجى اختيار نوع طعام");
            }
          },
        ),
      ],
    );
  }
}

