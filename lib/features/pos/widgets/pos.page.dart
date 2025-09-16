import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../catalog/stores/catalog.store.dart';
import '../stores/pos.store.dart';
import 'pos_header.dart';
import 'categories_section.dart';
import 'products_section.dart';

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
            PosHeader(posStore: posStore),
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

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: CategoriesSection(posStore: posStore),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              child: ProductsSection(posStore: posStore),
            ),
          ),
        ),
      ],
    );
  }
}
