/// PRODUCT CARD
///
/// Este widget implementa um card de produto para a interface POS com:
///
/// FUNCIONALIDADES:
/// - Exibição de imagem do produto com fallback para placeholder
/// - Badge de desconto quando produto está em promoção
/// - Badge de status do produto (novo, esgotado, etc.)
/// - Preços com formatação brasileira (R$)
/// - Preço riscado quando em promoção
/// - Ícone de expandir para visualização completa
/// - Efeitos hover para interatividade
///
/// LAYOUT:
/// - Seção superior: Imagem do produto (3/4 da altura)
/// - Seção inferior: Informações textuais (1/4 da altura)
/// - Design responsivo com sombras e bordas arredondadas
///
/// O widget utiliza PosUtils para formatação de preços e configuração
/// de badges de status, garantindo consistência visual.

import 'package:flutter/material.dart';
import '../../catalog/entities/item_categoria.entity.dart';
import '../utils/pos_utils.dart';

// Widget de card de produto para exibição na grade de produtos
class ProductCard extends StatelessWidget {
  final ItemCategoria product; // Produto a ser exibido no card
  final VoidCallback? onTap; // Callback executado quando o card é tocado

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Cursor de clique quando hover
      child: GestureDetector(
        onTap: onTap, // Executa callback quando tocado
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12), // Bordas arredondadas
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08), // Sombra sutil
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seção da imagem do produto (3/4 da altura)
              Expanded(
                flex: 3,
                child: _buildImageSection(),
              ),
              // Seção de informações do produto (1/4 da altura)
              _buildContentSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Constrói a seção da imagem do produto com badges sobrepostos
  Widget _buildImageSection() {
    return Padding(
      padding: const EdgeInsets.all(5), // Padding para espaçamento interno
      child: Stack(
        children: [
          // Container principal da imagem
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey.shade100, // Cor de fundo enquanto carrega
              child: product.fotoPrincipal != null
                  ? Image.network(
                      product.fotoPrincipal!,
                      fit: BoxFit.cover, // Imagem cobre todo o container
                      errorBuilder: (context, error, stackTrace) =>
                          _buildProductPlaceholder(), // Fallback se erro ao carregar
                    )
                  : _buildProductPlaceholder(), // Placeholder se não há imagem
            ),
          ),
          // Badge de desconto sobreposto (canto superior esquerdo)
          if (product.statusPromocao && product.porcentagemPromocional > 0)
            Positioned(
              top: 6,
              left: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green.shade500, // Verde para indicar desconto
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${product.porcentagemPromocional}%', // Percentual de desconto
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          // Ícone de expandir (canto inferior direito)
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white
                    .withValues(alpha: 0.9), // Fundo semi-transparente
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.open_in_full, // Ícone para expandir/visualizar detalhes
                size: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Constrói a seção de conteúdo com informações do produto
  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(8), // Padding interno para o conteúdo
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge de status do produto (se existir)
          if (product.status != null) ...[
            _buildStatusBadge(),
            const SizedBox(height: 6), // Espaçamento após badge
          ],
          // Nome do produto
          Text(
            product.nome,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.2, // Altura da linha para melhor legibilidade
            ),
            maxLines: 2, // Máximo 2 linhas
            overflow: TextOverflow.ellipsis, // Corta texto longo com "..."
          ),
          const SizedBox(height: 4), // Espaçamento antes dos preços
          // Seção de preços
          _buildPriceSection(),
        ],
      ),
    );
  }

  // Constrói o badge de status do produto
  Widget _buildStatusBadge() {
    final badgeConfig = PosUtils.getStatusBadgeConfig(
        product.status); // Obtém configuração do badge
    if (badgeConfig == null) {
      return const SizedBox
          .shrink(); // Retorna widget vazio se não há configuração
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeConfig.backgroundColor, // Cor de fundo baseada no status
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        badgeConfig.text, // Texto do status
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  // Constrói a seção de preços com suporte a promoções
  Widget _buildPriceSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Se está em promoção, mostra preço original riscado
        if (product.statusPromocao) ...[
          Text(
            'R\$ ${product.preco.toStringAsFixed(2).replaceAll('.', ',')}', // Preço original formatado
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
              decoration: TextDecoration.lineThrough, // Texto riscado
            ),
          ),
          const SizedBox(width: 6), // Espaçamento entre preços
        ],
        // Preço final (promocional ou normal)
        Text(
          PosUtils.buildPriceText(product), // Utiliza PosUtils para formatação
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            // Verde se em promoção, preto se preço normal
            color:
                product.statusPromocao ? Colors.green.shade600 : Colors.black87,
          ),
        ),
      ],
    );
  }

  // Constrói o placeholder quando não há imagem ou erro ao carregar
  Widget _buildProductPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade200, // Fundo cinza claro
      child: Icon(
        Icons
            .image_not_supported_outlined, // Ícone indicando imagem não disponível
        size: 48,
        color: Colors.grey.shade400,
      ),
    );
  }
}
