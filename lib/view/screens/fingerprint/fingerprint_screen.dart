import 'package:expensemanage_app/util/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../util/images.dart';
import '../../../util/styles.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key? key}) : super(key: key);

  @override
  State<FingerPrintScreen> createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(Images.logo),
            Text("Welcome",style: poppinsMedium.copyWith(fontSize: 30),),
            Text("Lorem ipsum dolor sit amet,!",style: poppinsRegular.copyWith(fontSize: 14,color: AppColors.kgreyText),)
          ],
        ),
      ),
    );
  }
}
