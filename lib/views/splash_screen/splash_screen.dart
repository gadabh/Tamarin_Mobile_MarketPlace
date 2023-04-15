
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/views/auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

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


  Widget build(BuildContext context) {
    return
        Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
             children: [
               300.heightBox,
               appname.text.color(Colors.black).fontFamily(bold).size(22).make(),

               SizedBox(height: 300,width: 300,
                 child:Lottie.asset('assets/b.json') ,
               ),
          //     appversion.text.make(),
               const Spacer(),
               credits.text.fontFamily(semibold).make(),

             ],

            ),
          ),
        );





  /*
      MaterialApp(


          title: 'Flutter Demo',
          home:  AnimatedSplashScreen(
              splash: Lottie.asset('assets/b.json'),
              splashIconSize: 250,
              backgroundColor: Colors.black,
              pageTransitionType: PageTransitionType.rightToLeftWithFade,
              nextScreen: const LoginScreen())

      );

*/




  }
}