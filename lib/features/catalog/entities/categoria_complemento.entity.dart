// ignore_for_file: unnecessary_null_comparison

import 'package:json_annotation/json_annotation.dart';

import 'complemento.entity.dart';
import '../enums/tipo_calculo.enum.dart';

part 'categoria_complemento.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class CategoriaComplemento {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'nome')
  final String nome;

  @JsonKey(name: 'ordem')
  final int ordem;

  @JsonKey(name: 'obrigatorio')
  final bool obrigatorio;

  @JsonKey(name: 'qtd_minima')
  final int qtdMinima;

  @JsonKey(name: 'qtd_maxima')
  final int qtdMaxima;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'tipo_calculo')
  final TipoCalculoEnum tipoCalculo;

  @JsonKey(name: 'buscar_complementos')
  final bool buscarComplementos;

  @JsonKey(name: 'complementos')
  final List<Complemento> complementos;

  const CategoriaComplemento({
    required this.id,
    required this.nome,
    required this.ordem,
    required this.obrigatorio,
    required this.qtdMinima,
    required this.qtdMaxima,
    required this.status,
    required this.tipoCalculo,
    required this.buscarComplementos,
    required this.complementos,
  });

  factory CategoriaComplemento.fromJson(Map<String, dynamic> json) =>
      _$CategoriaComplementoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriaComplementoToJson(this);

  int get totalComplementos => complementos.length;
}
