import 'package:flutter/cupertino.dart';

class BaseModel extends ChangeNotifier {
  ModelState _state = ModelState.Idle;

  ModelState get state => _state;

  void setState(value) {
    _state = value;

    notifyListeners();
  }
}

enum ModelState { Idle, Busy }
