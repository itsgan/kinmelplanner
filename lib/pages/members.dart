import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MembersList extends StatefulWidget {
  @override
  _MembersListState createState() => _MembersListState();
}

class _MembersListState extends State<MembersList> {
  Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Members List')),
        body: StreamBuilder(
            stream: firestore.collection('user').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      var memberData = snapshot.data.documents[index];
                      var meroNumber = 'tel:' + memberData['userMobile'];
                      return ListTile(
                        title: Text(memberData['userName']),
                        subtitle: Row(
                          children: <Widget>[
                            Text(memberData['userMobile']),
                            // Text(meroNumber),
                            SizedBox(width: 5),
                            InkWell(
                                child: Icon(
                                  Icons.call,
                                  size: 14.0,
                                  color: Colors.green,
                                ),
                                onTap: () async {
                                  if (await canLaunch(meroNumber)) {
                                    await launch(meroNumber);
                                  } else {
                                    throw 'Could not make a call';
                                  }
                                })
                          ],
                        ),
                      );
                    });
              }
            }));
  }
}
