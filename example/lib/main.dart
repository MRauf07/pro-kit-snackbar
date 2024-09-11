import 'package:example/snackbar_demo.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: SnackBarDemo()
    );
  }
}
