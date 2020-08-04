import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:merokinmel_planner/provider/events_block.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime meroEventDate;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController event = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController venue = TextEditingController();
  TextEditingController members = TextEditingController();

  Firestore firestore = Firestore.instance;

  addEvents(String eventsName) {
    firestore.collection('events').document(eventsName).setData({
      'event': event.text,
      'venue': venue.text,
      'date': meroEventDate,
      'members': members.text
    });
  }

  @override
  Widget build(BuildContext context) {
    final EventBlock eventBlock = Provider.of<EventBlock>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
              key: key,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Event', border: OutlineInputBorder()),
                    controller: event,
                    validator: (value) =>
                        value.isEmpty ? 'This field cannot be empty' : null,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(meroEventDate == null
                            ? 'Select the date'
                            : meroEventDate.toString().split(' ').first),
                      ),
                      SizedBox(width: 5),
                      SizedBox(
                        width: 75,
                        child: RaisedButton.icon(
                            icon: Icon(Icons.calendar_today),
                            label: Text('...'),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: (meroEventDate == null
                                    ? DateTime.now()
                                    : meroEventDate),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2050),
                              ).then((value) {
                                setState(() {
                                  meroEventDate = value;
                                });
                              });
                            }),
                      )
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Venue', border: OutlineInputBorder()),
                    validator: (value) =>
                        value.isEmpty ? 'This field cannot be empty' : null,
                    controller: venue,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Members', border: OutlineInputBorder()),
                    controller: members,
                    validator: (value) =>
                        value.isEmpty ? 'This field cannot be empty' : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      onPressed: () {
                        if (key.currentState.validate()) {
                          addEvents(event.text);
                          Toast.show('Your event has been created', context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.CENTER);

                          eventBlock.createEvent(event.text);

                          setState(() {
                            venue.clear();
                            event.clear();
                            date.clear();
                            members.clear();
                          });
                        }
                      },
                      child: Text('Create Event'))
                ],
              )),
        ),
      ),
    );
  }
}
