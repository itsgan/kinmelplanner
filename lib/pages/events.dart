import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventsList extends StatefulWidget {
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Events')),
        body: StreamBuilder(
            stream: firestore.collection('events').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // return Text('Data is not available');
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      var myData = snapshot.data.documents[index];
                      return ListTile(
                        title: Text(myData['event']),
                        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Date: ' + myData['date']),
                                Text('Venue: ' + myData['venue']),
                              ],
                            ),
                            Text('Participants: '+myData['members']),
                            SizedBox(height:4)
                          ],
                        ),
                      );
                    });
              }
            }));
  }
}
