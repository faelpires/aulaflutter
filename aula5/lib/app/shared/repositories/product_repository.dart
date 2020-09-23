import 'package:aula5/app/shared/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/product_repository_interface.dart';

part 'product_repository.g.dart';

@Injectable()
class ProductRepository implements IProductRepository {
  final Dio dio;

  ProductRepository({@required this.dio});

  @override
  void dispose() {}

  @override
  Future<ProductModel> add(ProductModel model) async {
    var response = await dio.post(
      '/products',
      data: model,
    );

    var result = ProductModel.fromJson(response.data);
    print(result.toJson());
    return result;
  }

  @override
  Future<List<ProductModel>> getAll(int categoryId) async {
    final response = await dio.get('/products?category=${categoryId ?? ''}');
    return ProductModel.fromMapList(response.data);
  }

  @override
  Future<ProductModel> getById(int id) async {
    var response = await dio.get('/products/$id');
    var result = ProductModel.fromJson(response.data);
    print(result.toJson());
    return result;
  }

  @override
  Future<int> remove(int id) async {
    var response = await dio.delete('/products/$id');
    var result = response.data;
    print(result);
    return result;
  }

  @override
  Future<ProductModel> update(int id, ProductModel model) async {
    var response = await dio.put(
      '/products/$id',
      //headers: {'content-type': 'application/json'},
      data: model,
    );

    var result = ProductModel.fromJson(response.data);
    print(result.toJson());
    return result;
  }
}
