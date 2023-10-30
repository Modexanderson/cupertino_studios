import 'dart:math';

import 'package:binance_pay/binance_pay.dart';
import 'package:cupertino_studios/models/.env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BinancePayState extends ChangeNotifier {
  double selectedAmount = 5.0;
  TextEditingController customAmountController = TextEditingController();

  void updateSelectedAmount(double amount) {
    selectedAmount = amount;
    notifyListeners();
  }
}

class BinancePayWidget extends StatelessWidget {
  BinancePayWidget({super.key});

  void createBinancePayOrder(double amount) async {
    BinancePay pay = BinancePay(
      apiKey: binanceApiKey,
      apiSecretKey: binanceSecretKey,
    );

    String tradeNo = generateMerchantTradeNo();

    OrderResponse response = await pay.createOrder(
      body: RequestBody(
        merchantTradeNo: tradeNo,
        orderAmount: amount.toString(),
        currency: 'USDT',
        goodsType: '01',
        goodsCategory: '1000',
        referenceGoodsId: 'referenceGoodsId',
        goodsName: 'goodsName',
        goodsDetail: 'goodsDetail',
        terminalType: 'WEB'
      ),
    );

    ///query the order
    QueryResponse queryResponse = await pay.queryOrder(
      merchantTradeNo: tradeNo,
      prepayId: response.data!.prepayId,
      
    );

    debugPrint(queryResponse.status);

    ///close the order
    CloseResponse closeResponse = await pay.closeOrder(
      merchantTradeNo: tradeNo,
    );

    debugPrint(closeResponse.status);
  }


//   void createBinancePayOrder(double amount) async {
//   var url = "https://bpay.binanceapi.com/binancepay/openapi/v2/order";
  
//   var uniqueOrderId = generateUniqueOrderId();

//   var requestBody = jsonEncode(
//     {
//     "env": {"terminalType": "APP"},
//     "orderTags": {"ifProfitSharing": true},
//     "merchantTradeNo": uniqueOrderId,
//     "orderAmount": amount,
//     "currency": "USDT",
//     "description": "very good Ice Cream",
//     "goodsDetails": [
//       {
//         "goodsType": "01",
//         "goodsCategory": "D000",
//         "referenceGoodsId": "7876763A3B",
//         "goodsName": "Ice Cream",
//         "goodsDetail": "Greentea ice cream cone"
//       }
//     ]
//   }
//   );

//   var response = await http.post(
//     Uri.parse(url),
//     headers: {
//       'Content-Type': 'application/json'
//     },
//     body: requestBody,
//   );

//   if (response.statusCode == 200) {
//     // Request successful, handle the response data here
//     print(response.body);
//   } else {
//     // Request failed, handle the error here
//     print('Request failed with status: ${response.statusCode}.');
//   }
// }


//   String generateUniqueOrderId() {
//     var timestamp = DateTime.now().millisecondsSinceEpoch;
//     var random = Random().nextInt(9999); // Generates a random 4-digit number
//     return '$timestamp$random';
//   }

// double selectedAmount = 5.0; // Default selected amount
//   TextEditingController customAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<BinancePayState>(
      builder: (context, state, _) {
        return CupertinoAlertDialog(
          title: const Text('Select Amount'),
          content: Column(
            children: [
              Column(
                children: [
                  for (var amount in [5, 10, 15, 20, 50, 100])
                    GestureDetector(
                      onTap: () {
                        state.updateSelectedAmount(amount.toDouble());
                        state.customAmountController.clear();
                      },
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
                                color: state.selectedAmount == amount.toDouble()
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
              // CupertinoPicker(
              //   itemExtent: 30,
              //   onSelectedItemChanged: (index) {
              //     state.updateSelectedAmount(
              //         [5, 10, 15, 20, 50, 100][index].toDouble());
              //   },
              //   children: [
              //     for (var amount in [5, 10, 15, 20, 50, 100])
              //       GestureDetector(
              //         onTap: () {
              //           state.updateSelectedAmount(amount.toDouble());
              //         },
              //         child: Container(

              //         )
              //         Card(
              //           color: state.selectedAmount == amount.toDouble()
              //               ? Colors.blue
              //               : Colors.white,
              //           child: SizedBox(
              //             height: 50,
              //             child: Center(
              //               child: Text(
              //                 '\$ $amount',
              //                 style: TextStyle(
              //                   fontSize: 20,
              //                   color: state.selectedAmount == amount.toDouble()
              //                       ? Colors.white
              //                       : Colors.black,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //   ],
              // ),
              const SizedBox(height: 10),
              CupertinoTextField(
                controller: state.customAmountController,
                keyboardType: TextInputType.number,
                placeholder: 'Enter custom amount',
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                onTap: () {
                  state.updateSelectedAmount(0.0);
                },
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('Confirm'),
              onPressed: () {
                var amount = 0.0;
                if (state.customAmountController.text.isEmpty) {
                  amount = state.selectedAmount;
                } else {
                  amount =
                      double.tryParse(state.customAmountController.text) ?? 0.0;
                  state.updateSelectedAmount(
                      amount); // Deselect the amount in the card
                }
                Navigator.of(context).pop();
                createBinancePayOrder(amount);

                // var amount = state.customAmountController.text.isEmpty
                //     ? state.selectedAmount
                //     : double.tryParse(state.customAmountController.text) ?? 0.0;
                // Navigator.of(context).pop();
                // createBinancePayOrder(amount);

                print(state.selectedAmount);
              },
            ),
          ],
        );
      },
    );
  }
}

// class FundAmountWidget extends StatelessWidget {
//   final Function(double) onAmountSelected;

//   const FundAmountWidget({required this.onAmountSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         for (var amount in [5, 10, 15, 20, 50, 100])
//           GestureDetector(
//             onTap: () {
//               onAmountSelected(amount.toDouble());
//             },
//             child: Card(
//               color: state.selectedAmount == amount.toDouble()
//                   ? Colors.blue
//                   : Colors.white,
//               child: SizedBox(
//                 height: 50,
//                 child: Center(
//                   child: Text(
//                     '\$ $amount',
//                     style: TextStyle(
//                       fontSize: 20,
//                       color: state.selectedAmount == amount.toDouble()
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
