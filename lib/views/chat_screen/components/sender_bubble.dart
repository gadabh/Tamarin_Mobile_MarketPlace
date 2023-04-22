

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:intl/intl.dart' as intl;
import '../../../consts/colors.dart';

Widget senderBubble( DocumentSnapshot data){
  var t = data["created_on"]== null ? DateTime.now() :data["created_on"].toDate() ;
  var time = intl.DateFormat("h:mma").format(t);

  return  Directionality(
    textDirection:  data['uid']== currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration:  BoxDecoration(
          color: data['uid']== currentUser!.uid ? redColor: CupertinoColors.darkBackgroundGray,
          borderRadius:  const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),

          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).make(),

        ],
      ),
    ),
  );
}