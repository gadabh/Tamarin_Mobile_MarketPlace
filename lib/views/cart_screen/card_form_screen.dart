import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/controllers/cart_controller.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';
import '../../widgets_common/custom_textfield.dart';


import 'package:mobile_v3/controllers/payment_controller.dart';

class ShippingDetails extends StatelessWidget {
  final String? totalAmount ;

  const ShippingDetails( {Key? key,required this.totalAmount}) : super(key: key );

  @override
  Widget build(BuildContext context) {

    var ccontroller = Get.find<CartController>();
    final PaymentController controller = Get.put(PaymentController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(

        title: "Info Card".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [


              costumTextField(hint: 'Address' , isPass: false , title: "Address" , controller: controller.addressController),
              costumTextField(hint: 'country',isPass: false,title: "country", controller: controller.country),
              costumTextField(hint: 'City',isPass: false ,title: 'City', controller: controller.cityController),
              costumTextField(hint: 'State',isPass: false ,title: 'State', controller: controller.stateController),
              costumTextField(hint: 'Postal Code',isPass: false,title: 'Postal Code', controller: controller.postalController),
              costumTextField(hint: 'Phone',isPass: false,title: "Phone", controller: controller.phoneController),


              20.heightBox,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Choose Payement Method".text.fontFamily(semibold).color(darkFontGrey).size(20).make(),
                  10.heightBox,
                  InkWell(
                    onTap: () {
                      controller.makePayment(amount: totalAmount!, currency: 'USD');
                    },
                    child: Obx(()=> Column(
                      children:
                      List.generate(payementMethodsImg.length,(index){
                        return GestureDetector(
                          onTap: ccontroller.changePayementIndex(index),
                          child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  color:  ccontroller.payementIndex.value ==index? redColor: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: redColor,
                                    width: 4,
                                  )
                              ),
                              margin: const EdgeInsets.only(bottom: 8),


                              child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Image.asset(payementMethodsImg[index],width: double.infinity,height: 100,
                                      fit: BoxFit.cover,),
                                    ccontroller.payementIndex.value==index?
                                    Transform.scale(
                                      scale: 1.3,

                                      child: Checkbox(
                                          activeColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),value: true, onChanged: (value){

                                      }
                                      ),
                                    ):Container(),

                                  ]
                              )

                          ),
                        );


                      }


                      ),
                    ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
