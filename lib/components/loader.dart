import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/layout.dart';

class Loader extends StatefulWidget {
  final String barText;
  final AnimationController controller;
  const Loader({Key? key, required this.barText, required this.controller}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(scale(30)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          LinearProgressIndicator(
            value: widget.controller.value,
            backgroundColor: grey,
            color: green,
            minHeight: scale(24),
          ),
          Text(
            widget.barText,
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.w800,
              fontSize: scale(16),
            ),
          )
        ],
      ),
    );
  }
}
