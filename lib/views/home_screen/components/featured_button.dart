import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/views/category_screen/category_details.dart';


Widget featuredButton( {String? title , icon}){

  return Row(
    children: [
      Image.asset(icon,width: 190,fit: BoxFit.fill,),
     // 10.heightBox,
     // title!.text.fontFamily(semibold).color(darkFontGrey).make(),

    ],
  ).box.width(200)
      .margin(EdgeInsets.symmetric(horizontal: 4))
      .white.padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm
      .make().onTap(() {
        Get.to(()=>CategoryDetails(title: title));
        
  });
}