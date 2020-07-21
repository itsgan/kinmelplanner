import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DroupDoun extends StatefulWidget {
  @override
  _DroupDounState createState() => _DroupDounState();
}

class _DroupDounState extends State<DroupDoun> {
  Firestore firestore = Firestore.instance;
  List<String> dataCategory = [];
  String selectetCategory = 'Vegetable';
  List<String> dataUnits = [];
  String selectedUnit = 'KG';

  @override
  void initState() {
    super.initState();
    setState(() {
      firestore.collection('categories').getDocuments().then((value) {
        value.documents.forEach((element) {
          setState(() {
            dataCategory.add(element.data["category"]);
          });
        });
      });

      firestore.collection('units').getDocuments().then((value) {
        value.documents.forEach((element) {
          setState(() {
            dataUnits.add(element.data["unit"]);
          });
        });
      });
    });

    print(dataCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('')),
        body: Column(
          children: <Widget>[
            Text('My Dropdown'),
            DropdownButton<String>(
                value: selectetCategory,
                isExpanded: true,
                underline: SizedBox(),
                items: dataCategory.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    this.selectetCategory = value;
                  });
                }),
            DropdownButton<String>(
                value: selectedUnit,
                isExpanded: true,
                underline: SizedBox(),
                items: dataUnits.map((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    this.selectedUnit = value;
                  });
                }),
          ],
        ));
  }
}
