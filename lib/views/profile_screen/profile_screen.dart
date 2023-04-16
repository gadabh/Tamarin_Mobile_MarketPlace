



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/controllers/auth_controller.dart';
import 'package:mobile_v3/controllers/profil_controller.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/profile_screen/components/details_card.dart';
import 'package:mobile_v3/views/profile_screen/edit_profile_screen.dart';

import '../../widgets_common/bg_auth_widget.dart';
import '../auth_screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller  = Get.put(ProfileController());
    return
      Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            title: "Profile".text.fontFamily(bold).color(darkFontGrey).make(),
          ),
        body: StreamBuilder(
          stream: FirestorServices.getUser(currentUser!.uid),
      
          builder: (BuildContext context , AsyncSnapshot<QuerySnapshot > snapshot ){

            if ( !snapshot.hasData){
              return const Center(child: CircularProgressIndicator (
                valueColor: AlwaysStoppedAnimation(redColor),
              ) ,);
            } else {

              var data = snapshot.data!.docs[0];

              return SafeArea(

                child: Column(
                  children: [
                    //edit profile button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                          alignment: Alignment.
                          topRight,
                          child: Icon(
                              Icons.edit ,
                              color: darkFontGrey
                          )).onTap(() {
                        Get.to(()=> const EditProfileScreen());
                      }),
                    ),




                    //Users details section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Image.asset(imgProfile2,width: 130,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),
                          10.heightBox,
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "User Name".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  5.heightBox,
                                  "customer@expl.com".text.color(darkFontGrey).make(),
                                ],
                              )),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: darkFontGrey,
                                  )
                              ),
                              onPressed: ()async{
                                await Get.put(AuthController()).signoutMethod(context);
                                Get.offAll(()=> const LoginScreen());

                              }, child:
                          logout.text.fontFamily(semibold).color(darkFontGrey).make()
                          )

                        ],


                      ),
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailsCard(count: "00" , title: "in your cart", width: context.screenWidth/3.4),
                        detailsCard(count: "32" , title: "in your Wishliste", width: context.screenWidth/3.4),
                        detailsCard(count: "675" , title: "your order", width: context.screenWidth/3.4),

                      ],
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: ( context,  index) {
                        return const Divider(color: lightGrey);
                      },
                      itemCount: profileButtonList.length,
                      itemBuilder: (BuildContext context , int index){
                        return ListTile(

                            leading: Image.asset(
                              profileButtonIcon[index] ,
                              width: 22,
                            ),
                            title: profileButtonList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make());

                      },
                    ).box
                        .white
                        .rounded
                        .margin(const EdgeInsets.all(12)
                    )
                        .padding(
                        const EdgeInsets
                            .symmetric(horizontal: 16))

                        .shadowSm.make()




                  ],
                ),
              );
            }


        },
        )


        );


  }
}
