import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trade_app/components/balance.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';
import 'package:trade_app/cubits/pair/pair_cubit.dart';
import 'package:trade_app/cubits/pair/pair_cubit.dart';
import 'package:trade_app/layout.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradeScreen extends StatefulWidget {
  final WebViewController controller;

  const TradeScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Layout(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Trade",
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: scale(22)),
            ),
          ),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: scale(30)),
                  child: Balance(),
                ),
                SizedBox(
                  height: scale(25),
                ),
                Container(
                  height: scale(321),
                  child: WebViewWidget(
                    controller: widget.controller,
                  ),
                ),
                SizedBox(
                  height: scale(16),
                ),
                BlocBuilder<PairCubit, PairState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: scale(30)),
                      child: Container(
                        width: double.maxFinite,
                        height: scale(54),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/choose_pair');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: secondButton,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(scale(12)),
                              ),
                              elevation: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Text(
                                state.chosenPair.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SvgPicture.asset("assets/icons/arrow-left.svg")
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: scale(16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: scale(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: scale(54),
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondButton,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(scale(12)),
                                ),
                                elevation: 0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Text(
                                  'GPB/USD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SvgPicture.asset(
                                    "assets/icons/arrow-left.svg")
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: scale(11),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: scale(54),
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: secondButton,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(scale(12)),
                                ),
                                elevation: 0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                Text(
                                  'GPB/USD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SvgPicture.asset(
                                    "assets/icons/arrow-left.svg")
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: scale(11),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: scale(30)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: scale(54),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    scale(12),
                                  ),
                                ),
                                elevation: 0),
                            child: Text(
                              'Sell',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: scale(24)
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: scale(11),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: scale(54),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    scale(12),
                                  ),
                                ),
                                elevation: 0),
                            child: Text(
                              'Buy',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: scale(24)
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
