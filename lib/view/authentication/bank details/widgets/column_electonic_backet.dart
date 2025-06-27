import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider_mersal/core/constant/app_colors.dart';
import 'package:provider_mersal/view/authentication/widget/text_field/custom_text_form_field.dart';

class ColumnElectronicBacket extends StatelessWidget {
  const ColumnElectronicBacket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomTextFormField(
          hintText: 'اسم مالك المحفظه باللغه العربيه',
          obscureText: false,
          isPassWord: false,
        ),
        const SizedBox(
          height: 15,
        ),
        const CustomTextFormField(
          suffixIcon: Icon(
            Iconsax.scanner,
            size: 20,
            color: AppColors.black,
          ),
          hintText: 'رقم هويه مالك المحفظه/رقم جواز السفر',
          obscureText: false,
          isPassWord: false,
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            // حقل اختيار الدولة
            Expanded(
              child: _buildPhoneInput(context),
            ),
            SizedBox(width: 10.w),
            // حقل رقم الهاتف
            const Expanded(
              flex: 3,
              child: CustomTextFormField(
                hintText: 'رقم هاتف المحفظة الإلكترونية',
                obscureText: false,
                isPassWord: false,
              ),
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildPhoneInput(BuildContext context) {
    String selectedCountryCode = '+20'; 
    String selectedCountryFlag = '🇪🇬'; 

    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            countryListTheme: CountryListThemeData(
              flagSize: 25,
              backgroundColor: Colors.white,
              textStyle:const TextStyle(fontSize: 16, color: Colors.blueGrey),
              bottomSheetHeight: 500,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              inputDecoration: InputDecoration(
                labelText: 'ابحث',
                hintText: 'أدخل اسم الدولة',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ),
                ),
              ),
            ),
            onSelect: (Country country) {
              setState(() {
                selectedCountryCode = '+${country.phoneCode}';
                selectedCountryFlag = country.flagEmoji;
              });
            },
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
          decoration: BoxDecoration(
            //    border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.lightGrey2,
          ),
          child: Row(
            children: [
              //
              //
               Text(
              selectedCountryFlag, // Replace with dynamic flag
                style: const TextStyle(fontSize: 20),
              )
           
              ,
              SizedBox(width: 5.w),
              
              Text(
                selectedCountryCode,
                style: TextStyle(fontSize: 14, color: AppColors.greyColor),
              ),
       
            ],
          ),
        ),
      );
    });
  }
}

// مكون CustomTextFormField
