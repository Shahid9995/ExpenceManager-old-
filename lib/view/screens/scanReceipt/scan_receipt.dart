import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/core/viewModel/Scaffold/AppScafflod.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/UserRepo.dart';
import '../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import 'add_new_receipt.dart';

class ScaneReceipts extends StatefulWidget {
  const ScaneReceipts({
    Key? key,
  }) : super(key: key);

  @override
  State<ScaneReceipts> createState() => _ScaneReceiptsState();
}

class _ScaneReceiptsState extends State<ScaneReceipts> {
  TextEditingController search = TextEditingController();
  UserDataController userDataController = UserDataController(userRepo: UserRepo(ApiClient()));
  RxBool isloading=false.obs;

  // Receipts? receiptsData= MyRepo.userDataModel.value.data!.receipts;
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
        heading: "Scanned Receipts",
        body: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: AppSizes.appHorizontalMd,
              // ),
              // Padding(
              //   padding:  EdgeInsets.symmetric(horizontal:AppSizes.appHorizontalMd),
              //   child: CustomTextField(
              //     hintText: "Search",
              //     isSuffixIcon: false,
              //     controller: search, prefixIcon: Images.search_icon, suffixIcon:const Icon(Icons.add),),
              // ),
             Obx((){
               return (!isloading.value)? Flexible(
                 child: RefreshIndicator(
                   onRefresh: () {
                     return refresh();
                   },
                   child: Container(
                     padding: EdgeInsets.symmetric(
                         horizontal: AppSizes.appHorizontalSm),
                     child: GridView(
                       gridDelegate:
                       const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisSpacing: 10,
                           crossAxisCount: 2,
                           mainAxisSpacing: 20,
                           childAspectRatio: 1),
                       children: List.generate(
                           MyRepo.userDataModel.value.data!.transactions!
                               .length +
                               1, (index) {
                         if ((index != 0)) {
                           return InkWell(
                             onTap: () {
                               _showDialogImg(index);
                             },
                             child: Container(
                               // padding: EdgeInsets.symmetric(),
                                 margin: EdgeInsets.symmetric(
                                     horizontal: AppSizes.appHorizontalSm),
                                 decoration: BoxDecoration(
                                   color: AppColors.kWhite,
                                   boxShadow: [
                                     BoxShadow(
                                       color:
                                       AppColors.kgreyText.withOpacity(0.3),
                                       blurRadius: 1.0, // soften the shadow
                                       spreadRadius: 1.0, //extend the shadow
                                       offset: const Offset(
                                         -1.0, // Move to right 5  horizontally
                                         2.0, // Move to bottom 5 Vertically
                                       ),
                                     )
                                   ],
                                   borderRadius: BorderRadius.circular(15),
                                   // border: Border.all(color: AppColors.kBlack.withOpacity(0.5))
                                 ),
                                 height: 185,
                                 // width: 170,
                                 child: Center(
                                     child: Column(
                                       mainAxisSize: MainAxisSize.max,
                                       mainAxisAlignment:
                                       MainAxisAlignment.spaceBetween,
                                       children: [
                                         Container(
                                           padding: const EdgeInsets.only(top: 10),
                                           child: CachedNetworkImage(
                                             // imageUrl: "",
                                             imageUrl:
                                             "${MyRepo.userDataModel.value.data!.transactions![index - 1].transactionImage}",
                                             imageBuilder:
                                                 (context, imageProvider) => Padding(
                                               padding: EdgeInsets.symmetric(
                                                   horizontal:
                                                   AppSizes.appHorizontalSm),
                                               child: Container(
                                                 // padding: EdgeInsets.symmetric(horizontal:AppSizes.appHorizontalSm*2),
                                                 // width: 1,
                                                 height: 120.0,
                                                 decoration: BoxDecoration(
                                                   // borderRadius: BorderRadius.circular(15),
                                                   image: DecorationImage(
                                                       image: imageProvider,
                                                       fit: BoxFit.fill),
                                                 ),
                                               ),
                                             ),
                                             placeholder: (context, index) => Container(
                                                 alignment: Alignment.center,
                                                 child:
                                                 const CircularProgressIndicator()),
                                             errorWidget: (context, url, error) =>
                                             const Icon(Icons.error),
                                           ),
                                         ),
                                         Container(
                                           decoration: BoxDecoration(
                                               color:
                                               AppColors.kBlack.withOpacity(0.5),
                                               borderRadius: const BorderRadius.only(
                                                   bottomLeft: Radius.circular(15),
                                                   bottomRight:
                                                   Radius.circular(15))),
                                           alignment: Alignment.bottomCenter,
                                           // child: ,
                                           height: 25,
                                           width: double.infinity,
                                           child: Row(
                                             children: [
                                               SizedBox(
                                                 width: AppSizes.appHorizontalSm,
                                               ),
                                               Center(
                                                   child: Text(
                                                     "${index - 1}",
                                                     style: const TextStyle(
                                                         color: Colors.white),
                                                   )),
                                             ],
                                           ),
                                         )
                                       ],
                                     ))),
                           );
                         } else {
                           return InkWell(
                             onTap: () {
                               print("===================");
                               Get.to(() => const AddNewReciept());
                             },
                             child: Container(
                                 margin: EdgeInsets.symmetric(
                                     horizontal: AppSizes.appHorizontalSm),
                                 decoration: BoxDecoration(
                                   color: AppColors.kWhite,
                                   borderRadius: BorderRadius.circular(15),
                                   // border: Border.all(color: AppColors.kAppTheme)
                                 ),
                                 // height: 185,
                                 // width: 170,
                                 child: DottedBorder(
                                     borderType: BorderType.RRect,
                                     radius: const Radius.circular(15),
                                     // radius: ,
                                     color: Colors.black.withOpacity(0.3),
                                     strokeWidth: 2, //thickness of dash/dots
                                     dashPattern: const [8, 4],
                                     child: Center(
                                       child: Column(
                                         mainAxisAlignment:
                                         MainAxisAlignment.center,
                                         children: [
                                           const Icon(
                                             Icons.camera_alt,
                                             color: AppColors.kPrimary,
                                           ),
                                           Text(
                                             "Tap To Scan New",
                                             style: poppinsLight.copyWith(
                                                 fontSize: 13),
                                           ),
                                         ],
                                       ),
                                     ))),
                           );
                         }
                       }),
                     ),
                   ),
                 ),
               ):const Center(child:  CircularProgressIndicator());
             })
            ],
          ),
        ));
  }

  Future<void> refresh() async {
    setState(() {});
  }

  // void _getUserData(UserDataController userDataController) async {
  //   if (userId.isEmpty) {
  //     Get.offAllNamed(RouteHelper.getSignInRoute());
  //     // showCustomSnackBar('enter_email_address'.tr);
  //   }
  //   else {
  //     isLoading.value=true;
  //     userDataController.userData(userId,).then((status) async {
  //       print("=Dashboard=status:${status.isSuccess}==");
  //       if (status.isSuccess) {
  //         isLoading.value=false;
  //         // if (authController.isActiveRememberMe) {
  //         //   authController.saveUserNumberAndPassword(_email, _password);
  //         // } else {
  //         //   authController.clearUserNumberAndPassword();
  //         // }
  //         // await Get.find<AuthController>().getProfile();
  //         // showCustomSnackBar(status.message);
  //         // Get.offAllNamed(RouteHelper.getDashboardRoute());
  //       }else {
  //         showCustomSnackBar(status.message);
  //       }
  //     });
  //   }
  // }
  void _showDialogImg(index) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.parse(MyRepo
        .userDataModel.value.data!.transactions![index - 1].transactionDate
        .toString()));
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, setState) {
          return Scaffold(
            backgroundColor: AppColors.kTransparent,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.symmetric(horizontal: 20),

                        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                        // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              // imageUrl: "",
                              imageUrl:
                                  "${MyRepo.userDataModel.value.data!.transactions![index - 1].transactionImage}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: double.infinity,
                                height: AppSizes.appHorizontalXXL * 5,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill),
                                ),
                              ),
                              placeholder: (context, index) => Container(
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            SizedBox(
                              height: AppSizes.appHorizontalSm,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Receipt Type: ",
                                    style: const TextStyle(
                                        color: AppColors.kGrayText),
                                  ),
                                  Text(
                                      "${MyRepo.userDataModel.value.data!.transactions![index - 1].transactionType}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Amount: ",
                                    style: const TextStyle(
                                        color: AppColors.kGrayText),
                                  ),
                                  Text(
                                      "${(MyRepo.userDataModel.value.data!.transactions![index - 1].amountCurrency)}${(MyRepo.userDataModel.value.data!.transactions![index - 1].transactionAmount)}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Date: ",
                                    style:
                                        TextStyle(color: AppColors.kGrayText),
                                  ),
                                  Text(date),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding:  EdgeInsets.only(left: 10),
                            //   child: Row(
                            //     children: [
                            //       Text("Expiry Date: ",style: TextStyle(color: AppColors.kGrayText),),
                            //       Text("${MyRepo.userDataModel.value.data!.cards![index-1].expiryDate}"),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Positioned(
                          top: 10,
                          right: 30,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: const [
                                    Icon(
                                      FontAwesomeIcons.close,
                                      color: AppColors.kBlack,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ))),
                      Positioned(
                          top: 10,
                          left: 30,
                          child: (!userDataController.isLoading)?
                          GestureDetector(
                              onTap: () {
                                isloading.value = true;
                                Get.back();
                                print("====delete item:${MyRepo.userDataModel.value.data!.transactions![index - 1].id}============");
                                userDataController.deleteReceipt((MyRepo.userDataModel.value.data!.transactions![index - 1].id.toString())).then((status) async {
                                  print("=Delete Receipt:${status.isSuccess}==");
                                  if (status.isSuccess) {
                                    await userDataController.getUserData();
                                    isloading.value = false;
                                  }
                                  // showCustomSnackBar("Card not deleted");
                                });
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.delete,
                                      // FontAwesomeIcons.recycle_bin,
                                      color: AppColors.kWhite,
                                      size: 20,
                                    ),
                                    // SizedBox()
                                    Text(
                                      "Delete",
                                      style: TextStyle(color: AppColors.kWhite),
                                    )
                                  ],
                                ),
                              )):const CircularProgressIndicator())
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
