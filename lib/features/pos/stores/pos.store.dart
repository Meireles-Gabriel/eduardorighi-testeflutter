import 'package:mobx/mobx.dart';
import 'package:get_it/get_it.dart';

import '../../catalog/entities/category.entity.dart';
import '../../catalog/entities/item_categoria.entity.dart';
import '../../catalog/stores/catalog.store.dart';

part 'pos.store.g.dart';

class PosStore = _PosStoreBase with _$PosStore;

abstract class _PosStoreBase with Store {
  final catalogStore = GetIt.I<CatalogStore>();

  @observable
  String searchQuery = '';

  @observable
  Categoria? selectedCategory;

  @observable
  bool showAllCategories = false;

  @observable
  int maxCategoriesInRow = 6;

  @action
  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  void selectCategory(Categoria? category) {
    selectedCategory = category;
  }

  @action
  void toggleShowAllCategories() {
    showAllCategories = !showAllCategories;
  }

  @computed
  List<Categoria> get filteredCategories {
    if (searchQuery.isEmpty) {
      return catalogStore.categorias;
    }

    return catalogStore.categorias.where((categoria) {
      // Search in category name
      final categoryNameMatch =
          categoria.nome?.toLowerCase().contains(searchQuery.toLowerCase()) ??
              false;

      // Search in item names within the category
      final itemsMatch = categoria.itens?.any((item) =>
              item.nome.toLowerCase().contains(searchQuery.toLowerCase())) ??
          false;

      return categoryNameMatch || itemsMatch;
    }).toList();
  }

  @computed
  List<ItemCategoria> get filteredProducts {
    if (selectedCategory == null) {
      return [];
    }

    final items = selectedCategory!.itens ?? [];

    if (searchQuery.isEmpty) {
      return items;
    }

    return items
        .where((item) =>
            item.nome.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }
}
