
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../consts/strings.dart';
import '../../consts/styles.dart';
import '../../controllers/home_controller.dart';
import '../../widgets_common/exit_dialog.dart';
import '../cart_screen/cart_screen.dart';
import '../category_screen/category_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());


    var navbarItem =[
      BottomNavigationBarItem(icon : Image.asset(icHome, width: 26),label :home),
      BottomNavigationBarItem(icon : Image.asset(icCategories, width: 26),label :categories),
      BottomNavigationBarItem(icon : Image.asset(icCart, width: 26),label :cart),
      BottomNavigationBarItem(icon : Image.asset(icProfile, width: 26),label :account)

    ];

    var navBody =[
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: ()async{
        showDialog(
            barrierDismissible : false ,
            context: context,
            builder:(context)=>exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [

            Obx(()=> Expanded( child: navBody.elementAt(controller.currentNavIndex.value), )),
          ],
        ),
        bottomNavigationBar: Obx(()=>
            BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              selectedItemColor: redColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              items: navbarItem,
              onTap: (value){
                controller.currentNavIndex.value=value;
              },),
        ),
      ),
    );
  }
}