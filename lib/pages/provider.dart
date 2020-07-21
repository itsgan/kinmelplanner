import 'package:flutter/material.dart';
import 'package:merokinmel_planner/provider/counter_block.dart';
import 'package:merokinmel_planner/widgets/aboutbutton.dart';
import 'package:merokinmel_planner/widgets/decrease.dart';
import 'package:merokinmel_planner/widgets/increase.dart';
import 'package:provider/provider.dart';

class MeroProvider extends StatefulWidget {
  @override
  _MeroProviderState createState() => _MeroProviderState();
}

class _MeroProviderState extends State<MeroProvider> {
  @override
  Widget build(BuildContext context) {
    final CounterBlock counterBlock = Provider.of<CounterBlock>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Provider')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                counterBlock.count.toString(),
                textScaleFactor: 5,
              ),
              IncreaseButton(),
              DecreaseButton(),
              AboutButton()
            ],
          ),
        ));
  }
}
