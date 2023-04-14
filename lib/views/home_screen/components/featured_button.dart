import 'package:flutter/cupertino.dart';
import 'package:mobile_v3/consts/consts.dart';


Widget featuredButton( {String? title , icon}){

  return Row(
    children: [
      Image.asset(icon,width: 190,fit: BoxFit.fill,),
     // 10.heightBox,
     // title!.text.fontFamily(semibold).color(darkFontGrey).make(),

    ],
  ).box.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).white.padding(const EdgeInsets.all(4)).roundedSM.outerShadowSm.make();
}