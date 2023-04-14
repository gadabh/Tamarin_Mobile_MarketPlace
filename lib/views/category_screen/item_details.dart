




import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/colors.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';


class ItemDetails extends StatelessWidget {
  final String? title ;
  const ItemDetails({Key? key ,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.share)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_outline))

        ],
      ),
      body: Column(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //swiper section
                  VxSwiper.builder(itemCount: 3,autoPlay: true,height: 350,aspectRatio: 16/9 , itemBuilder: (context,index){
                    return Image.asset(imgP1,width: double.infinity,fit : BoxFit.cover,);
                  }),
                  10.heightBox ,
                  title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox ,
                  VxRating(onRatingUpdate: (value){},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                  size: 25,
                  stepInt: true,),
                  10.heightBox,
                  "\$ 2".text.fontFamily(bold).color(Colors.red).size(18).make(),
                  Row(

                    children: [
                      Expanded(

                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment : CrossAxisAlignment.start ,
                          children: [
                            "Seller".text.gray800.fontFamily(bold).make(),
                            5.heightBox,
                            "Ghada".text.gray500.fontFamily(semibold).size(16).make(),
                          ],

                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.message_rounded, color: darkFontGrey),
                      )
                    ],
                  ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(Colors.grey.shade100).make(),
                   //description Section
                  10.heightBox,
                  "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                  10.heightBox,
                  "this is a description ...".text.color(darkFontGrey).make(),

                  //Review section
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:
                    List.generate(itemDetailsListe.length, (index) => ListTile(title: itemDetailsListe[index]
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .make(),
                      trailing: const Icon(Icons.arrow_forward),
                    )),
                  ),
                  20.heightBox,
                  //asset you may like
                  assetyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                      List.generate(6, (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(imgP1, width: 170,fit: BoxFit.cover),
                          10.heightBox,
                          "Amphibious for Blender 2.8".text.fontFamily(semibold).color(darkFontGrey).make(),
                          10.heightBox,
                          "Free".text.fontFamily(bold).color(Colors.green).size(16).make(),


                        ],
                      ).box.white.roundedSM.margin(EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(8)).make()
                      ),


                    ),
                  )



                ],
              ),
            ),

          )),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButtom(color: redColor,onPress: (){},textColor: whiteColor,title: "Add to cart "),
          )
        ],

      ),
    );
  }
}
