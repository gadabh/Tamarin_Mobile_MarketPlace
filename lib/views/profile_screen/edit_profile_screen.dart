
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/controllers/profil_controller.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';

import '../../widgets_common/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data ;
  const EditProfileScreen ({Key? key,this.data}) : super(key: key);



  @override
  Widget build(BuildContext context  ) {
    var controller = Get.find<ProfileController>();


    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: "Edit Profile".text.fontFamily(bold).color(darkFontGrey).make(),
      ),
        body: Obx(()=> Column(
            mainAxisSize: MainAxisSize.min,
            children: [

                  //if data url and controller path is empty
                  data['photo'] ==''&& controller.profilImgPath.isEmpty
                  ?Image.asset(imgProfile2,width: 130,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                  //if data is not empty but controller path is empty
                  : data['photo'] != ''&& controller.profilImgPath.isEmpty
                  ?Image.network(data['photo'],  width: 50,
                  fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                  // if both are empty
                  :Image.file(File(controller.profilImgPath.value),
                   width: 50,
                   fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),

              ourButtom(color: redColor ,onPress: (){
                controller.changImage(context);
              },

                  textColor:  whiteColor, title: "Change"),
              const Divider(),
              20.heightBox,
              costumTextField(
                controller: controller.nameController,
                  hint: nameHint ,
                  title: name ,
                  isPass:  false),
              costumTextField(
                  controller: controller.passController,
                  hint: passwordHint ,
                  title: password ,
                  isPass:  true),
              20.heightBox,
           controller.isLoading.value? const CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation(redColor),
           ) :
           SizedBox(
                width: context.screenWidth-60,
                  child: ourButtom(color: redColor ,onPress: ()async{
                    controller.isLoading(true);
                     await  controller.uploadProfileImage();
                     await controller.updateProfile(
                       imgUrl: controller.profilImageLink,
                       name: controller.nameController.text,
                       password: controller.passController.text
                     );
                     VxToast.show(context, msg: "Updated");

                  },textColor:  whiteColor, title: "Save")),


            ],
          ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top:50 ,left: 12 , right: 12)).rounded.make(),
        ),
    );
  }
}
