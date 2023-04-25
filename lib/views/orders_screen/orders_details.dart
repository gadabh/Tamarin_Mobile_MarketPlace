



import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:intl/intl.dart';
import 'components/order_place_details.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data ;
  const OrdersDetails( {Key? key ,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(


        title: "Order Details".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                 const Image(image: AssetImage("assets/images/order-icon.png")),
                const Divider(),

                orderPlaceDetails(
                    d1:data["order_code"] ,
                    d2: data["payement_method"],
                    title1 :"Order Code",
                    title2 :"Payement Method",
                ),
                orderPlaceDetails(
                  d1:DateFormat().add_yMd().format((data["order_date"].toDate())),
                  d2:"PAYED",
                  title1 :"Order Date",
                  title2: "State",

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         "Adress".text.fontFamily(semibold).make(),
                          "${data["order_by_name"]}".text.make(),
                          "${data["order_by_email"]}".text.make(),
                          "${data["order_by_adress"]}".text.make(),
                          "${data["order_by_city"]}".text.make(),
                          "${data["order_by_state"]}".text.make(),
                          "${data["order_by_phone"]}".text.make(),
                          "${data["order_by_postalCode"]}".text.make(),
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            "${data["total_amount"]}".text.color(Colors.red).fontFamily(bold).make(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],

            ).box.outerShadowMd.white.make(),
            const Divider(),
            10.heightBox,
            "Ordered Assets".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
            10.heightBox,
             ListView(
               shrinkWrap: true,
               children:
               List.generate(data['order'].length, (index){
                   return
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             20.heightBox,
                             "Asset Name".text.fontFamily(semibold).make(),
                             "${data['order'][index]['name']}".text.color(Colors.red).fontFamily(semibold).make(),

                           ],
                         ),
                         SizedBox(
                           width: 130 ,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               20.heightBox,
                               "Owner Name".text.fontFamily(semibold).make(),
                               "${data['order'][index]['prop']}".text.color(Colors.red).fontFamily(semibold).make(),

                             ],
                           ),
                         ),
                         SizedBox(
                           width: 50 ,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               20.heightBox,
                               const Image(image: AssetImage("assets/images/order-icon.png")),

                             ],
                           ),
                         ),

                       ],

                     ),
                   );
               }).toList(),

             )

          ],
        ),
      ),




    );
  }
}
