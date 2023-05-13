

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/colors.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/category_screen/loading_indicator.dart';
import 'package:mobile_v3/views/chat_screen/chat_screen.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../controllers/asset_controller.dart';

class ItemDetails extends StatelessWidget {


  final String? title ;
  final dynamic data ;
  const ItemDetails({Key? key ,required this.title , this.data}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AssetController>();

    return WillPopScope(
      onWillPop: ()async {
        //  controller.resetValues();
        return false ;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed:(){
              //   controller.resetValues();
              Get.back();
            } ,icon: const Icon(Icons.arrow_back),),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
            Obx(()=>
                IconButton(onPressed: (){
                  if(controller.isFav.value){
                    controller.removeFromWishlist(data.id,context);

                  }else{
                    controller.addToWishlist(data.id,context);

                  }

                }, icon:  Icon(
                  Icons.favorite_outlined ,
                  color: controller.isFav.value? Colors.red : darkFontGrey,

                )),
            )

          ],
        ),
        body: Column(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //swiper section
                    VxSwiper.builder(
                        itemCount: data['imageURL'].length,
                        autoPlay: true,
                        height: 350,
                        viewportFraction : 1.0 ,
                        aspectRatio: 16/9 ,
                        itemBuilder: (context,index){
                          return Image.network(data['imageURL'][index],width: double.infinity,fit : BoxFit.cover,);
                        }),
                    10.heightBox ,
                    title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox ,
                    VxRating(
                      value: double.parse(data['rating']),
                      isSelectable : false ,
                      maxRating: 5,
                      onRatingUpdate: (value){},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      stepInt: true,),
                    10.heightBox,

                    data['price']==0 ?
                    "Free".text.fontFamily(bold).color(Colors.green).size(16).make()
                        :
                    "\$ ${data['price']}".text.fontFamily(bold).color(Colors.red).size(18).make(),

                    Row(

                      children: [
                        Expanded(

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment : CrossAxisAlignment.start ,
                            children: [
                              "Brand : ".text.gray800.fontFamily(bold).make(),
                              5.heightBox,
                              "${data['brand']}".text.gray500.fontFamily(semibold).size(16).make(),
                            ],

                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message_rounded, color: darkFontGrey),
                        ).onTap(() {

                          Get.to(
                                ()=> const ChatScreen(),

                            arguments: [data['brand'], data['added_by']],
                          );
                        })
                      ],
                    ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(Colors.grey.shade100).make(),
                    //description Section
                    10.heightBox,
                    "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    "${data['desc']}".text.color(darkFontGrey).make(),



                    //Review section
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children:
                      List.generate(itemDetailsListe.length, (index) => ListTile(title: itemDetailsListe[index]
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                        trailing: const Icon(Icons.arrow_forward),
                      )),
                    ),
                    20.heightBox,
                    //asset you may like

                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white38
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          assetyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),

                          20.heightBox,

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



                  ],
                ),
              ),

            )),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButtom(
                color: redColor,
                onPress: () async {

                  if ("${data['price']}" == "0") {
                    final url = Uri.parse(data['sourceURL']);
                    await launch(url.toString());


                  }

                },
                textColor: whiteColor,
                title: "${data['price']}" == "0" ? "Get asset" : "Add to cart",
              ),
            ) ,
          ],
        ),
      ),
    );
  }
}
