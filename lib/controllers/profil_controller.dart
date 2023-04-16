




import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_v3/consts/consts.dart';

class ProfileController extends GetxController{

var profilImgPath =''.obs ;


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
}
























