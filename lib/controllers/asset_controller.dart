import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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
    name , imageURL , prop , price ,context,  sourceURL,docId,UpdatedAt,category,
    createdAt,desc ,editedBy ,formats,rating,state,sub_category ,added_by ,brand,wishlist, required String userId
  })async{

    await firestore.collection(cartCollection).doc().set({
      'UpdatedAt':UpdatedAt,
      'userId':userId,
      'added_by' : added_by,
      //currentUser!.uid,
      'brand': brand,
      'category':category,
      'createdAt':createdAt,
      'desc':desc,
      'editedBy':editedBy,
      'formats':formats,
      'id': docId,
      'imageURL': imageURL ,
      'is_featured': false ,
      'name' :name ,
      'price':price,
      'prop': prop ,
      'rating':rating,
      'sourceURL':sourceURL,
      'state':state,
      'sub_category':sub_category,
      'wishlist':wishlist,
    }
    ).catchError((error){

      VxToast.show(context, msg: error.toString());
    });
    iscart(true);
  }
  rmFromCart(docId)async{
    await firestore.collection(cartCollection).doc(docId).delete();

    iscart(false);
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









}




























