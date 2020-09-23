import 'package:aula5/app/shared/models/category_model.dart';
import 'package:aula5/app/shared/models/product_model.dart';
import 'package:aula5/app/shared/repositories/interfaces/category_repository_interface.dart';
import 'package:aula5/app/shared/repositories/interfaces/product_repository_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'product_controller.g.dart';

@Injectable()
class ProductController = _ProductControllerBase with _$ProductController;

abstract class _ProductControllerBase with Store {
  @observable
  List<CategoryModel> categories;

  final ICategoryRepository categoryRepository;
  @observable
  var hasLoadError = false;

  @observable
  var isInAsyncCall = false;

  @observable
  ProductModel model;

  final IProductRepository repository;

  _ProductControllerBase({
    @required this.repository,
    @required this.categoryRepository,
  });

  @action
  Future load(int id) async {
    try {
      isInAsyncCall = true;
      hasLoadError = false;

      categories = await categoryRepository.getAll();

      if (id == null)
        model = ProductModel();
      else
        model = await repository.getById(id);
    } catch (e) {
      hasLoadError = true;
      print(e);
      throw e;
    } finally {
      isInAsyncCall = false;
    }
  }

  @action
  Future save() async {
    try {
      isInAsyncCall = true;

      if (model.id == null)
        await repository.add(model);
      else
        await repository.update(model.id, model);
    } catch (e) {
      print(e);
      throw e;
    } finally {
      isInAsyncCall = false;
    }
  }
}
