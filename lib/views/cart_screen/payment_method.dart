



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';

import '../../widgets_common/our_buttom.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Choose Payement Method".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButtom(
          onPress: (){

          } ,
          color: redColor,
          textColor: whiteColor,
          title: "Pay now",
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: List.generate(payementMethods.length, (index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 8),
              child:
              Image.asset(
                payementMethodsImg[index],
                width: double.infinity,
                height: 120 ,
                fit: BoxFit.cover,

              ),
            );
          }),

        ),
      )

    );
  }
}
