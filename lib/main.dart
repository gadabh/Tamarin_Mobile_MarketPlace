import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mobile_v3/views/auth_screen/login_screen.dart';
import 'package:mobile_v3/views/home_screen/home.dart';
import 'package:mobile_v3/views/splash_screen/splash_screen.dart';
import 'consts/consts.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const LoginScreen()),
        GetPage(name: '/home', page: () => const Home()),
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}