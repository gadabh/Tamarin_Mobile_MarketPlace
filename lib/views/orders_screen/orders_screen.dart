



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/services/firestore_services.dart';

import '../category_screen/loading_indicator.dart';
import 'orders_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: 'My Orders'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: Card(
        child: StreamBuilder(
          stream: FirestorServices.getAllOrders(),
          builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(child: loadingIndicator(),);
            }else if (snapshot.data!.docs.isEmpty){
                return "No orders yet !".text.color(darkFontGrey).makeCentered();

            }else{
              var data=snapshot.data!.docs;
              return
                  ListView.builder(
                      itemCount: data.length,
                    itemBuilder: (BuildContext context ,int index){
                        return ListTile(
                          leading: "${index +1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                          title: (data[index].id).toString().text.color(redColor).fontFamily(semibold).make(),
                          subtitle:(data[index]['orderAmount']).toString().numCurrency.text.color(darkFontGrey).fontFamily(bold).make(),
                          trailing: IconButton(onPressed: (){
                            Get.to(()=>OrdersDetails(data:data[index]));

                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded ,
                            color: darkFontGrey,
                          ),
                          ),
                        );
                    },

                  );

            }
          },
        ),
      ),
    );
  }
}
