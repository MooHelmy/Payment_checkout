import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:payymentts/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:payymentts/core/utils/api_keys.dart';

void main() {
  Stripe.publishableKey = ApiKeys.publishablekey;
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}
              //steps
// paymentIntentObject Creat Payment intent(amount,currency)
// Init payment sheet(paymentIntentClientSecret)
//Present PaymentSheet