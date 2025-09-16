import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../catalog/stores/catalog.store.dart';

class PosPage extends StatelessWidget {
  PosPage({super.key});

  final catalogStore = GetIt.I<CatalogStore>();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          "Desenvolver aqui, sinta-se livre para criar novas pastas e arquivos conforme a necessidade."),
    );
  }
}
