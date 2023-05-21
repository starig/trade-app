import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';
import 'package:trade_app/cubits/pair/pair_cubit.dart';
import 'package:trade_app/screens/splash_screen.dart';
import 'package:trade_app/screens/trade_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

String generateHtmlUri(String symbol) {
  return Uri.dataFromString(
    '''
    <div class="tradingview-widget-container">
      <div id="tradingview_f70f4"></div>
      <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
      <script type="text/javascript">
      new TradingView.widget(
      {
        "autosize": true,
        "symbol": "NASDAQ:$symbol",
        "interval": "D",
        "timezone": "Etc/UTC",
        "theme": "dark",
        "style": "1",
        "locale": "en",
        "toolbar_bg": "#f1f3f6",
        "enable_publishing": false,
        "hide_top_toolbar": false,
        "hide_legend": true,
        "allow_symbol_change": true,
        "save_image": false,
        "container_id": "tradingview_f70f4"
      }
      );
      </script>
    </div>
    ''',
    mimeType: 'text/html',
    encoding: Encoding.getByName('utf-8'),
  ).toString();
}

class _InitialScreenState extends State<InitialScreen> {
  int webViewProgress = 0;
  late WebViewController controller;

  late TradingViewSymbol initSymbol;




  askForNotifications() async {
    await Permission.notification.isDenied.then((value) async {
      if (value) {
        var response = await Permission.notification.request();
      }
      context.read<AppCubit>().setIsLoaded(true);
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    String stockSymbol = context.read<PairCubit>().state.chosenPair.name;
    String htmlUri = generateHtmlUri(stockSymbol);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) async {
            double progressDouble = progress + 0.0;
            if (progress == 100) {
              var response = await askForNotifications();
              if (response) {
                context.read<AppCubit>().toggleShowBottomNavbar(true);
                context.read<AppCubit>().setLoadingProgress(progressDouble);
              }
            }
            context.read<AppCubit>().setLoadingProgress(progressDouble);
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(htmlUri));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      if (state.isLoaded) {
        return BlocBuilder<PairCubit, PairState>(
          builder: (context, state) {
            return TradeScreen(controller: controller);
          },
        );
      } else {
        return SplashScreen();
      }
    });
  }
}
