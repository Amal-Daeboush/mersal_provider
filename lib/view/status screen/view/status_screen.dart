import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_mersal/core/sevices/sevices.dart';
import 'package:provider_mersal/view/address/screen/address.dart';
import 'package:provider_mersal/view/authentication/authentication/view/authentication_screen.dart';

class StatusScreen extends StatelessWidget {
  final String status;
  final String? message;

  const StatusScreen({super.key, required this.status, this.message});

  void _redirectIfActive() {
    if (status == 'active') {
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(AddressScreen(isfromHome: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // تشغيل التحويل بعد أول إطار
    WidgetsBinding.instance.addPostFrameCallback((_) => _redirectIfActive());

    String title = '';
    String description = '';

    switch (status) {
      case 'pending':
        title = 'قيد الانتظار';
        description = 'تم إرسال طلبك. ننتظر موافقة الإدارة.';
        break;
      case 'pand':
        title = 'مرفوض';
        description = 'لم يتم قبول حسابك. الرجاء مراجعة الدعم.';
        break;
      case 'suspended':
        title = 'موقوف';
        description = 'تم تعليق حسابك مؤقتًا.';
        break;
      case 'active':
        title = 'تم التفعيل';
        description = 'سيتم تحويلك إلى الصفحة الرئيسية...';
        break;
      default:
        title = 'غير معروف';
        description = 'حالة الحساب غير معروفة.';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('حالة الحساب')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    status == 'active' ? Icons.check_circle : Icons.info,
                    color: status == 'active' ? Colors.green : Colors.orange,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message ?? description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  if (status != 'active')
                    ElevatedButton(
                      onPressed: () {
                        MyServices().clear();
                        Get.offAll(AuthenticationScreen());} ,
                      child: const Text('هل تريد اعادة تسجيل الدخول'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
