import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:flutter/cupertino.dart';

import 'dimensions.dart';

class PrimaryButton extends StatefulWidget {

  final String text;
  final double width;
  const PrimaryButton({Key? key,required this.text,this.width=200}) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Container(
      width: widget.width,
      padding: EdgeInsets.symmetric(vertical: AppSizes.appHorizontalSm*1.2),
      decoration: BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: BorderRadius.circular(AppSizes.appHorizontalSm*3)
      ),
      child: Center(child: Text(widget.text,style:poppinsMedium.copyWith(fontSize: AppSizes.appHorizontalSm*1.2,color: AppColors.kWhite),)),
    );
  }
}
