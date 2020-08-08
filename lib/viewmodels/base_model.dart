import 'package:flutter/cupertino.dart';

enum ViewState { Idle, Busy }

class BaseModel extends ChangeNotifier {
  ViewState viewState = ViewState.Idle;
  ViewState get state => viewState;
  bool isDisposed = false;
  onChange() {
    notifyListeners();
  }

  void changeState(ViewState _viewState) {
    viewState = _viewState;
    onChange();
  }
}
