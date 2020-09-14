import 'package:aula5/app/shared/models/product_model.dart';
import 'package:aula5/app/shared/repositories/interfaces/product_repository_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'product_controller.g.dart';

@Injectable()
class ProductController = _ProductControllerBase with _$ProductController;

abstract class _ProductControllerBase with Store {
  final IProductRepository repository;
  _ProductControllerBase({@required this.repository});

  @observable
  var isInAsyncCall = false;

  @observable
  ObservableFuture<ProductModel> model;

  @action
  Future load(int id) async {
    if (id == null) return;
    isInAsyncCall = true;

    model = ObservableFuture(
      repository.getById(id).then(
        (value) {
          isInAsyncCall = false;
          return value;
        },
      ),
    );
  }

  @action
  Future save(ProductModel model) async {
    try {
      isInAsyncCall = true;

      if (model.id == null)
        await repository.add(model);
      else
        await repository.update(model.id, model);
    } catch (e) {
      throw e;
    } finally {
      isInAsyncCall = false;
    }
  }
}
