import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';
import 'package:trade_app/cubits/pair/pair_cubit.dart';
import 'package:trade_app/screens/splash_screen.dart';
import 'package:trade_app/screens/trade_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'screens/top_screen.dart';

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
        "width": 1000,
        "height": 800,
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
      ..setBackgroundColor(background)
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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, appState) {
      if (appState.isLoaded) {
        return BlocBuilder<PairCubit, PairState>(
          builder: (context, state) {
            if (appState.isPairChanged) {
              String stockSymbol = state.chosenPair.name;
              String htmlUri = generateHtmlUri(stockSymbol);
              controller.loadRequest(Uri.parse(htmlUri));
              context.read<AppCubit>().setIsPairChanged(false);
            }
            List<Widget> _screens = [
              TradeScreen(controller: controller),
              TopScreen(),
            ];
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/BG.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                backgroundColor:
                appState.isLoaded ? background : Colors.transparent,
                body: _screens[_selectedIndex],
                bottomNavigationBar: appState.showBottomNavbar ? Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: scale(0.5),
                              color: line
                          )
                      )
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: background,
                    currentIndex: _selectedIndex,
                    selectedItemColor: green,
                    unselectedItemColor: blueGrey,
                    onTap: _onItemTapped,
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset("assets/icons/trade.svg"),
                        activeIcon: SvgPicture.asset("assets/icons/trade-active.svg"),
                        label: 'Trade',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset("assets/icons/user.svg"),
                        activeIcon: SvgPicture.asset("assets/icons/user-active.svg"),
                        label: 'Top',
                      ),
                    ],
                  ),
                ) : null,
              ),
            );
          },
        );
      } else {
        return SplashScreen();
      }
    });
  }
}
