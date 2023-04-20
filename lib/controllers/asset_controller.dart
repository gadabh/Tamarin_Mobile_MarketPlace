




import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';

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
addToCart({
    name , imageURL , seller , price ,context
})async{
  await firestore.collection(cartCollection).doc().set({
    'name' :name ,
    'imageURL': imageURL ,
    'seller': seller ,
    'price':price,
    'added_by' : currentUser!.uid

  }).catchError((error){
    VxToast.show(context, msg: error.toString());
  });
}


resetValues(){

}


}




























