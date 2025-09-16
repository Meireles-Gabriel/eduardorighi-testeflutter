enum MetodoRegrasAgendamentoEnum {
  loja,
  produto;

  String get name {
    switch (this) {
      case MetodoRegrasAgendamentoEnum.loja:
        return 'loja';
      case MetodoRegrasAgendamentoEnum.produto:
        return 'produto';
    }
  }
}
