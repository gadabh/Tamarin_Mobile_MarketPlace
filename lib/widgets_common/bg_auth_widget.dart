import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';





Widget bgAuthWidget({Widget? child}){
  return Container(

    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(imgAuthBackground),fit: BoxFit.fill
    )),
    child: child,
  );
}


