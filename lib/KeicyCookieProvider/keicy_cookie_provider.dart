import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'index.dart';

class KeicyCookieProvider extends ChangeNotifier {
  static KeicyCookieProvider of(BuildContext context, {bool listen = false}) => Provider.of<KeicyCookieProvider>(context, listen: listen);

  static final bool _isCheckCookie = true;
  static int _minutes;
  static SharedPreferences prefs;

  KeicyCookieProvider({@required int minutes}) {
    _minutes = minutes;
  }

  KeicyCookieState _keicyCookieState = KeicyCookieState.init();
  KeicyCookieState get keicyCookieState => _keicyCookieState;

  void setKeicyCookieState(KeicyCookieState keicyCookieState, {bool isNotifiable = true}) {
    if (_keicyCookieState != keicyCookieState) {
      _keicyCookieState = keicyCookieState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> checkCookie({@required String routeName, @required Map<String, dynamic> arguments, int minutes}) async {
    bool isCheckCookie;

    prefs = prefs ?? await SharedPreferences.getInstance();
    minutes = minutes ?? _minutes;
    arguments = arguments ?? Map<String, dynamic>();
    isCheckCookie = arguments["isCheckCookie"] ?? _isCheckCookie;

    /// When this route is navigated by other page or don't need to check cookie info
    if (!isCheckCookie) {
      setKeicyCookieState(_keicyCookieState.update(progressState: 2));
      prefs.setInt("Route Name: $routeName", DateTime.now().millisecondsSinceEpoch);
      return;
    }

    /// Checking Cookie
    else {
      int ts = prefs.getInt("Route Name: $routeName");

      /// When this route is first loading
      if (ts == null) {
        setKeicyCookieState(_keicyCookieState.update(progressState: 2));
        prefs.setInt("Route Name: $routeName", DateTime.now().millisecondsSinceEpoch);
        return;
      }

      Duration duration = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(ts));

      /// When the cookie time is not over,
      if (duration.compareTo(Duration(minutes: minutes)) < 0) {
        setKeicyCookieState(_keicyCookieState.update(progressState: 2));
        prefs.setInt("Route Name: $routeName", DateTime.now().millisecondsSinceEpoch);
        return;
      }

      /// When the cookie time is not over,
      else {
        setKeicyCookieState(_keicyCookieState.update(progressState: -1));
        return;
      }
    }
  }
}
