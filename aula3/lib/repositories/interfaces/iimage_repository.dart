import 'package:aula3/models/image_model.dart';

abstract class IImageRepository {
  Future<ImageModel> get();
}
