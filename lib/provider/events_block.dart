
import 'package:flutter/cupertino.dart';

class EventBlock extends ChangeNotifier {
  String _event = '';
  List<String> _units = ['Dozen','KG', 'LTR','PC','PKT', 'Set'];
  String _selectedUnit = 'KG';
  
  void createEvent(String value) {
    _event = value;
    notifyListeners();
  }

  String get isEventCreated {
    return _event;
  }

  List<String> get units {
    return _units;
  }

  void selectUnit(String u) {
    _selectedUnit = u;
    notifyListeners();
  }

  String get selectedUnit{
    return _selectedUnit;
  }
}

