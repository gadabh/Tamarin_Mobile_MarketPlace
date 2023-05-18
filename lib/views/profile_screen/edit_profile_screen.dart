
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/controllers/profil_controller.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';

import '../../widgets_common/custom_textfield.dart';
import 'package:lottie/lottie.dart';


class EditProfileScreen extends StatelessWidget {
  final dynamic data ;
  const EditProfileScreen ({Key? key,this.data}) : super(key: key);



  @override
  Widget build(BuildContext context  ) {
    var controller = Get.find<ProfileController>();


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

        appBar: AppBar(
        title: "Edit Profile".text.fontFamily(bold).color(darkFontGrey).make(),
      ),
        body: Obx(()=> Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if data image url and controller pah is empty
              controller.profilImgPath.isEmpty
                  ?  Lottie.asset('assets/profile-persons.json',height: 150)
                  :
              Image.file(
                File(controller.profilImgPath.value),
                width: 100,
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
              10.heightBox,
              costumTextField(
                  controller: controller.oldpassController,
                  hint: passwordHint ,
                  title: oldpass ,
                  isPass:  true),
              10.heightBox,
              costumTextField(
                  controller: controller.newpassController,
                  hint: passwordHint ,
                  title: newpass ,
                  isPass:  true),
              20.heightBox,
           controller.isLoading.value? const CircularProgressIndicator(
             valueColor: AlwaysStoppedAnimation(redColor),
           ) :
           SizedBox(
                width: context.screenWidth-60,
                  child: ourButtom(
                   color: redColor ,
                   onPress: ()async{


                      controller.isLoading(true);
                      // if image is not selected
                     if(controller.profilImgPath.value.isEmpty){
                        await controller.uploadProfileImage() ;
                      }else{
                        controller.profilImageLink = data['photo'];
                    }
                      // if old password match data base
                      if(data['password']== controller.oldpassController.text){

                       await controller.changeAuthPassword(
                         email : data['email'],
                         password: controller.oldpassController.text,
                         newpassword: controller.newpassController.text ,
                       );

                        await  controller.uploadProfileImage();
                        await controller.updateProfile(
                            imgUrl: controller.profilImageLink,
                            name: controller.nameController.text,
                            password: controller.newpassController.text
                        );
                        VxToast.show(context, msg: "Updated");

                      }else{
                        VxToast.show(context, msg: "Wrong old password");
                        controller.isLoading(false);

                      }


                  },textColor:  whiteColor, title: "Save")),


            ],
          ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top:50 ,left: 12 , right: 12)).rounded.make(),
        ),
    );
  }
}
