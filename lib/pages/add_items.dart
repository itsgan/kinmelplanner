import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItemsList extends StatefulWidget {
  @override
  _AddItemsListState createState() => _AddItemsListState();
}

class _AddItemsListState extends State<AddItemsList> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController item = TextEditingController();
  List<String> dataCategory = [];
  String category;

  Firestore firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();

    setState(() {
      firestore.collection('categories').getDocuments().then((value) {
        value.documents.forEach((element) {
          setState(() {
            dataCategory.add(element.documentID);
          });
        });
      });
    });

    setState(() {
      category = 'Dairy';
    });
  }

  void addItem(String itemsName) {
    firestore
        .collection('/categories/$category/$category').document(itemsName)
        .setData({"categoryName": category, "itemName": item.text});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Item List')),
      body: Builder(builder: (context){
return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                Container(
                  child: DropdownButton<String>(
                      value: category,
                      hint: Text('Select Category'),
                      isExpanded: true,
                      items: dataCategory.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          this.category = value;
                        });
                      }),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Item Name', border: OutlineInputBorder()),
                  validator: (String value) => value.isEmpty
                      ? 'This Field can not be empty, Type Item Name'
                      : null,
                  controller: item,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                    child: Text('Add Item'),
                    onPressed: () {
                      if (key.currentState.validate()) {
                        addItem(item.text);
                        setState(() {
                          item.clear();
                        });
                      }
                      SnackBar mySnackBar = SnackBar(content: Text('Your item has been added'));
                      Scaffold.of(context).showSnackBar(mySnackBar);
                    })
              ],
            )),
      );
      })
    );
  }
}
