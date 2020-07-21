import 'package:flutter/material.dart';
import 'package:merokinmel_planner/pages/about.dart';

class AboutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(child:Text('About'), onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
    },
      
    );
  }
}