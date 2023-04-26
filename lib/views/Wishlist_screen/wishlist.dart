



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_v3/consts/consts.dart';
import 'package:mobile_v3/services/firestore_services.dart';

import '../category_screen/loading_indicator.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: 'My Wishlist'.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestorServices.getAllWishlists(),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }else if (snapshot.data!.docs.isEmpty){
            return "No WishList yet !".text.color(darkFontGrey).makeCentered();

          }else{
            var data =snapshot.data!.docs;
            return   Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount : data.length ,

                      itemBuilder: (BuildContext context , int index ){
                        return ListTile(
                          leading: Image.network("${data[index]['imageURL'][0]}" ,fit: BoxFit.cover, height: 100 ,width: 100,),
                          title:"${data[index]['name']}".text.fontFamily(semibold).size(16).color(darkFontGrey).make(),
                          subtitle: "${data[index]['price']}".numCurrency.text.color(Colors.red).fontFamily(semibold).make(),
                          trailing: const Icon(Icons.favorite , color: Colors.red)
                              .onTap(() async {
                               await firestore.collection(assetCollection).doc(data[index].id).set({
                                 'wishlist':FieldValue.arrayRemove([currentUser!.uid])
                               },SetOptions(merge: true));
                          }),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
