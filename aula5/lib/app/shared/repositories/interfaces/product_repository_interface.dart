import 'package:aula5/app/shared/models/product_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IProductRepository implements Disposable {
  Future<List<ProductModel>> getAll(int categoryId);
  Future<ProductModel> getById(int id);
  Future<ProductModel> add(ProductModel model);
  Future<ProductModel> update(int id, ProductModel model);
  Future<int> remove(int id);
}
