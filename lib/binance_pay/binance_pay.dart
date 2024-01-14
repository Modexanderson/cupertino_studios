// import 'dart:math';

import 'package:binance_pay/binance_pay.dart';
import '../models/.env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BinancePayState extends ChangeNotifier {
  double selectedAmount = 5.0;
  TextEditingController customAmountController = TextEditingController();

  void updateSelectedAmount(double amount) {
    selectedAmount = amount;
    notifyListeners();
  }
}

  void createBinancePayOrder(double amount) async {
    BinancePay pay = BinancePay(
      apiKey: binanceApiKey,
      apiSecretKey: binanceSecretKey,
    );

    String tradeNo = generateMerchantTradeNo();

    RequestBody requestBody = RequestBody(
      merchantTradeNo: tradeNo,
      orderAmount: amount.toString(),
      currency: 'USDT',
      goodsType: '01',
      goodsCategory: '1000',
      referenceGoodsId: 'referenceGoodsId',
      goodsName: 'Projects Support',
      goodsDetail: 'goodsDetail',
      terminalType: 'WEB',
    );

    OrderResponse response = await pay.createOrder(body: requestBody);

    if (response.status == 'SUCCESS') {
      String universalLink = response.data!.universalUrl;

      // Open the QR code link in the default browser or external app
      html.window.open(universalLink, '_blank');
    //   if (await canLaunchUrl( Uri.parse(universalLink))) {
    //     await launchUrl(Uri.parse(universalLink));
    //     print(universalLink);
    //   } else {
    //     print('Could not launch $universalLink');
    //   }

    //   // Redirect users to the checkoutURL or display the QR code
    // } else {
    //   print('Error creating Binance Pay order: ${response.errorMessage}');
    }

    ///query the order
    QueryResponse queryResponse = await pay.queryOrder(
      merchantTradeNo: tradeNo,
      prepayId: '29383937493038367292',
    );

    debugPrint(queryResponse.status);

    ///close the order
    CloseResponse closeResponse = await pay.closeOrder(
      merchantTradeNo: tradeNo,
    );

    debugPrint(closeResponse.status);
  }

  Widget binancePayWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<BinancePayState>(
          builder: (context, state, _) {
            return AlertDialog(
              title: const Text('Select Amount'),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      constraints.maxWidth < 900 ? 
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: (70 / 70),
                        children: [
                          for (var amount in [5, 10, 15, 20, 50, 100])
                            GestureDetector(
                              onTap: () {
                                state.updateSelectedAmount(amount.toDouble());
                                state.customAmountController.clear();
                              },
                              child: SizedBox(
                                width: 150,
                                height: 60,
                                child: Card(
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
                            ),
                        ],
                      ) :
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
                              child: SizedBox(
                                width: 150,
                                height: 60,
                                child: Card(
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
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
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
                        padding:
                            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
                      )
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
                        onPressed: () {
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
                          createBinancePayOrder(amount);
                          Navigator.of(context).pop();

                          // var amount = state.customAmountController.text.isEmpty
                          //     ? state.selectedAmount
                          //     : double.tryParse(state.customAmountController.text) ?? 0.0;
                          // Navigator.of(context).pop();
                          // createBinancePayOrder(amount);

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
    );
  }
