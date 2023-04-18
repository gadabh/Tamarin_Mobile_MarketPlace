

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

}