import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';

Widget costumNumberField({String? title, required String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Colors.black).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        keyboardType: TextInputType.number, // Set the keyboard type to accept only numbers
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
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
            borderSide: BorderSide(color: textfieldGrey),
          ),
        ),
      ),
    ],
  );
}
