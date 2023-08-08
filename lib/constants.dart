import 'package:flutter/material.dart';

class Constants {
  static const primaryColor = Color.fromARGB(255, 122, 37, 137);
  static const textInputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Constants.primaryColor,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Constants.primaryColor,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Constants.primaryColor,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Constants.primaryColor,
        width: 2,
      ),
    ),
  );
}
