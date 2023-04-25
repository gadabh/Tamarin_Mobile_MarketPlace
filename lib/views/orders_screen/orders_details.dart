import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:intl/intl.dart';
import 'components/order_place_details.dart';
import 'package:flutter/foundation.dart';


import 'package:url_launcher/url_launcher.dart';

class OrdersDetails extends StatefulWidget {
  final dynamic data ;
  const OrdersDetails( {Key? key ,this.data}) : super(key: key);

  @override
  State<OrdersDetails> createState() => _OrdersDetailsState();
}

class _OrdersDetailsState extends State<OrdersDetails> {



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
                    d1:widget.data["order_code"] ,
                    d2: widget.data["payement_method"],
                    title1 :"Order Code",
                    title2 :"Payement Method",
                ),
                orderPlaceDetails(
                  d1:DateFormat().add_yMd().format((widget.data["order_date"].toDate())),
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
                          "${widget.data["order_by_name"]}".text.color(Colors.black45).make(),
                          "${widget.data["order_by_email"]}".text.color(Colors.black45).make(),
                          "${widget.data["order_by_adress"]}".text.color(Colors.black45).make(),
                          "${widget.data["order_by_city"]}".text.color(Colors.black45).make(),
                          "${widget.data["order_by_state"]}".text.color(Colors.black45).make(),
                          "${widget.data["order_by_phone"]}".text.color(Colors.black45).make(),
                          "${widget.data["order_by_postalCode"]}".text.color(Colors.black45).make(),
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            "${widget.data["total_amount"]}".text.color(Colors.black45).fontFamily(bold).make(),
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

             ListView(
               physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true,
               children:
               List.generate(widget.data['order'].length, (index){
                   return
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                     child: Column(
                       children: [
                          Image.network("${widget.data['order'][index]['imageURL']}",height: 200,width: 200,),


                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             5.heightBox,
                             "Asset Name".text.fontFamily(semibold).make(),
                             "${widget.data['order'][index]['name']}".text.color(Colors.black45).fontFamily(semibold).make(),

                           ],
                         ),

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             20.heightBox,
                             "Owner Name".text.fontFamily(semibold).make(),
                             "${widget.data['order'][index]['prop']}".text.color(Colors.black45).fontFamily(semibold).make(),

                           ],
                         ),




                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             20.heightBox,
                           Row(
                             mainAxisSize: MainAxisSize.min,
                             children:  [
                               const Icon(Icons.file_download),
                               RichText(
                               text:
                                TextSpan(
                                  text: 'Download',
                                  style:  const TextStyle(color: Colors.black),
                                  recognizer:  TapGestureRecognizer() ..onTap = ()
                                  {
                                    launch("${widget.data['order'][index]['sourceURL']}");
                                    }, ), )], ),

                           ],
                         ),
                         20.heightBox,

                         Divider(),
                       ],
                     ),
                   );
               }).toList(),
             )
          ],
        ).box.make(),
      ),
    );
  }
}
