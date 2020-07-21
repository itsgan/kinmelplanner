import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Makecall extends StatefulWidget {
  @override
  _MakecallState createState() => _MakecallState();
}

class _MakecallState extends State<Makecall> {
  String meroNumber = 'tel:+977-9842038504';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Make a call')),
      body: Column(
        children: <Widget>[
          Text(meroNumber),
          FloatingActionButton(
              child: Icon(Icons.call),
              onPressed: () async {
                // const url = 'https:wedharane.com.np';
                // const url = 'tel:+9779842038504';
                if (await canLaunch(meroNumber)) {
                  await launch(meroNumber);
                } else {
                  throw 'Could not call on $meroNumber';
                }
              }),
        ],
      ),
    );
  }
}
