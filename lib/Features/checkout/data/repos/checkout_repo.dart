import 'package:dartz/dartz.dart';
import 'package:payymentts/Features/checkout/data/Models/payment_intent_model/payment_intent_input.dart';
import 'package:payymentts/core/errors/failures.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
