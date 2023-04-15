import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/controllers/auth_controller.dart';
import 'package:mobile_v3/views/auth_screen/login_screen.dart';
import 'package:mobile_v3/views/home_screen/home.dart';
import 'package:mobile_v3/widgets_common/appLogo_widget.dart';
import 'package:mobile_v3/widgets_common/our_buttom.dart';
import '../../widgets_common/bg_auth_widget.dart';
import '../../widgets_common/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck =false ;
  var controller = Get.put(AuthController());


  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return bgAuthWidget(
        child:Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                appLogoWidget(),
                10.heightBox,
                "Join the  $appname".text.fontFamily(bold).color(redColor).size(22).make(),
                15.heightBox,
                Column(
                  children: [
                    costumTextField( title: name, hint: nameHint , controller: nameController , isPass :false),
                    costumTextField( title: email, hint: emailHint ,controller: emailController , isPass : false),
                    costumTextField( title:  password , hint: passwordHint , controller: passwordController , isPass: true ),
                    costumTextField( title:  retypePassword , hint: passwordHint , controller: passwordRetypeController , isPass: true),


                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){}, child: forgetPass.text.make()))   ,


                    Row(
                      children: [
                        Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue){
                          setState(() {
                            isCheck=newValue;

                          });

                      },
                      ),
                        10.widthBox,

                         Expanded(
                           child: RichText(
                                 text:const  TextSpan(
                              children: [
                                TextSpan(
                                    text: "I agree to the",
                                    style: TextStyle(
                                      fontFamily : regular ,
                                      color : fontGrey ,
                                    )),


                                TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                      fontFamily : regular ,
                                      color : redColor ,
                                    )),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily : regular ,
                                      color : fontGrey ,
                                    )),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      fontFamily : regular ,
                                      color : redColor ,
                                    )),
                              ]
                            )),
                         ),
                      ],
                    ),
                    5.heightBox,
                    ourButtom(

                        color: isCheck==true ? redColor  : lightGrey,
                        title: signup ,
                        textColor: whiteColor,
                        onPress: () async {
                           if (isCheck != false ){
                             try{
                               await controller.signupMethod(
                                   context: context , 
                                   email: emailController.text , 
                                   password: passwordController.text).then((value)  {
                                     return controller.storeUserData(
                                       email: emailController.text ,
                                       name: nameController.text,
                                       password : passwordController.text,
                                     ) ;
                               }).then((value) {
                                 VxToast.show(context, msg: "Logged In Successful");
                                 Get.offAll(()=>const Home());
                               });

                             }catch(e){
                               auth.signOut();
                               VxToast.show(context, msg: e.toString());


                             }
                           }
                        }
                    ).box.width(context.screenWidth -50).make(),
                    10.heightBox,
                    RichText(
                        text: const TextSpan(
                      children: [
                            TextSpan
                            (text : alreadyHaveAccount,
                            style:
                                TextStyle(
                                    fontFamily: bold ,
                                    color: fontGrey
                                ),
                             ),
                        TextSpan
                          (text : login,
                          style:
                          TextStyle(
                              fontFamily: bold ,
                              color: redColor
                          ),
                        ),


                      ]
                    )).onTap(() {
                     Get.to(()=> const LoginScreen());
                    })






                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16) ).width(context.screenWidth- 70).make()
              ],
            ),
          ),
        ));
  }
}

