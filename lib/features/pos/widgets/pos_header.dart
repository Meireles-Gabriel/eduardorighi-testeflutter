import 'package:flutter/material.dart';
import '../stores/pos.store.dart';
import '../../../shared/widgets/search_input.widget.dart';

class PosHeader extends StatelessWidget {
  final PosStore posStore;

  const PosHeader({
    super.key,
    required this.posStore,
  });

  @override
  Widget build(BuildContext context) {
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
        const _HeaderTitles(),
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
        const _HeaderTitles(),
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
        const Row(
          children: [
            Icon(
              Icons.arrow_back,
              size: 24,
            ),
            SizedBox(width: 16),
            _HeaderTitles(),
          ],
        ),
        const SizedBox(height: 16),
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
}

class _HeaderTitles extends StatelessWidget {
  const _HeaderTitles();

  @override
  Widget build(BuildContext context) {
    return const Column(
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
    );
  }
}
