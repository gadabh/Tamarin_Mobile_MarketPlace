import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/controllers/asset_controller.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/category_screen/item_details.dart';
import 'package:mobile_v3/consts/consts.dart';

import 'loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String? title ;
  const CategoryDetails({Key? key ,required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);

  }
  switchCategory(title){
    if(controller.subcat.contains(title)){
     assetMethod= FirestorServices.getSubCategoryAssets(title );
    }else{
      assetMethod = FirestorServices.getAssets(title);

    }
  }

  var controller =Get.find<AssetController>();
  dynamic assetMethod ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: lightGrey,
              appBar: AppBar(
                title: widget.title!.text.fontFamily(bold).color(darkFontGrey).make(),

              ),
              body:Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [

                
                  20.heightBox,

                  StreamBuilder(
                    stream: assetMethod,
                    builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return Expanded(
                          child: Center(
                            child:  loadingIndicator(),
                          ),
                        );
                      }else if (snapshot.data!.docs.isEmpty){
                        return Expanded(
                          child: "No Assets Found".text.color(darkFontGrey).makeCentered(),
                        );
                      }else {
                        var data = snapshot.data!.docs ;
                        return
                              Expanded(

                                  child: GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount:2 ,crossAxisSpacing: 2,mainAxisSpacing: 8,mainAxisExtent: 250  ),
                                    itemBuilder: (context , index){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(data[index]['imageURL'][0], width: 200, height: 150,fit: BoxFit.cover),


                                          (() {
                                            String shortenName = data[index]['name'];
                                            if (shortenName.length > 15) {
                                              shortenName = shortenName.substring(0, 15) + '...';
                                            }
                                            return shortenName;
                                          })().text.fontFamily(semibold).color(darkFontGrey).make(),





                                          10.heightBox,

                                          data[index]['price']==0 ?
                                          "Free".text.fontFamily(bold).color(Colors.green).size(16).make()
                                              :

                                          "\$ ${data[index]['price']}".text.fontFamily(bold).color(Colors.green).size(16).make(),


                                        ],
                                      ).box.white.roundedSM.outerShadowSm.margin(const EdgeInsets.symmetric(horizontal: 4))
                                          .padding(const EdgeInsets.all(12)).make().onTap(() {
                                           controller.checkIfFav(data[index]);
                                        Get.to(()=>ItemDetails(
                                            title: "${data[index]['name']}",
                                            data: data[index],

                                        ));
                                      });

                                    }
                                    ,

                          ),
                        );
                      }
                    },
                  ),
                ],
              )

         );
  }
}
