// coverage:ignore-start

// service locator
import 'package:get_it/get_it.dart';
import 'package:teste_flutter/features/catalog/stores/catalog.store.dart';

final sl = GetIt.I;

void slStores() {
  sl.registerLazySingleton<CatalogStore>(() => CatalogStore());
}

void init() {
  slStores();
}
