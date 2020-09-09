import 'package:flutter/material.dart';
import 'package:aula3/page1.dart';
import 'package:aula3/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: myTheme,
      home: Page1(),
    );
  }
}
