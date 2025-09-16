import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../catalog/entities/item_categoria.entity.dart';
import '../stores/pos.store.dart';
import '../utils/pos_utils.dart';
import 'product_card.dart';

class ProductsSection extends StatelessWidget {
  final PosStore posStore;

  const ProductsSection({
    super.key,
    required this.posStore,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (posStore.selectedCategory == null) {
          return _buildEmptyState();
        }

        final products = posStore.filteredProducts;

        if (products.isEmpty) {
          return _buildNoProductsFound();
        }

        return _buildProductsGrid(products);
      },
    );
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
        final dimensions = PosUtils.getProductCardDimensions(screenWidth);

        int crossAxisCount = ((screenWidth + dimensions.spacing) /
                (dimensions.width + dimensions.spacing))
            .floor();

        crossAxisCount = crossAxisCount.clamp(1, 8);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: dimensions.width / dimensions.height,
            crossAxisSpacing: dimensions.spacing,
            mainAxisSpacing: dimensions.spacing,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: dimensions.width,
              height: dimensions.height,
              child: ProductCard(
                product: products[index],
                onTap: () {},
              ),
            );
          },
        );
      },
    );
  }
}
