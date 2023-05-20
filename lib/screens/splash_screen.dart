import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_app/components/loader.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';
import 'package:trade_app/layout.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  double barValue = 0;
  String barText = "";

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..addListener(() {
        setState(() {
          barValue = controller.value * 100;
          barText = "${barValue.toString().split('.')[0]}%";
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
  builder: (context, state) {
    controller.animateTo(state.loadingProgress / 100);
    return Layout(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: scale(38)),
          child: Loader(
            barText: barText,
            controller: controller,
          ),
        ),
      ),
    );
  },
);
  }
}
