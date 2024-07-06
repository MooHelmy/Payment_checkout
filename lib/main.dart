import 'package:flutter/material.dart';
import 'package:payymentts/Features/checkout/presentation/views/my_cart_view.dart';

void main() {
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}
//steps
// paymentIntentObject Creat Payment intent(amount,currency)
// Init payment sheet(paymentIntentClientSecret)
//Present PaymentSheet