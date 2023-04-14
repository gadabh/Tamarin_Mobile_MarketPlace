import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_v3/widgets_common/bg_widget.dart';
import 'package:mobile_v3/consts/consts.dart';

class CategoryDetails extends StatelessWidget {
  final String? title ;
  const CategoryDetails({Key? key ,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(



           child: Scaffold(
              appBar: AppBar(
                title: title!.text.fontFamily(bold).white.make(),
     
              ),
              body: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                          List.generate(6,
                                  (index) =>"Asset...".
                                       text
                                      .size(12)
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .makeCentered()
                                      .box
                                      .white
                                      .rounded
                                      .size(120, 60)
                                      .margin(const EdgeInsets.symmetric(horizontal: 4))
                                      .make() )

                      ),

                    ),
                    //assets container
                    20.heightBox,
                    Expanded(

                           child: GridView.builder(
                             physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                                itemCount: 8,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount:2 ,crossAxisSpacing: 2,mainAxisSpacing: 8,mainAxisExtent: 250  ),
                                itemBuilder: (context , index){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(imgP5, width: 200, height: 150,fit: BoxFit.cover),
                                      "Amphibious for Blender 2.8".text.fontFamily(semibold).color(darkFontGrey).make(),
                                      10.heightBox,
                                      "\$ 2".text.fontFamily(bold).color(Colors.green).size(16).make(),


                                    ],
                                  ).box.white.roundedSM.outerShadowSm.margin(const EdgeInsets.symmetric(horizontal: 4)).padding(const EdgeInsets.all(12)).make();

                                }
                      ,
                    ))
                  ],
                ),
              ),
            )
         );
  }
}
