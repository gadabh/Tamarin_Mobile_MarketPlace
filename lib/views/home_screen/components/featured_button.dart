import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/views/category_screen/category_details.dart';


Widget featuredButton({String? title, icon}) {
  return Padding(
    padding: EdgeInsets.all(7.0), // Adjust the padding values as needed
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 60, fit: BoxFit.fill),
        SizedBox(height: 10),
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ).box.rounded.white.size(170, 140).make().onTap(() {
      Get.to(() => CategoryDetails(title: title));
    }),
  );
}
