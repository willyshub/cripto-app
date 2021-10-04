import 'package:cripto_api_flutter/app_widget.dart';
import 'package:cripto_api_flutter/repository/coin_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinRepository>(
          create: (context) => CoinRepository(),
        )
      ],
      child: AppWidget(),
    );
  }
}
