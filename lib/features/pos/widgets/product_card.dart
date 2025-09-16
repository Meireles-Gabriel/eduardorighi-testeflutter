import 'package:flutter/material.dart';
import '../../catalog/entities/item_categoria.entity.dart';
import '../utils/pos_utils.dart';

class ProductCard extends StatelessWidget {
  final ItemCategoria product;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
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
              Expanded(
                flex: 3,
                child: _buildImageSection(),
              ),
              _buildContentSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
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
          if (product.statusPromocao && product.porcentagemPromocional > 0)
            Positioned(
              top: 6,
              left: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.status != null) ...[
            _buildStatusBadge(),
            const SizedBox(height: 6),
          ],
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
          _buildPriceSection(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final badgeConfig = PosUtils.getStatusBadgeConfig(product.status);
    if (badgeConfig == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeConfig.backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        badgeConfig.text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPriceSection() {
    return Row(
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
          PosUtils.buildPriceText(product),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color:
                product.statusPromocao ? Colors.green.shade600 : Colors.black87,
          ),
        ),
      ],
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
}
