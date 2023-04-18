



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/controllers/asset_controller.dart';
import 'package:mobile_v3/views/category_screen/category_details.dart';

import '../../widgets_common/bg_auth_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AssetController());


    return
      Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          automaticallyImplyLeading: false ,
          backgroundColor: lightGrey
          ,
          title: categories.text.color(darkFontGrey).fontFamily(bold).make(),
        ),
        body:  Container(
            padding: EdgeInsets.all(1),

            child: GridView.builder(
                shrinkWrap: true,
                itemCount:12 ,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3 , mainAxisSpacing: 8 , crossAxisSpacing: 8, mainAxisExtent: 200),
                itemBuilder: (context,index){

                  return Column(
                    children: [
                      30.heightBox,
                      Image.asset(categoryImages[index],height: 60, width: 50, fit: BoxFit.cover,),
                      20.heightBox,
                      categoriesListe[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                    ],
                  ).box.rounded.gray50.clip(Clip.antiAlias).outerShadowSm.make()
                      .onTap(() {
                        controller.getSubCategories(categoriesListe[index]);
                    Get.to(()=> CategoryDetails(title: categoriesListe[index]));
                  });
                }


            ),
          ),


    );
  }
}
