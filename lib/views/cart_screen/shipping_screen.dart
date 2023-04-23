

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/controllers/cart_controller.dart';
import 'package:mobile_v3/views/cart_screen/payment_method.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';

import '../../widgets_common/custom_textfield.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(

        title: "Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButtom(
          onPress: (){
            if(controller.addressController.text.length>10){
                 Get.to(()=>const PaymentMethods());
            }else{
              VxToast.show(context, msg: "Please fill the form");
            }
          } ,
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            costumTextField(hint: 'Address' , isPass: false , title: "Address" , controller: controller.addressController),
            costumTextField(hint: 'City',isPass: false ,title: 'City', controller: controller.cityController),
            costumTextField(hint: 'State',isPass: false ,title: 'State', controller: controller.stateController),
            costumTextField(hint: 'Postal Code',isPass: false,title: 'Postal Code', controller: controller.postalController),
            costumTextField(hint: 'Phone',isPass: false,title: "Phone", controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
