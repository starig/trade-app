import 'package:flutter/material.dart';
import 'package:trade_app/initial.dart';
import 'package:trade_app/screens/choose_pair.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/': (context) => const InitialScreen(),
  '/choose_pair': ((context) => const ChoosePairScreen()),
};
