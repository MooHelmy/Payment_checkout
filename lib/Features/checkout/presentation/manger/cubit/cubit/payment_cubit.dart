import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payymentts/Features/checkout/data/Models/payment_intent_model/payment_intent_input.dart';
import 'package:payymentts/Features/checkout/data/repos/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;

  Future<void> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    final result = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    result.fold((l) {
      emit(PaymentFailure(l.errMessage));
    }, (r) {
      emit(PaymentSucess());
    });
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
