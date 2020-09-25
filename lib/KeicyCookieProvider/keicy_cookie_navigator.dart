import 'package:flutter/material.dart';

class KeicyCookieNavigator {
  static Future<T> pushNamed<T extends Object>(BuildContext context, String routeName) async {
    return Navigator.of(context).pushNamed(
      routeName,
      arguments: {"isCheckCookie": false},
    );
  }
}
