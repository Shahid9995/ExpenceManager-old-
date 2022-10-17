import 'package:cached_network_image/cached_network_image.dart';
import 'package:expensemanage_app/util/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/repository/MyRepo.dart';
import '../../../core/viewModel/Scaffold/AppScafflod.dart';
import '../../../util/app_size.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return AppScafflod(
      isActionButton: true,
      heading: 'Products', body:Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          return restun();
        },
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: MyRepo.userDataModel.value.data!.priceLookups!.length,
                  itemBuilder: (context,index){
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            // imageUrl: "",
                            imageUrl: "${MyRepo.userDataModel.value.data!.priceLookups![index].productImage}",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 70,
                              width: 50,
                              decoration: BoxDecoration(

                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context,index)=>CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),),
                          SizedBox(
                            width: AppSizes.appHorizontalSm,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${MyRepo.userDataModel.value.data!.priceLookups![index].productTitle}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
                              SizedBox(
                                height: AppSizes.appHorizontalSm*0.5,
                              ),
                              Text("${MyRepo.userDataModel.value.data!.priceLookups![index].productDescription}",style: TextStyle(color: AppColors.kGrayText),),
                              SizedBox(
                                height: AppSizes.appHorizontalSm*0.5,
                              ),
                              Text("${MyRepo.userDataModel.value.data!.priceLookups![index].priceCurrency} ${MyRepo.userDataModel.value.data!.priceLookups![index].price}",style: TextStyle(color: AppColors.kPrimary),),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: AppColors.kGray,
                    )
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
