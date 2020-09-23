import 'package:aula5/app/shared/models/category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/category_repository_interface.dart';

part 'category_repository.g.dart';

@Injectable()
class CategoryRepository implements ICategoryRepository {
  final Dio dio;

  CategoryRepository({@required this.dio});

  @override
  Future<List<CategoryModel>> getAll() async {
    final response = await dio.get('/categories');
    return CategoryModel.fromMapList(response.data);
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
