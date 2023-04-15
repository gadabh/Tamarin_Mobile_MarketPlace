import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';



Widget costumTextField({String? title , required String? hint , controller}){


  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        decoration:   InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,

          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide:
              BorderSide(color: redColor)
          ),

        ),
      )

    ],
  );
}