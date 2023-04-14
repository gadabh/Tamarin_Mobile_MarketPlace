



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/consts/listes.dart';
import 'package:mobile_v3/views/category_screen/category_details.dart';
import 'package:mobile_v3/widgets_common/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: categories.text.fontFamily(bold).make(),
        ),
        body: bgWidget(

          child : Container(
            padding: EdgeInsets.all(12),

            child: GridView.builder(

                shrinkWrap: true,
                itemCount:11 ,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3 ,
                  mainAxisSpacing: 8 ,
                crossAxisSpacing: 8,

                mainAxisExtent: 200),
                itemBuilder: (context,index){

                  return Column(
                    children: [
                      Image.asset(categoryImages[index],height: 60,
                      width: 50,
                      fit: BoxFit.cover,),
                      10.heightBox,
                      categoriesListe[index].text.color(darkFontGrey).align(TextAlign.center).make(),
                    ],
                  ).box.gray50.roundedSM.clip(Clip.antiAlias).outerShadowSm.make().onTap(() { 
                    Get.to(()=> CategoryDetails(title: categoriesListe[index]));
                  });
                }


            ),
          ),
        ) ,

    );
  }
}
