import 'package:flutter/material.dart';

class MeroDatePicker extends StatefulWidget {
  @override
  _MeroDatePickerState createState() => _MeroDatePickerState();
}

class _MeroDatePickerState extends State<MeroDatePicker> {
  DateTime meroDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(meroDate == null
                  ? 'Please pick a date'
                  : meroDate.toString().split(' ').first ),
              RaisedButton(
                  child: Text('Select Date'),
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2050),)
                        .then((value){
                          setState(() {
                            meroDate=value;
                          });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
