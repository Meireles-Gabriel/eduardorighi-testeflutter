enum AgendamentoEnum {
  agendamento_e_hora,
  somente_agendamento,
  somente_na_hora,
  sem_agendamento;

  static AgendamentoEnum fromString(String value) {
    switch (value.toLowerCase()) {
      case 'agendamento_e_hora':
        return AgendamentoEnum.agendamento_e_hora;
      case 'somente_agendamento':
        return AgendamentoEnum.somente_agendamento;
      case 'somente_na_hora':
        return AgendamentoEnum.somente_na_hora;
      case 'sem_agendamento':
        return AgendamentoEnum.sem_agendamento;
      default:
        throw Exception('Tipo de agendamento inválido: $value');
    }
  }

  String get name {
    switch (this) {
      case AgendamentoEnum.agendamento_e_hora:
        return 'agendamento_e_hora';
      case AgendamentoEnum.somente_agendamento:
        return 'somente_agendamento';
      case AgendamentoEnum.somente_na_hora:
        return 'somente_na_hora';
      case AgendamentoEnum.sem_agendamento:
        return 'sem_agendamento';
    }
  }
}
