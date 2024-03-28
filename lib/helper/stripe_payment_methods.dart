import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> makePayment(
    {required BuildContext context,
    required String client_secret,
    required String payment_intent_id,
    required Function(String) transactionID}) async {
  try {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: client_secret,
      style: ThemeMode.light,
      merchantDisplayName: 'Yellow Line',
      customerId: payment_intent_id,
      googlePay: PaymentSheetGooglePay(
          merchantCountryCode: 'AE', currencyCode: 'AED', testEnv: true),
      // applePay: PaymentSheetApplePay(
      //     merchantCountryCode: 'AE',
      //     buttonType: PlatformButtonType.pay)
    ));
    await displayPaymentSheet(
        payment_id: payment_intent_id,
        context: context,
        transactionID: transactionID);
  } catch (err) {
    throw Exception(err);
  }
}

displayPaymentSheet(
    {String? payment_id,
    required BuildContext context,
    required Function(String) transactionID}) async {
  try {
    await Stripe.instance.presentPaymentSheet().then((value) {
      transactionID.call(payment_id!);
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  } on StripeException catch (e) {
    print('Error is:---> $e');
    AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: const [
              Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              Text("Payment Failed"),
            ],
          ),
        ],
      ),
    );
  } catch (e) {
    print('$e');
  }
}
