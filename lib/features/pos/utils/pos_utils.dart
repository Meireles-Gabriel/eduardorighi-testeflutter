import 'package:flutter/material.dart';
import '../../catalog/entities/category.entity.dart';
import '../../catalog/entities/item_categoria.entity.dart';
import '../../catalog/entities/capa.entity.dart';
import '../../catalog/enums/status.enum.dart';

class PosUtils {
  static Color getCategoryColor(Categoria categoria) {
    final colors = [
      const Color(0xFF1FB76C),
      const Color(0xFFFF8441),
      const Color(0xFF276EF1),
      const Color(0xFFFF1445),
      const Color(0xFFffe15d),
      const Color(0xFF7f7f7f),
    ];

    return colors[categoria.id % colors.length];
  }

  static String? getCategoryImageUrl(Categoria categoria) {
    if (categoria.capa == null) return null;

    if (categoria.capa is CapaImagem) {
      final capaImagem = categoria.capa as CapaImagem;
      return capaImagem.defaultUrl;
    }

    return null;
  }

  static String buildPriceText(ItemCategoria product) {
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

  static StatusBadgeConfig? getStatusBadgeConfig(dynamic status) {
    if (status == null) return null;

    String statusString;
    if (status is StatusEnum) {
      statusString = status.name;
    } else {
      statusString = status.toString().toLowerCase();
    }

    switch (statusString.toLowerCase()) {
      case 'novidade':
        return StatusBadgeConfig(
          backgroundColor: Colors.green.shade500,
          text: 'NOVIDADE',
        );
      case 'esgotado':
        return StatusBadgeConfig(
          backgroundColor: Colors.grey.shade500,
          text: 'ESGOTADO',
        );
      case 'indisponivel':
      case 'indisponível':
        return StatusBadgeConfig(
          backgroundColor: Colors.red.shade500,
          text: 'INDISPONÍVEL',
        );
      case 'pausado':
        return StatusBadgeConfig(
          backgroundColor: Colors.orange.shade500,
          text: 'PAUSADO',
        );
      default:
        return null;
    }
  }

  static ResponsiveConfig getResponsiveConfig(double screenWidth) {
    if (screenWidth > 1200) {
      return ResponsiveConfig(
        crossAxisCount: 6,
        childAspectRatio: 2.5,
        maxCategoriesInRow: 6,
        deviceType: DeviceType.desktop,
      );
    } else if (screenWidth > 600) {
      return ResponsiveConfig(
        crossAxisCount: 4,
        childAspectRatio: 2.2,
        maxCategoriesInRow: 4,
        deviceType: DeviceType.tablet,
      );
    } else {
      return ResponsiveConfig(
        crossAxisCount: 2,
        childAspectRatio: 2.0,
        maxCategoriesInRow: 2,
        deviceType: DeviceType.mobile,
      );
    }
  }

  static ProductCardDimensions getProductCardDimensions(double screenWidth) {
    if (screenWidth > 1200) {
      return ProductCardDimensions(
        width: 120.0,
        height: 160.0,
        spacing: 16.0,
      );
    } else if (screenWidth > 600) {
      return ProductCardDimensions(
        width: 130.0,
        height: 173.0,
        spacing: 16.0,
      );
    } else {
      return ProductCardDimensions(
        width: 140.0,
        height: 186.0,
        spacing: 16.0,
      );
    }
  }
}

class StatusBadgeConfig {
  final Color backgroundColor;
  final String text;

  StatusBadgeConfig({
    required this.backgroundColor,
    required this.text,
  });
}

class ResponsiveConfig {
  final int crossAxisCount;
  final double childAspectRatio;
  final int maxCategoriesInRow;
  final DeviceType deviceType;

  ResponsiveConfig({
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.maxCategoriesInRow,
    required this.deviceType,
  });
}

class ProductCardDimensions {
  final double width;
  final double height;
  final double spacing;

  ProductCardDimensions({
    required this.width,
    required this.height,
    required this.spacing,
  });
}

enum DeviceType { mobile, tablet, desktop }
