



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/firebase_consts.dart';

class AuthController extends GetxController{

  //
  var isLoading = false.obs ;





  //text Controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  //Login method
  Future<UserCredential?> loginMethod ({ context}) async{
    UserCredential? userCredential ;

   try{
     userCredential = await auth.signInWithEmailAndPassword(
         email :emailController.text ,
         password: passwordController.text);

   }on FirebaseException catch (e){
    VxToast.show(context  , msg: e.toString());
   }
    return userCredential;

  }

  //Signup method
  Future<UserCredential?> signupMethod ({email , password ,context}) async{
    UserCredential? userCredential ;

    try{
      userCredential = await auth.createUserWithEmailAndPassword(email :email , password: password);

    }on FirebaseException catch (e){
      VxToast.show(context  , msg: e.toString());
    }
    return userCredential;

  }


  //signout method
   signoutMethod(context) async {
    try{
      await auth.signOut();
    } catch(e){
      VxToast.show(context  , msg: e.toString());

    }
   }




  //storing data method
 storeUserData({email,password ,name,photo,role}) async{
    DocumentReference store = await firestore.collection(userCollection)
        .doc(currentUser!.uid);
    store.set({
      'email': email,
      'password': password,
      'name': name,
      'photo': '',
      'id' : currentUser!.uid ,
      'role': role,
      'cart_count':"00",
       'order_count':"00",
       'wishlist_count':"00",


    });

 }

}