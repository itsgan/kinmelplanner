// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class PhotoCamera extends StatefulWidget {
//   Firestore firestore = Firestore.instance;

//   @override
//   _PhotoCameraState createState() => _PhotoCameraState();
// }

// class _PhotoCameraState extends State<PhotoCamera> {
// //Get Image
// // final picker = ImagePicker();
// // File image;
// // Future getImage() async {
// // final file = await picker.getImage(source: ImageSource.gallery);
// // setState(() {
// //   image = file(pickedFile.path);
// // });

// // }

// Future getCamera() async {
//   var photo = await picker.getImage(source: ImageSource.camera);
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:Text('Photo')),
//       body:Column(children: <Widget>[
//         FloatingActionButton(onPressed: (){getImage();}, child: Icon(Icons.image, color: Colors.redAccent,),),
//         FloatingActionButton(onPressed: (){getCamera();}, child: Icon(Icons.photo_camera, color:Colors.red),)
//       ],)
      
//     );
//   }
// }