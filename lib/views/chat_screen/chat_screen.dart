

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/views/chat_screen/components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "title".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.8),
        child: Column(
          children: [
            Expanded(
                child: Container(
                 color: CupertinoColors.lightBackgroundGray,
                  child: ListView(
                    children: [
                      senderBubble(),
                      senderBubble(),
                    ],
                  ),
                ),

           ),
            10.heightBox,
            Row(
              children: [
                Expanded(child: TextFormField(
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
                IconButton(onPressed: (){}, icon: const Icon(Icons.send,color: redColor,))
              ],
            ).box.height(80).padding(EdgeInsets.all(16)).margin(const EdgeInsets.only(bottom: 8)).make(),
          ],
        ),
      ),
    );
  }
}
