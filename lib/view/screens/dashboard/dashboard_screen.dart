import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/core/repository/UserRepo.dart';
import 'package:expensemanage_app/helper/route_helper.dart';
import 'package:expensemanage_app/util/app_constants.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/view/screens/scanReceipt/scan_receipt.dart';
import 'package:expensemanage_app/view/screens/security/security_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/api/api_client.dart';
import '../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/custom_snackbar.dart';
import '../Reports/report_screen.dart';
import '../ScanCard/add_new_card.dart';
import '../ScanCard/scaned_cards.dart';
import '../Transcations/add_transaction.dart';
import '../alert/AlertScreen.dart';
import '../price_lookup/object_detact/object_detacter_view.dart';
import '../profile/myprofile_screen.dart';
import 'Widget/dashboard_icon.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey = GlobalKey<ScaffoldState>();
  var box=GetStorage();
  var userId;
  RxBool isLoading=false.obs;
  UserDataController userDataController=UserDataController(userRepo: UserRepo(ApiClient()));
  @override
  void initState(){
    userId=box.read(AppConstants.USERID).toString();
    _getUserData(userDataController);
    // print("=====userID:${MyRepo.loginDataModel.value.data!.id}========");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        key: _drawerscaffoldkey,
        drawer: CustomDrawer(),
        body: Obx((){
        if(!isLoading.value){
          return  Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: SvgPicture.asset(
                        Images.auth_drawer,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: AppSizes.appHorizontalMd,
                                  left: AppSizes.appHorizontalSm * 2,
                                  right: AppSizes.appHorizontalSm * 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            _drawerscaffoldkey.currentState!.openDrawer();
                                          },
                                          child: const Icon(
                                            FontAwesomeIcons.bars,
                                            color: AppColors.kWhite,
                                          )),
                                      SizedBox(
                                        width: AppSizes.appHorizontalSm * 1.5,
                                      ),
                                       Text(
                                        "Today Expanses",
                                        style: poppinsRegular.copyWith(color: AppColors.kWhite,
                                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.to(() => const MyProfileScreen());
                                      },
                                      child:  Image.asset(Images.dashboard_user,height: 25,width: 25,)
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: AppSizes.appHorizontalMd * 2.7,
                                  top: AppSizes.appHorizontalSm),
                              child: Row(
                                children: [
                                   Text(
                                    '${MyRepo.userDataModel.value.data!.amountcurrency}',
                                    style: TextStyle(
                                        color: AppColors.kWhite,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: AppSizes.appHorizontalSm * 0.5,
                                  ),
                                   Text(
                                    "${MyRepo.userDataModel.value.data!.todaySpent}",
                                    style:poppinsMedium.copyWith(fontSize:Dimensions.FONT_SIZE_XXL_LARGE ,color: AppColors.kWhite)
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                Expanded(
                  child: GridView(
                    scrollDirection: Axis.vertical,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20,
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        childAspectRatio: 1),
                    padding: EdgeInsets.all(AppSizes.appHorizontalSm),
                    shrinkWrap: true,
                    children: [
                      DashBoardIcon(
                        onTap: () {
                          Get.to(() => const AlertScreen());
                        },
                        tittle: "Alerts",
                        imgPath: Images.alert_svg,
                      ),
                      DashBoardIcon(
                        onTap: () {
                          Get.to(()=> const ScaneReceipts());
                        },
                        tittle: "Scan Receipts",
                        imgPath: Images.scane_recipt,
                      ),
                      DashBoardIcon(
                        onTap: () {
                          Get.to(()=> AddNewCards());
                        },
                        tittle: "Add Card",
                        imgPath: Images.add_card,
                      ),
                      DashBoardIcon(
                        onTap: () {
                          Get.to(()=>const ObjectDetectorView());
                          // Get.to(()=> const PriceList());
                        },
                        tittle: "Price Lookup",
                        imgPath: Images.price_look,
                      ),
                      DashBoardIcon(
                        onTap: () {
                          Get.to(()=>const transactionList());
                        },
                        tittle: "Transactions",
                        imgPath: Images.transaction,
                      ),
                      DashBoardIcon(
                        onTap: () {
                          Get.to(() => const ReportScreen());
                        },
                        tittle: "Reports",
                        imgPath: Images.reports,
                      ),
                    ],
                  ),
                ),
              ],
            );
        }else{
          return const Center(child: const CircularProgressIndicator());
        }

      }),
    );
  }

  void _getUserData(UserDataController userDataController) async {
    if (userId.isEmpty) {
      Get.offAllNamed(RouteHelper.getSignInRoute());
      // showCustomSnackBar('enter_email_address'.tr);
    }
    else {
      isLoading.value=true;
      userDataController.userData(userId,).then((status) async {
        print("=Dashboard=status:${status.isSuccess}==");
        if (status.isSuccess) {
          isLoading.value=false;
          // if (authController.isActiveRememberMe) {
          //   authController.saveUserNumberAndPassword(_email, _password);
          // } else {
          //   authController.clearUserNumberAndPassword();
          // }
          // await Get.find<AuthController>().getProfile();
          // showCustomSnackBar(status.message);
          // Get.offAllNamed(RouteHelper.getDashboardRoute());
        }else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}

class CustomDrawer extends StatelessWidget {
  var box=GetStorage();
   CustomDrawer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.kWhite,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.appHorizontalLg,
                vertical: AppSizes.appHorizontalLg,
              ),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: poppinsMedium.copyWith(fontSize:Dimensions.FONT_SIZE_LARGE )
                  ),
                  Text(
                    "${box.read(AppConstants.USERNAME)}",
                    style:poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_XXL_LARGE)
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.5,
              color: AppColors.kGrayText.withOpacity(0.5),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.appHorizontalLg,
                      vertical: AppSizes.appHorizontalMd,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(()=> const MyProfileScreen());
                          },
                          child: Text(
                            "Account",
                            style: poppinsMedium.copyWith(fontSize:Dimensions.FONT_SIZE_LARGE )) ) ,
                        SizedBox(
                          height: AppSizes.appHorizontalSm * 2,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=>ScaneReceipts());
                          },
                          child: Text(
                            "Receipts",
                            style: poppinsMedium.copyWith(fontSize:Dimensions.FONT_SIZE_LARGE )) ),
                        SizedBox(
                          height: AppSizes.appHorizontalSm * 2,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=>const transactionList());
                          },
                          child: Text(
                            "Transactions", style: poppinsMedium.copyWith(fontSize:Dimensions.FONT_SIZE_LARGE )
                          ),
                        ),
                        SizedBox(
                          height: AppSizes.appHorizontalSm * 2,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(()=>const ReportScreen());
                          },
                          child: Text(
                            "Reports",style: poppinsMedium.copyWith(fontSize:Dimensions.FONT_SIZE_LARGE )
                        )),
                        SizedBox(
                          height: AppSizes.appHorizontalSm * 2,
                        ),
                        Text(
                          "Settings",
                            style: poppinsMedium.copyWith(fontSize:Dimensions.FONT_SIZE_LARGE )
                        ),
                        SizedBox(
                          height: AppSizes.appHorizontalSm*1.5,
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.kPrimary,
                            ),
                            SizedBox(
                              width: AppSizes.appHorizontalSm,
                            ),
                            InkWell(
                              onTap: (){
                                Get.to(()=>const AlertScreen());
                              },
                              child: Text(
                                "Alerts & Notifications",
                                style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.appHorizontalSm*1.5,
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.kPrimary,
                            ),
                            SizedBox(
                              width: AppSizes.appHorizontalSm,
                            ),
                            InkWell(
                              onTap: (){
                                Get.to(()=>SecurityScreen());
                              },
                              child: Text(
                                "Security",
                                  style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSizes.appHorizontalSm*1.5,
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColors.kPrimary,
                            ),
                            SizedBox(
                              width: AppSizes.appHorizontalSm,
                            ),
                            InkWell(
                              onTap: (){
                                Get.to(()=>const ScanCards());
                              },
                              child: Text(
                                "Cards",
                                  style: poppinsRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(bottom: AppSizes.appHorizontalXXL,left: AppSizes.appHorizontalLg),
                    child: InkWell(
                      onTap: (){
                        GetStorage().remove(AppConstants.USERID);
                        // box.read(AppConstants.USERID);
                        Get.offAllNamed(RouteHelper.getSignInRoute());
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.signOut,size: 14,),
                          SizedBox(
                            width: AppSizes.appHorizontalSm*.7,
                          ),
                          Text("Log Out",style: poppinsMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
