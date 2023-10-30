import 'package:cupertino_studios/binance_pay/binace_pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../stripe/stripe_payment.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});
  
  void showPaymentDialog(BuildContext context) {
    showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return BinancePayWidget();
    });}
  @override
  Widget build(BuildContext context) {
    // Mapping of payment options
    List<Map<String, dynamic>> paymentOptions = [
      {
        'name': 'Card Payment',
        'image': 'assets/icons/stripe_method.svg',
        'onTap': () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const StipePayment()));
        }
      },
      {'name': 'Crypto Payment', 'image': 'assets/icons/0xprocessing_method.svg', 'onTap': {}},
      {'name': 'Payeer', 'image': 'assets/icons/payeer_method.svg', 'onTap': {}},
      {'name': 'Enot', 'image': 'assets/icons/enot_method.svg', 'onTap': {}},
      {'name': 'Binance Pay', 'image': 'assets/icons/binancePay_method.svg', 'onTap': () {
        showPaymentDialog(context);
      }},
      // Add more payment options as needed
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: const CupertinoNavigationBar(
            middle: Text(
              'Support',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              const Text('Support Funds'),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: (166 / 94),
                  children: List.generate(paymentOptions.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        paymentOptions[index]['onTap']();
                      },
                      child: Container(
                        // width: 166,
                        // height: 94,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(25, 22, 50, 0.12),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Image.network(paymentOptions[index]['image']),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Center(
              //     child: SizedBox(
              //   height: 100,
              //   child:
              //   GridView.count(
              //     crossAxisCount: paymentOptions.length,
              //     crossAxisSpacing: 40,
              //     padding: EdgeInsets.all(20),
              //     children: List.generate(paymentOptions.length, (index) {
              //       return GestureDetector(
              //         onTap: () {
              //           paymentOptions[index]['onTap']();
              //         },
              //         child: Card(
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             children: <Widget>[
              //               GridTile(
              //                 child: Column(
              //                   children: [
              //                     Image.network(paymentOptions[index]['image']),
              //                     SizedBox(
              //                       height: 20,
              //                     ),
              //                     Text(paymentOptions[index]['name']),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     }),
              //   ),
              // )),
            ],
          )),
        );
      },
    );
  }
}
