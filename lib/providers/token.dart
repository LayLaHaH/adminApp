import 'package:flutter/foundation.dart';

class Token extends ChangeNotifier {
  late String _token="0";

  String get token => _token;

  set token(String value) {
    _token = value;
    notifyListeners();
  }

  void updateToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }
}
