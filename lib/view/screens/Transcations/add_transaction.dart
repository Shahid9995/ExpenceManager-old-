import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/api/api_client.dart';
import '../../../core/repository/MyRepo.dart';
import '../../../core/repository/UserRepo.dart';
import '../../../core/viewModel/Scaffold/AppScafflod.dart';
import '../../../core/viewModel/controller/userdatacontroller/user_data_controller.dart';
import '../../../util/app_color.dart';
import '../../../util/app_size.dart';

class transactionList extends StatefulWidget {
  const transactionList({Key? key}) : super(key: key);

  @override
  State<transactionList> createState() => _transactionListState();
}

class _transactionListState extends State<transactionList> {
  UserDataController userDataController=UserDataController(userRepo: UserRepo(ApiClient()));
  @override
  void initState() {
    // userDataController.transType();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
      // isTransaction: true,
      // isActionButton: true,
      heading: 'Transactions', body:Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return restun();
        },
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(

                  itemCount: MyRepo.userDataModel.value.data!.transactions!.length,
                  itemBuilder: (context,index){
                    String date=DateFormat('yyyy-MM-dd').format(DateTime.parse(MyRepo.userDataModel.value.data!.transactions![index].transactionDate.toString()));
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.kGrayText.withOpacity(0.5)
                            )
                          ),
                          margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 10) ,
                          padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${MyRepo.userDataModel.value.data!.transactions![index].transactionType}",style: const TextStyle(color: AppColors.kBlack,fontSize: 18,fontWeight: FontWeight.w600),),
                              SizedBox(
                                height: AppSizes.appHorizontalSm*0.5,
                              ),
                              Text("${MyRepo.userDataModel.value.data!.transactions![index].transactionDescription}",textAlign: TextAlign.start,style: const TextStyle(color: AppColors.kBlack,),),
                              SizedBox(
                                height: AppSizes.appHorizontalSm*0.5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.calendar_month,size: 15,color: AppColors.kPrimary,),
                                      SizedBox(
                                        width: AppSizes.appHorizontalSm*0.5,
                                      ),
                                      Text(date)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("${MyRepo.userDataModel.value.data!.amountcurrency}",style: const TextStyle(color: AppColors.kPrimary,fontWeight: FontWeight.w600,fontSize: 20),),
                                      SizedBox(
                                        width: AppSizes.appHorizontalSm*0.5,
                                      ),
                                      Text("${MyRepo.userDataModel.value.data!.transactions![index].transactionAmount}",style: const TextStyle(color: AppColors.kPrimary,fontWeight: FontWeight.w600,fontSize: 20))
                                    ],
                                  )

                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            // FloatingActionButtonThemeData()

          ],
        ),
      ),
    ),);
  }
  Future<void> restun() async {
    setState(() {
    });
  }
}