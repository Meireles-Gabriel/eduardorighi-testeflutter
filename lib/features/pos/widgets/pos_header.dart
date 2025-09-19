/// POS HEADER
///
/// Este widget implementa o cabeçalho da interface POS (Point of Sale) com:
///
/// FUNCIONALIDADES:
/// - Layout responsivo adaptado para mobile, tablet e desktop
/// - Campo de busca integrado com a store POS
/// - Títulos informativos (status do pedido e loja)
/// - Botões de navegação e filtros
/// - Ícone de atalhos de teclado (desktop)
///
/// LAYOUTS RESPONSIVOS:
/// 1. Mobile: Layout vertical com busca em linha separada
/// 2. Tablet: Layout horizontal compacto sem ícone de teclado
/// 3. Desktop: Layout completo horizontal com todos os elementos
///
/// O widget se adapta automaticamente baseado na largura da tela,
/// proporcionando uma experiência otimizada para cada dispositivo.

import 'package:flutter/material.dart';
import '../stores/pos.store.dart';
import '../../../shared/widgets/search_input.widget.dart';

// Widget do cabeçalho do POS com layout responsivo
class PosHeader extends StatelessWidget {
  final PosStore posStore; // Store que gerencia o estado do POS

  const PosHeader({
    super.key,
    required this.posStore,
  });

  @override
  Widget build(BuildContext context) {
    // Detecta o tamanho da tela para responsividade
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600; // Breakpoint para mobile
    final isTablet =
        screenWidth > 600 && screenWidth <= 1200; // Breakpoint para tablet

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200, // Borda inferior sutil
            width: 1,
          ),
        ),
      ),
      // Seleciona layout baseado no tamanho da tela
      child: isMobile
          ? _buildMobileHeader()
          : isTablet
              ? _buildTabletHeader()
              : _buildDesktopHeader(),
    );
  }

  // Layout para desktop - horizontal completo com todos os elementos
  Widget _buildDesktopHeader() {
    return Row(
      children: [
        // Botão de voltar
        const Icon(
          Icons.arrow_back,
          size: 24,
        ),
        const SizedBox(width: 16),
        // Títulos do pedido e loja
        const _HeaderTitles(),
        const SizedBox(width: 12),
        // Campo de busca
        SearchInput(
          onChanged: (value) => posStore.updateSearchQuery(
              value ?? ''), // Atualiza query de busca na store
          placeholder: 'Buscar',
          width: 300, // Largura fixa para desktop
        ),
        const SizedBox(width: 16),
        // Botão de filtro com ícone e texto
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.filter_list),
          label: const Text('Filtrar'),
        ),
        const Spacer(), // Empurra próximos elementos para a direita
        // Ícone de atalhos de teclado (específico do desktop)
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            shape: BoxShape.circle, // Container circular
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.keyboard_alt_outlined, size: 20),
            padding: EdgeInsets.zero, // Remove padding padrão
          ),
        ),
      ],
    );
  }

  // Layout para tablet - horizontal compacto sem ícone de teclado
  Widget _buildTabletHeader() {
    return Row(
      children: [
        // Botão de voltar
        const Icon(
          Icons.arrow_back,
          size: 24,
        ),
        const SizedBox(width: 16),
        // Títulos do pedido e loja
        const _HeaderTitles(),
        const SizedBox(width: 12),
        // Campo de busca
        SearchInput(
          onChanged: (value) => posStore.updateSearchQuery(
              value ?? ''), // Atualiza query de busca na store
          placeholder: 'Buscar',
          width: 300, // Largura fixa para tablet
        ),
        const SizedBox(width: 16),
        // Botão de filtro apenas com ícone (compacto)
        OutlinedButton(
          onPressed: () {},
          child: const Icon(Icons.filter_list),
        ),
        const Spacer(), // Empurra elementos para distribuir espaço
      ],
    );
  }

  // Layout para mobile - vertical com busca em linha separada
  Widget _buildMobileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Primeira linha: botão voltar e títulos
        const Row(
          children: [
            Icon(
              Icons.arrow_back,
              size: 24,
            ),
            SizedBox(width: 16),
            _HeaderTitles(), // Títulos do pedido e loja
          ],
        ),
        const SizedBox(height: 16), // Espaçamento vertical
        // Segunda linha: busca e filtro
        Row(
          children: [
            // Campo de busca expandido para ocupar espaço disponível
            Expanded(
              child: SearchInput(
                onChanged: (value) => posStore.updateSearchQuery(
                    value ?? ''), // Atualiza query de busca na store
                placeholder: 'Buscar',
                width: double.infinity, // Ocupa toda largura disponível
              ),
            ),
            const SizedBox(width: 12),
            // Botão de filtro compacto apenas com ícone
            OutlinedButton(
              onPressed: () {},
              child: const Icon(Icons.filter_list),
            ),
          ],
        ),
      ],
    );
  }
}

// Widget privado para exibir títulos do cabeçalho
class _HeaderTitles extends StatelessWidget {
  const _HeaderTitles();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Se ajusta ao conteúdo
      children: [
        // Título principal do status do pedido
        Text(
          'Criando pedido',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        // Subtítulo com informação da loja
        Text(
          'Loja: [nome loja]', // Placeholder para nome da loja
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey, // Cor mais sutil para informação secundária
          ),
        ),
      ],
    );
  }
}
