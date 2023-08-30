import 'package:flutter/foundation.dart';

class IsVisible extends ChangeNotifier {
  late bool _isVisible;

  bool get token => _isVisible;

  set token(bool value) {
    _isVisible = value;
    notifyListeners();
  }

  void updateToken(bool newToken) {
    _isVisible = newToken;
    notifyListeners();
  }
}
