import 'package:expensemanage_app/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/app_size.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class AuthScaffold extends StatefulWidget {
  final Widget body;
  final String title;
  final String decs;

  const AuthScaffold({Key? key,required this.body,required this.title,required this.decs }) : super(key: key);

  @override
  State<AuthScaffold> createState() => _AuthScaffoldState();
}

class _AuthScaffoldState extends State<AuthScaffold> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return  Scaffold(
      backgroundColor: AppColors.kWhite,
      // key:_drawerscaffoldkey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  // height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.green
                    // image: DecorationImage(image: SvgPicture.asset())
                  ),
                  child: SvgPicture.asset(Images.auth_drawer,
                    fit: BoxFit.fill,
                  ),
                ),
                SafeArea(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: AppSizes.appHorizontalSm*3,left: 40,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(Images.svg_logo),
                              SizedBox(
                                height: AppSizes.appVerticalSm*1,
                              ),
                              // Image.asset(Images.logo),
                              Text(widget.title,style: poppinsMedium.copyWith(fontSize: AppSizes.appHorizontalMd*1.2,color: AppColors.kWhite),),
                              // Text(widget.title,style: TextStyle(color: Colors.white,fontSize: AppSizes.appHorizontalMd*1,fontWeight: FontWeight.w500),),
                              SizedBox(
                                height: AppSizes.appVerticalSm*0.5,
                              ),
                              Text(widget.decs,style: poppinsRegular.copyWith(color: AppColors.kWhite,fontSize: AppSizes.appHorizontalSm*1.1),),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            widget.body,
          ],
        ),
      ),
    );
  }
}
