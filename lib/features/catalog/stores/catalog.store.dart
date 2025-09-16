import 'package:mobx/mobx.dart';
import 'package:teste_flutter/features/catalog/entities/category.entity.dart';
import 'package:teste_flutter/features/catalog/services/get_catalog_mock.service.dart';

part 'catalog.store.g.dart';

class CatalogStore = _CatalogStoreBase with _$CatalogStore;

abstract class _CatalogStoreBase with Store {
  _CatalogStoreBase() {
    initStore();
  }

  @observable
  List<Categoria> categorias = [];

  @action
  Future<void> initStore() async {
    final getCatalog = GetCatalogMockService();
    categorias = await getCatalog.getCategorias();
  }
}
