import 'package:json_annotation/json_annotation.dart';

import 'turno.entity.dart';

part 'disponibilidade.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Disponibilidade {

  @JsonKey(name: 'sempre_disponivel')
  final bool sempreDisponivel;

  @JsonKey(name: 'dom')
  final bool dom;

  @JsonKey(name: 'seg')
  final bool seg;

  @JsonKey(name: 'ter')
  final bool ter;

  @JsonKey(name: 'qua')
  final bool qua;

  @JsonKey(name: 'qui')
  final bool qui;

  @JsonKey(name: 'sex')
  final bool sex;

  @JsonKey(name: 'sab')
  final bool sab;

  @JsonKey(name: 'ocultar_indisponivel')
  final bool? ocultarIndisponivel;

  @JsonKey(name: 'turno_1')
  final Turno? turno1;

  @JsonKey(name: 'turno_2')
  final Turno? turno2;

  @JsonKey(name: 'turno_3')
  final Turno? turno3;

  @JsonKey(name: 'turno_4')
  final Turno? turno4;

  const Disponibilidade({
    required this.sempreDisponivel,
    required this.dom,
    required this.seg,
    required this.ter,
    required this.qua,
    required this.qui,
    required this.sex,
    required this.sab,
    this.ocultarIndisponivel,
    this.turno1,
    this.turno2,
    this.turno3,
    this.turno4,
  });

  factory Disponibilidade.fromJson(Map<String, dynamic> json) {
    final turno1 = json['turno_1'] as Map<String, dynamic>?;
    final turno2 = json['turno_2'] as Map<String, dynamic>?;
    final turno3 = json['turno_3'] as Map<String, dynamic>?;
    final turno4 = json['turno_4'] as Map<String, dynamic>?;

    return Disponibilidade(
      sempreDisponivel: json['sempre_disponivel'],
      dom: json['dom'],
      seg: json['seg'],
      ter: json['ter'],
      qua: json['qua'],
      qui: json['qui'],
      sex: json['sex'],
      sab: json['sab'],
      ocultarIndisponivel: json['ocultar_indisponivel'],
      turno1: turno1 == null ? null : Turno.fromJson(turno1),
      turno2: turno2 == null ? null : Turno.fromJson(turno2),
      turno3: turno3 == null ? null : Turno.fromJson(turno3),
      turno4: turno4 == null ? null : Turno.fromJson(turno4),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sempre_disponivel'] = sempreDisponivel;
    data['dom'] = dom;
    data['seg'] = seg;
    data['ter'] = ter;
    data['qua'] = qua;
    data['qui'] = qui;
    data['sex'] = sex;
    data['sab'] = sab;
    data['ocultar_indisponivel'] = ocultarIndisponivel;
    if (turno1 != null) {
      data['turno_1'] = turno1!.toJson();
    }
    if (turno2 != null) {
      data['turno_2'] = turno2!.toJson();
    }
    if (turno3 != null) {
      data['turno_3'] = turno3!.toJson();
    }
    if (turno4 != null) {
      data['turno_4'] = turno4!.toJson();
    }
    return data;
  }
}
