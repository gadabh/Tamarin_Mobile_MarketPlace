import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{

var profilImgPath =''.obs ;
var profilImageLink ='';
var isLoading = false.obs ;

//text fild
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

changImage(context)async {
  try {
    final img = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 70);
    if (img == null) return;
    profilImgPath.value = img.path;
  } on PlatformException catch(e) {
    VxToast.show(context, msg: e.toString());
  }

  }



  uploadProfileImage()async{
  var filename = basename(profilImgPath.value);
  var destination ='profil_Pic/${currentUser!.uid}/$filename';
  Reference ref = FirebaseStorage.instance.ref().child(destination);
  await ref.putFile(File(profilImgPath.value));
  profilImageLink = await ref.getDownloadURL();

  }


  updateProfile({name,password,imgUrl}) async{
  var store = firestore.collection(userCollection).doc(currentUser!.uid);
  await store.set(
    {
      'name': name ,
      'password': password ,
      'photo': imgUrl

    }, SetOptions(merge: true)
  );
  isLoading(false);

  }



  changeAuthPassword({email,password,newpassword}) async{
   final cred = EmailAuthProvider.credential(email: email, password: password);
   await currentUser!.reauthenticateWithCredential(cred).then((value) {
     currentUser!.updatePassword(newpassword) ;
   }).catchError((error){
     print(error.toString());
   });
  }
}
























