



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/category_screen/loading_indicator.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping cart"
        .text
        .color(darkFontGrey)
        .fontFamily(semibold)
        .make(),
      ),
      body:  StreamBuilder(
        stream: FirestorServices.getCart(currentUser!.uid) ,
         builder: (BuildContext context  , AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );

          }else if (snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart is empty".text.color(darkFontGrey).make(),
            );

          }else {
            var data= snapshot.data!.docs ;
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child:
                      Container(
                          child: ListView.builder(
                              itemCount : data.length ,
                              itemBuilder: (BuildContext context , int index ){
                                return ListTile(
                                  leading: Image.network("${data[index]['imageURL']}"),

                                );
                              }),
                      ),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      "40"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(Colors.red)
                          .make(),
                    ],
                  ).box.padding(const EdgeInsets.all(12)).width(context.screenWidth - 60).color(lightGolden).roundedSM.make(),
                  10.heightBox,
                  SizedBox(
                    width: context.screenWidth - 60 ,
                    child: ourButtom(
                        color: redColor ,
                        onPress: (){

                        } ,
                        textColor: whiteColor ,
                        title: "Check-out"
                    ) ,
                  )

                ],
              ),
            );
          }
         },
      )
    );
  }
}
