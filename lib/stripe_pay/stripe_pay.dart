// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe_web/flutter_stripe_web.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../config.dart';
import '../models/.env.dart';

class StripePayState extends ChangeNotifier {
  double selectedAmount = 5.0;
  TextEditingController customAmountController = TextEditingController();

  final CardEditController _controller;

  StripePayState() : _controller = CardEditController() {
    _controller.addListener(update);
  }

  CardEditController get controller => _controller;

  void update() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(update);
    _controller.dispose();
  }

  void updateSelectedAmount(double amount) {
    selectedAmount = amount;
    notifyListeners();
  }
}

class StripePayWidget extends StatelessWidget {
  StripePayWidget({super.key});

  // final controller = CardEditController();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void showMessageDialog(String message) {
    showCupertinoDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<StripePayState>(context).controller;

    Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({
      required String paymentIntentId,
    }) async {
      final url = Uri.parse(kApiUrl);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: json.encode({'paymentIntentId': paymentIntentId}),
      );
      return json.decode(response.body);
    }

    Future<Map<String, dynamic>> callNoWebhookPayEndpointMethodId({
      // required bool useStripeSdk,
      required String paymentMethodId,
      required String currency,
      required String amount,
      List<String>? items,
    }) async {
      final url = Uri.parse(kApiUrl);
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'useStripeSdk': true,
        'payment_method_types[]': 'card',
      };
      final response = await http.post(
        url,
        headers: {
          'Authorization':
              'Bearer $stripeSecretKey', // Replace with your Stripe secret key
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    }

    calculateAmount(String amount) {
      final a = (int.parse(amount)) * 100;
      return a.toString();
    }

    Future<void> confirmIntent(String paymentIntentId) async {
      final result = await callNoWebhookPayEndpointIntentId(
          paymentIntentId: paymentIntentId);
      if (result['error'] != null) {
        showMessageDialog('Error: ${result['error']}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${result['error']}'),
        ));
        print('Error: ${result['error']}');
      } else {
        showMessageDialog('Success!: The payment was confirmed successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Success!: The payment was confirmed successfully!'),
          ),
        );
      }
    }

    Future<void> handlePayPress({required String amount}) async {
      if (!controller.complete) {
        return;
      }

      try {
        // 1. Gather customer billing information (ex. email)
        const billingDetails = BillingDetails(
          email: 'email@stripe.com',
          phone: '+48888000888',
          address: Address(
            city: 'Houston',
            country: 'US',
            line1: '1459  Circle Drive',
            line2: '',
            state: 'Texas',
            postalCode: '77063',
          ),
        ); // mocked data for tests

        // 2. Create payment method
        final paymentMethod = await WebStripe.instance
            .createPaymentMethod(const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: billingDetails,
          ),
        ));

        // 3. call API to create PaymentIntent
        final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
          amount: calculateAmount(amount),
          // useStripeSdk: true,
          paymentMethodId: paymentMethod.id,
          currency: 'usd', // mocked data
          items: ['id-1'],
        );

        if (paymentIntentResult['error'] != null) {
          // Error during creating or confirming Intent
          showMessageDialog('Error: ${paymentIntentResult['error']}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${paymentIntentResult['error']}'),
          ));
          print('Error: ${paymentIntentResult['error']}');
          return;
        }

        if (paymentIntentResult['clientSecret'] != null &&
            paymentIntentResult['requiresAction'] == null) {
          // Payment succedeed
          showMessageDialog(
              'Success!: The payment was confirmed successfully!');

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text('Success!: The payment was confirmed successfully!')));
          return;
        }

        if (paymentIntentResult['clientSecret'] != null &&
            paymentIntentResult['requiresAction'] == true) {
          // 4. if payment requires action calling handleNextAction
          final paymentIntent = await WebStripe.instance.handleNextAction(
            paymentIntentResult['clientSecret'],
            returnURL: 'flutterstripe://redirect',
          );

          if (paymentIntent.status ==
              PaymentIntentsStatus.RequiresConfirmation) {
            // 5. Call API to confirm intent
            await confirmIntent(paymentIntent.id);
          } else {
            // Payment succedeed
            showMessageDialog('Error: ${paymentIntentResult['error']}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Error: ${paymentIntentResult['error']}')));
          }
        }
      } catch (e) {
        showMessageDialog('Error: $e');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
        rethrow;
      }
    }

    return Consumer<StripePayState>(
      builder: (context, state, _) {
        return AlertDialog(
          title: const Text('Select Amount'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 60.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: (170 / 70),
                    children: [
                      for (var amount in [5, 10, 15, 20, 50, 100])
                        GestureDetector(
                          onTap: () {
                            state.updateSelectedAmount(amount.toDouble());
                            state.customAmountController.clear();
                          },
                          child: Container(
                            color: state.selectedAmount == amount.toDouble()
                                ? Colors.blue
                                : Colors.white,
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  '\$ $amount',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: state.selectedAmount ==
                                            amount.toDouble()
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  CupertinoTextField(
                    controller: state.customAmountController,
                    keyboardType: TextInputType.number,
                    placeholder: 'Enter Amount',
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    placeholderStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 8.0),
                      child: Text(
                        '\$',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onTap: () {
                      state.updateSelectedAmount(0.0);
                    },
                  ),
                  const SizedBox(height: 20),
                  WebCardField(
                    controller: controller,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () => controller.focus(),
                          child: const Text('Focus'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () => controller.blur(),
                          child: const Text('Blur'),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () => controller.clear(),
                          child: const Text('Clear'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: CupertinoDialogAction(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoDialogAction(
                    child: const Text('Confirm'),
                    onPressed: () async {
                      var amount = 0.0;
                      if (state.customAmountController.text.isEmpty) {
                        amount = state.selectedAmount;
                      } else {
                        amount = double.tryParse(
                                state.customAmountController.text) ??
                            0.0;
                        state.updateSelectedAmount(
                            amount); // Deselect the amount in the card
                      }
                      // Navigator.of(context).pop();
                      controller.complete
                          ? await handlePayPress(amount: amount.toString())
                          : null;

                      print(state.selectedAmount);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
