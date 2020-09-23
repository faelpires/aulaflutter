import 'shared/repositories/category_repository.dart';
import 'package:aula5/app/modules/product/product_page.dart';
import 'package:aula5/app/shared/utils/environment_config.dart';
import 'modules/product/product_controller.dart';
import 'package:dio/dio.dart';
import 'shared/repositories/product_repository.dart';
import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:aula5/app/app_widget.dart';
import 'package:aula5/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $CategoryRepository,
        $ProductController,
        $ProductRepository,
        $AppController,
        Bind(
          (i) => Dio(
            BaseOptions(
              baseUrl: EnvironmentConfig.BASE_API_URL,
            ),
          ),
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: HomeModule()),
        ModularRouter(
          '/product',
          child: (_, __) => ProductPage(),
        ),
        ModularRouter(
          '/product/:id',
          child: (_, args) => ProductPage(
            id: args.params["id"] != null ? int.parse(args.params["id"]) : null,
          ),
        ),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
