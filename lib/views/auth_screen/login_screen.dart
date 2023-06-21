import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/controllers/auth_controller.dart';
import 'package:mobile_v3/views/auth_screen/signup_screen.dart';
import 'package:mobile_v3/views/home_screen/home.dart';
import 'package:mobile_v3/widgets_common/appLogo_widget.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';
import '../../widgets_common/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
        backgroundColor: Colors.white,

        resizeToAvoidBottomInset: false,
         body: Center(
          child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),


            Column(
              children: [
                10.heightBox,
                "Log in to GraphiBee".text.fontFamily(bold).color(redColor).size(22).make(),
                60.heightBox,
                Obx(()=>
                   Column(
                    children: [
                      costumTextField( hint: emailHint ,title: email, isPass: false , controller:  controller.emailController),
                      costumTextField(  hint: passwordHint ,title:  password , isPass: true , controller: controller.passwordController),

                      5.heightBox,
                      controller.isLoading.value
                      ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ) : ourButtom(
                          color: redColor ,
                          title: login ,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isLoading(true);

                            await controller.loginMethod(context: context ,).then((value)  {
                              if ( value != null ){
                               VxToast.show(context, msg: "Logged In Successful");
                                Get.offAll(()=>const Home());

                              } else{
                                controller.isLoading(false);
                              }
                            });


                          }
                      ).box.width(context.screenWidth -50).make(),
                      30.heightBox,

                  ],
                  ),
                ),





                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButtom(
                    color: Colors.white70 ,
                    title: signup ,
                    textColor: redColor,
                    onPress: ()
                       {
                        Get.to(() => const SignUpScreen());

                        }
                ).box.width(context.screenWidth -50).make(),

               ],
            ).box.white.rounded.padding(const EdgeInsets.all(16) ).width(context.screenWidth- 70).make()

          ],
        ),

    ));
  }
}
