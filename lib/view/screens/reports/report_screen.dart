import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/core/viewModel/Scaffold/AppScafflod.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/dimensions.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:expensemanage_app/view/screens/reports/dayScreen.dart';
import 'package:expensemanage_app/view/screens/reports/week_screen.dart';
import 'package:expensemanage_app/view/screens/reports/year_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'month_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return AppScafflod(
        heading: "Reports",
        body: Expanded(
          child: Column(
            children:  [
              ReportContainer(
                onTap: (){
                  Get.to(()=> DayScreen(
                    dataModel: MyRepo.userDataModel.value.data!.reports!.today,
                    heading: "Today",));
                },
                text: "Today",
                boxColor: AppColors.kToday,
              ),
              ReportContainer(
                onTap: (){
                  Get.to(()=> WeekScreen(
                    dataModel: MyRepo.userDataModel.value.data!.reports!.week,
                    heading: "This Week",));
                },
                text: "Week",
                boxColor: AppColors.kWeek,
              ),
              ReportContainer(
                onTap: (){
                  Get.to(()=> MonthScreen( dataModel: MyRepo.userDataModel.value.data!.reports!.month,
                      heading: "This Month",));
                    //   MonthScreen(
                    // dataModel: MyRepo.userDataModel.value.data!.reports!.month,
                    // heading: "this Month",));
                },
                text: "Month",
                boxColor: AppColors.kMonth,
              ),
              ReportContainer(
                onTap: (){
                  Get.to(()=> YearScreen(
                    dataModel: MyRepo.userDataModel.value.data!.reports!.year,
                    heading: "This Year",));
                },
                text: "Year",
                boxColor: AppColors.kYear,
              ),
            ],
          ),
        ));
  }
}

class ReportContainer extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;
  final Color boxColor;

  const ReportContainer({
    required this.onTap,
    required this.text,
    required this.boxColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          // height: 150,
          decoration: BoxDecoration(
            color: boxColor,
            // color: AppColors.kToday
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  text,
                  style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_XXL_LARGE),
                ),
                const Icon(
                  FontAwesomeIcons.angleRight,
                  color: AppColors.kAppbarColor,
                  size: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
