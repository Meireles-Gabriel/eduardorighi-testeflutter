import 'package:json_annotation/json_annotation.dart';

part 'dia_semana_cashback.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class DiaSemanaCashback {
  @JsonKey(name: 'ativo_delivery')
  final bool ativoDelivery;

  @JsonKey(name: 'ativo_nolocal')
  final bool ativoNolocal;

  @JsonKey(name: 'porcentagem_delivery')
  final double porcentagemDelivery;

  @JsonKey(name: 'porcentagem_nolocal')
  final int porcentagemNolocal;

  @JsonKey(name: 'regra_id_delivery')
  final int regraIdDelivery;

  @JsonKey(name: 'regra_id_nolocal')
  final int? regraIdNolocal;

  @JsonKey(name: 'prazo_delivery')
  final int prazoDelivery;

  @JsonKey(name: 'prazo_nolocal')
  final int prazoNolocal;

  const DiaSemanaCashback({
    required this.ativoDelivery,
    required this.ativoNolocal,
    required this.porcentagemDelivery,
    required this.porcentagemNolocal,
    required this.regraIdDelivery,
    this.regraIdNolocal,
    required this.prazoDelivery,
    required this.prazoNolocal,
  });

  factory DiaSemanaCashback.fromJson(Map<String, dynamic> json) => _$DiaSemanaCashbackFromJson(json);

  Map<String, dynamic> toJson() => _$DiaSemanaCashbackToJson(this);

}
