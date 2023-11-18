import 'package:Autosmart/src/login.dart';

import 'package:flutter/material.dart';

void main() => runApp(const Autosmart_App());

class Autosmart_App extends StatelessWidget {
  const Autosmart_App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoSmart',
      home: Autosmart_LoginForm(),
    );
  }
}
