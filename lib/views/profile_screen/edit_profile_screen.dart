
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/controllers/profil_controller.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';

import '../../consts/images.dart';
import '../../widgets_common/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen ({Key? key}) : super(key: key);

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


              controller.profilImgPath.isEmpty
                  ?Image.asset(imgProfile2,width: 130,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
              :Image.file(File(controller.profilImgPath.value),
                width: 150,
                fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make(),

              ourButtom(color: redColor ,onPress: (){
                controller.changImage(context);
              },

                  textColor:  whiteColor, title: "Change"),
              const Divider(),
              20.heightBox,
              costumTextField(hint: nameHint , title: name , isPass:  false),
              costumTextField(hint: passwordHint , title: password , isPass:  true),
              20.heightBox,
              SizedBox(
                width: context.screenWidth-60,
                  child: ourButtom(color: redColor ,onPress: (){

                  },textColor:  whiteColor, title: "Save")),


            ],
          ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top:50 ,left: 12 , right: 12)).rounded.make(),
        ),
    );
  }
}
