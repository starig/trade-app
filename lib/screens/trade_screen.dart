import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_app/components/balance.dart';
import 'package:trade_app/components/timer_picker.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/helpers.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';
import 'package:trade_app/cubits/pair/pair_cubit.dart';
import 'package:trade_app/cubits/trade/trade_cubit.dart';
import 'package:trade_app/layout.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradeScreen extends StatefulWidget {
  final WebViewController controller;

  const TradeScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  final TextEditingController _investmentController = TextEditingController();
  final TextEditingController _timerController = TextEditingController();
  bool isInvestmentFocused = false;
  bool isTimerFocused = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _investmentController.dispose();
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Layout(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Trade",
              style:
              TextStyle(fontWeight: FontWeight.w700, fontSize: scale(22)),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: scale(30)),
                  child: const Balance(),
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
                                borderRadius: BorderRadius.circular(scale(12)),
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
                BlocBuilder<TradeCubit, TradeState>(builder: (context, state) {
                  _investmentController.text = state.investmentCount.toString();
                  _investmentController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _investmentController.text.length));

                  String minutesString = state.timer.minutes < 10
                      ? '0${state.timer.minutes}'
                      : '${state.timer.minutes}';
                  String secondsString = state.timer.seconds < 10
                      ? '0${state.timer.seconds}'
                      : '${state.timer.seconds}';

                  _timerController.text = "$minutesString:$secondsString";
                  _timerController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _timerController.text.length));

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: scale(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: scale(54),
                            decoration: BoxDecoration(
                                color: secondButton,
                                border: Border.all(
                                    width: isTimerFocused ? 1 : 0,
                                    color: isTimerFocused ? green : background),
                                borderRadius: BorderRadius.circular(scale(12))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: scale(16.5),
                                right: scale(16.5),
                                top: scale(5),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Timer',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: scale(12),
                                      color: white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<TradeCubit>()
                                                .decreaseSeconds();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icons/minus-cirlce.svg",
                                          ),
                                        ),
                                        Container(
                                          width: scale(50),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isTimerFocused = true;
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) {
                                                      return TimerPickerDialog(
                                                        selectedMinutes:
                                                        state.timer
                                                            .minutes,
                                                        selectedSeconds:
                                                        state.timer
                                                            .seconds,
                                                      );
                                                    })
                                                    .whenComplete(
                                                        () =>
                                                        setState(() {
                                                          isTimerFocused =
                                                          false;
                                                        }));
                                              },
                                              child:
                                              Text(_timerController.text,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: scale(16),
                                                    color: white
                                                ),)),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<TradeCubit>()
                                                .increaseSeconds();
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/add-circle.svg"),
                                        )
                                      ],
                                    ),
                                  )
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
                            decoration: BoxDecoration(
                                color: secondButton,
                                border: Border.all(
                                    width: isInvestmentFocused ? 1 : 0,
                                    color: isInvestmentFocused
                                        ? green
                                        : background),
                                borderRadius: BorderRadius.circular(scale(12))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: scale(16.5),
                                right: scale(16.5),
                                top: scale(5),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Intestment',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: scale(12),
                                      color: white,
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<TradeCubit>()
                                                .decreaseInvestmentCount();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icons/minus-cirlce.svg",
                                          ),
                                        ),
                                        Container(
                                          width: scale(46),
                                          child: TextFormField(
                                            controller: _investmentController,
                                            keyboardType: TextInputType.number,
                                            onTap: () {
                                              setState(() {
                                                isInvestmentFocused = true;
                                              });
                                            },
                                            onTapOutside: (e) {
                                              FocusScope.of(context).unfocus();
                                              setState(() {
                                                isInvestmentFocused = false;
                                              });
                                            },
                                            onChanged: (String value) {
                                              _investmentController.text =
                                                  value;
                                              _investmentController.selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset:
                                                          value.length));
                                              context
                                                  .read<TradeCubit>()
                                                  .setInvestmentCount(value);
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              isCollapsed: true,
                                              filled: true,
                                              fillColor: Colors.transparent,
                                            ),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: white,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<TradeCubit>()
                                                .increaseInvestmentCount();
                                          },
                                          child: SvgPicture.asset(
                                              "assets/icons/add-circle.svg"),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
                SizedBox(
                  height: scale(11),
                ),
                BlocBuilder<TradeCubit, TradeState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: scale(30)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: scale(54),
                              child: ElevatedButton(
                                onPressed: state.isPending ? null : () {
                                    context.read<TradeCubit>().sell();
                                    showSuccessSnackbar(context, 'Successful');
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: state.isPending ? grey : red,
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
                                      fontSize: scale(24),
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
                                onPressed: state.isPending ? null : () {
                                  bool response = context.read<TradeCubit>().buy();
                                  if (response) {
                                    showSuccessSnackbar(context, 'Successful');
                                  } else {
                                    showUnsuccessSnackbar(context, 'Not successful');
                                  }
                                },
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
                                      fontSize: scale(24)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
