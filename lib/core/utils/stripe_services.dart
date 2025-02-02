import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payymentts/Features/checkout/data/Models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:payymentts/Features/checkout/data/Models/ephemeral_key_model/init_payment_sheet_input_model.dart';
import 'package:payymentts/Features/checkout/data/Models/payment_intent_model/payment_intent_input.dart';
import 'package:payymentts/Features/checkout/data/Models/payment_intent_model/payment_intent_model.dart';
import 'package:payymentts/core/utils/api_keys.dart';
import 'package:payymentts/core/utils/api_service.dart';

class StripeService {
  // paymentIntentObject Creat Payment intent(amount,currency)

  ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var respons = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: ApiKeys.secretkey,
    );
    var paymentIntentModel = PaymentIntentModel.fromJson(respons.data);
    return paymentIntentModel;
  }

  // Init payment sheet(paymentIntentClientSecret)
  Future initPaymentSheet(
      {required InitiPaymentSheetInputModel
          initiPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: initiPaymentSheetInputModel.clientSecret,
          merchantDisplayName: 'Helmy',
          customerEphemeralKeySecret:
              initiPaymentSheetInputModel.ephemeralKeySecret,
          customerId: initiPaymentSheetInputModel.customerId),
    );
  }

//Present PaymentSheet
  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var paymentEphemeralKeyModel = await createEphemeralKey(
        customerId: paymentIntentInputModel.customerId!);
    InitiPaymentSheetInputModel initiPaymentSheetInputModel =
        InitiPaymentSheetInputModel(
            clientSecret: paymentIntentModel.clientSecret!,
            customerId: paymentIntentInputModel.customerId!,
            ephemeralKeySecret: paymentEphemeralKeyModel.secret!);
    await initPaymentSheet(
      initiPaymentSheetInputModel: initiPaymentSheetInputModel,
    );
    await displayPaymentSheet();
  }

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    var response = await apiService.post(
        body: {'customer': customerId},
        contentType: Headers.formUrlEncodedContentType,
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        token: ApiKeys.secretkey,
        headers: {
          'Authorization': "Bearer ${ApiKeys.secretkey}",
          'Stripe-Version': '2024-06-20',
        });

    var ephermeralKey = EphemeralKeyModel.fromJson(response.data);

    return ephermeralKey;
  }
}
