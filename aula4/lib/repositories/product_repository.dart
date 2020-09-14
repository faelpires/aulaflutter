import 'dart:convert';

import 'package:aula4/models/product_model.dart';
import 'package:aula4/repositories/interfaces/iproduct_repository.dart';
import 'package:http/http.dart' as http;

class ProductRepository implements IProductRepository {
  http.Client _client;
  String baseUrl;

  ProductRepository() {
    _client = http.Client();
    baseUrl = 'https://demoapifaelpires.azurewebsites.net/api';
  }

  @override
  Future<List<ProductModel>> getAll() async {
    var response = await _client.get('$baseUrl/products');
    return ProductModel.fromMapList(json.decode(response.body));
  }

  @override
  Future<ProductModel> add(ProductModel model) async {
    var response = await _client.post(
      '$baseUrl/products',
      headers: {'content-type': 'application/json'},
      body: json.encode(model),
    );

    var result = ProductModel.fromJson(json.decode(response.body));
    print(result.toJson());
    return result;
  }

  @override
  Future<ProductModel> getById(int id) async {
    var response = await _client.get('$baseUrl/products/$id');
    var result = ProductModel.fromJson(json.decode(response.body));
    print(result.toJson());
    return result;
  }

  @override
  Future<int> remove(int id) async {
    var response = await _client.delete('$baseUrl/products/$id');
    var result = int.parse(response.body);
    print(result);
    return result;
  }

  @override
  Future<ProductModel> update(int id, ProductModel model) async {
    var response = await _client.put(
      '$baseUrl/products/$id',
      headers: {'content-type': 'application/json'},
      body: json.encode(model),
    );

    var result = ProductModel.fromJson(json.decode(response.body));
    print(result.toJson());
    return result;
  }
}
