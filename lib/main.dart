import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/pages/home_page.dart';

void main() async {
  //init the hive
  await Hive.initFlutter();
  //open a box
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoApp',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          toolbarHeight: 200,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
