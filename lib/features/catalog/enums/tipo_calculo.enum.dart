enum TipoCalculoEnum {
  maior,
  media,
  soma;

  String get name {
    switch (this) {
      case TipoCalculoEnum.maior:
        return 'maior';
      case TipoCalculoEnum.media:
        return 'media';
      case TipoCalculoEnum.soma:
        return 'soma';
    }
  }
}
