import 'package:expensemanage_app/util/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = true,bool isTop=false}) {
  Get.showSnackbar(GetSnackBar(

    backgroundColor: isError ? Colors.red : Colors.green,
    message: message,
    duration:  const Duration(seconds:3),
    snackStyle: SnackStyle.FLOATING,
    margin: EdgeInsets.all(AppSizes.appHorizontalSm),
    borderRadius: 10,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
  ));
}