import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';

class Layout extends StatefulWidget {
  final Widget child;
  final AppBar? appBar;

  const Layout({Key? key, required this.child, this.appBar}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/BG.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            appBar: widget.appBar,
            backgroundColor:
                state.isLoaded ? background : Colors.transparent,
            body: widget.child,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: state.showBottomNavbar ? Container(
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
          );
        },
      ),
    );
  }
}
