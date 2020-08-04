import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PurchaseItems extends StatefulWidget {
  @override
  _PurchaseItemsState createState() => _PurchaseItemsState();
}

class _PurchaseItemsState extends State<PurchaseItems> {
  Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Update Shopping Item')),
        body: StreamBuilder(
            stream: firestore.collection('meroShopping').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return (CircularProgressIndicator());
              } else {
                return (ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      var shoppingData = snapshot.data.documents[index];
                      return ExpansionTile(
                        title: Text(shoppingData['event']),
                        subtitle: Row(children: <Widget>[
                          // Text(shoppingData['category']),
                          Text(shoppingData['item']),
                          Text(shoppingData['unit']),
                          Text(shoppingData['quantity'].toString()),
                        ],),
                      );
                    }));
              }
            }));
  }
}
