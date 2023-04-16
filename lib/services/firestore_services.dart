

import 'package:mobile_v3/consts/consts.dart';

class FirestorServices {




  //get users data
  static getUser(uid){
    return firestore.collection(userCollection).where('id',isEqualTo: uid).snapshots();
  }
}