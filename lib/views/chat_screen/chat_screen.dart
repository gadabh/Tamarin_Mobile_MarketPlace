

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/controllers/chats_controller.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/category_screen/loading_indicator.dart';
import 'package:mobile_v3/views/chat_screen/components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "title".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.8),
        child: Column(
          children: [
            Obx(()=>
             controller.isLoading.value?   Center(
              child: loadingIndicator(),
               ):

               Expanded(
                  child: StreamBuilder(
                    stream: FirestorServices.getChatMessages(controller.chatDocId.toString()),
                    builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return Center(
                          child: loadingIndicator(),
                        );
                      }else if ( snapshot.data!.docs.isEmpty){
                        return Center(
                          child: "Send a message ...".text.color(darkFontGrey).make() ,
                        );
                      }else{
                        return ListView(
                          children: [
                            senderBubble(),
                          ],
                        );
                      }
                    },
                  )

           ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: textfieldGrey
                        )
                    ),

                    hintText: "Type a message ..."
                  ),

                )
                ),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.msgController.text);
                  controller.msgController.clear();
                }, icon: const Icon(Icons.send,color: redColor,))
              ],
            ).box.height(80).padding(EdgeInsets.all(16)).margin(const EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),
    );
  }
}
