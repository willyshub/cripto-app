import 'package:cripto_api_flutter/view/pages/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CriptoApp',
      theme: ThemeData(
        primaryColor: Colors.pink[900],
      ),
      home: HomePage(),
    );
  }
}
