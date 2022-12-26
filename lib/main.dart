import 'package:cocktailer_project/pages/app.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( //여기서 전체적인 값을 지정가능
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}