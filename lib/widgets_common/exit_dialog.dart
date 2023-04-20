import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit ?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButtom(
                color: redColor,
                onPress: (){
                 SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes"
            ),
            ourButtom(
                color: redColor,
                onPress: (){
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No"
            ),

          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}