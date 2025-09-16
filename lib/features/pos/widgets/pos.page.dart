import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../catalog/entities/category.entity.dart';
import '../../catalog/entities/item_categoria.entity.dart';
import '../../catalog/entities/capa.entity.dart';
import '../../catalog/enums/status.enum.dart';
import '../../catalog/stores/catalog.store.dart';
import '../stores/pos.store.dart';
import '../../../shared/widgets/search_input.widget.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  final catalogStore = GetIt.I<CatalogStore>();
  final posStore = GetIt.I<PosStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Observer(
                builder: (_) => _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth <= 1200;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: isMobile
          ? _buildMobileHeader()
          : isTablet
              ? _buildTabletHeader()
              : _buildDesktopHeader(),
    );
  }

  Widget _buildDesktopHeader() {
    return Row(
      children: [
        const Icon(
          Icons.arrow_back,
          size: 24,
        ),
        const SizedBox(width: 16),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Criando pedido',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'Loja: [nome loja]',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        SearchInput(
          onChanged: (value) => posStore.updateSearchQuery(value ?? ''),
          placeholder: 'Buscar',
          width: 300,
        ),
        const SizedBox(width: 16),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          label: const Text('Filtrar'),
        ),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_alt_outlined, size: 20),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _buildTabletHeader() {
    return Row(
      children: [
        const Icon(
          Icons.arrow_back,
          size: 24,
        ),
        const SizedBox(width: 16),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Criando pedido',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'Loja: [nome loja]',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        SearchInput(
          onChanged: (value) => posStore.updateSearchQuery(value ?? ''),
          placeholder: 'Buscar',
          width: 300,
        ),
        const SizedBox(width: 16),
        OutlinedButton(
          onPressed: () {},
          child: const Icon(Icons.filter_list),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primeira linha: botão voltar + títulos
        const Row(
          children: [
            Icon(
              Icons.arrow_back,
              size: 24,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Criando pedido',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Loja: [nome loja]',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Segunda linha: busca + filtro
        Row(
          children: [
            Expanded(
              child: SearchInput(
                onChanged: (value) => posStore.updateSearchQuery(value ?? ''),
                placeholder: 'Buscar',
                width: double.infinity,
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () {},
              child: const Icon(Icons.filter_list),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Seção de categorias com padding normal em fundo branco
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: _buildCategoriesSection(),
        ),
        const SizedBox(height: 24),
        // Seção de produtos com fundo cinza que se estende até o fim da janela
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              child: _buildProductsSection(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Observer(
      builder: (_) {
        final filteredCategories = posStore.filteredCategories;
        final showAllCategories = posStore.showAllCategories;

        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final isDesktop = screenWidth > 1200;
            final isTablet = screenWidth > 600;
            final isMobile = !isDesktop && !isTablet;

            if (isMobile) {
              // Mobile: usar carrousel horizontal
              return _buildMobileCategoriesCarousel(filteredCategories);
            } else {
              // Desktop/Tablet: usar grid como antes
              const maxLines = 2;
              final maxCategoriesWhenCollapsed =
                  posStore.maxCategoriesInRow * maxLines;

              final hasMoreCategories =
                  filteredCategories.length > maxCategoriesWhenCollapsed;
              final shouldShowButton = hasMoreCategories;

              final displayedCategories = showAllCategories
                  ? filteredCategories
                  : filteredCategories
                      .take(maxCategoriesWhenCollapsed -
                          (shouldShowButton ? 1 : 0))
                      .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoriesGrid(displayedCategories, shouldShowButton,
                      filteredCategories, maxCategoriesWhenCollapsed),
                ],
              );
            }
          },
        );
      },
    );
  }

  Widget _buildMobileCategoriesCarousel(List<Categoria> filteredCategories) {
    const int maxVisibleCategories = 5;

    final showingAll = posStore.showAllCategories;
    final hasMoreCategories = filteredCategories.length > maxVisibleCategories;

    final displayedCategories = showingAll
        ? filteredCategories
        : filteredCategories
            .take(maxVisibleCategories - 1)
            .toList(); // Reserve space for button

    final showButton = hasMoreCategories;
    final totalItems = displayedCategories.length + (showButton ? 1 : 0);

    return SizedBox(
      height: 80, // Altura fixa para o carrousel
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: totalItems,
        itemBuilder: (context, index) {
          // Se é o último item e devemos mostrar o botão "Ver mais/menos"
          if (showButton && index == displayedCategories.length) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 120,
                child: showingAll ? _buildVerMenosCard() : _buildVerMaisCard(),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: 120,
              child: _buildMobileCategoryCard(displayedCategories[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileCategoryCard(Categoria categoria) {
    final isSelected = posStore.selectedCategory?.id == categoria.id;

    return GestureDetector(
      onTap: () => posStore.selectCategory(categoria),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image or color
              Container(
                decoration: BoxDecoration(
                  color: _getCategoryColor(categoria),
                  image: _getCategoryImageUrl(categoria) != null
                      ? DecorationImage(
                          image: NetworkImage(_getCategoryImageUrl(categoria)!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
              // Overlay gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              ),
              // Content positioned at center
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      categoria.nome ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${categoria.totalItens}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid(
      List<Categoria> categories,
      bool shouldShowMoreButton,
      List<Categoria> filteredCategories,
      int maxCategoriesWhenCollapsed) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isDesktop = screenWidth > 1200;
        final isTablet = screenWidth > 600;

        int crossAxisCount;
        double childAspectRatio;

        if (isDesktop) {
          crossAxisCount = 6;
          childAspectRatio = 2.5;
          posStore.maxCategoriesInRow = 6;
        } else if (isTablet) {
          crossAxisCount = 4;
          childAspectRatio = 2.2;
          posStore.maxCategoriesInRow = 4;
        } else {
          crossAxisCount = 2;
          childAspectRatio = 2.0;
          posStore.maxCategoriesInRow = 2;
        }

        final showingAll = posStore.showAllCategories;
        final hasMoreCategories =
            filteredCategories.length > maxCategoriesWhenCollapsed;
        final showButton = hasMoreCategories;

        final totalItems = categories.length + (showButton ? 1 : 0);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: totalItems,
          itemBuilder: (context, index) {
            // Se é o último item e devemos mostrar o botão "Ver mais/menos"
            if (showButton && index == categories.length) {
              return showingAll ? _buildVerMenosCard() : _buildVerMaisCard();
            }
            return _buildCategoryCard(categories[index]);
          },
        );
      },
    );
  }

  Widget _buildCategoryCard(Categoria categoria) {
    final isSelected = posStore.selectedCategory?.id == categoria.id;

    return _CategoryCard(
      categoria: categoria,
      isSelected: isSelected,
      onTap: () => posStore.selectCategory(categoria),
      getCategoryColor: _getCategoryColor,
      getCategoryImageUrl: _getCategoryImageUrl,
    );
  }

  String? _getCategoryImageUrl(Categoria categoria) {
    if (categoria.capa == null) return null;

    if (categoria.capa is CapaImagem) {
      final capaImagem = categoria.capa as CapaImagem;
      return capaImagem.defaultUrl;
    }

    return null;
  }

  Color _getCategoryColor(Categoria categoria) {
    // Generate a color based on category name/id for consistent colors
    final colors = [
      const Color(0xFF1FB76C), // Green
      const Color(0xFFFF8441), // Orange
      const Color(0xFF276EF1), // Blue
      const Color(0xFFFF1445), // Red
      const Color(0xFFffe15d), // Yellow
      const Color(0xFF7f7f7f), // Grey
    ];

    return colors[categoria.id % colors.length];
  }

  Widget _buildVerMaisCard() {
    return GestureDetector(
      onTap: () => posStore.toggleShowAllCategories(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 24,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(height: 8),
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

  Widget _buildVerMenosCard() {
    return GestureDetector(
      onTap: () => posStore.toggleShowAllCategories(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_arrow_up,
                  size: 24,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(height: 8),
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

  Widget _buildProductsSection() {
    if (posStore.selectedCategory == null) {
      return _buildEmptyState();
    }

    final products = posStore.filteredProducts;

    if (products.isEmpty) {
      return _buildNoProductsFound();
    }

    return _buildProductsGrid(products);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum produto encontrado',
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

  Widget _buildNoProductsFound() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum produto encontrado',
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

  Widget _buildProductsGrid(List<ItemCategoria> products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Tamanhos diferenciados por tipo de tela
        double fixedCardWidth;
        double fixedCardHeight;
        const double spacing = 16.0;

        // Definir tamanhos baseados na largura da tela
        if (screenWidth > 1200) {
          // Desktop: cards menores
          fixedCardWidth = 120.0;
          fixedCardHeight = 160.0; // 120 * 1.33
        } else if (screenWidth > 600) {
          // Tablet: tamanho intermediário
          fixedCardWidth = 130.0;
          fixedCardHeight = 173.0; // 130 * 1.33
        } else {
          // Mobile: tamanho atual
          fixedCardWidth = 140.0;
          fixedCardHeight = 186.0; // 140 * 1.33
        }

        // Calcular quantas colunas cabem na tela com o tamanho fixo
        int crossAxisCount =
            ((screenWidth + spacing) / (fixedCardWidth + spacing)).floor();

        // Garantir pelo menos 1 coluna e máximo baseado no espaço disponível
        crossAxisCount =
            crossAxisCount.clamp(1, 8); // Aumentado para 8 para desktop

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: fixedCardWidth / fixedCardHeight,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: fixedCardWidth,
              height: fixedCardHeight,
              child: _buildProductCard(products[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildProductCard(ItemCategoria product) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Handle product tap
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5), // Margem de 2px
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            8), // Bordas levemente arredondadas
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.grey.shade100,
                          child: product.fotoPrincipal != null
                              ? Image.network(
                                  product.fotoPrincipal!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      _buildProductPlaceholder(),
                                )
                              : _buildProductPlaceholder(),
                        ),
                      ),
                      // Apenas badge de desconto no topo-esquerda
                      if (product.statusPromocao &&
                          product.porcentagemPromocional > 0)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.green.shade500,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${product.porcentagemPromocional}%',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      // Expand icon at bottom-right
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.open_in_full,
                            size: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content section
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status badge (abaixo da imagem)
                    if (product.status != null) ...[
                      _buildStatusBadgeForContent(product.status!),
                      const SizedBox(height: 6),
                    ],
                    // Product name
                    Text(
                      product.nome,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Price section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.statusPromocao) ...[
                          Text(
                            'R\$ ${product.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          _buildPriceText(product),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: product.statusPromocao
                                ? Colors.green.shade600
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade200,
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 48,
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildStatusBadgeForContent(dynamic status) {
    if (status == null) return const SizedBox.shrink();

    Color backgroundColor;
    String text;

    // Handle both enum and string cases
    String statusString;
    if (status is StatusEnum) {
      statusString = status.name;
    } else {
      statusString = status.toString().toLowerCase();
    }

    switch (statusString.toLowerCase()) {
      case 'novidade':
        backgroundColor = Colors.green.shade500;
        text = 'NOVIDADE';
        break;
      case 'esgotado':
        backgroundColor = Colors.grey.shade500;
        text = 'ESGOTADO';
        break;
      case 'indisponivel':
      case 'indisponível':
        backgroundColor = Colors.red.shade500;
        text = 'INDISPONÍVEL';
        break;
      case 'pausado':
        backgroundColor = Colors.orange.shade500;
        text = 'PAUSADO';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  String _buildPriceText(ItemCategoria product) {
    final price =
        product.statusPromocao ? product.precoPromocional : product.preco;
    final priceString = price.toStringAsFixed(2).replaceAll('.', ',');

    switch (product.precoPrefix.toString()) {
      case 'PrecoPrefixEnum.a_partir':
        return 'a partir de R\$ $priceString';
      default:
        return 'R\$ $priceString';
    }
  }
}

class _CategoryCard extends StatefulWidget {
  final Categoria categoria;
  final bool isSelected;
  final VoidCallback onTap;
  final Color Function(Categoria) getCategoryColor;
  final String? Function(Categoria) getCategoryImageUrl;

  const _CategoryCard({
    required this.categoria,
    required this.isSelected,
    required this.onTap,
    required this.getCategoryColor,
    required this.getCategoryImageUrl,
  });

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: isHovered
              ? (Matrix4.identity()..scale(1.02))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isSelected ? Colors.green : Colors.grey.shade300,
              width: widget.isSelected ? 2 : 1,
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isHovered ? 0.1 : 0.05),
                blurRadius: isHovered ? 8 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image or color
                Container(
                  decoration: BoxDecoration(
                    color: widget.getCategoryColor(widget.categoria),
                    image: widget.getCategoryImageUrl(widget.categoria) != null
                        ? DecorationImage(
                            image: NetworkImage(
                                widget.getCategoryImageUrl(widget.categoria)!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                // Overlay gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: isHovered ? 0.2 : 0.1),
                        Colors.black.withValues(alpha: isHovered ? 0.7 : 0.6),
                      ],
                    ),
                  ),
                ),
                // Content positioned at center-left
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.categoria.nome ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.categoria.totalItens} produtos',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
