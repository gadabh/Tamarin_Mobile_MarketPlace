


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';

import '../../../consts/styles.dart';

Widget orderPlaceDetails ({d1, d2, title1, title2}){
  return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              "$title1".text.fontFamily(semibold).make(),
              "$d1".text.color(Colors.black45).fontFamily(semibold).make(),

            ],
          ),
          SizedBox(
            width: 130 ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightBox,
                "$title2".text.fontFamily(semibold).make(),
                "$d2".text.color(Colors.black45).fontFamily(semibold).make(),

              ],
            ),
          ),
        ],

      ),
    );

}