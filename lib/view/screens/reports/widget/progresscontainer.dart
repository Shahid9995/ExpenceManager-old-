import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/dimensions.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../util/app_color.dart';

class ProgressBar extends StatelessWidget {
  final double max;
  final double current;
  final Color color;
  final String text;
  final bool subType;


  const ProgressBar(
      {Key? key,
        this.text="food",
        this.subType=false,
        required this.max,
        required this.current,
        this.color = AppColors.kPrimary})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return LayoutBuilder(
        builder: (_, boxConstraints) {
      var x = boxConstraints.maxWidth;
      int i=5;
      var xx=0.0;
      if((max-current)<=10){
        i=0;
      }
      // (max==0)?max=1:
      RxBool isOverFlow=false.obs;
      // var x = boxConstraints.maxWidth;
      var percent = ((current) / max) * x;
      var percnt = (current / max) * 100;
      if(percnt<=15){
        percent=AppSizes.appHorizontalXXL*1.1;
        xx=x;
      }else if(percnt>=60){
        isOverFlow.value=true;
      }


      // if(percent>170) {
      //
      // }
      print("percent=$percent");

      return Row(
        children: [
          Stack(
            children: [
              // Container(
              //   width: x,
              //   height: 7,
              //   decoration: BoxDecoration(
              //     color: Color(0xffd3d3d3),
              //     borderRadius: BorderRadius.circular(35),
              //   ),
              // ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: percent,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            subType? const Icon(FontAwesomeIcons.angleDown,color: AppColors.kWhite,):Container(),
                            // SizedBox(
                            //   width: AppSizes.appVerticalSm*0.5,
                            // ),
                             Text(text,style:  poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,color: AppColors.kWhite),)
                          ],
                        ),
                        (isOverFlow.value)? Row(
                          children: [
                             Text('${MyRepo.userDataModel.value.data!.amountcurrency}',style:  poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,color: AppColors.kWhite),),
                            SizedBox(
                              width: AppSizes.appHorizontalSm,
                            ),
                             Text("$current",style:  poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,color: AppColors.kWhite),)
                          ],
                        ):Container(),
                      ],
                    ),
                  ),
                ) ,
              ),
              (!isOverFlow.value)? AnimatedContainer(

                width: xx,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.kTransparent,
                  borderRadius: BorderRadius.circular(35),
                ),
                duration: const Duration(milliseconds: 600),
                child: Center(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*1.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // const Icon(FontAwesomeIcons.angleDown,color: AppColors.kWhite,),
                            SizedBox(
                              width: AppSizes.appVerticalSm*4.5,
                            ),
                           // const Text("",style:  TextStyle(color: AppColors.kBlack),)
                          ],
                        ),
                        (!isOverFlow.value)? Row(
                          children: [
                             Text('${MyRepo.userDataModel.value.data!.amountcurrency}',style:poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,color: AppColors.kBlack),),
                            SizedBox(
                              width: AppSizes.appHorizontalSm*0.5,
                            ),
                             Text("$current",style:  poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,color: AppColors.kBlack),)
                          ],
                        ):Container(),
                      ],
                    ),
                  ),
                ),
              ):Container(),
            ],
          ),
          // Text("ksfdng")
        ],
      );
        },
    );
  }
}