import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';


Widget ourButtom({onPress , color , textColor ,String? title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress ,

    child: title!.text.color(textColor).fontFamily(bold).make(),

  );

}