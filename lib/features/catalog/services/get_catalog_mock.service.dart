import 'dart:convert';
import 'package:flutter/services.dart';
import '../entities/category.entity.dart';

class GetCatalogMockService {
  Future<List<Categoria>> getCategorias() async {
    final String response = await rootBundle.loadString('assets/catalog.json');
    final data = json.decode(response);
    final categoriasJson = data['categorias'] as List<dynamic>;
    return categoriasJson.map((json) => Categoria.fromJson(json)).toList();
  }
}
