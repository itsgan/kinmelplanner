import 'package:flutter/material.dart';
import 'package:merokinmel_planner/provider/counter_block.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    final CounterBlock counterBlock = Provider.of<CounterBlock>(context);
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Center(
          child: Text(
        counterBlock.count.toString(),
        style: TextStyle(color: Colors.amber),
        textScaleFactor: 6,
      )),
    );
  }
}
