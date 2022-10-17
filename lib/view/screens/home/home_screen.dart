import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../helper/route_helper.dart';
import '../../../util/circular_button.dart';
import '../../../util/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var box=GetStorage();
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right:-AppSizes.appHorizontalSm*3.5,
                top: 50,
                child: Image.asset(Images.home_coin,height: AppSizes.appHorizontalXXL*1.1,width: AppSizes.appHorizontalXXL*1.1,)),
            Positioned(
              left: -AppSizes.appHorizontalSm*3,
                top: AppSizes.appVerticalXXL*2.4,
                child: Image.asset(Images.home_coin,height: 80,width: 80,)),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(AppSizes.appHorizontalSm*2.5, AppSizes.appHorizontalSm*3.5,0,0),
                    child: Image.asset(Images.menu_icon,height: 30,width: 30,),
                  ),
                ),
                SizedBox(
                  height: AppSizes.appVerticalSm*.8,
                ),
                Image.asset(Images.logo_home,height: AppSizes.appHorizontalXXL*1.1,width: AppSizes.appHorizontalXXL*1.1,),
                SizedBox(
                  height: AppSizes.appVerticalMd,
                ),
                Text("Hello ${box.read(AppConstants.USERNAME)},",style: poppinsMedium.copyWith(fontSize:AppSizes.appHorizontalSm*2.4),),
                SizedBox(
                  height: AppSizes.appVerticalSm*.5,
                ),
                Text("Lorem ipsum dolor sit amet,",style: poppinsRegular.copyWith(fontSize:AppSizes.appHorizontalSm,color: AppColors.kGrayText),),
                SizedBox(height: AppSizes.appVerticalMd*1.8,),
                Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: SvgPicture.asset(Images.icon_background,fit: BoxFit.fill,color: AppColors.kGrayText.withOpacity(0.2),),
                    ),
                    Positioned.fill(
                      // left: AppSizes.appHorizontalMd,
                      // top: AppSizes.appVerticalMd,
                      child: Align(
                          alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("You Spent",style:poppinsLight.copyWith(fontSize: AppSizes.appHorizontalSm*1.3),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('\$',style:poppinsMedium.copyWith(fontSize:AppSizes.appHorizontalMd*1.2),),
                                SizedBox(
                                  width: AppSizes.appHorizontalSm*0.2,
                                ),
                                Text("${box.read(AppConstants.TodaySpent)}",style:poppinsMedium.copyWith(fontSize:AppSizes.appHorizontalMd*1.2),)
                              ],
                            ),
                            Text(" Today",style:poppinsLight.copyWith(fontSize: AppSizes.appHorizontalSm*1.3),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      InkWell(
                        onTap: (){
                          Get.offNamed(RouteHelper.getDashboardRoute());
                        },
                          child: const CircularButton(text: "My Account",))
                    ],
                  ),
                )

              ],
            ),
          ],
        ),
      ),
      // backgroundColor: ,
    );
  }
}
