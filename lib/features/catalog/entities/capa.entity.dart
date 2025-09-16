import 'package:json_annotation/json_annotation.dart';

import '../enums/tipo.enum.dart';

@JsonSerializable(
  explicitToJson: true,
)
abstract class Capa {
  @JsonKey(name: 'tipo')
  final TipoEnum tipo;

  Capa(this.tipo);

  factory Capa.fromJson(Map<String, dynamic> json) {
    final tipo = TipoEnum.fromString(json['tipo']);

    switch (tipo) {
      case TipoEnum.PADRAO:
        return CapaPadrao();
      case TipoEnum.IMAGEM:
        return CapaImagem(
          defaultUrl: json['default'],
          corFonteDefault: json['cor_fonte_default'],
          mobile: json['mobile'],
          corFonteMobile: json['cor_fonte_mobile'],
        );
      case TipoEnum.COR:
        return CapaCor(
          corFundo: json['cor_fundo'],
          corFonte: json['cor_fonte'],
        );
      case TipoEnum.EMPTY:
        return CapaPadrao();
    }
  }

  Map<String, dynamic> toJson();
}

@JsonSerializable(
  explicitToJson: true,
)
class CapaPadrao extends Capa {
  CapaPadrao() : super(TipoEnum.PADRAO);

  @override
  Map<String, dynamic> toJson() => {
        'tipo': tipo.name,
      };
}

@JsonSerializable(
  explicitToJson: true,
)
class CapaImagem extends Capa {
  @JsonKey(name: 'default')
  final String? defaultUrl;

  @JsonKey(name: 'cor_fonte_default')
  final String? corFonteDefault;

  @JsonKey(name: 'mobile')
  final String? mobile;

  @JsonKey(name: 'cor_fonte_mobile')
  final String? corFonteMobile;

  CapaImagem({
    required this.defaultUrl,
    required this.corFonteDefault,
    required this.mobile,
    required this.corFonteMobile,
  }) : super(TipoEnum.IMAGEM);

  @override
  Map<String, dynamic> toJson() => {
        'tipo': tipo.name,
        'default': defaultUrl,
        'cor_fonte_default': corFonteDefault,
        'mobile': mobile,
        'cor_fonte_mobile': corFonteMobile,
      };
}

@JsonSerializable(
  explicitToJson: true,
)
class CapaCor extends Capa {
  @JsonKey(name: 'cor_fundo')
  final String corFundo;

  @JsonKey(name: 'cor_fonte')
  final String corFonte;

  CapaCor({
    required this.corFundo,
    required this.corFonte,
  }) : super(TipoEnum.COR);

  @override
  Map<String, dynamic> toJson() => {
        'tipo': tipo.name,
        'cor_fundo': corFundo,
        'cor_fonte': corFonte,
      };
}
