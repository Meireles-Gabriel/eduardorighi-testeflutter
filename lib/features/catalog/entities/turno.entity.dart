import 'package:json_annotation/json_annotation.dart';

part 'turno.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Turno {
  
  @JsonKey(name: 'ativo')
  final bool ativo;

  @JsonKey(name: 'inicio')
  final String inicio;

  @JsonKey(name: 'fim')
  final String fim;

  const Turno({
    required this.ativo,
    required this.inicio,
    required this.fim,
  });

  factory Turno.fromJson(Map<String, dynamic> json) {
    return Turno(
      ativo: json['ativo'],
      inicio: json['inicio'],
      fim: json['fim'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ativo'] = ativo;
    data['inicio'] = inicio;
    data['fim'] = fim;
    return data;
  }
}
