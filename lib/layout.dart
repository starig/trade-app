import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/cubits/app/app_cubit.dart';

class Layout extends StatefulWidget {
  final Widget child;
  final AppBar? appBar;

  const Layout({Key? key, required this.child, this.appBar}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
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
            backgroundColor: state.isLoaded ? background : Colors.transparent,
            body: widget.child,
          );
        },
      ),
    );
  }
}
