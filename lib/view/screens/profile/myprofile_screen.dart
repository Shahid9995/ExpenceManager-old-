import 'package:expensemanage_app/core/viewModel/Scaffold/AppScafflod.dart';
import 'package:expensemanage_app/helper/route_helper.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/dimensions.dart';
import 'package:expensemanage_app/view/screens/phonenumber_screen.dart';
import 'package:expensemanage_app/view/screens/userName_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/styles.dart';

import '../changepassword/changepasswor_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return AppScafflod(heading:"My Profile", body: Column(
      children: [
        InkWell(onTap: (){
          Get.to(()=>const UserNameScreen());
        },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*2,vertical: AppSizes.appHorizontalSm*2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Update Username",style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),),
              Icon(FontAwesomeIcons.angleRight,)
            ],),
          ),
        ),
        Divider(
          thickness:1,
          color: AppColors.kGrayText.withOpacity(0.6),
          // height: 10,
        ),
        InkWell(
          onTap: (){
            Get.to(()=>const PhoneNumberScreen());
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*2,vertical: AppSizes.appHorizontalSm*2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Update Phone Number",style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),),
                Icon(FontAwesomeIcons.angleRight,)
              ],),
          ),
        ),
        Divider(
          thickness:1,
          color: AppColors.kGrayText.withOpacity(0.6),
          // height: 10,
        ),
        InkWell(
          onTap: (){
            Get.to(()=>ChangePasswordScreen());
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*2,vertical: AppSizes.appHorizontalSm*2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Change Password",style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),),
                Icon(FontAwesomeIcons.angleRight,)
              ],),
          ),
        ),
        Divider(
          thickness:1,
          color: AppColors.kGrayText.withOpacity(0.6),
          // height: 10,
        ),
        InkWell(
          onTap: (){
            // var box=GetStorage();
            GetStorage().remove(AppConstants.USERID);
            // box.read(AppConstants.USERID);
            Get.offAllNamed(RouteHelper.getSignInRoute());
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*2,vertical: AppSizes.appHorizontalSm*2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.signOut,size: 20,),
                    SizedBox(
                      width: AppSizes.appHorizontalSm,
                    ),
                    Text("Log Out",style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),),
                  ],
                ),
                Icon(FontAwesomeIcons.angleRight,)
              ],),
          ),
        ),
      ],
    ));
  }
}
