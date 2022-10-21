
import 'dart:async';

import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../helper/route_helper.dart';
import '../../../util/images.dart';

class Splash2Screen extends StatefulWidget {
  const Splash2Screen({Key? key}) : super(key: key);

  @override
  State<Splash2Screen> createState() => _Splash2ScreenState();
}
class _Splash2ScreenState extends State<Splash2Screen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  void _route() async{
    var box =GetStorage();
    // String userId=box.read(AppConstants.USERID).toString();
    Timer(const Duration(seconds: 2), () {
        // Get.offNamed(box.hasData(AppConstants.USERID)?Get.to(()=>getDashboardRoute):RouteHelper.getSignInRoute());
        Get.offNamed(box.hasData(AppConstants.USERID)?RouteHelper.getHomeRoute():RouteHelper.getSignInRoute());


    });
  }
  @override
  void initState(){
    _route();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
      key:_globalKey,
      body:SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(child: Image.asset(Images.logo)),
              Center(child: Image.asset(Images.coin_gif,height: 100,width: 100,)),
            ],
          ),
        ),
      ) ,
    );
  }
}
