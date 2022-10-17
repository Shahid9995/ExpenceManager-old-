import 'package:expensemanage_app/util/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomNotificationBar(String message, ) {
  Get.showSnackbar(GetSnackBar(
    padding: EdgeInsets.symmetric(vertical: AppSizes.appVerticalSm),
    snackPosition:SnackPosition.TOP,
    backgroundColor:  Colors.green,
    title: "Transaction Alert",
    icon: const Icon(Icons.notifications_active_outlined,color: Colors.white,size: 30,),
    message: message,
    duration:  const Duration(seconds: 7),
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.all(AppSizes.appHorizontalSm),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}