import 'package:cupertino_studios/binance_pay/binance_pay.dart';
import 'package:cupertino_studios/stripe_pay/stripe_pay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SupportPage extends StatelessWidget {
  const SupportPage({super.key});
  
  void showPaymentDialog(BuildContext context, dynamic widget) {
    showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return widget;
    });}
  @override
  Widget build(BuildContext context) {
    // Mapping of payment options
    List<Map<String, dynamic>> paymentOptions = [
      // {
      //   'name': 'Card Payment',
      //   'image': 'assets/icons/stripe_method.svg',
      //   'onTap': () {
      //     showPaymentDialog(context,  StripePayWidget());
      //   }
      // },
      // {'name': 'Crypto Payment', 'image': 'assets/icons/0xprocessing_method.svg', 'onTap': {}},
      // {'name': 'Payeer', 'image': 'assets/icons/payeer_method.svg', 'onTap': {}},
      // {'name': 'Enot', 'image': 'assets/icons/enot_method.svg', 'onTap': {}},
      {'name': 'Binance Pay', 'image': 'assets/icons/binancePay_method.svg', 'onTap': () {
        showPaymentDialog(context, BinancePayWidget());
      }},
      // Add more payment options as needed
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: const CupertinoNavigationBar(
            middle: Text(
              'Choose Payment Method',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: constraints.maxWidth < 900 ? GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 60.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: (70 / 70),
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
                          child: SvgPicture.asset(paymentOptions[index]['image']),
                        ),
                      ),
                    );
                  }),
                ) :
                 GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 60.0,
                  mainAxisSpacing: 20.0,
                  childAspectRatio: (170 / 70),
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
                          child: SvgPicture.asset(paymentOptions[index]['image']),

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
