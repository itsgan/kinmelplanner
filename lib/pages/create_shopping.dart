import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CreateShoppingList extends StatefulWidget {
  @override
  _CreateShoppingListState createState() => _CreateShoppingListState();
}

class _CreateShoppingListState extends State<CreateShoppingList> {
  GlobalKey<FormState> key = GlobalKey();
  // TextEditingController event = TextEditingController();
  // TextEditingController category = TextEditingController();
  TextEditingController item = TextEditingController();
  // TextEditingController unit = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController user = TextEditingController();
  TextEditingController price = TextEditingController();
  List<String> unitList = List<String>();
  List<String> dataCategory = [];
  List<String> dataEvent = [];
  List<String> dataUnits = [];
  String category;
  String unit;
  String event;

  Firestore firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    setState(() {
      firestore.collection('categories').getDocuments().then((value) {
        value.documents.forEach((element) {
          setState(() {
            dataCategory.add(element.data['category']);
          });
        });
      });

      firestore.collection('events').getDocuments().then((value) {
        value.documents.forEach((element) {
          setState(() {
            dataEvent.add(element.data['event']);
          });
        });
      });

      firestore.collection('units').getDocuments().then((value) {
        value.documents.forEach((element) {
          setState(() {
            dataUnits.add(element.data['unit']);
          });
        });
      });
    });
  }

  createMeroShoppingList() {
    firestore.collection('shopping').document().setData({
      "event": event,
      "category": category,
      "item": item.text,
      "unit": unit,
      "quantity": quantity.text,
      "price": price.text,
      "user": user.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Shopping List')),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DropdownButton<String>(
                    value: event,
                    hint: Text('Event'),
                    isExpanded: true,
                    items: dataEvent.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        this.event = value;
                      });
                    }),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                    value: category,
                    hint: Text('Cateogry'),
                    isExpanded: true,
                    items: dataCategory.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        this.category = value;
                      });
                    }),
                TextFormField(
                  controller: item,
                  decoration: InputDecoration(labelText: 'Item'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('This field can not be empty, Please select the item');
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton(
                    // value: unit,
                    hint: Text('Unit'),
                    value:unit,
                    isExpanded: true,
                    items: dataUnits.map((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        this.unit = value;
                      });
                    }),
                TextFormField(
                  controller: quantity,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('This field can not be empty, Please select the category');
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: price,
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('This field can not be empty, Please input the Price');
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: user,
                  decoration: InputDecoration(labelText: 'Purchaser'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ('This field can not be empty, Please select the purchaser');
                    } else {
                      return null;
                    }
                  },
                ),
                RaisedButton(
                    child: Text('Create List'),
                    onPressed: () {
                      if (key.currentState.validate()) {
                        createMeroShoppingList();
                        Toast.show(
                            'Your Shopping List has been created', context,
                            gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);

                        setState(() {
                          // event.clear();
                          // category.clear();
                          item.clear();
                          // unit.clear();
                          quantity.clear();
                          price.clear();
                          user.clear();
                        });
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
