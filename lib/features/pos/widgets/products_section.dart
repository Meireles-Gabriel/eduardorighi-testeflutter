/// PRODUCTS SECTION
///
/// Este widget gerencia a exibição da grade de produtos na interface POS:
///
/// FUNCIONALIDADES:
/// - Grid responsivo de produtos baseado no tamanho da tela
/// - Estados vazios quando nenhuma categoria está selecionada
/// - Estado "nenhum produto encontrado" para buscas sem resultado
/// - Cálculo automático de colunas baseado na largura disponível
/// - Integração com PosUtils para dimensionamento responsivo
///
/// ESTADOS:
/// 1. Categoria não selecionada: Mostra estado vazio com ícone
/// 2. Nenhum produto encontrado: Mostra mensagem de busca vazia
/// 3. Produtos encontrados: Exibe grid responsivo de ProductCards
///
/// RESPONSIVIDADE:
/// - Calcula automaticamente quantas colunas cabem na tela
/// - Mantém proporções consistentes dos cards de produto
/// - Espaçamento uniforme entre elementos
///
/// O widget usa MobX Observer para reatividade automática e
/// se adapta às mudanças de categoria e filtros de busca.

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../catalog/entities/item_categoria.entity.dart';
import '../stores/pos.store.dart';
import '../utils/pos_utils.dart';
import 'product_card.dart';

// Widget que gerencia a seção de produtos com grid responsivo
class ProductsSection extends StatelessWidget {
  final PosStore posStore; // Store que gerencia o estado do POS

  const ProductsSection({
    super.key,
    required this.posStore,
  });

  @override
  Widget build(BuildContext context) {
    // Observer para reatividade MobX - rebuilda quando dados da store mudam
    return Observer(
      builder: (_) {
        // Se nenhuma categoria está selecionada, mostra estado vazio
        if (posStore.selectedCategory == null) {
          return _buildEmptyState();
        }

        // Obtém produtos filtrados da categoria selecionada
        final products = posStore.filteredProducts;

        // Se não há produtos (filtro de busca vazio), mostra estado "não encontrado"
        if (products.isEmpty) {
          return _buildNoProductsFound();
        }

        // Se há produtos, constrói o grid responsivo
        return _buildProductsGrid(products);
      },
    );
  }

  // Constrói o estado vazio quando nenhuma categoria está selecionada
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32), // Padding generoso para centrar bem
        child: Column(
          mainAxisSize: MainAxisSize.min, // Se ajusta ao conteúdo
          children: [
            Icon(
              Icons.search, // Ícone de busca para indicar seleção
              size: 64,
              color: Colors.grey.shade400, // Cor sutil
            ),
            const SizedBox(height: 16), // Espaçamento entre ícone e texto
            Text(
              'Nenhum produto encontrado', // Mensagem informativa
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Constrói o estado quando não há produtos na busca/categoria
  Widget _buildNoProductsFound() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32), // Padding generoso para centrar bem
        child: Column(
          mainAxisSize: MainAxisSize.min, // Se ajusta ao conteúdo
          children: [
            Icon(
              Icons.search, // Ícone de busca para indicar busca vazia
              size: 64,
              color: Colors.grey.shade400, // Cor sutil
            ),
            const SizedBox(height: 16), // Espaçamento entre ícone e texto
            Text(
              'Nenhum produto encontrado', // Mensagem para resultado vazio
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Constrói o grid responsivo de produtos
  Widget _buildProductsGrid(List<ItemCategoria> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth; // Largura disponível
        final dimensions = PosUtils.getProductCardDimensions(
            screenWidth); // Dimensões dos cards

        // Calcula quantas colunas cabem na largura disponível
        int crossAxisCount = ((screenWidth + dimensions.spacing) /
                (dimensions.width + dimensions.spacing))
            .floor();

        // Limita entre 1 e 8 colunas para evitar extremos
        crossAxisCount = crossAxisCount.clamp(1, 8);

        return GridView.builder(
          shrinkWrap: true, // Se ajusta ao conteúdo
          physics:
              const NeverScrollableScrollPhysics(), // Desabilita scroll próprio
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount, // Número de colunas calculado
            childAspectRatio:
                dimensions.width / dimensions.height, // Proporção dos cards
            crossAxisSpacing: dimensions.spacing, // Espaçamento horizontal
            mainAxisSpacing: dimensions.spacing, // Espaçamento vertical
          ),
          itemCount: products.length, // Número de produtos
          itemBuilder: (context, index) {
            return SizedBox(
              width: dimensions.width, // Largura fixa baseada no cálculo
              height: dimensions.height, // Altura fixa baseada no cálculo
              child: ProductCard(
                product: products[index], // Produto do índice atual
                onTap: () {}, // Placeholder para ação ao tocar no produto
              ),
            );
          },
        );
      },
    );
  }
}
