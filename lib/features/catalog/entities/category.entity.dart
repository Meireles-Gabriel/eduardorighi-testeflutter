import 'package:json_annotation/json_annotation.dart';

import 'capa.entity.dart';
import 'disponibilidade.entity.dart';
import '../enums/status.enum.dart';
import 'item_categoria.entity.dart';

part 'category.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Categoria {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'nome')
  final String? nome;

  @JsonKey(name: 'descricao')
  final String? descricao;

  @JsonKey(name: 'disponibilidade')
  final Disponibilidade? disponibilidade;

  @JsonKey(name: 'capa')
  final Capa? capa;

  @JsonKey(name: 'status')
  final StatusEnum? status;

  @JsonKey(name: 'ordem')
  final int? ordem;

  @JsonKey(name: 'itens')
  final List<ItemCategoria>? itens;

  const Categoria({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.disponibilidade,
    required this.capa,
    required this.status,
    required this.ordem,
    required this.itens,
  });
  factory Categoria.fromJson(Map<String, dynamic> json) =>
      _$CategoriaFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriaToJson(this);

  int get totalItens => itens?.length ?? 0;
}
