import 'package:flutter/cupertino.dart';
import 'package:mobile_v3/consts/consts.dart';


Widget appLogoWidget (){
  //using velocity X here 
  return Image.asset(icAppLogo).box.white.size(310, 150).padding(const EdgeInsets.all(8)).make();

}