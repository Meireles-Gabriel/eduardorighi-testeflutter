enum PrecoPrefixEnum {
    a_partir,
    EMPTY;

      String get name {
    switch (this) {
      case PrecoPrefixEnum.a_partir:
        return 'a_partir';
      case PrecoPrefixEnum.EMPTY:
        return '';
    }
  }
}