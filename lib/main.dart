
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:provider_mersal/core/sevices/sevices.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'bindings/initial_bindings.dart';
import 'theme/app_themes.dart';
import 'view/splash screen/view/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await MyServices().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          locale: const Locale('ar'),
          initialBinding: InitialBindings(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
        //  getPages: routes,
          home: SplashScreen(),
        );
      },
    );
  }
}

