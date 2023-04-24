import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/controllers/cart_controller.dart';
import 'package:mobile_v3/controllers/payment_controller.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/cart_screen/card_form_screen.dart';
import 'package:mobile_v3/views/category_screen/loading_indicator.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';
import '../../controllers/asset_controller.dart';



class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
     var controller = Get.put(CartController());
     var ccontroller = Get.put(AssetController());
     var pcontroller = Get.put(PaymentController());
    return  Scaffold(
       bottomNavigationBar: SizedBox(
         height: 60,
         child: ourButtom(
                 color: redColor ,
                 onPress: (){
                    Get.to(()=>const ShippingDetails());
                  } ,
                  textColor: whiteColor ,
                title: "Checkout"
           ),
       ) ,
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
            controller.calculate(data);
            pcontroller.assetSnapshot= data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child:
                      ListView.builder(
                          itemCount : data.length ,
                          itemBuilder: (BuildContext context , int index ){
                            return ListTile(
                              leading: Image.network("${data[index]['imageURL']}" , height: 100 ,width: 100,),
                              title:"${data[index]['name']}".text.fontFamily(semibold).size(16).color(darkFontGrey).make(),
                              subtitle: "${data[index]['price']}".numCurrency.text.color(Colors.red).fontFamily(semibold).make(),
                              trailing: const Icon(Icons.delete , color: Colors.red)
                                .onTap(() async {
                                  ccontroller.decreaseQuantity(context);
                                  FirestorServices.deletDocument(data[index].id);

                            }),
                            );
                          }),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(()=>
                        "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .fontFamily(semibold)
                            .color(Colors.red)
                            .make(),
                      ),
                    ],
                  ).box.padding(const EdgeInsets.all(12)).width(context.screenWidth - 60).color(lightGolden).roundedSM.make(),
                  10.heightBox,


                ],
              ),
            );
          }
         },
      )
    );
  }
}
