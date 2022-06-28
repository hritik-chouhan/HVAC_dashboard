import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'homePage.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

// void main() {
//   runApp(ProviderScope(
//     child:  MaterialApp(
//       home: MyHomePage(),
//     ),
//   ));
// }