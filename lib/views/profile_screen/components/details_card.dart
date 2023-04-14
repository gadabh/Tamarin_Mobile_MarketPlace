



import 'package:flutter/cupertino.dart';
import 'package:mobile_v3/consts/colors.dart';
import 'package:mobile_v3/consts/consts.dart';

Widget detailsCard({ width , String? count , required String title }){

  return    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      title.text.fontFamily(bold).size(14).color(darkFontGrey).make(),
      5.heightBox,
      count!.text.color(darkFontGrey).make(),
    ],
  ).box.white.rounded.width(width).height(80).padding(EdgeInsets.all(4)).make();


}