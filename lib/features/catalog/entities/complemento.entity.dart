import 'package:json_annotation/json_annotation.dart';
import 'package:teste_flutter/utils/extension_methos/extension_methods.dart';

import '../enums/status.enum.dart';

part 'complemento.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Complemento {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'nome')
  final String nome;

  @JsonKey(name: 'preco')
  double preco;

  @JsonKey(name: 'status')
  final StatusEnum status;

  @JsonKey(name: 'ordem')
  final int ordem;

  @JsonKey(name: 'qtd_minima')
  final int qtdMinima;

  @JsonKey(name: 'qtd_maxima')
  final int qtdMaxima;

  @JsonKey(name: 'foto_principal')
  final String? fotoPrincipal;

  @JsonKey(name: 'unidade_medida')
  final String unidadeMedida;

  Complemento({
    required this.id,
    required this.nome,
    required this.preco,
    required this.status,
    required this.ordem,
    required this.qtdMinima,
    required this.qtdMaxima,
    required this.fotoPrincipal,
    required this.unidadeMedida,
  });

  factory Complemento.fromJson(Map<String, dynamic> json) =>
      _$ComplementoFromJson(json);

  Map<String, dynamic> toJson() => _$ComplementoToJson(this);

  String get sortingName => nome.toLowerCase().removeDiacritics();

  void setPreco(double preco) {
    this.preco = preco;
  }
}
