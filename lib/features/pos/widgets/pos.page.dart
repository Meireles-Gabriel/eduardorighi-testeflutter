/// POS PAGE
///
/// Esta é a página principal da interface POS (Point of Sale) que organiza
/// todos os componentes da experiência de criação de pedidos:
///
/// ESTRUTURA:
/// - PosHeader: Cabeçalho com busca e navegação
/// - CategoriesSection: Seção de categorias de produtos
/// - ProductsSection: Lista de produtos da categoria selecionada
///
/// CARACTERÍSTICAS:
/// - Layout em CustomScrollView para scroll suave
/// - Integração com MobX para reatividade automática
/// - Injeção de dependência via GetIt para stores
/// - Design responsivo adaptado para diferentes telas
/// - Fundo cinza claro para separação visual das seções
///
/// A página utiliza o padrão Observer do MobX para reagir automaticamente
/// às mudanças de estado nas stores PosStore e CatalogStore.

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../../catalog/stores/catalog.store.dart';
import '../stores/pos.store.dart';
import 'pos_header.dart';
import 'categories_section.dart';
import 'products_section.dart';

// Página principal da interface POS
class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  // Injeção de dependência das stores via GetIt
  final catalogStore = GetIt.I<CatalogStore>(); // Store do catálogo de produtos
  final posStore = GetIt.I<PosStore>(); // Store do estado do POS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, // Fundo cinza claro
      body: SafeArea(
        // Observer para reatividade MobX - rebuilda quando dados das stores mudam
        child: Observer(
          builder: (_) => CustomScrollView(
            // Scroll customizado para performance
            slivers: [
              // Seção superior com fundo branco (header + categorias)
              SliverToBoxAdapter(
                child: Container(
                  color:
                      Colors.white, // Fundo branco para destacar seção superior
                  child: Column(
                    children: [
                      // Cabeçalho com busca e navegação
                      PosHeader(posStore: posStore),
                      // Seção de categorias com padding
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: CategoriesSection(posStore: posStore),
                      ),
                    ],
                  ),
                ),
              ),
              // Espaçamento entre seções para separação visual
              const SliverToBoxAdapter(
                child: SizedBox(height: 24),
              ),
              // Seção de produtos com fundo cinza
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: ProductsSection(
                      posStore:
                          posStore), // Lista de produtos da categoria selecionada
                ),
              ),
              // Espaço extra para garantir que o fundo cinza se estenda até o final
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
