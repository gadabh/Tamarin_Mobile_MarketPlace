




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';

import '../models/category_model.dart';

class AssetController extends GetxController{
  var subcat=[];
  var isFav = false.obs ;
  var iscart =false.obs ;
  var quantity= 0.obs ;



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
    name , imageURL , prop , price ,context,//existe,
})async{
  await firestore.collection(cartCollection).doc().set({

    'name' :name ,
    'imageURL': imageURL ,
    'prop': prop ,
    'price':price,
    'added_by' : currentUser!.uid,
   // 'existe': existe,

  }).catchError((error){
    VxToast.show(context, msg: error.toString());
  });
}

addToWishlist(docId,context)async{
  await firestore.collection(assetCollection).doc(docId).set({
    'wishlist': FieldValue.arrayUnion([
      currentUser!.uid
    ])
  },SetOptions(merge: true));
  isFav(true);
  VxToast.show(context  , msg: "Added to Wishlist");
}


  removeFromWishlist(docId,context)async{
    await firestore.collection(assetCollection).doc(docId).set({
      'wishlist': FieldValue.arrayRemove([
        currentUser!.uid
      ]),

    },SetOptions(merge: true));
    isFav(false);
    VxToast.show(context  , msg: "Removed from Wishlist");
  }



  checkIfFav(data)async{
    if(data['wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else {
      isFav(false);

    }
  }

  increaseQuantity(context){
    VxToast.show(context, msg: "add in the cart");
  quantity.value++;
  }
  decreaseQuantity(context){

  quantity.value--;
  }




  /*



  checkIfInCart(data)async{
    if(data['exist'].contains(currentUser!.uid)){
      iscart(true);
    }else {
      iscart(false);

    }
  }

  addIdToCart(docId,context)async{
    await firestore.collection(assetCollection).doc(docId).set({
      'exist': FieldValue.arrayUnion([
        currentUser!.uid
      ])
    },SetOptions(merge: true));
    iscart(true);
    VxToast.show(context  , msg: "Add to cart");
  }
*/





}




























