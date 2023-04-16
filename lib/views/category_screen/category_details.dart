import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/controllers/asset_controller.dart';
import 'package:mobile_v3/views/category_screen/item_details.dart';
import 'package:mobile_v3/consts/consts.dart';

import '../../widgets_common/bg_auth_widget.dart';

class CategoryDetails extends StatelessWidget {
  final String? title ;
  const CategoryDetails({Key? key ,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller =Get.find<AssetController>();

    return Scaffold(
      backgroundColor: lightGrey,
              appBar: AppBar(
                title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
     
              ),
              body: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                          List.generate(controller.subcat.length,
                                  (index) =>"${controller.subcat[index]}".
                                       text
                                      .size(12)
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .makeCentered()
                                      .box
                                      .white
                                      .rounded
                                      .size(120, 60)
                                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                                      .make() )

                      ),

                    ),
                    //assets container
                    20.heightBox,
                    Expanded(

                           child: GridView.builder(
                             physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                                itemCount: 8,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount:2 ,crossAxisSpacing: 2,mainAxisSpacing: 8,mainAxisExtent: 250  ),
                                itemBuilder: (context , index){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(imgP5, width: 200, height: 150,fit: BoxFit.cover),
                                      "Amphibious for Blender 2.8".text.fontFamily(semibold).color(darkFontGrey).make(),
                                      10.heightBox,
                                      "\$ 2".text.fontFamily(bold).color(Colors.green).size(16).make(),


                                    ],
                                  ).box.white.roundedSM.outerShadowSm.margin(const EdgeInsets.symmetric(horizontal: 4))
                                      .padding(const EdgeInsets.all(12)).make().onTap(() { 
                                        Get.to(()=>ItemDetails(title: "exemple of one asset "));
                                  });

                                }
                      ,
                    ))
                  ],
                ),
              ),

         );
  }
}
