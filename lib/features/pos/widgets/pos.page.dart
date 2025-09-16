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
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Observer(
          builder: (_) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      PosHeader(posStore: posStore),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: CategoriesSection(posStore: posStore),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: ProductsSection(posStore: posStore),
                ),
              ),
              // Adiciona espaço extra para garantir que o fundo cinza se estenda até o final
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
