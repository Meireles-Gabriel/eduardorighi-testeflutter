/// CATEGORIES SECTION
///
/// Este widget gerencia a exibição de categorias na interface POS, adaptando-se
/// a diferentes tamanhos de tela e estados de visualização:
///
/// FUNCIONALIDADES PRINCIPAIS:
/// - Layout responsivo (desktop/tablet vs mobile)
/// - Sistema de mostrar/ocultar categorias ("Ver mais"/"Ver menos")
/// - Filtragem de categorias baseada em busca
/// - Seleção visual de categoria ativa
///
/// LAYOUTS:
/// 1. Desktop/Tablet: Grid de categorias com botões de expansão
/// 2. Mobile: Carousel horizontal ou grid expandido
///
/// ESTADOS:
/// - Collapsed: Mostra apenas algumas categorias com botão "Ver mais"
/// - Expanded: Mostra todas as categorias com botão "Ver menos"
///
/// O widget usa MobX Observer para reatividade automática e
/// PosUtils para configurações responsivas.

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../catalog/entities/category.entity.dart';
import '../stores/pos.store.dart';
import '../utils/pos_utils.dart';
import 'category_card.dart';

// Widget principal que gerencia a seção de categorias
class CategoriesSection extends StatelessWidget {
  final PosStore posStore; // Store que gerencia o estado do POS

  const CategoriesSection({
    super.key,
    required this.posStore,
  });

  @override
  Widget build(BuildContext context) {
    // Observer para reatividade MobX - rebuilda quando dados da store mudam
    return Observer(
      builder: (_) {
        // Obtém categorias filtradas baseadas na busca atual
        final filteredCategories = posStore.filteredCategories;
        final showAllCategories = posStore.showAllCategories;

        // LayoutBuilder para design responsivo baseado na largura da tela
        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final config = PosUtils.getResponsiveConfig(
                screenWidth); // Configuração responsiva

            // Lógica de layout para mobile vs desktop/tablet
            if (config.deviceType == DeviceType.mobile) {
              return _buildMobileCategoriesCarousel(filteredCategories);
            } else {
              // Para desktop/tablet: calcula quantas categorias mostrar
              const maxLines = 2; // Máximo de 2 linhas quando colapsado
              final maxCategoriesWhenCollapsed =
                  config.maxCategoriesInRow * maxLines;

              final hasMoreCategories =
                  filteredCategories.length > maxCategoriesWhenCollapsed;
              final shouldShowButton = hasMoreCategories;

              // Lista de categorias a serem exibidas (limitada se colapsado)
              final displayedCategories = showAllCategories
                  ? filteredCategories
                  : filteredCategories
                      .take(maxCategoriesWhenCollapsed -
                          (shouldShowButton
                              ? 1
                              : 0)) // Reserva espaço para botão
                      .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoriesGrid(
                    displayedCategories,
                    shouldShowButton,
                    filteredCategories,
                    maxCategoriesWhenCollapsed,
                    config,
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  // Constrói o carousel horizontal para dispositivos móveis
  Widget _buildMobileCategoriesCarousel(List<Categoria> filteredCategories) {
    const int maxVisibleCategories = 5; // Máximo de categorias no carousel

    final showingAll = posStore.showAllCategories;
    final hasMoreCategories = filteredCategories.length > maxVisibleCategories;

    // Se está mostrando todas as categorias, usa grid expandido
    if (showingAll) {
      return _buildMobileCategoriesGrid(filteredCategories);
    }

    // Se não está mostrando todas, usa carousel horizontal
    final displayedCategories = filteredCategories
        .take(maxVisibleCategories - 1)
        .toList(); // Reserva espaço para botão
    final showButton = hasMoreCategories;
    final totalItems = displayedCategories.length + (showButton ? 1 : 0);

    return SizedBox(
      height: 80, // Altura fixa para o carousel
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Scroll horizontal
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: totalItems,
        itemBuilder: (context, index) {
          // Se é o último item e há mais categorias, mostra botão "Ver mais"
          if (showButton && index == displayedCategories.length) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 120, // Largura fixa para consistência
                child: _buildShowMoreCard(),
              ),
            );
          }

          // Card de categoria normal
          return Padding(
            padding:
                const EdgeInsets.only(right: 12), // Espaçamento entre cards
            child: SizedBox(
              width: 120, // Largura fixa para cada card
              child: MobileCategoryCard(
                categoria: displayedCategories[index],
                onTap: () => posStore.selectCategory(
                    displayedCategories[index]), // Seleciona categoria
                isSelected: posStore.selectedCategory?.id ==
                    displayedCategories[index]
                        .id, // Verifica se está selecionada
              ),
            ),
          );
        },
      ),
    );
  }

  // Constrói o grid de categorias para desktop/tablet
  Widget _buildCategoriesGrid(
    List<Categoria> categories,
    bool shouldShowMoreButton,
    List<Categoria> filteredCategories,
    int maxCategoriesWhenCollapsed,
    ResponsiveConfig config,
  ) {
    final showingAll = posStore.showAllCategories;
    final hasMoreCategories =
        filteredCategories.length > maxCategoriesWhenCollapsed;
    final showButton = hasMoreCategories;

    final totalItems =
        categories.length + (showButton ? 1 : 0); // +1 para botão se necessário

    // Atualiza configuração responsiva na store
    posStore.maxCategoriesInRow = config.maxCategoriesInRow;

    return GridView.builder(
      shrinkWrap: true, // Se ajusta ao conteúdo
      physics:
          const NeverScrollableScrollPhysics(), // Desabilita scroll próprio
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: config
            .crossAxisCount, // Número de colunas baseado no tamanho da tela
        childAspectRatio:
            config.childAspectRatio, // Proporção largura/altura dos cards
        crossAxisSpacing: 16, // Espaçamento horizontal
        mainAxisSpacing: 16, // Espaçamento vertical
      ),
      itemCount: totalItems,
      itemBuilder: (context, index) {
        // Se é o último item e deve mostrar botão, exibe "Ver mais" ou "Ver menos"
        if (showButton && index == categories.length) {
          return showingAll
              ? _buildShowLessCard(isMobile: false)
              : _buildShowMoreCard();
        }
        // Card de categoria normal
        return CategoryCard(
          categoria: categories[index],
          onTap: () =>
              posStore.selectCategory(categories[index]), // Seleciona categoria
          isSelected: posStore.selectedCategory?.id ==
              categories[index].id, // Verifica se está selecionada
        );
      },
    );
  }

  // Constrói o card "Ver mais" para expandir categorias
  Widget _buildShowMoreCard() {
    return GestureDetector(
      onTap: () => posStore
          .toggleShowAllCategories(), // Alterna para mostrar todas as categorias
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Cursor de clique
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            color: Colors.grey.shade100, // Cor de fundo sutil
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add, // Ícone de adicionar
                  size: 24,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  'Ver mais',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Constrói o card "Ver menos" para colapsar categorias
  Widget _buildShowLessCard({bool isMobile = false}) {
    return GestureDetector(
      onTap: () => posStore
          .toggleShowAllCategories(), // Alterna para mostrar menos categorias
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Cursor de clique
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            color: Colors.grey.shade100, // Cor de fundo sutil
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_arrow_up, // Ícone de seta para cima
                  size: 24,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  'Ver menos',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Constrói o grid expandido para mobile quando mostrando todas as categorias
  Widget _buildMobileCategoriesGrid(List<Categoria> filteredCategories) {
    final totalItems =
        filteredCategories.length + 1; // +1 para o botão "Ver menos"

    return GridView.builder(
      shrinkWrap: true, // Se ajusta ao conteúdo
      physics:
          const NeverScrollableScrollPhysics(), // Desabilita scroll próprio
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 colunas para mobile
        childAspectRatio: 2.0, // Proporção mais ampla para mobile
        crossAxisSpacing: 12, // Espaçamento horizontal menor
        mainAxisSpacing: 12, // Espaçamento vertical menor
      ),
      itemCount: totalItems,
      itemBuilder: (context, index) {
        // Se é o último item, mostra o botão "Ver menos"
        if (index == filteredCategories.length) {
          return _buildShowLessCard(isMobile: true);
        }

        // Card de categoria para mobile
        return MobileCategoryCard(
          categoria: filteredCategories[index],
          onTap: () => posStore
              .selectCategory(filteredCategories[index]), // Seleciona categoria
          isSelected: posStore.selectedCategory?.id ==
              filteredCategories[index].id, // Verifica se está selecionada
        );
      },
    );
  }
}
