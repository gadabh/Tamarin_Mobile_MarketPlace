import 'package:flutter/material.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/views/auth_screen/login_screen.dart';
import 'package:mobile_v3/widgets_common/appLogo_widget.dart';
import 'package:velocity_x/velocity_x.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  //method to change screen
  changeScreen(){
    Future.delayed(const Duration(seconds: 3),() async {
      //using getX
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));

    });
  }
  @override
  void initState() {
    changeScreen();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                 child:Image.asset(icSplashBg ,width: 300),


                 ),  20.heightBox,
                appLogoWidget(),
                10.heightBox,
                appname.text.fontFamily(bold).size(22).white.make(),
                5.heightBox,
                appversion.text.white.make(),
                const Spacer(),
                credits.text.white.fontFamily(semibold).make(),
                30.heightBox,
              ],


        ),
      ),
    );
  }
}
