



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/views/profile_screen/components/details_card.dart';
import 'package:mobile_v3/widgets_common/bg_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  bgWidget(
      child:  Scaffold(
        body: SafeArea(

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
                          color: whiteColor
                      )).onTap(() { }),
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
                        "User Name".text.fontFamily(semibold).white.make(),
                        5.heightBox,
                        "customer@expl.com".text.white.make(),
                    ],
                  )),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: whiteColor,
                        )
                      ),
                        onPressed: (){}, child:
                        logout.text.fontFamily(semibold).white.make()
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
                
                    .shadowSm.make().box.color(redColor).make()




              ],
            ),
          ),


        ),

    );
  }
}
