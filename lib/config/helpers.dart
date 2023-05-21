import 'package:flutter/material.dart';
import 'package:trade_app/config/colors.dart';

void showSuccessSnackbar(BuildContext context, String message) {
  final snackbar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: white),
    ),
    showCloseIcon: true,
    closeIconColor: white,
    backgroundColor: green,
    duration: Duration(milliseconds: 500),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showUnsuccessSnackbar(BuildContext context, String message) {
  final snackbar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: white),
    ),
    showCloseIcon: true,
    closeIconColor: white,
    backgroundColor: red,
    duration: Duration(milliseconds: 500),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}