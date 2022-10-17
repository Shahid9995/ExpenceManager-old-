import 'package:expensemanage_app/core/viewModel/Scaffold/AppScafflod.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../util/styles.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}
var box=GetStorage();
bool priceAlert = false;
bool newTranstion = false;

class _AlertScreenState extends State<AlertScreen> {
  @override
  void initState(){
    priceAlert=(box.read(AppConstants.PRICEALERT)=="0")?false:true;
    newTranstion=(box.read(AppConstants.transaction_alert)=="false")?false:true;
    print("==init Transition:${box.read(AppConstants.transaction_alert)}=========");
    super.initState();
  }
  @override
  void dispose(){
    print("==dispose Transition:$newTranstion=========");
    box.write(AppConstants.transaction_alert,"$newTranstion" );
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
        heading: "Alert",
        body: Column(
          children: [
            SizedBox(
              height: AppSizes.appHorizontalSm,
            ),
            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*2,vertical:AppSizes.appHorizontalSm ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //        Text(
            //         "Price Alerts",style: poppinsRegular.copyWith(fontSize: AppSizes.appHorizontalSm*1.3),
            //       ),
            //       CupertinoSwitch(
            //         activeColor: AppColors.kPrimary,
            //         // inactiveColor: AppColors.kAppbarColor,
            //         value: priceAlert,
            //         onChanged: (bool value) {
            //           setState(() {
            //           priceAlert=value;
            //         print("===$value====");
            //           });},
            //       )
            //     ],
            //   ),
            // ),
            // Divider(
            //   thickness:1,
            //   color: AppColors.kGrayText.withOpacity(0.6),
            //   // height: 10,
            // ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*2,vertical: AppSizes.appHorizontalSm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "New Transaction",style: poppinsRegular.copyWith(fontSize: AppSizes.appHorizontalSm*1.3)
                  ),
                  CupertinoSwitch(
                    activeColor: AppColors.kPrimary,
                    // inactiveColor: AppColors.kAppbarColor,
                    value: newTranstion,
                    onChanged: (bool value) {
                      setState(() {
                        newTranstion=value;
                    print("===$value====");
                      });

                      },
                  )
                ],
              ),
            ),
            Divider(
              thickness:1,
              color: AppColors.kGrayText.withOpacity(0.6),
              // height: 10,
            ),
            // Divide
          ],
        ));
  }
}
