import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merokinmel_planner/pages/create_meroshopping.dart';
import 'package:merokinmel_planner/provider/events_block.dart';
import 'package:provider/provider.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  Firestore firestore = Firestore.instance;
  List<String> eventsList = [];
  String myEvent;

  @override
  void initState() {
    super.initState();
    setState(() {
      firestore.collection('events').getDocuments().then((value) {
        value.documents.forEach((element) {
          setState(() {
            eventsList.add(element.data['event']);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final EventBlock eventBlock = Provider.of<EventBlock>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My Events')),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                    hint: Text('Select Event'),
                    value: myEvent,
                    items: eventsList.map((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        this.myEvent = value;
                      });
                    }),
                SizedBox(width: 6),
                RaisedButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateMeroShoppingList()));
                      eventBlock.createEvent(myEvent);
                    })
              ],
            ),
            RaisedButton(
                child: Text('Create Event'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateMeroShoppingList()));
                }),
          ],
        ),
      ),
    );
  }
}
