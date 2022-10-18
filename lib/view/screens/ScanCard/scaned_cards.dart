import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expensemanage_app/core/repository/MyRepo.dart';
import 'package:expensemanage_app/core/viewModel/Scaffold/AppScafflod.dart';
import 'package:expensemanage_app/core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:expensemanage_app/util/app_size.dart';
import 'package:expensemanage_app/view/screens/ScanCard/add_new_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/UserRepo.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class ScanCards extends StatefulWidget {
  const ScanCards({
    Key? key,
  }) : super(key: key);

  @override
  State<ScanCards> createState() => _ScanCardsState();
}

class _ScanCardsState extends State<ScanCards> {
  TextEditingController search = TextEditingController();
  UserDataController userDataController =
      UserDataController(userRepo: UserRepo(ApiClient()));
  RxBool isloading = false.obs;
  // cards? cardsData= MyRepo.userDataModel.value.data!.cards;
  @override
  Widget build(BuildContext context) {
    return AppScafflod(

        // isActionButton: ,
        heading: "Scanned Cards",
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
              //     controller: search, prefixIcon: Icon(Icons.search,color: AppColors.kGrayText,),
              //     suffixIcon:Icon(Icons.add),),
              // ),
              Obx(() {
                return (!isloading.value)
                    ? Flexible(
                        child: RefreshIndicator(
                          onRefresh: () {
                            return restun();
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
                                  MyRepo.userDataModel.value.data!.cards!
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
                                            horizontal:
                                                AppSizes.appHorizontalSm),
                                        decoration: BoxDecoration(
                                          color: AppColors.kWhite,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius:
                                                  1.0, // soften the shadow
                                              spreadRadius:
                                                  0, //extend the shadow
                                              offset: Offset(
                                                0, // Move to right 5  horizontally
                                                1.0, // Move to bottom 5 Vertically
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          // border: Border.all(color: AppColors.kBlack.withOpacity(0.5))
                                        ),
                                        // height: 190,
                                        // width: 170,
                                        child: Center(
                                            child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: AppSizes.appHorizontalSm * 0.6,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    // imageUrl: "",
                                                    imageUrl:
                                                        "${MyRepo.userDataModel.value.data!.cards![index - 1].cardImage}",
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(width: 150,
                                                      height: 90,
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                        image: DecorationImage(image: imageProvider,
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    placeholder: (context,
                                                            index) =>
                                                        Container(
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                const CircularProgressIndicator()),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      AppSizes.appHorizontalSm *
                                                          .5,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: AppSizes
                                                              .appHorizontalSm *
                                                          1),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        Images.card_user,
                                                        height: 15,
                                                        width: 15,
                                                      ),
                                                      SizedBox(
                                                        width: AppSizes
                                                                .appHorizontalSm *
                                                            .5,
                                                      ),
                                                      Text(
                                                        "${MyRepo.userDataModel.value.data!.cards![index - 1].nameOnCard}",
                                                        style: poppinsRegular
                                                            .copyWith(
                                                                fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      AppSizes.appHorizontalSm *
                                                          .2,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: AppSizes
                                                              .appHorizontalSm *
                                                          1.1),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        Images.credit_card,
                                                        height: 12,
                                                        width: 12,
                                                      ),
                                                      SizedBox(
                                                        width: AppSizes
                                                                .appHorizontalSm *
                                                            0.8,
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                        "${MyRepo.userDataModel.value.data!.cards![index - 1].cardNumber}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: poppinsRegular
                                                            .copyWith(
                                                                fontSize: 11),
                                                      )),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.kBlack
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomLeft: Radius.circular(15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15))),
                                              alignment: Alignment.bottomCenter,
                                              // child: ,
                                              height: 25,
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: AppSizes
                                                        .appHorizontalSm,
                                                  ),
                                                  Center(
                                                      child: Text(
                                                    "$index",
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
                                      Get.to(() => const AddNewCards());
                                    },
                                    child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                AppSizes.appHorizontalSm),
                                        // decoration: BoxDecoration(
                                        //   color: AppColors.kWhite,
                                        //   boxShadow: [
                                        //     BoxShadow(
                                        //       color: AppColors.kgreyText,
                                        //       blurRadius: 1.0, // soften the shadow
                                        //       spreadRadius: 0, //extend the shadow
                                        //       offset: Offset(
                                        //         0, // Move to right 5  horizontally
                                        //         1.0, // Move to bottom 5 Vertically
                                        //       ),
                                        //     )
                                        //   ],
                                        //   borderRadius: BorderRadius.circular(15),
                                        //   // border: Border.all(color: AppColors.kBlack.withOpacity(0.5))
                                        // ),
                                        // height: 185,
                                        // width: 170,
                                        child: DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(15),
                                            // radius: ,
                                            color: AppColors.kgreyText,
                                            strokeWidth:
                                                2, //thickness of dash/dots
                                            dashPattern: const [8, 4],
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt,
                                                    color: AppColors.kPrimary,
                                                  ),
                                                  Text(
                                                    "Tap To Scan New ",
                                                    style: poppinsLight,
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
                      )
                    : const Center(child: CircularProgressIndicator());
              })
            ],
          ),
        ));
  }

  Future<void> restun() async {
    setState(() {});
  }

  void _showDialogImg(index) {
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
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              // imageUrl: "",
                              imageUrl:
                                  "${MyRepo.userDataModel.value.data!.cards![index - 1].cardImage}",
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
                                    "Name on Card: ",
                                    style:
                                        TextStyle(color: AppColors.kGrayText),
                                  ),
                                  Text(
                                      "${MyRepo.userDataModel.value.data!.cards![index - 1].nameOnCard}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Card Number: ",
                                    style:
                                        TextStyle(color: AppColors.kGrayText),
                                  ),
                                  Text(
                                      "${MyRepo.userDataModel.value.data!.cards![index - 1].cardNumber}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, bottom: 5),
                              child: Row(
                                children: [
                                  const Text(
                                    "Cvv: ",
                                    style:
                                        TextStyle(color: AppColors.kGrayText),
                                  ),
                                  Text(
                                      "${MyRepo.userDataModel.value.data!.cards![index - 1].cvv}"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    "Expiry Date: ",
                                    style:
                                        TextStyle(color: AppColors.kGrayText),
                                  ),
                                  Text(
                                      "${MyRepo.userDataModel.value.data!.cards![index - 1].expiryDate}"),
                                ],
                              ),
                            )
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
                          child: GestureDetector(
                              onTap: () {
                                isloading.value = true;
                                Get.back();
                                print(
                                    "====delete item:${MyRepo.userDataModel.value.data!.cards![index - 1].id}============");
                                userDataController.deleteCard((MyRepo.userDataModel.value.data!.cards![index - 1].id.toString())).then((status) async {
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
                              )))
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
