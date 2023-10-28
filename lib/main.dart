import 'package:Autosmart/src/login.dart';

import 'package:flutter/material.dart';

void main() => runApp(Autosmart_App());

class Autosmart_App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Autosmart',
      home: Autosmart_LoginForm(),
    );
  }
}
