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
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                const Image(image: AssetImage("assets/images/order-icon.png" ),height:100),

                const Divider(),

                orderPlaceDetails(
                    d1:widget.data.id ,
                    d2: widget.data["orderStatus"],
                    title1 :"Order Code",
                    title2 :"State",
                ),
                orderPlaceDetails(
                  d1:widget.data["orderDate"].toString(),
                  d2:"PAYED",
                  title1 :"Order Date",
                  title2: "State",

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            "${widget.data["orderAmount"]}  ".text.color(Colors.black45).fontFamily(bold).make(),
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
               List.generate(widget.data['cartItems'].length, (index){
                   return
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16.0 ,vertical: 8),
                     child: Column(
                       children: [
                          Image.network("${widget.data['cartItems'][0]['imageURL'][0]}",height: 200,width: 200,),


                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             5.heightBox,
                             "Asset Name".text.fontFamily(semibold).make(),
                             "${widget.data['cartItems'][index]['name']}".text.color(Colors.black45).fontFamily(semibold).make(),

                           ],
                         ),

                         Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             20.heightBox,
                             "Owner Name".text.fontFamily(semibold).make(),
                             "${widget.data['cartItems'][index]['prop']}".text.color(Colors.black45).fontFamily(semibold).make(),

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
                                    launch("${widget.data['cartItems'][index]['sourceURL']}");
                                    }, ), )], ),
                           ],
                         ),
                         20.heightBox,
                         const  Divider( height: 20,
                           thickness: 2,
                           indent: 20,
                           endIndent: 0,
                           color: Colors.black12,),


                       ],

                     ),
                   );
               }).toList(),

             ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),



            orderPlaceDetails(
              d1:widget.data["orderAmount"] ,
              d2: "",
              title1 :"TOTAL : ",
              title2 :"",
            ),
            20.heightBox,
            Divider()



          ],
        ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 4)).make(),

      ),

    );
  }
}
