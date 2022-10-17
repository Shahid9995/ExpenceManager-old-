

import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../util/dimensions.dart';
import '../../../view/screens/Transcations/add_transaction_detail.dart';
import '../../../view/screens/price_lookup/add_new_product.dart';

class AppScafflod extends StatefulWidget {
  final String heading;
  final Widget body;
  final bool isActionButton;
  final bool isTransaction;


  const AppScafflod({Key? key,required this.heading,required this.body,this.isActionButton=false,this.isTransaction=false}) : super(key: key);

  @override
  State<AppScafflod> createState() => _AppScafflodState();
}

class _AppScafflodState extends State<AppScafflod> {

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
      backgroundColor: AppColors.kWhite,
         floatingActionButton:(widget.isActionButton)?
         FloatingActionButton(
        onPressed: () {
          Get.to(()=>(widget.isTransaction)?AddTransactionDetails():AddNewProduct());
        },
        backgroundColor: AppColors.kPrimary,
        child: const Icon(Icons.add),
      ):null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: AppSizes.appHorizontalMd*2.2,left: AppSizes.appHorizontalSm*1.2,),
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.kAppbarColor
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                    child: Container(
                      padding: EdgeInsets.all(10),
                        child: Icon(FontAwesomeIcons.angleLeft,color: AppColors.kWhite))),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(widget.heading,style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE+2,color: AppColors.kWhite),),
                    ],
                  ),
                ),
                SizedBox(
                  width: AppSizes.appHorizontalSm*5,
                )
              ],
            ),
          ),
          widget.body
        ],
      ),
    );
  }
}
