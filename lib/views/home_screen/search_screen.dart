



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/services/firestore_services.dart';
import 'package:mobile_v3/views/category_screen/loading_indicator.dart';

import '../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title ;
  const SearchScreen({Key? key , this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestorServices.searchAssets(title),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if ( snapshot.data!.docs.isEmpty){
            return
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: "No Assets Found".text.color(Colors.black).makeCentered(),
              );

          }else {
            var data = snapshot.data!.docs;
            var filtered = data.where(
                    (element) => element['name'].toString().toLowerCase()
                .contains(title!.toLowerCase())).toList();

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount
                    (crossAxisCount: 2 , mainAxisExtent: 300 , crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
                children: filtered.mapIndexed((currentValue, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network("${filtered[index]['imageURL'][0]}", width: 200, height: 200,fit: BoxFit.cover),
                    const  Spacer(),
                    (() {
                      String shortenName = filtered[index]['name'];
                      if (shortenName.length > 15) {
                        shortenName = shortenName.substring(0, 15) + '...';
                      }
                      return shortenName;
                    })().text.fontFamily(semibold).color(darkFontGrey).make(),

                    10.heightBox,

                    filtered[index]['price']==0 ?
                    "Free".text.fontFamily(bold).color(Colors.green).size(16).make()
                        :
                    "\$ ${filtered[index]['price']}".text.fontFamily(bold).color(Colors.green).size(16).make()
                  ],
                ).box.white.outerShadowMd.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM
                    .padding(const EdgeInsets.all(12)).make().onTap(() {
                  Get.to(()=>ItemDetails(
                      title:"${filtered[index]['name']}",
                      data:filtered[index]));
                }),
                ).toList(),
              ),
            );


          }

        },

      ),

    );
  }
}
