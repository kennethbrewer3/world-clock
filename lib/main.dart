import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:world_clock/data/clock_model.dart';
import 'package:world_clock/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ChangeNotifierProvider<ClockModel>(
        builder: (context) => ClockModel(),
        child: HomePage(title: 'International Clock'),
      ),
    );
  }
}
