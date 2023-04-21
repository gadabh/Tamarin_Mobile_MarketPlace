

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "title".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.8),
        child: Column(
          children: [
            Expanded(
                child: Container(
                 color: Colors.teal,
                ),
           ),
            Row(
              children: [
                Expanded(child: TextFormField()),
                IconButton(onPressed: (){}, icon: const Icon(Icons.send,color: redColor,))
              ],
            ).box.height(60).padding(EdgeInsets.all(16)).make(),
          ],
        ),
      ),
    );
  }
}
