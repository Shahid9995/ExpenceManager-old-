import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/core/viewModel/Scaffold/AppScafflod.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/viewModel/DataModel/user_data_model.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../Reports/widget/progresscontainer.dart';

class DayScreen extends StatefulWidget {

  final String heading;
  final List<ReportModel>? dataModel;
  const DayScreen({Key? key,required this.heading,required this.dataModel}) : super(key: key);

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return AppScafflod(heading: widget.heading, body: Expanded(
      child: Column(
        children: [
          SizedBox(
              height: AppSizes.appHorizontalMd*1.5
          ),
          Center(
            child: Stack(
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
                            Text('${MyRepo.userDataModel.value.data!.amountcurrency}',style:poppinsMedium.copyWith(fontSize:AppSizes.appHorizontalMd*1.2),),
                            SizedBox(
                              width: AppSizes.appHorizontalSm*0.2,
                            ),
                            Text("${MyRepo.userDataModel.value.data!.todaySpent}",style:poppinsMedium.copyWith(fontSize:AppSizes.appHorizontalMd*1.2),)
                          ],
                        ),
                        Text(" Today",style:poppinsLight.copyWith(fontSize: AppSizes.appHorizontalSm*1.3),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height:AppSizes.appHorizontalMd*2 ,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.appHorizontalSm
              ),
              child: ListView.builder(
                  itemCount: MyRepo.userDataModel.value.data!.reports!.today!.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSizes.appHorizontalSm*0.5),
                          child: ProgressBar(
                            text: "${widget.dataModel![index].transactionType}",
                            current: MyRepo.userDataModel.value.data!.reports!.today![index].transactionAmount.toDouble(),
                            max:(MyRepo.userDataModel.value.data!.todaySpent.toDouble()==0)?1:MyRepo.userDataModel.value.data!.todaySpent.toDouble(),),
                        ),
                        // SizedBox(
                        //   height: AppSizes.appHorizontalSm,
                        // ),
                      ],
                    );
                  }),
            ),
          ),
          // Container(
          //   alignment: Alignment.centerLeft,
          //     child: Column(
          //       children: [
          //          ProgressBar(current: 0, max:100,),
          //          SizedBox(
          //            height: AppSizes.appHorizontalMd,
          //          ),
          //          ProgressBar(current: 30, max:100,),
          //         SizedBox(
          //           height: AppSizes.appHorizontalMd,
          //         ),
          //          ProgressBar(current: 40, max:100,),
          //         SizedBox(
          //           height: AppSizes.appHorizontalMd,
          //         ),
          //          ProgressBar(current: 60, max:100,),
          //       ],
          //     ))
        ],
      ),
    ));
  }
}
