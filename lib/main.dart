import 'package:flutter/material.dart';
import 'package:merokinmel_planner/pages/home.dart';
import 'package:merokinmel_planner/provider/counter_block.dart';
import 'package:merokinmel_planner/provider/events_block.dart';
import 'package:merokinmel_planner/provider/theme_block.dart';
import 'package:provider/provider.dart';

// void main()=>runApp(MyApp());
void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CounterBlock()),
        ChangeNotifierProvider.value(value: ThemeBlock()),
        ChangeNotifierProvider.value(value: EventBlock()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeBlock>(builder: (context, data, child) {
      return MaterialApp(
          title: 'Kinmel Planner',
          debugShowCheckedModeBanner: false,
          theme: data.isDarkThemeEnabled == true
              ? ThemeData.dark()
              : ThemeData.light(),
          home: HomePage());
    });
  }
}
