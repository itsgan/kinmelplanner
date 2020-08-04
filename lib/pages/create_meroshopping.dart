import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merokinmel_planner/widgets/item_details.dart';

class CreateMeroShoppingList extends StatefulWidget {
  @override
  _CreateMeroShoppingListState createState() => _CreateMeroShoppingListState();
}

class _CreateMeroShoppingListState extends State<CreateMeroShoppingList> {

  List<String>dataUnits=[];
  String units;
  Firestore firestore = Firestore.instance;

@override
  void initState() {
    super.initState();
    setState(() {
      firestore.collection('units').getDocuments().then((value){
        value.documents.forEach((element){
          setState(() {
            dataUnits.add(element.documentID);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(title: Text('Mero Shopping List')),
            body: StreamBuilder(
              stream: firestore.collection('categories').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text('...loading..');
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        var myData = snapshot.data.documents[index];
                        return ExpansionTile(
                          title: Text(myData['categoryName'].toString()),
                          children: [
                            StreamBuilder(
                                stream: firestore
                                    .collection(
                                        "/categories/${myData['categoryName']}/${myData['categoryName']}")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text('...loadng...');
                                  } else {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount:
                                            snapshot.data.documents.length,
                                        itemBuilder: (context, index) {
                                          var data =
                                              snapshot.data.documents[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return SimpleDialog(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  data['itemName'] +
                                                                      ' details',
                                                                  textScaleFactor:
                                                                      1.5,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .caption,
                                                                ),
                                                              ),
                                                              ShoppingItem(
                                                                itemName: data[
                                                                    'itemName'],
                                                              )
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      final snackbar = SnackBar(
                                                          content: Row(
                                                        children: <Widget>[
                                                          Icon(Icons.thumb_up),
                                                          Text(
                                                              'Your data is saved'),
                                                        ],
                                                      ));
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              snackbar);
                                                    },
                                                    child:
                                                        Text(data['itemName'])),
                                                SizedBox(height: 10)
                                              ],
                                            ),
                                          );
                                        });
                                  }
                                })
                          ],
                        );
                      });
                }
              },
            ));
      },
    );
  }
}
