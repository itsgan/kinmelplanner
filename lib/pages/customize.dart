import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merokinmel_planner/pages/add_items.dart';
import 'package:merokinmel_planner/provider/theme_block.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CustomSetting extends StatefulWidget {
  @override
  _CustomSettingState createState() => _CustomSettingState();
}

class _CustomSettingState extends State<CustomSetting> {
  GlobalKey<FormState> key1 = GlobalKey<FormState>();
  GlobalKey<FormState> key2 = GlobalKey<FormState>();
  GlobalKey<FormState> key3 = GlobalKey<FormState>();
  TextEditingController unit = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController location = TextEditingController();

  Firestore firestore = Firestore.instance;

  addUnit(String unitsName) {
    firestore.collection('units').document(unitsName).setData({
      'unit': unit.text,
    });
  }

  addCategory(String categoryName) {
    firestore
        .collection('categories')
        .document(categoryName)
        .setData({'categoryName': category.text});
  }

  addLocation(String locationName) {
    firestore
        .collection('location')
        .document(locationName)
        .setData({'location': location.text});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeBlock themeBlock = Provider.of<ThemeBlock>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Customize')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Form(
                key: key1,
                child: Row(children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: location,
                      decoration: InputDecoration(labelText: 'Location'),
                      validator: (value) =>
                          value.isEmpty ? 'This Field can not be empty' : null,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                      width: 75,
                      child: RaisedButton(
                          child: Text('Add'),
                          onPressed: () {
                            if (key1.currentState.validate())
                              addLocation(location.text);
                            Toast.show('Your location has been added', context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.CENTER);
                            setState(() {
                              location.clear();
                            });
                          }))
                ]),
              ),
              Form(
                key: key2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: category,
                        decoration: InputDecoration(labelText: 'Category'),
                        validator: (value) => value.isEmpty
                            ? 'This field can not be empty'
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                        width: 75,
                        child: RaisedButton(
                            child: Text('Add'),
                            onPressed: () {
                              if (key2.currentState.validate()) {
                                addCategory(category.text);
                                Toast.show('Category has been added', context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.CENTER);
                                setState(() {
                                  category.clear();
                                });
                              }
                            }))
                  ],
                ),
              ),
              Form(
                key: key3,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: unit,
                        decoration: InputDecoration(labelText: 'Unit'),
                        validator: (value) => value.isEmpty
                            ? 'This field can not be empty'
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                        width: 75,
                        child: RaisedButton(
                            child: Text('Add'),
                            onPressed: () {
                              if (key3.currentState.validate()) {
                                addUnit(unit.text);
                                Toast.show('Your Unit has been added', context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.CENTER);
                                setState(() {
                                  unit.clear();
                                });
                              }
                            }))
                  ],
                ),
                
              ),
              SizedBox(height:10),
              RaisedButton(child:Text('Add Multiple Items'),onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddItemsList()));
              }),
              ListTile(
                title: Text('Enable Dark Theme'),
                trailing: Switch(
                    value: themeBlock.isDarkThemeEnabled,
                    onChanged: (bool value) {
                      themeBlock.enableDarkTheme(value);
                    }),
              )
            ],
          ),
        ));
  }
}
