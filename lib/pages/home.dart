import 'package:flutter/material.dart';
import 'package:merokinmel_planner/pages/call.dart';
import 'package:merokinmel_planner/pages/drop_down.dart';
import 'package:merokinmel_planner/pages/events.dart';
import 'package:merokinmel_planner/pages/members.dart';
import 'package:merokinmel_planner/pages/provider.dart';
import 'package:merokinmel_planner/pages/shoppinglist.dart';
import 'package:merokinmel_planner/widgets/mydrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Kinmel Planner')),
        drawer: MyDrawer(),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('images/SabjiMandi.jpg')),
            ),
            Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 5,
              children: <Widget>[
                RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventsList()));
                    },
                    child: Text('Events')),
                RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShoppingList()));
                    },
                    child: Text('Shopping List')),
                RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Makecall()));
                    },
                    child: Text('Call Now')),
                RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MembersList()));
                    },
                    child: Text('Members')),
                RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DroupDoun()));
                    },
                    child: Text('DropDown')),
                RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MeroProvider()));
                    },
                    child: Text('Provider')),
              ],
            )
          ],
        ));
  }
}
