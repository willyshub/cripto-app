import 'dart:convert';

import 'package:cripto_api_flutter/models/coin_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CoinRepository extends ChangeNotifier {
  CoinRepository() {
    _setupDataTable();
  }

  static CoinRepository instance = CoinRepository();

  List<CoinModel> _table = [];
  List<CoinModel> get table => _table;

  get getSetupDataTable => _setupDataTable();

  Future<void> _setupDataTable() async {
    final uri =
        Uri.parse('https://api.coinbase.com/v2/assets/search?base=BRL');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = await jsonDecode(response.body);

      List<dynamic> coinsInternal = json['data'];

      coinsInternal.forEach((coin) {
        table.add(CoinModel(
          id: coin['id'],
          icone: coin['image_url'],
          nome: coin['name'],
          sigla: coin['symbol'],
          preco: coin['latest'],
          color: coin['color'],
          description: coin['description'] ?? "Não tem descrição",
        ));
      });
    }
    notifyListeners();
  }
}
