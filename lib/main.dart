// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:proy_taller/screens/loading.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
  
}