import 'package:flag_mark/theme.dart';
import 'package:flag_mark/views/home/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlagMark',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: ThemeColors.lightGrey,
        cardColor: ThemeColors.lightNavy,
        canvasColor: ThemeColors.navy,
        textTheme: TextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
    );
  }
}
