import 'package:flutter/material.dart';
import 'package:trade_app/initial.dart';
import 'package:trade_app/screens/choose_pair.dart';
import 'package:trade_app/screens/splash_screen.dart';
import 'package:trade_app/screens/trade_screen.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/': (context) => const InitialScreen(),
  // '/trade_screen': (context) => const TradeScreen(),
  '/choose_pair': ((context) => const ChoosePairScreen()),
  // '/verify': ((context) => const VerifyScreen()),
  // '/forget_password': ((context) => const ForgetPasswordScreen()),
  // '/new_password': ((context) => const NewPasswordScreen()),
  // '/login': ((context) => const LoginScreen()),
  // // '/fingerprint': ((context) => const FingetPrintScreen()),
  // '/index': ((context) => const IndexScreen()),
  // '/add_feedback': ((context) => const AddFeedBackScreen()),
};
