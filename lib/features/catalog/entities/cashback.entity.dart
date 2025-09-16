import 'package:json_annotation/json_annotation.dart';

import 'dia_semana_cashback.entity.dart';

part 'cashback.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Cashback {
  @JsonKey(name: 'domingo')
  final DiaSemanaCashback domingo;

  @JsonKey(name: 'segunda')
  final DiaSemanaCashback segunda;

  @JsonKey(name: 'terca')
  final DiaSemanaCashback terca;

  @JsonKey(name: 'quarta')
  final DiaSemanaCashback quarta;

  @JsonKey(name: 'quinta')
  final DiaSemanaCashback quinta;

  @JsonKey(name: 'sexta')
  final DiaSemanaCashback sexta;

  @JsonKey(name: 'sabado')
  final DiaSemanaCashback sabado;

  const Cashback({
    required this.domingo,
    required this.segunda,
    required this.terca,
    required this.quarta,
    required this.quinta,
    required this.sexta,
    required this.sabado,
  });

  factory Cashback.fromJson(Map<String, dynamic> json) => _$CashbackFromJson(json);

  Map<String, dynamic> toJson() => _$CashbackToJson(this);
}
