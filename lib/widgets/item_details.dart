import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merokinmel_planner/provider/events_block.dart';
import 'package:provider/provider.dart';

class ShoppingItem extends StatelessWidget {
  final String itemName;
  final Firestore firestore = Firestore.instance;

  ShoppingItem({this.itemName});
  String meroUnit;

  final GlobalKey<FormState> key = GlobalKey<FormState>();
  // final TextEditingController unit = TextEditingController();
  final TextEditingController quantity = TextEditingController();

  void addShoppingItem(String myEvent) {
    firestore.collection('meroShopping').add({
      'event': myEvent,
      'category': '',
      'item': itemName,
      'unit': meroUnit,
      'quantity': int.parse(quantity.text),
      'rate': '',
      'amount': '',
      'status': 'planned',
    });
  }

  @override
  Widget build(BuildContext context) {
    final EventBlock eventBlock = Provider.of<EventBlock>(context);
    return Container(
      width: 200,
      child: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                  value: eventBlock.selectedUnit,
                  isExpanded: true,
                  hint: Text('Select Unit'),
                  items: eventBlock.units.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    eventBlock.selectUnit(value);
                    meroUnit = value;
                    print(meroUnit);
                  }),
              
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (String value) =>
                    value.isEmpty ? 'This field can not be empty' : null,
                controller: quantity,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                      child: Text('Ok'),
                      onPressed: () {
                        if (key.currentState.validate()) {
                          addShoppingItem(eventBlock.isEventCreated);
                        }

                        print(itemName);
                        //operation code
                        Navigator.pop(context);
                      }),
                  SizedBox(width: 6),
                  RaisedButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
