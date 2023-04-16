


import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class AssetController extends GetxController{
  var subcat=[];

getSubCategories(title) async{
  subcat.clear();
  var data = await rootBundle.loadString("lib/services/category_model.json");
  var decoded=categoyModelFromJson(data);
  var s= decoded.categories.where((element) => element.name == title).toList();

  for(var e in s[0].subcategory){
    subcat.add(e);
  }
}


}




























