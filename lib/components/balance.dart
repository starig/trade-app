import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/cubits/trade/trade_cubit.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TradeCubit, TradeState>(
      builder: (context, state) {
        return Container(
          height: scale(54),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(scale(12)),
            color: secondButton,
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Balance',
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w500,
                  fontSize: scale(12),
                ),
              ),
              Text(
                state.balance.toString(),
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w600,
                  fontSize: scale(16),
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
