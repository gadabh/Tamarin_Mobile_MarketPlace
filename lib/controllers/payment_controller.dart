import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_v3/views/home_screen/home.dart';
import 'package:intl/intl.dart';
import '../consts/consts.dart';
import '../consts/firebase_consts.dart';
import 'home_controller.dart';


class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;



  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              applePay: true,
              googlePay: true,
              testEnv: true,
              merchantCountryCode: 'US',
              merchantDisplayName: 'Prospects',
              customerId: paymentIntentData!['customer'],
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            ));
        displayPaymentSheet(amount );
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      await placeMyOrder(amount);

      await clearCart();
      Get.offAll(Home());

    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51N0B1rFtPiYOJlBcQvr97gpcsmgdO9Vztua0ui4wjWtImc6LovQQOU0uSSTN4JNdKnFvwjpVN5xzPzQWcYeLYS8c00sp3XpIYn',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }





  //text controllers for  cart details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var country =TextEditingController();
  var postalController = TextEditingController();
  var phoneController = TextEditingController();
  var controller = TextEditingController();

  late dynamic assetSnapshot ;
  var assets =[];
  Random random = Random();

  //validate the order
  placeMyOrder(String amount) async {
    await getAssetDetails();
    String formattedDate = DateFormat('E MMM dd y').format(DateTime.now());    await firestore.collection(ordersCollection).doc().set({
      'cartItems': FieldValue.arrayUnion(assets),

      'orderAmount': amount,
      'createdAt': FieldValue.serverTimestamp(),
      'orderDate': formattedDate,
      'orderStatus': 'PAYED',
      "orderTime": "",
      'order_code': random.nextInt(90000),
      "shippingAdress": FieldValue.arrayUnion([
        {
          'country': country.text,
          'city': cityController.text,
          'state': stateController.text,
          'name': Get.find<HomeController>().username,
          'postal_code': postalController.text,
          'line1': addressController.text,
          "line2": "",
          "phone": phoneController.text,
        }
      ]),
      'userEmail': currentUser!.email,
      'userID': currentUser!.uid,
    });


  }


  getAssetDetails() async {
    assets.clear();
    for(var i=0;i< assetSnapshot.length ; i++){
      assets.add({
        'UpdatedAt':assetSnapshot[i]['UpdatedAt'],
        'added_by' : assetSnapshot[i]['added_by'],
        'brand': assetSnapshot[i]['brand'],
        'category':assetSnapshot[i]['category'],
        'createdAt':assetSnapshot[i]['createdAt'],
        'desc':assetSnapshot[i]['desc'],
        'editedBy':assetSnapshot[i]['editedBy'],
        'formats':assetSnapshot[i]['formats'],
        'id': assetSnapshot[i]['id'],
        'imageURL': assetSnapshot[i]['imageURL'],
        'is_featured': assetSnapshot[i]['is_featured'],
        'name' :assetSnapshot[i]['name'],
        'price':assetSnapshot[i]['price'],
        'prop': assetSnapshot[i]['prop'],
        'rating':assetSnapshot[i]['rating'],
        'sourceURL':assetSnapshot[i]['sourceURL'],
        'state':assetSnapshot[i]['state'],
        'sub_category':assetSnapshot[i]['sub_category'],
        'wishlist': assetSnapshot[i]['wishlist'],


      });

    }

    // print(assets);
  }

  clearCart() async {
    for(var i=0;i< assetSnapshot.length ; i++){
      firestore.collection(cartCollection).doc(assetSnapshot[i].id).delete();
    }


  }
}