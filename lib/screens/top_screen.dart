import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/layout.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class Trader {
  final String name;
  int deposit;
  int profit;
  final Widget flag;
  final String country;

  Trader(
      {required this.name,
      required this.deposit,
      required this.profit,
      required this.flag,
      required this.country});
}

class _TopScreenState extends State<TopScreen> {
  List<Trader> traders = [
    Trader(
      name: 'John',
      deposit: 2367,
      profit: 336755,
      flag: SvgPicture.asset("assets/flags/brazil.svg"),
      country: 'Brazil',
    ),
    Trader(
      name: 'Jane',
      deposit: 1175,
      profit: 148389,
      flag: SvgPicture.asset("assets/flags/european-union.svg"),
      country: 'Europe',
    ),
    Trader(
      name: 'Mike',
      deposit: 1000,
      profit: 113888,
      flag: SvgPicture.asset("assets/flags/georgia.svg"),
      country: 'Georgia',
    ),
    Trader(
      name: 'Emily',
      deposit: 999,
      profit: 36755,
      flag: SvgPicture.asset("assets/flags/hawaii.svg"),
      country: 'Hawaii',
    ),
    Trader(
      name: 'Robert',
      deposit: 888,
      profit: 18389,
      flag: SvgPicture.asset("assets/flags/kiribati.svg"),
      country: 'Kiribati',
    ),
    Trader(
      name: 'Sarah',
      deposit: 777,
      profit: 12000,
      flag: SvgPicture.asset("assets/flags/mauritius.svg"),
      country: 'Mauritius',
    ),
    Trader(
      name: 'Michael',
      deposit: 666,
      profit: 11111,
      flag: SvgPicture.asset("assets/flags/mongolia.svg"),
      country: 'Mongolia',
    ),
    Trader(
      name: 'Olivia',
      deposit: 555,
      profit: 9988,
      flag: SvgPicture.asset("assets/flags/nato.svg"),
      country: 'Nato',
    ),
    Trader(
      name: 'Daniel',
      deposit: 444,
      profit: 8877,
      flag: SvgPicture.asset("assets/flags/sardinia.svg"),
      country: 'Sardinia',
    ),
    Trader(
      name: 'Sophia',
      deposit: 333,
      profit: 6652,
      flag: SvgPicture.asset("assets/flags/united-kingdom.svg"),
      country: 'United Kingdom',
    ),
  ];

  final random = Random();

  void updateValues() {
    final count = random.nextInt(traders.length) + 1;

    for (int i = 0; i < count; i++) {
      final index = random.nextInt(traders.length);
      final step = random.nextInt(101) + 50;
      traders[index].deposit += step;
      traders[index].profit += step;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(
        const Duration(
          minutes: 3,
          // seconds: 3,
        ), (_) {
      updateValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "TOP 10 Traders",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: scale(22)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: scale(12), right: scale(12), bottom: scale(46)),
          child: Container(
            padding: EdgeInsets.only(top: scale(16)),
            decoration: BoxDecoration(
                color: tableBg, borderRadius: BorderRadius.circular(scale(8))),
            child: Column(
              children: [
                Container(
                  height: scale(50),
                  padding: EdgeInsets.symmetric(horizontal: scale(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '№',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                          fontSize: scale(12),
                        ),
                      ),
                      Text(
                        'Сountry',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                          fontSize: scale(12),
                        ),
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                          fontSize: scale(12),
                        ),
                      ),
                      Text(
                        'Deposit',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                          fontSize: scale(12),
                        ),
                      ),
                      Text(
                        'Profit',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                          fontSize: scale(12),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        height: scale(50),
                        padding: EdgeInsets.symmetric(horizontal: scale(8)),
                        decoration: BoxDecoration(
                            color: index % 2 == 1 ? null : background),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w500,
                                fontSize: scale(12),
                              ),
                            ),
                            traders[index].flag,
                            Text(
                              traders[index].name,
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w500,
                                fontSize: scale(12),
                              ),
                            ),
                            Text(
                              '\$${traders[index].deposit}',
                              style: TextStyle(
                                color: white,
                                fontWeight: FontWeight.w500,
                                fontSize: scale(12),
                              ),
                            ),
                            Text(
                              '\$${traders[index].profit}',
                              style: TextStyle(
                                color: green,
                                fontWeight: FontWeight.w500,
                                fontSize: scale(12),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
