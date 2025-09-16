import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:teste_flutter/utils/extension_methos/extension_methods.dart';

import 'cashback.entity.dart';
import 'categoria_complemento.entity.dart';
import 'disponibilidade.entity.dart';
import '../enums/agendamento.enum.dart';
import '../enums/preco_prefix.enum.dart';
import '../enums/status.enum.dart';
import 'fotos.entity.dart';

part 'item_categoria.entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
class ItemCategoria {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'nome')
  final String nome;

  @JsonKey(name: 'nome_normalizado')
  final String nomeNormalizado;

  @JsonKey(name: 'descricao')
  final String? descricao;

  @JsonKey(name: 'preco_prefix')
  final PrecoPrefixEnum precoPrefix;

  @JsonKey(name: 'preco')
  double preco;

  @JsonKey(name: 'preco_promocional')
  double precoPromocional;

  @JsonKey(name: 'preco_com_complementos')
  double precoComComplementos;

  @JsonKey(name: 'preco_promocional_com_complementos')
  final double precoPromocionalComComplementos;

  @JsonKey(name: 'porcentagem_promocional')
  int porcentagemPromocional;

  @JsonKey(name: 'status_promocao_complementos')
  final bool statusPromocaoComplementos;

  @JsonKey(name: 'status_promocao')
  bool statusPromocao;

  @JsonKey(name: 'tipo_entrega')
  final bool tipoEntrega;

  @JsonKey(name: 'tipo_retirada')
  final bool tipoRetirada;

  @JsonKey(name: 'tipo_consumo')
  final bool tipoConsumo;

  @JsonKey(name: 'is_maior_de_idade')
  final bool isMaiorDeIdade;

  @JsonKey(name: 'somente_por_pontos')
  final bool somentePorPontos;

  @JsonKey(name: 'disponivel_por_pontos')
  final bool disponivelPorPontos;

  @JsonKey(name: 'disponivel_delivery')
  final bool disponivelDelivery;

  @JsonKey(name: 'disponivel_nolocal')
  final bool disponivelNolocal;

  @JsonKey(name: 'disponivel_marketplace')
  final bool disponivelMarketplace;

  @JsonKey(name: 'ocultar_indisponivel')
  final bool ocultarIndisponivel;

  @JsonKey(name: 'valor_pontos')
  final int valorPontos;

  @JsonKey(name: 'mostrar_observacao')
  final bool mostrarObservacao;

  @JsonKey(name: 'status')
  final StatusEnum? status;

  @JsonKey(name: 'agendamento')
  final AgendamentoEnum? agendamento;

  @JsonKey(name: 'foto_principal')
  final String? fotoPrincipal;

  @JsonKey(name: 'fotos')
  final List<Foto> fotos;

  @JsonKey(name: 'disponibilidade')
  final Disponibilidade disponibilidade;

  @JsonKey(name: 'multiplicador')
  final int multiplicador;

  @JsonKey(name: 'qtd_minima')
  final int qtdMinima;

  @JsonKey(name: 'qtd_maxima')
  final int qtdMaxima;

  @JsonKey(name: 'cashback')
  final Cashback? cashback;

  @JsonKey(name: 'categoria_id')
  final int categoriaId;

  @JsonKey(name: 'resumo_updated_at')
  final String resumoUpdatedAt;

  @JsonKey(name: 'carrinho_quick_add')
  final bool carrinhoQuickAdd;

  @JsonKey(name: 'ordem')
  final int ordem;

  @JsonKey(name: 'categorias_complementos')
  final List<CategoriaComplemento> categoriasComplementos;

  ItemCategoria({
    required this.id,
    required this.nome,
    required this.nomeNormalizado,
    required this.descricao,
    required this.precoPrefix,
    required this.preco,
    required this.precoPromocional,
    required this.precoComComplementos,
    required this.precoPromocionalComComplementos,
    required this.porcentagemPromocional,
    required this.statusPromocaoComplementos,
    required this.statusPromocao,
    required this.tipoEntrega,
    required this.tipoRetirada,
    required this.tipoConsumo,
    required this.isMaiorDeIdade,
    required this.somentePorPontos,
    required this.disponivelPorPontos,
    required this.disponivelDelivery,
    required this.disponivelNolocal,
    required this.disponivelMarketplace,
    required this.ocultarIndisponivel,
    required this.valorPontos,
    required this.mostrarObservacao,
    required this.status,
    required this.agendamento,
    required this.fotoPrincipal,
    required this.fotos,
    required this.disponibilidade,
    required this.multiplicador,
    required this.qtdMinima,
    required this.qtdMaxima,
    required this.cashback,
    required this.categoriaId,
    required this.resumoUpdatedAt,
    required this.carrinhoQuickAdd,
    required this.ordem,
    required this.categoriasComplementos,
  });

  factory ItemCategoria.fromJson(Map<String, dynamic> json) {
    final cashback = json['cashback'] as Map<String, dynamic>?;

    return ItemCategoria(
      id: json['id'],
      nome: json['nome'],
      nomeNormalizado: json['nome_normalizado'],
      descricao: json['descricao'] ?? '',
      precoPrefix: PrecoPrefixEnum.values
          .firstWhere(((p) => p.name == json['preco_prefix'])),
      preco: (json['preco'] as int).fromCents(),
      precoPromocional: (json['preco_promocional'] as int).fromCents(),
      precoComComplementos: (json['preco_com_complementos'] as int).fromCents(),
      precoPromocionalComComplementos:
          (json['preco_promocional_com_complementos'] as int).fromCents(),
      porcentagemPromocional: json['porcentagem_promocional'],
      statusPromocaoComplementos: json['status_promocao_complementos'],
      statusPromocao: json['status_promocao'],
      tipoEntrega: json['tipo_entrega'],
      tipoRetirada: json['tipo_retirada'],
      tipoConsumo: json['tipo_consumo'],
      isMaiorDeIdade: json['is_maior_de_idade'],
      somentePorPontos: json['somente_por_pontos'],
      disponivelPorPontos: json['disponivel_por_pontos'],
      disponivelDelivery: json['disponivel_delivery'],
      disponivelNolocal: json['disponivel_nolocal'],
      disponivelMarketplace: json['disponivel_marketplace'],
      ocultarIndisponivel: json['ocultar_indisponivel'],
      valorPontos: json['valor_pontos'],
      mostrarObservacao: json['mostrar_observacao'],
      status:
          StatusEnum.values.firstWhereOrNull(((s) => s.name == json['status'])),
      agendamento: json['agendamento'] != null
          ? AgendamentoEnum.fromString(json['agendamento'])
          : null,
      fotoPrincipal: json['foto_principal'] ?? '',
      fotos: (json['fotos'] as List<dynamic>)
          .map((e) => Foto.fromJson(e as Map<String, dynamic>))
          .toList(),
      disponibilidade: Disponibilidade.fromJson(json['disponibilidade']),
      multiplicador: json['multiplicador'],
      qtdMinima: json['qtd_minima'],
      qtdMaxima: json['qtd_maxima'],
      cashback: cashback == null ? null : Cashback.fromJson(cashback),
      categoriaId: json['categoria_id'],
      resumoUpdatedAt: json['resumo_updated_at'],
      carrinhoQuickAdd: json['carrinho_quick_add'],
      ordem: json['ordem'],
      categoriasComplementos: (json['categorias_complementos']
                  as List<dynamic>? ??
              [])
          .map((e) => CategoriaComplemento.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['nome_normalizado'] = nomeNormalizado;
    data['descricao'] = descricao;
    data['preco_prefix'] = precoPrefix;
    data['preco'] = preco;
    data['preco_promocional'] = precoPromocional;
    data['preco_com_complementos'] = precoComComplementos;
    data['preco_promocional_com_complementos'] =
        precoPromocionalComComplementos;
    data['porcentagem_promocional'] = porcentagemPromocional;
    data['status_promocao_complementos'] = statusPromocaoComplementos;
    data['status_promocao'] = statusPromocao;
    data['tipo_entrega'] = tipoEntrega;
    data['tipo_retirada'] = tipoRetirada;
    data['tipo_consumo'] = tipoConsumo;
    data['is_maior_de_idade'] = isMaiorDeIdade;
    data['somente_por_pontos'] = somentePorPontos;
    data['disponivel_por_pontos'] = disponivelPorPontos;
    data['disponivel_delivery'] = disponivelDelivery;
    data['disponivel_nolocal'] = disponivelNolocal;
    data['disponivel_marketplace'] = disponivelMarketplace;
    data['ocultar_indisponivel'] = ocultarIndisponivel;
    data['valor_pontos'] = valorPontos;
    data['mostrar_observacao'] = mostrarObservacao;
    data['status'] = status;
    data['agendamento'] = agendamento;
    data['foto_principal'] = fotoPrincipal;
    data['fotos'] = fotos.map((v) => v.toJson()).toList();
    data['disponibilidade'] = disponibilidade.toJson();
    data['multiplicador'] = multiplicador;
    data['qtd_minima'] = qtdMinima;
    data['qtd_maxima'] = qtdMaxima;
    data['cashback'] = cashback?.toJson();
    data['categoria_id'] = categoriaId;
    data['resumo_updated_at'] = resumoUpdatedAt;
    data['carrinho_quick_add'] = carrinhoQuickAdd;
    data['ordem'] = ordem;
    data['categorias_complementos'] =
        categoriasComplementos.map((v) => v.toJson()).toList();
    return data;
  }

  String? get tipo {
    final tipos = <String>[];
    if (tipoEntrega) tipos.add('entrega');
    if (tipoRetirada) tipos.add('retirada');
    if (tipoConsumo) tipos.add('consumo no local');

    if (tipos.isEmpty) return null;
    if (tipos.length == 1) return tipos.first.capitalizeFirstLetter();
    if (tipos.length == 2) {
      return '${tipos[0]} e ${tipos[1]}'.capitalizeFirstLetter();
    }

    final allButLast = tipos.sublist(0, tipos.length - 1).join(', ');
    final last = tipos.last;
    return '$allButLast e $last'.capitalizeFirstLetter();
  }

  String? get delivery {
    final deliveries = <String>[];
    if (disponivelNolocal) deliveries.add('Delivery e salão');
    if (disponivelMarketplace) deliveries.add('Marketplace');
    if (deliveries.isEmpty) return null;
    return deliveries.join(' e ');
  }

  int get totalComplementos => categoriasComplementos.length;

  String get sortingName => nome.toLowerCase().removeDiacritics();

  void setPreco(double preco) {
    this.preco = preco;
  }

  void setStatusPromocao(bool statusPromocao) {
    this.statusPromocao = statusPromocao;
  }

  void setPrecoPromocional(double precoPromocional) {
    this.precoPromocional = precoPromocional;
  }

  void setPorcentagemPromocional(int porcentagemPromocional) {
    this.porcentagemPromocional = porcentagemPromocional;
  }
}
