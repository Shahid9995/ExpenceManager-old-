import 'package:expensemanage_app/util/dimensions.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/app_size.dart';
import '../../../../util/images.dart';

class DashBoardIcon extends StatefulWidget {
  final GestureTapCallback onTap;
  final String tittle;
  final String imgPath;
   DashBoardIcon({Key? key,required this.tittle,required this.imgPath,required this.onTap}) : super(key: key);

  @override
  State<DashBoardIcon> createState() => _DashBoardIconState();
}

class _DashBoardIconState extends State<DashBoardIcon> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(widget.imgPath,),
          SizedBox(
            height: AppSizes.appHorizontalSm,
          ),
          Text(widget.tittle,overflow: TextOverflow.clip,textAlign:TextAlign.center,style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE+2),)
        ],
      ),
    );
  }
}
