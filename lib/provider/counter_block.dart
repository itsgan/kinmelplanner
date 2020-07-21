import 'package:flutter/widgets.dart';

class CounterBlock extends ChangeNotifier{
  int _count = 0;

  void increment(){
    _count++;
    notifyListeners();
  } 

  void decrement(){
    _count--;
    notifyListeners();
  }

  int get count{
    return _count;
  }
}