import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/repository/MyRepo.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_size.dart';

class TransTypeDropDown extends StatefulWidget {
  const TransTypeDropDown({Key? key,}) : super(key: key);
  @override
  State<TransTypeDropDown> createState() => _TransTypeDropDownState();
}
class _TransTypeDropDownState extends State<TransTypeDropDown> {
  RxBool isDropdown=false.obs;
  // GestureTapCallback?  onTap;
  @override
  initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Column(
        children: [
          InkWell(
            onTap: (){
              isDropdown.value=!isDropdown.value;
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*1),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGrayText),
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    Text(MyRepo.transtypeName.value),
                    Icon(
                      isDropdown.value
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      color: AppColors.kPrimary,
                      size: 30,
                    ),
                  ],
                )
            ),
          ),
          SizedBox(
            height: AppSizes.appHorizontalSm,
          ),
          if(isDropdown.value)
            Container(
              decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(10)
              ),
              height: 200,
              child: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                        itemCount: MyRepo.transTypeModel.value.data!.length,
                        itemBuilder:(context,index){

                          return InkWell(
                            // onTap:widget.onTap,
                            onTap: (){
                              MyRepo.transtypeName.value=MyRepo.transTypeModel.value.data![index].transactionType!;
                              MyRepo.transtypeID.value=MyRepo.transTypeModel.value.data![index].id.toString();

                              isDropdown.value=!isDropdown.value;
                              print("==transtypeID=====${MyRepo.transtypeID.value}");

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.kPageBG,
                                  borderRadius:
                                  BorderRadius
                                      .circular(10)),
                              padding:
                              EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 10),
                              margin:
                              EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 5),
                              child: Center(
                                child: Text("${MyRepo.transTypeModel.value.data![index].transactionType}",
                                  style: TextStyle(
                                      color:
                                      AppColors.kPrimary),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
        ],
      );
    });
  }
}