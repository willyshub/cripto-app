import 'package:flutter/material.dart';

class CoinModel {
  CoinModel({
    required this.id,
    required this.icone,
    required this.nome,
    required this.sigla,
    required this.preco,
    required this.description,
    required this.color,
  });
  String id;
  String icone;
  String nome;
  String sigla;
  String preco;
  String description;
  String color;
}
