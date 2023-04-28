import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/category_screen/item_details.dart';
import 'package:mobile_v3/views/category_screen/loading_indicator.dart';
import 'package:mobile_v3/views/home_screen/components/featured_button.dart';
import 'package:mobile_v3/widgets_common/home_buttons.dart';

import '../../controllers/asset_controller.dart';

class HomeScreen extends StatelessWidget {


  const HomeScreen ({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AssetController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            // search container 
            Container(
            alignment: Alignment.center,
            height: 60,
            color:lightGrey,
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything ,
                hintStyle: TextStyle(color : textfieldGrey)
              ),
            ),
          ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [

                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 200,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length, itemBuilder: (context,index){
                      return Image.asset(
                          slidersList[index],
                          fit : BoxFit.fill
                      ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 5)).make();
                    }
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      List.generate(2, (index) => homeButtons(
                        height: context.screenHeight *0.15 ,
                        width: context.screenWidth /2.5 ,
                        icon: index==0 ? icTodaysDeal : icFlashDeal,
                        title: index==0 ? todayDeal : flashsale ,

                      )),

                    ),

                    10.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                      List.generate(3, (index) => homeButtons(
                        height: context.screenHeight *0.15 ,
                        width: context.screenWidth /3.5 ,
                        icon: index==0 ? icTopCategories : index ==1 ? icBrands : icTopSeller,
                        title: index==0 ? topCategories : index ==1 ? brand : topSellers ,

                      )),

                    ),
                    20.heightBox,
                    Align(
                        alignment : Alignment.centerLeft,
                        child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                    20.heightBox,
                    //Featured  categories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                          List.generate(
                              3, (index) =>Column(
                                children: [
                                  Column(
                                    children: [
                                    featuredButton(icon: featuredImages1[index] ,
                                        //title: featuredTitles1[index]
                                    ),
                                    10.heightBox,
                                    featuredButton(icon: featuredImages2[index] ,
                                        //title: featuredTitles2[index]
                                       ),
                                    ],),],
                              ),).toList(),
                      ),
                    ),

                    //featured Asset
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white38
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredAsset.text.black.fontFamily(bold).size(18).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestorServices.getfeaturedAssets(),

                              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {

                                if(!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                }else if ( snapshot.data!.docs.isEmpty){
                                  return "No Featured Assets ".text.white.makeCentered();
                                }
                                else{
                                  var featuredData= snapshot.data!.docs;

                                  return Row(
                                    children:
                                    List.generate(featuredData.length, (index) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(featuredData[index]['imageURL'][0], width: 170,height: 120,fit: BoxFit.cover),
                                        10.heightBox,




                                        (() {
                                          String shortenName = featuredData[index]['name'];
                                          if (shortenName.length > 15) {
                                            shortenName = shortenName.substring(0, 15) + '...';
                                          }
                                          return shortenName;
                                        })().text.fontFamily(semibold).color(darkFontGrey).make(),











                                        10.heightBox,
                                      featuredData[index]['price']==0 ?
                                      "Free".text.fontFamily(bold).color(Colors.green).size(16).make()
                                        :
                                      "\$ ${featuredData[index]['price']}".text.fontFamily(bold).color(Colors.green).size(16).make()
                                      ],
                                    ).box.white.roundedSM.margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(8))
                                        .make().onTap(() {
                                      Get.to(()=>ItemDetails(
                                          title:"${featuredData[index]['name']}",
                                          data:featuredData[index]));
                                    })
                                    ),
                                  );
                                }

                              }
                            ),
                          )
                        ],
                      ) ,
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSlidersList.length, itemBuilder: (context,index){
                      return Image.asset(
                          secondSlidersList[index],
                          fit : BoxFit.fill
                      ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 5)).make();
                    }
                    ),

                    //ALL ASSETS
                    20.heightBox,
                    StreamBuilder(
                      stream: FirestorServices.allAssets(),
                        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                        if (!snapshot.hasData){
                          return loadingIndicator();
                        }else
                        {
                          var allassetsdata = snapshot.data!.docs;
                          return      GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allassetsdata.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,mainAxisExtent: 300 ,crossAxisSpacing: 8,mainAxisSpacing: 8),
                              itemBuilder: ( context,  index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network("${allassetsdata[index]['imageURL'][0]}", width: 200, height: 200,fit: BoxFit.cover),
                                    const  Spacer(),


                                    (() {
                                      String shortenName = allassetsdata[index]['name'];
                                      if (shortenName.length > 15) {
                                        shortenName = shortenName.substring(0, 15) + '...';
                                      }
                                      return shortenName;
                                    })().text.fontFamily(semibold).color(darkFontGrey).make(),





                                    10.heightBox,

                                    allassetsdata[index]['price']==0 ?
                                    "Free".text.fontFamily(bold).color(Colors.green).size(16).make()
                                        :
                                    "\$ ${allassetsdata[index]['price']}".text.fontFamily(bold).color(Colors.green).size(16).make(),
                                  ],
                                ).box.white.roundedSM
                                    .margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(12))
                                    .make().onTap(() {
                                      Get.to(()=>ItemDetails(
                                          title:"${allassetsdata[index]['name']}",
                                          data:allassetsdata[index]));
                                });
                              });
                        }})
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
