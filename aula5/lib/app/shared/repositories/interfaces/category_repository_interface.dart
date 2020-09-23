import 'package:aula5/app/shared/models/category_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class ICategoryRepository implements Disposable {
  Future<List<CategoryModel>> getAll();
}
