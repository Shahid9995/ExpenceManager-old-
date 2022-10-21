import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/repository/MyRepo.dart';
import '../../../../core/viewModel/Scaffold/AppScafflod.dart';
import '../../../../util/app_color.dart';
import '../../../../util/app_size.dart';

class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  // UserDataController userDataController=UserDataController(userRepo: UserRepo(ApiClient()));
  @override
  void initState() {
    // print("===length:${MyRepo.googleDataModel.value.data![index].pagemap!.cseImage!.length}======");
    // userDataController.transType();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose(){
    MyRepo.googleDataModel.value.data!.clear();
    MyRepo.tittle.value='';
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
      // isTransaction: true,
      // isActionButton: true,
      heading: 'Product Detail', body:Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return restun();
        },
        child:
        Column(
          children: [
            Flexible(
              child:true?GridView(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: .9),
                children: List.generate(MyRepo.googleDataModel.value.data!.length, (index) {
                    return InkWell(
                      onTap: () {
                        // _showDialogImg(index);
                      },
                      child: Container(
                        // padding: EdgeInsets.symmetric(),
                        //   margin: EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm),
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,

                            borderRadius: BorderRadius.circular(15),
                            // border: Border.all(color: AppColors.kBlack.withOpacity(0.5))
                          ),
                          // height: 190,
                          // width: 170,
                          child: Center(
                              child: Column(
                                // mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: AppColors.kBlack.withOpacity(0.5))),
                                    padding: EdgeInsets.symmetric(vertical: AppSizes.appHorizontalSm * 0.6,
                                    ),
                                    child:   (MyRepo.googleDataModel.value.data![index].pagemap!.cseImage!=null)?
                                    CachedNetworkImage(
                                      // imageUrl: "",
                                      imageUrl: "${MyRepo.googleDataModel.value.data![index].pagemap!.cseImage!.first.src}",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(width: 150,
                                            height: 90,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(image: imageProvider,
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                      placeholder: (context,index) =>
                                          Container(alignment: Alignment.center,
                                              child: const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                    ):Container(),
                                  ),
                                  SizedBox(height: AppSizes.appVerticalSm*.5,),
                                  RichText(text:TextSpan(
                                    text: "${MyRepo.googleDataModel.value.data![index].displayLink}",
                                    style: const TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final url = Uri.parse("${MyRepo.googleDataModel.value.data![index].link}");
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        } else {
                                          throw "Could not launch $url";
                                        }
                                      },
                                  ), ),
                                  SizedBox(height: AppSizes.appVerticalSm*.5,),
                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: AppSizes.appHorizontalSm*1.3),
                                    child: Text("${MyRepo.googleDataModel.value.data![index].title}",textAlign: TextAlign.start,style: const TextStyle(color: AppColors.kBlack,fontSize: 15,fontWeight: FontWeight.w500)),
                                  )
                                ],
                              ))),
                    );
                }),
              ):
              ListView.builder(
                  itemCount: MyRepo.googleDataModel.value.data!.length,
                  itemBuilder: (context,index){
                    print("===length:${MyRepo.googleDataModel.value.data![index].pagemap!.cseImage!=null}======");
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.kGrayText
                            )
                          ),
                          margin:const EdgeInsets.symmetric(horizontal: 15,vertical: 10) ,
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    (MyRepo.googleDataModel.value.data![index].pagemap!.cseImage!=null)? CachedNetworkImage(
                                      // imageUrl: "",
                                      imageUrl: "${MyRepo.googleDataModel.value.data![index].pagemap!.cseImage!.first.src}",
                                      // imageUrl: "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSGKxks616GarxvpvK6dy5BjeMmfrqxEXJx4t69Mg3Kra5XVn7dgN5cg04N",
                                      // imageBuilder: (context, imageProvider) => Container(
                                      //   width: double.infinity,
                                      //   // height: 10,
                                      //   decoration: BoxDecoration(
                                      //     // borderRadius: BorderRadius.circular(10),
                                      //     image: DecorationImage(
                                      //         image: imageProvider,
                                      //         fit: BoxFit.fill
                                      //     ),
                                      //   ),
                                      // ),
                                      placeholder: (context,index)=>Container(
                                          alignment: Alignment.center,
                                          child: const CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                    ):Container(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: AppSizes.appHorizontalSm*0.5,
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${MyRepo.googleDataModel.value.data![index].title}",textAlign: TextAlign.start,style: const TextStyle(color: AppColors.kBlack,fontSize: 18,fontWeight: FontWeight.w600),),
                                    SizedBox(
                                      height: AppSizes.appHorizontalSm*0.5,
                                    ),
                                    Text("${MyRepo.googleDataModel.value.data![index].snippet}",textAlign: TextAlign.start,style: const TextStyle(color: AppColors.kBlack,fontSize: 15,),),
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
                                            const Icon(Icons.web_asset_sharp,color: AppColors.kPrimary,),
                                            SizedBox(
                                              width: AppSizes.appHorizontalSm*0.5,
                                            ),
                                            RichText(text:TextSpan(
                                              text: "${MyRepo.googleDataModel.value.data![index].displayLink}",
                                              style: const TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () async {
                                                  final url = Uri.parse("${MyRepo.googleDataModel.value.data![index].link}");
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url);
                                                  } else {
                                                    throw "Could not launch $url";
                                                  }
                                                },
                                            ), )
                                          ],
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Text("${MyRepo.userDataModel.value.data!.amountcurrency}",style: const TextStyle(color: AppColors.kPrimary,fontWeight: FontWeight.w600,fontSize: 20),),
                                        //     SizedBox(
                                        //       width: AppSizes.appHorizontalSm*0.5,
                                        //     ),
                                        //     Text("${MyRepo.userDataModel.value.data!.transactions![index].transactionAmount}",style: const TextStyle(color: AppColors.kPrimary,fontWeight: FontWeight.w600,fontSize: 20))
                                        //   ],
                                        // )

                                      ],
                                    ),
                                  ],
                                ),
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