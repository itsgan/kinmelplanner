import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  DateTime dob;
  String gender = 'Male';
  List<String> genderList = ['Male', 'Female', 'Others'];
  GlobalKey<FormState> key = GlobalKey();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  // TextEditingController gender = TextEditingController();
  // TextEditingController dob = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController photo = TextEditingController();
  TextEditingController status = TextEditingController();

  Firestore firestore = Firestore.instance;

  createUser() {
    firestore.collection('user').document().setData({
      'userID': id.text,
      'userName': name.text,
      'userGender': gender,
      'userDOB': dob,
      'userMobile': mobile.text,
      'userEmail': email.text,
      'userPhoto': photo.text,
      'userStatus': "Active",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('User Registration')),
        body: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: id,
                    decoration: InputDecoration(labelText: 'User ID'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ('This field can not be empty, Please input your User ID');
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ('This field can not be empty, Please input your name');
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Text('Gender'),
                      DropdownButton(
                          value: gender,
                          items: genderList.map((String myGender) {
                            return DropdownMenuItem(
                                value: myGender, child: Text(myGender));
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              gender = value;
                            });
                          })
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(dob == null
                          ? 'Please select your DOB'
                          : dob.toString().split(' ').first),
                      RaisedButton(
                          child: Text('...'),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: dob == null ? DateTime.now() : dob,
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              setState(() {
                                dob = value;
                              });
                            });
                          })
                    ],
                  ),
                  TextFormField(
                    controller: mobile,
                    decoration: InputDecoration(labelText: 'Mobile'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ('This field can not be empty, Please input your mobile number');
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(labelText: 'E-mail'),
                  ),
                  TextFormField(
                    controller: photo,
                    decoration: InputDecoration(labelText: 'Photo'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return ('This field can not be empty, Please input your name');
                      } else {
                        return null;
                      }
                    },
                  ),
                  RaisedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        if (key.currentState.validate()) {
                          createUser();
                          Toast.show(
                              'Your form has been successfully submitted',
                              context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.CENTER);

                        }
                      })
                ],
              ),
            )));
  }
}
