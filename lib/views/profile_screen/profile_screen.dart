



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
import 'package:mobile_v3/views/category_screen/loading_indicator.dart';
import 'package:mobile_v3/views/orders_screen/orders_screen.dart';
import 'package:mobile_v3/views/profile_screen/components/details_card.dart';
import 'package:mobile_v3/views/profile_screen/edit_profile_screen.dart';

import '../Wishlist_screen/wishlist.dart';
import '../auth_screen/login_screen.dart';
import '../chat_screen/messaging_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {


  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var controller  = Get.put(ProfileController());
    FirestorServices.getCounts();
    return
      Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            automaticallyImplyLeading: false ,
            title: "Profile".text.fontFamily(bold).color(darkFontGrey).make(),
          ),
        body: StreamBuilder(
          stream: FirestorServices.getUser(currentUser!.uid),

          builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot ){

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
                        controller.nameController.text=data['name'];
                        Get.to(()=>  EditProfileScreen(data: data,));
                      }),
                    ),




                    //Users details section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['photo'] == '' ?
                          Lottie.asset('assets/profile-persons.json',height: 150)                          :
                      Image.network(data['photo'],width: 130,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),

                    10.heightBox,
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 "${data['name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  5.heightBox,
                                "${data['email']}".text.color(darkFontGrey).make(),
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

                    FutureBuilder(
                        future: FirestorServices.getCounts(),
                        builder: (BuildContext context , AsyncSnapshot snapshot){
                          if(!snapshot.hasData){
                            return loadingIndicator();
                          }else {
                            var countdata = snapshot.data ;

                            return  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                               detailsCard(count: countdata[0].toString(), title: "in your cart", width: context.screenWidth/3.4),
                                detailsCard(count: countdata[1].toString(), title: "in your Wishliste", width: context.screenWidth/3.4),
                                detailsCard(count: countdata[2].toString() , title: "your order", width: context.screenWidth/3.4),

                              ],
                            );
                          }


                    }),




                  ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: ( context,  index) {
                        return const Divider(color: lightGrey);
                      },
                      itemCount: profileButtonList.length,
                      itemBuilder: (BuildContext context , int index){
                        return ListTile(
                          onTap: (){
                            switch (index){
                              case 0 :
                                Get.to(()=>OrdersScreen());
                                break;
                              case 1 :
                                Get.to(()=>WishListScreen());
                                break;
                              case 2:
                                Get.to(()=>MessegesScreen());
                                break;

                            }
                          },

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
