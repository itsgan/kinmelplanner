import 'package:flutter/material.dart';
import 'package:merokinmel_planner/provider/counter_block.dart';
import 'package:provider/provider.dart';


class IncreaseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBlock counterBlock = Provider.of<CounterBlock>(context);
    return RaisedButton(
        child: Text('Increase', style:TextStyle(color:Color(0xff902266))),
        onPressed: () {
          counterBlock.increment();
        });
  
  }
}
