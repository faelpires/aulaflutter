import 'package:aula4/models/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getAll();
  Future<ProductModel> getById(int id);
  Future<ProductModel> add(ProductModel model);
  Future<ProductModel> update(int id, ProductModel model);
  Future<int> remove(int id);
}
