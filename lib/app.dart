import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/routes.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';
import 'package:trade_app/cubits/pair/pair_cubit.dart';
import 'package:trade_app/cubits/trade/trade_cubit.dart';

import 'initial.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => AppCubit())),
        BlocProvider(create: ((context) => TradeCubit())),
        BlocProvider(create: ((context) => PairCubit())),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: "Trade App",
          debugShowCheckedModeBanner: false,
          // initialRoute: '/trade_screen',
          home: InitialScreen(),
          // routes: routes,
          theme: ThemeData(
            scaffoldBackgroundColor: background,
            appBarTheme: AppBarTheme(
              backgroundColor: background,
            )
          ),
        ),
      ),
    );;
  }
}
