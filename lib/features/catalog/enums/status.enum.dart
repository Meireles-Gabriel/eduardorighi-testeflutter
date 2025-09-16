import 'package:json_annotation/json_annotation.dart';

enum StatusEnum {
  @JsonValue('pausado')
  pausado,

  @JsonValue('indisponível')
  indisponivel,

  @JsonValue('esgotado')
  esgotado,

  @JsonValue('disponivel')
  disponivel,

  @JsonValue('novidade')
  novidade;

  factory StatusEnum.fromString(String value) {
    value = value.toLowerCase();
    switch (value) {
      case 'disponivel':
        return StatusEnum.disponivel;
      case 'esgotado':
        return StatusEnum.esgotado;
      case 'indisponível':
        return StatusEnum.indisponivel;
      case 'novidade':
        return StatusEnum.novidade;
      case 'pausado':
        return StatusEnum.pausado;
      default:
        return StatusEnum.disponivel;
    }
  }

  String get name {
    switch (this) {
      case StatusEnum.disponivel:
        return 'disponivel';
      case StatusEnum.esgotado:
        return 'esgotado';
      case StatusEnum.indisponivel:
        return 'indisponível';
      case StatusEnum.novidade:
        return 'novidade';
      case StatusEnum.pausado:
        return 'pausado';
    }
  }

  String get label {
    switch (this) {
      case StatusEnum.disponivel:
        return 'Disponível';
      case StatusEnum.esgotado:
        return 'Esgotado';
      case StatusEnum.indisponivel:
        return 'Indisponível';
      case StatusEnum.novidade:
        return 'Novidade';
      case StatusEnum.pausado:
        return 'Pausado';
    }
  }

  int get id {
    switch (this) {
      case StatusEnum.disponivel:
        return 0;
      case StatusEnum.esgotado:
        return 1;
      case StatusEnum.indisponivel:
        return 2;
      case StatusEnum.novidade:
        return 3;
      case StatusEnum.pausado:
        return 4;
    }
  }

  String get tooltip {
    switch (this) {
      case StatusEnum.disponivel:
        return 'Disponível para compra e visível no site.';
      case StatusEnum.esgotado:
        return 'Informa no site como “Esgotado”. Não altera o estoque.';
      case StatusEnum.indisponivel:
        return 'Informa no site como “Indisponível”. Não altera o estoque.';
      case StatusEnum.novidade:
        return 'Informa no site como “Novidade”. Disponível para compra e visível no site.';
      case StatusEnum.pausado:
        return 'Não visível no site. Não altera o estoque.';
    }
  }

  @override
  String toString() {
    switch (this) {
      case indisponivel:
        return 'indisponível';
      case StatusEnum.pausado:
        return 'pausado';
      case StatusEnum.novidade:
        return 'novidade';
      case StatusEnum.esgotado:
        return 'esgotado';
      case StatusEnum.disponivel:
        return 'disponivel';
    }
  }
}
