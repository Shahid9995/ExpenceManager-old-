

import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatefulWidget {
  final String text;
  const CircularButton({Key? key,required this.text}) : super(key: key);

  @override
  State<CircularButton> createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.appHorizontalSm*0.5
      ),
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.kPrimary,
        shape: BoxShape.circle,
        border: Border.all(
          width: 10,
          color: AppColors.kLightPrimary
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
                child: Text(widget.text,textAlign: TextAlign.center,style: poppinsMedium.copyWith(fontSize: AppSizes.appHorizontalSm*1.2,color: AppColors.kWhite),)),
          ),
        ],
      ),
    );
  }
}
