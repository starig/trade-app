import 'package:flutter/material.dart';
import 'package:trade_app/layout.dart';

class TopScreen extends StatefulWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  State<TopScreen> createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        child: Center(
      child: Text('top'),
    ));
  }
}
