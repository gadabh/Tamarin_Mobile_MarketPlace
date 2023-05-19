import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/controllers/home_controller.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/category_screen/item_details.dart';
import 'package:mobile_v3/views/category_screen/loading_indicator.dart';
import 'package:mobile_v3/views/home_screen/components/featured_button.dart';
import 'package:mobile_v3/views/home_screen/search_screen.dart';
import 'package:mobile_v3/widgets_common/home_buttons.dart';

import '../../controllers/asset_controller.dart';
import '../category_screen/category_details.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen ({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AssetController());
    var Homecontroller =Get.find<HomeController>();

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
              controller: Homecontroller.searchController,
              decoration:  InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.search).onTap(() {
                  if(Homecontroller.searchController.text.isNotEmptyAndNotNull){
                    Get.to(()=> SearchScreen(title: Homecontroller.searchController.text,));

                  }


                }),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything ,
                hintStyle: TextStyle(color : textfieldGrey)
              ),
            ),
          ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [

                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 250,

                      enlargeCenterPage: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Image.asset(
                                secondSlidersList[index],
                                fit: BoxFit.fill,
                              ).box.rounded.clip(Clip.antiAlias).make(),
                            ),
                            SizedBox(width: 10), // Adjust the spacing between images as needed
                          ],
                        );
                      },
                    ),




                    Align(
                        alignment : Alignment.centerLeft,
                        child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                    10.heightBox,
                    //Featured  categories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children:
                          List.generate(
                              2, (index) =>Column(

                            children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [


                                      featuredButton(icon:  featuredImages1[index] ,
                                        title:  featuredTitles1[index]
                                    ),
                                  10.heightBox,

                                    featuredButton(icon: featuredImages2[index] ,
                                        title: featuredTitles2[index]
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
                        color: Colors.white38,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredAsset.text.black.fontFamily(bold).size(18).make(),
                          10.heightBox,

// ...

                         SizedBox(
                    height: 200,
                    child: FutureBuilder(
                        future: FirestorServices.getfeaturedAssets(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return "No Featured Assets ".text.white.makeCentered();
                  } else {
                    var featuredData = snapshot.data!.docs;
                    int currentPageIndex = 0;
                    final PageController pageController = PageController(initialPage: currentPageIndex);

                    // Auto-scroll function
                    void autoScroll() {
                      currentPageIndex = (currentPageIndex + 1) % featuredData.length;
                      pageController.animateToPage(
                        currentPageIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }

                    // Start auto-scrolling
                    Timer.periodic(const Duration(seconds: 3), (timer) {
                      autoScroll();
                    });

                    return PageView.builder(
                      controller: pageController,
                      itemCount: (featuredData.length / 2).ceil(), // Divide the total count by 3 and round up
                      itemBuilder: (context, pageIndex) {
                        final startIndex = pageIndex * 2;
                        final endIndex = startIndex + 2 < featuredData.length ? startIndex + 2 : featuredData.length;
                        final itemsPerPage = featuredData.sublist(startIndex, endIndex);

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: itemsPerPage.map((itemData) {
                              return Container(
                                width: MediaQuery.of(context).size.width /2.3 - 16, // Subtract margin from width
                                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      itemData['imageURL'][0],
                                      width: 145,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    (() {
                                      String shortenName = itemData['name'];
                                      if (shortenName.length > 15) {
                                        shortenName = shortenName.substring(0, 15) + '...';
                                      }
                                      return shortenName;
                                    })().text.fontFamily(semibold).color(darkFontGrey).make(),
                                    10.heightBox,
                                    itemData['price'] == 0
                                        ? 'Free'.text.fontFamily(bold).color(Colors.green).size(16).make()
                                        : '\$ ${itemData['price']}'.text.fontFamily(bold).color(Colors.green).size(16).make(),
                                  ],
                                ).box.white.roundedSM.padding(const EdgeInsets.all(8)).make().onTap(() {
                                  Get.to(() => ItemDetails(title: '${itemData['name']}', data: itemData));
                                }),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),







                        ],
                      ),

                    ),




                    //ALL ASSETS
                    30.heightBox,


                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white38
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          8.heightBox,
                          "All Assets ".text.black.fontFamily(bold).size(18).make(),
                          15.heightBox,
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
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:2,mainAxisExtent: 200 ,crossAxisSpacing: 8,mainAxisSpacing: 8),
                                    itemBuilder: ( context,  index){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network("${allassetsdata[index]['imageURL'][0]}", width: 200, height: 120,fit: BoxFit.cover),
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
                              }}),
                        ],
                      ),
                    )
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
