import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:payymentts/Features/checkout/data/Models/payment_intent_model/payment_intent_input.dart';
import 'package:payymentts/Features/checkout/presentation/manger/cubit/cubit/payment_cubit.dart';
import 'package:payymentts/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:payymentts/core/widgets/custom_button.dart';

class CustomBouttomBlocConsumer extends StatelessWidget {
  const CustomBouttomBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSucess) {
          Get.to(const ThankYouView());
        }
        if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Payment Failed${state.errMessage}'),
          ));
        }
      },
      builder: (context, state) {
        return CustomButton(
          onTap: () {
            PaymentIntentInputModel paymentIntentInputModel =
                PaymentIntentInputModel(amount: '100', currency: "USD");
            BlocProvider.of<PaymentCubit>(context)
                .makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
          isloading: state is PaymentLoading ? true : false,
          text: 'Continue',
        );
      },
    );
  }
}
