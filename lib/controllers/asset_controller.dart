import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import '../models/category_model.dart';

class AssetController extends GetxController{
  var subcat=[];
  var isFav = false.obs ;
  var isInCart = false.obs;





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



  }





  checkIfIncart(docId, context,controller ,data) async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection(assetCollection).doc(docId).get();
    final List<dynamic>? inCart = snapshot.data()?['InCart'];

    if (inCart != null && inCart.contains(currentUser!.uid)) {
      isInCart(true);
      VxToast.show(context, msg: 'Item already in cart');
    } else {
      await controller.addToCart(
        docId: data.id,
        userId: currentUser!.uid,
        added_by: data['added_by'],
        UpdatedAt: data['UpdatedAt'],
        brand: data['brand'],
        category: data['category'],
        createdAt: data['createdAt'],
        desc: data['desc'],
        editedBy: data['editedBy'],
        formats: data['formats'],
        rating: data['rating'],
        state: data['state'],
        sub_category: data['sub_category'],
        sourceURL: data['sourceURL'],
        wishlist: data['wishlist'],

        name: data['name'],
        imageURL: [data['imageURL'][0]],
        prop: data['prop'],
        price: data['price'],
        context: context,
      );
      await FirebaseFirestore.instance.collection(assetCollection).doc(docId).set({
        'InCart': FieldValue.arrayUnion([
          currentUser!.uid
        ])
      }, SetOptions(merge: true));
      isInCart(false);
      VxToast.show(context, msg: 'Item added to cart');
    }
  }










  rmFromCart(docId)async{
    await firestore.collection(cartCollection).doc(docId).delete();
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











}




























