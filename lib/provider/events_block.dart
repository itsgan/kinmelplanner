import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventBlock extends ChangeNotifier {
  String _event = '';
  List<String> _units = ['Dozen', 'KG', 'LTR', 'PC', 'PKT', 'Set'];
  String _selectedUnit = 'KG';
  String _accountName = '';
  String _email = '';
  String _image = '';

  void setAccountName(String acName) {
    _accountName = acName;
    notifyListeners();
  }

  void setEmail(String mail) {
    _email = mail;
    notifyListeners();
  }

  void setImage(String photo) {
    _image = photo;
    notifyListeners();
  }

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

  String get selectedUnit {
    return _selectedUnit;
  }

  String get accountName {
    return _accountName;
  }

  String get image {
    return _image;
  }

  String get email {
    return _email;
  }
}
