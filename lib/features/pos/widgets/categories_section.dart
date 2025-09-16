import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../catalog/entities/category.entity.dart';
import '../stores/pos.store.dart';
import '../utils/pos_utils.dart';
import 'category_card.dart';

class CategoriesSection extends StatelessWidget {
  final PosStore posStore;

  const CategoriesSection({
    super.key,
    required this.posStore,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final filteredCategories = posStore.filteredCategories;
        final showAllCategories = posStore.showAllCategories;

        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final config = PosUtils.getResponsiveConfig(screenWidth);

            if (config.deviceType == DeviceType.mobile) {
              return _buildMobileCategoriesCarousel(filteredCategories);
            } else {
              const maxLines = 2;
              final maxCategoriesWhenCollapsed =
                  config.maxCategoriesInRow * maxLines;

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

  Widget _buildMobileCategoriesCarousel(List<Categoria> filteredCategories) {
    const int maxVisibleCategories = 5;

    final showingAll = posStore.showAllCategories;
    final hasMoreCategories = filteredCategories.length > maxVisibleCategories;

    // Se está mostrando todas as categorias, usa grid
    if (showingAll) {
      return _buildMobileCategoriesGrid(filteredCategories);
    }

    // Se não está mostrando todas, usa carousel
    final displayedCategories =
        filteredCategories.take(maxVisibleCategories - 1).toList();
    final showButton = hasMoreCategories;
    final totalItems = displayedCategories.length + (showButton ? 1 : 0);

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: totalItems,
        itemBuilder: (context, index) {
          if (showButton && index == displayedCategories.length) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: SizedBox(
                width: 120,
                child: _buildShowMoreCard(),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SizedBox(
              width: 120,
              child: MobileCategoryCard(
                categoria: displayedCategories[index],
                onTap: () =>
                    posStore.selectCategory(displayedCategories[index]),
                isSelected: posStore.selectedCategory?.id ==
                    displayedCategories[index].id,
              ),
            ),
          );
        },
      ),
    );
  }

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

    final totalItems = categories.length + (showButton ? 1 : 0);

    posStore.maxCategoriesInRow = config.maxCategoriesInRow;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: config.crossAxisCount,
        childAspectRatio: config.childAspectRatio,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: totalItems,
      itemBuilder: (context, index) {
        if (showButton && index == categories.length) {
          return showingAll
              ? _buildShowLessCard(isMobile: false)
              : _buildShowMoreCard();
        }
        return CategoryCard(
          categoria: categories[index],
          onTap: () => posStore.selectCategory(categories[index]),
          isSelected: posStore.selectedCategory?.id == categories[index].id,
        );
      },
    );
  }

  Widget _buildShowMoreCard() {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
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

  Widget _buildShowLessCard({bool isMobile = false}) {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.keyboard_arrow_up,
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

  Widget _buildMobileCategoriesGrid(List<Categoria> filteredCategories) {
    final totalItems =
        filteredCategories.length + 1; // +1 para o botão "Ver menos"

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.0,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: totalItems,
      itemBuilder: (context, index) {
        // Se é o último item, mostra o botão "Ver menos"
        if (index == filteredCategories.length) {
          return _buildShowLessCard(isMobile: true);
        }

        return MobileCategoryCard(
          categoria: filteredCategories[index],
          onTap: () => posStore.selectCategory(filteredCategories[index]),
          isSelected:
              posStore.selectedCategory?.id == filteredCategories[index].id,
        );
      },
    );
  }
}
