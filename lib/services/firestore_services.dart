

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_v3/consts/consts.dart';

class FirestorServices {




  //get users data
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }

  // get asset according to category
   static getAssets(category){
    return firestore.collection(assetCollection).where('category',isEqualTo : category).snapshots();

   }

  //get cart asset
   static getCart(uid){
     return firestore.collection(cartCollection).where('userId' , isEqualTo: uid).snapshots();
   }
   // delte asset from cart ==> del  document
  static deletDocument(docId)  {
    firestore.collection(cartCollection).doc(docId).delete();
  }




  //get all chat messages
  static getChatMessages(docId){
    return firestore
        .collection(chatsCollection)
        .doc(docId).collection(messageCollection)
        .orderBy('created_on',descending: false)
        .snapshots();
  }



  static getAllOrders(){
    return firestore.collection(ordersCollection)
        .where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }

  static getAllWishlists(){
    return firestore.collection(assetCollection)
        .where('wishlist',arrayContains: currentUser!.uid).snapshots();
  }

  static getAllMessages(){
    return   firestore
        .collection(chatsCollection).where('fromId',isEqualTo: currentUser!.uid)

        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore.collection(cartCollection).where('added_by', isEqualTo: currentUser!.uid
    ).get().then((value) {return value.docs.length ;}),

      firestore.collection(assetCollection)
          .where('wishlist',arrayContains: currentUser!.uid).get().then((value)
      {return value.docs.length ;}),

      firestore.collection(ordersCollection)
          .where('order_by',isEqualTo: currentUser!.uid).get().then((value)
      {return value.docs.length ;}),

    ]
    );
    return res ;
  }

  static allAssets(){
    return firestore.collection(assetCollection).snapshots();
  }

 static getfeaturedAssets(){
    return firestore.collection(assetCollection).where('is_featured',isEqualTo: true).get();
 }


 static searchAssets(title){
    return firestore.collection(assetCollection)
        .where("name",isLessThanOrEqualTo: title).get();
 }





}




















