enum TipoEnum {
  COR,
  IMAGEM,
  PADRAO,
  EMPTY;

  static TipoEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'padrao':
        return TipoEnum.PADRAO;
      case 'imagem':
        return TipoEnum.IMAGEM;
      case 'cor':
        return TipoEnum.COR;
      default:
        return TipoEnum.EMPTY;
        // throw Exception('Tipo de capa inválido: $value');
    }
  }

  String get name {
    switch (this) {
      case TipoEnum.COR:
        return 'cor';
      case TipoEnum.IMAGEM:
        return 'imagem';
      case TipoEnum.PADRAO:
        return 'padrao';
      case TipoEnum.EMPTY:
        return '';
    }
  }
}
