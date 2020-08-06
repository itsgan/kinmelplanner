import 'dart:io';

import 'package:flutter/material.dart';

import 'package:merokinmel_planner/pages/create_event.dart';
import 'package:merokinmel_planner/pages/create_meroshopping.dart';

import 'package:merokinmel_planner/pages/create_user.dart';
import 'package:merokinmel_planner/pages/customize.dart';
import 'package:merokinmel_planner/pages/purchase_items.dart';
import 'package:merokinmel_planner/provider/events_block.dart';
import 'package:merokinmel_planner/provider/theme_block.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final EventBlock eventBlock = Provider.of<EventBlock>(context);
    final ThemeBlock themeBlock = Provider.of<ThemeBlock>(context);
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(eventBlock.accountName),
          accountEmail: Text(eventBlock.email),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(eventBlock.image),
          ),
        ),
        ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateUser()));
            },
            leading: Icon(Icons.person),
            title: Text('Create User')),
        ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateEvent()));
            },
            leading: Icon(Icons.event),
            title: Text('Create Event')),
        ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateMeroShoppingList()));
            },
            leading: Icon(Icons.note),
            title: Text('Create Shopping List')),
        ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PurchaseItems()));
          },
          leading: Icon(Icons.shopping_cart), title: Text('Update Shopping Items')),
        ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomSetting()));
            },
            leading: Icon(Icons.settings),
            title: Text('Customize')),
        ListTile(
            onTap: () {
              exit(0);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text('Quit')),
        ListTile(
          title: Text('Dark Theme'),
          trailing: Switch(
              value: themeBlock.isDarkThemeEnabled,
              onChanged: (bool value) {
                themeBlock.enableDarkTheme(value);
              }),
        )
      ],
    ));
  }
}
