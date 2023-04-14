import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:mobile_v3/consts/consts.dart';





Widget bgWidget({Widget? child}){
  return Container(
    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill
    )),
    child: child,
  );
}


