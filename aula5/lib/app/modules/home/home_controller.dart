import 'package:aula5/app/shared/models/category_model.dart';
import 'package:aula5/app/shared/models/product_model.dart';
import 'package:aula5/app/shared/repositories/interfaces/category_repository_interface.dart';
import 'package:aula5/app/shared/repositories/interfaces/product_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  List<CategoryModel> categories;

  @observable
  CategoryModel category;

  final ICategoryRepository categoryRepository;
  @observable
  var isInAsyncCall = false;

  @observable
  ObservableFuture<List<ProductModel>> model;

  final IProductRepository repository;

  _HomeControllerBase({
    @required this.repository,
    @required this.categoryRepository,
  });

  @action
  Future loadList() async {
    isInAsyncCall = true;

    if (categories == null) categories = await categoryRepository.getAll();

    model = ObservableFuture(
      repository.getAll(category?.id ?? null).then(
        (value) {
          isInAsyncCall = false;
          return value;
        },
      ).catchError((e) {
        isInAsyncCall = false;
        throw e;
      }),
    );
  }

  @action
  void setCategory(CategoryModel value) {
    category = value;
    loadList();
  }

  @action
  void remove(int id) {
    isInAsyncCall = true;
    repository
        .remove(id)
        .then(
          (value) => loadList(),
        )
        .catchError(
      (e) {
        isInAsyncCall = false;
        throw e;
      },
    );
  }
}
