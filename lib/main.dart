import 'package:flutter/material.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:todo_list_hive/welcome.dart';

void main() async {
  //iniit
  await Hive.initFlutter();
  //open box
  await Hive.openBox("Mybox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      home: Welcome());
  }
}
