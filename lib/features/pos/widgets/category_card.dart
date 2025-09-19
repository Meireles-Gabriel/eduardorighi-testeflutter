/// CATEGORY CARD WIDGETS
///
/// Este arquivo contém dois widgets para exibir cards de categorias:
///
/// 1. CategoryCard: Widget principal para desktop/tablet com efeitos hover
///    - Exibe categorias com imagem de fundo, nome e contagem de produtos
///    - Suporte a hover effects com escala e animações
///    - Borda verde quando selecionado
///    - Layout otimizado para telas maiores
///
/// 2. MobileCategoryCard: Widget otimizado para dispositivos móveis
///    - Layout mais compacto sem efeitos hover
///    - Texto centralizado
///    - Mesmo sistema de seleção com borda verde
///
/// Ambos os widgets:
/// - Recebem uma categoria, callback onTap e estado isSelected
/// - Usam PosUtils para determinar cores e imagens das categorias
/// - Aplicam bordas verdes visuais quando selecionados
/// - Exibem nome da categoria e quantidade de produtos

import 'package:flutter/material.dart';
import '../../catalog/entities/category.entity.dart';
import '../utils/pos_utils.dart';

// Widget de card de categoria para desktop/tablet com efeitos hover
class CategoryCard extends StatefulWidget {
  final Categoria categoria; // Categoria a ser exibida no card
  final VoidCallback onTap; // Callback executado quando o card é tocado
  final bool isSelected; // Indica se esta categoria está selecionada

  const CategoryCard({
    super.key,
    required this.categoria,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isHovered = false; // Controla o estado de hover do mouse sobre o card

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Executa o callback quando o card é tocado
      child: MouseRegion(
        cursor:
            SystemMouseCursors.click, // Mostra cursor de clique quando hover
        onEnter: (_) => setState(() => isHovered = true), // Ativa estado hover
        onExit: (_) =>
            setState(() => isHovered = false), // Desativa estado hover
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200), // Duração da animação
          // Aplica escala de 1.02x quando hover para efeito visual
          transform: isHovered
              ? (Matrix4.identity()..scale(1.02))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              // Borda verde se selecionado, cinza se não selecionado
              color: widget.isSelected ? Colors.green : Colors.grey.shade300,
              width: widget.isSelected
                  ? 3
                  : 1, // Borda mais espessa se selecionado
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                // Sombra mais intensa quando hover
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
                // Container de fundo com cor ou imagem da categoria
                Container(
                  decoration: BoxDecoration(
                    color: PosUtils.getCategoryColor(
                        widget.categoria), // Cor de fundo baseada na categoria
                    image: PosUtils.getCategoryImageUrl(widget.categoria) !=
                            null
                        ? DecorationImage(
                            image: NetworkImage(PosUtils.getCategoryImageUrl(
                                widget.categoria)!),
                            fit: BoxFit.cover, // Imagem cobre todo o container
                          )
                        : null,
                  ),
                ),
                // Overlay com texto da categoria
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nome da categoria
                            Text(
                              widget.categoria.nome ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                shadows: [
                                  // Sombra no texto para melhor legibilidade sobre imagens
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis, // Corta texto longo
                            ),
                            const SizedBox(height: 2),
                            // Contagem de produtos na categoria
                            Text(
                              '${widget.categoria.totalItens} produtos',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget de categoria otimizado para dispositivos móveis
class MobileCategoryCard extends StatelessWidget {
  final Categoria categoria; // Categoria a ser exibida
  final VoidCallback onTap; // Callback executado quando tocado
  final bool isSelected; // Indica se está selecionada

  const MobileCategoryCard({
    super.key,
    required this.categoria,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Executa callback quando tocado
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            // Borda verde se selecionado, cinza se não
            color: isSelected ? Colors.green : Colors.grey.shade300,
            width: isSelected ? 3 : 1, // Borda mais espessa se selecionado
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05), // Sombra sutil
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
              // Container de fundo com cor/imagem da categoria
              Container(
                decoration: BoxDecoration(
                  color: PosUtils.getCategoryColor(
                      categoria), // Cor baseada na categoria
                  image: PosUtils.getCategoryImageUrl(categoria) != null
                      ? DecorationImage(
                          image: NetworkImage(
                              PosUtils.getCategoryImageUrl(categoria)!),
                          fit: BoxFit.cover, // Imagem cobre todo o container
                        )
                      : null,
                ),
              ),
              // Overlay com texto centralizado
              Padding(
                padding: const EdgeInsets.all(8), // Padding menor para mobile
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Nome da categoria
                    Text(
                      categoria.nome ?? '',
                      style: const TextStyle(
                        fontSize: 12, // Fonte menor para mobile
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 2,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                          ),
                        ],
                      ),
                      maxLines: 2, // Permite 2 linhas no mobile
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center, // Texto centralizado
                    ),
                    const SizedBox(height: 2),
                    // Contagem de produtos
                    Text(
                      '${categoria.totalItens} produtos',
                      style: const TextStyle(
                        fontSize: 10, // Fonte ainda menor para contagem
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 2,
                            color: Color.fromRGBO(0, 0, 0, 0.5),
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
    );
  }
}
