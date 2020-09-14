import 'package:aula5/app/shared/models/product_model.dart';
import 'package:aula5/app/shared/repositories/interfaces/product_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final IProductRepository repository;
  _HomeControllerBase({@required this.repository}) {
    loadList();
  }

  @observable
  var isInAsyncCall = false;

  @observable
  ObservableFuture<List<ProductModel>> model;

  @action
  void loadList() {
    isInAsyncCall = true;
    model = ObservableFuture(
      repository.getAll().then(
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
