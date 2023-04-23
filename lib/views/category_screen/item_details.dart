






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/colors.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/views/chat_screen/chat_screen.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';

import '../../controllers/asset_controller.dart';


class ItemDetails extends StatelessWidget {

  static const existe =false ;
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
                    assetyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                        List.generate(6, (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(imgP1, width: 170,fit: BoxFit.cover),
                            10.heightBox,
                            "Amphibious for Blender 2.8".text.fontFamily(semibold).color(darkFontGrey).make(),
                            10.heightBox,
                            "Free".text.fontFamily(bold).color(Colors.green).size(16).make(),


                          ],
                        ).box.white.roundedSM.margin(EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(8)).make()
                        ),


                      ),
                    )



                  ],
                ),
              ),

            )),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButtom(
                    color: redColor,
                    onPress: (){

                  if(controller.iscart.value){
                    VxToast.show(context, msg: "Already in the cart");

                  }else{
                    controller.addIdToCart(data.id,context);
                    controller.addToCart(
                      name: data['name'],
                      imageURL: data['imageURL'][0],
                      prop: data['prop'],
                      price: data['price'],
                      existe: "true",
                      context: context,
                    );



                  }

                    },
                    textColor: whiteColor,
                    title: "Add to cart "),
              ),

          ],

        ),
      ),
    );
  }
}
