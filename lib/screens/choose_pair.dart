import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';
import 'package:trade_app/cubits/pair/pair_cubit.dart';
import 'package:trade_app/layout.dart';

class ChoosePairScreen extends StatefulWidget {
  const ChoosePairScreen({Key? key}) : super(key: key);

  @override
  State<ChoosePairScreen> createState() => _ChoosePairScreenState();
}


class _ChoosePairScreenState extends State<ChoosePairScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PairCubit, PairState>(
      builder: (context, state) {
        List<Widget> children = [];

        for (TradingViewSymbol pair in TradingViewSymbol.values) {

          children.add(Container(
            height: scale(54),
            child: ElevatedButton(
              onPressed: () {
                context.read<PairCubit>().setChosenPair(pair);
                context.read<AppCubit>().setIsPairChanged(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: pair == state.chosenPair ? green : secondButton,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(scale(12)),
                ),
              ),
              child: Text(pair.name),
            ),
          ));
        }
        return Layout(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Currency pair",
              style:
                  TextStyle(fontWeight: FontWeight.w700, fontSize: scale(22)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(scale(37)),
            child: GridView.count(
              mainAxisSpacing: scale(20),
              childAspectRatio: scale(2.75),
              crossAxisSpacing: scale(21),
              crossAxisCount: 2,
              children: children,
            ),
          ),
        );
      },
    );
  }
}
