import 'package:flutter/material.dart';

class RootSceneProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  set currentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }
}
