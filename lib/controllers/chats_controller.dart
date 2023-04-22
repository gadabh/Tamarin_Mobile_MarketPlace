


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/controllers/home_controller.dart';

class ChatsController extends GetxController{

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

       var chats = firestore.collection(chatsCollection);
       //reciver
       var receiverName =Get.arguments[0];
       var receiverId = Get.arguments[1];
      //sender
       var senderName = Get.find<HomeController>().username ;
       var currentId = currentUser!.uid ;

       var msgController =TextEditingController();

       dynamic chatDocId ;
       var isLoading =false.obs;

           // Display  msg
             getChatId()async{
               isLoading(true);
               await chats.
               where('users', isEqualTo: {
                 receiverId: null ,
                 currentId :null
               })
                   .limit(1)
                   .get()
                   .then((QuerySnapshot snapshot ) {
                 if(snapshot.docs.isNotEmpty){
                   chatDocId = snapshot.docs.single.id;
                 }else {
                   chats.add({
                     'created_on':null ,
                     'last_msg':'',
                     'users': {
                       receiverId : null,
                       currentId : null
                     },
                     'toId':'',
                     'fromId':'',
                     'receiver_name' : receiverName,
                     'sender_name': senderName
                   }).then((value) {
                      chatDocId = value.id ;
                   });
                 }
               });
               isLoading(false);
             }


           // send msg
               sendMsg(String msg)async{
               if(msg.trim().isNotEmpty){
                 chats.doc(chatDocId).update({
                   'created_on': FieldValue.serverTimestamp(),
                   'last_msg':msg,
                   'toId': receiverId,
                   'fromId': currentId ,

                 });
                 chats.doc(chatDocId).collection(messageCollection).doc().set({
                   'created_on': FieldValue.serverTimestamp(),
                   'msg':msg,
                   'uid': currentId ,
                 });


               }
               }

}