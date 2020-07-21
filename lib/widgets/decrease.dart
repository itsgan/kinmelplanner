import 'package:flutter/material.dart';
import 'package:merokinmel_planner/provider/counter_block.dart';
import 'package:provider/provider.dart';

class DecreaseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBlock counterBlock = Provider.of<CounterBlock>(context);
    return RaisedButton(
        child: Text('Decrease'),
        onPressed: () {
          counterBlock.decrement();
        });
  }
}
