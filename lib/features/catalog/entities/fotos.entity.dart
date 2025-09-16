import 'package:json_annotation/json_annotation.dart';

part 'fotos.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class Foto {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'ordem')
  final int ordem;

  @JsonKey(name: 'url')
  final String url;

  const Foto({
    required this.id,
    required this.ordem,
    required this.url,
  });

  factory Foto.fromJson(Map<String, dynamic> json) => _$FotoFromJson(json);

  Map<String, dynamic> toJson() => _$FotoToJson(this);

}
