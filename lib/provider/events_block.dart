import 'package:flutter/cupertino.dart';

class EventBlock extends ChangeNotifier {
  String _event = '';

  void createEvent(String value) {
    _event = value;
    notifyListeners();
  }

  String get isEventCreated {
    return _event;
  }
}
