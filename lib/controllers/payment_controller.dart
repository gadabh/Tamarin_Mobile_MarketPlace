import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
        displayPaymentSheet(amount);
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
  var postalController = TextEditingController();
  var phoneController = TextEditingController();
  var controller = TextEditingController();

  late dynamic assetSnapshot ;
  var assets =[];

  //validate the order
  placeMyOrder(String amount)async{

    await getAssetDetails();

    await firestore.collection(ordersCollection).doc().set(
        {
          'order_by': currentUser!.uid,
          'order_by_name': Get.find<HomeController>().username,
          'order_by_email': currentUser!.email,
          'order_by_adress': addressController.text,
          'order_by_state':stateController.text,
          'order_by_city':cityController.text,
          'order_by_phone':phoneController.text,
          'order_by_postalCode':postalController.text,
          'payement_method': 'Stripe',
          'total_amount':amount,
          'order': FieldValue.arrayUnion(assets),
        }
    );
  }


  getAssetDetails(){
    assets.clear();
    for(var i=0;i< assetSnapshot.length ; i++){
      assets.add({
        'name':assetSnapshot[i]['name'],
        'imageURL':assetSnapshot[i]['imageURL'],
        'prop':assetSnapshot[i]['prop'],
      });

    }
    // print(assets);
  }
}