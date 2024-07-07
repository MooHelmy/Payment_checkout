import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payymentts/Features/checkout/data/Models/payment_intent_model/payment_intent_input.dart';
import 'package:payymentts/Features/checkout/data/repos/checkout_repo.dart';
import 'package:payymentts/core/errors/failures.dart';
import 'package:payymentts/core/utils/stripe_services.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);

      return right(null);
    } on StripeException catch (e) {
      return left(ServerFailure(
          errMessage: e.error.message ?? 'Oops there was an error'));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
