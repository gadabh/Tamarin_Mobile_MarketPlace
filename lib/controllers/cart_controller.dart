
import 'package:get/get.dart';


class CartController extends GetxController{
  var totalP = 0.obs ;







  var payementIndex=0.obs;
  changePayementIndex(index){
    payementIndex.value=index;
  }




  calculate(data){
    totalP.value=0;
    for(var i =0 ; i<data.length ; i++){

      totalP.value = totalP.value + int.parse(data[i]['price'].toString());
    }
  }


}