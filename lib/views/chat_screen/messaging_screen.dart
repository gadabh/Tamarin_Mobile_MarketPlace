






import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/chat_screen/chat_screen.dart';

import '../category_screen/loading_indicator.dart';

class MessegesScreen extends StatelessWidget {
  const MessegesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: 'My Messages'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestorServices.getAllMessages(),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if (snapshot.data!.docs.isEmpty){
            return "No Messages yet !".text.color(darkFontGrey).makeCentered();

          }else{
            var data = snapshot.data!.docs;
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                      itemBuilder: (BuildContext context , int index){
                      return Card(
                        child: ListTile(
                          onTap: (){
                            Get.to(()=>ChatScreen(),
                                arguments: [data[index]['receiver_name'].toString(),
                                  data[index]['toId'].toString()],);
                          },
                          leading: const CircleAvatar(
                            backgroundColor: redColor,
                            child: Icon(
                              Icons.person,
                              color: whiteColor,

                            ),
                          ),
                          title: "${data[index]['receiver_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                          subtitle: "${data[index]['last_msg']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                        ),
                      );

                      }))
                ],

              ),
            );
          }
        },
      ),
    );
  }
}
