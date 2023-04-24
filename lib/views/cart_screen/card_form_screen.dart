import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/controllers/cart_controller.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';
import '../../widgets_common/custom_textfield.dart';


import 'package:mobile_v3/controllers/payment_controller.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var ccontroller = Get.find<CartController>();
    final PaymentController controller = Get.put(PaymentController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(

        title: "Info Card".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButtom(
          onPress: (){
            if(ccontroller.addressController.text.length>10){

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

            costumTextField(hint: 'Address' , isPass: false , title: "Address" , controller: ccontroller.addressController),
            costumTextField(hint: 'City',isPass: false ,title: 'City', controller: ccontroller.cityController),
            costumTextField(hint: 'State',isPass: false ,title: 'State', controller: ccontroller.stateController),
            costumTextField(hint: 'Postal Code',isPass: false,title: 'Postal Code', controller: ccontroller.postalController),
            costumTextField(hint: 'Phone',isPass: false,title: "Phone", controller: ccontroller.phoneController),
                20.heightBox,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Choose Payement Method".text.fontFamily(semibold).color(darkFontGrey).size(20).make(),
                10.heightBox,
                InkWell(
                  onTap: () {
                    controller.makePayment(amount: '4', currency: 'USD');
                  },
                  child: Column(
                    children:
                    List.generate(payementMethodsImg.length,(index){
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                style: BorderStyle.solid,
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
                              Transform.scale(
                                scale: 1.3,

                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),value: true, onChanged: (value){

                                }
                                    ),
                              ),
                            
                            ]
                          )

                      );


                    }


                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
