import 'package:aula5/app/shared/models/category_model.dart';
import 'package:aula5/app/shared/widgets/center_text.dart';
import 'package:aula5/app/shared/widgets/loading.dart';
import 'package:aula5/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  void _add() async {
    await Modular.to.pushNamed(
      '/product',
    );
    controller.loadList();
  }

  void _edit(int id) async {
    await Modular.to.pushNamed(
      '/product/$id',
    );

    controller.loadList();
  }

  void _delete(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).delete),
          content: Text(
            S.of(context).confirmDeletion,
          ),
          actions: [
            FlatButton(
              child: Text(
                S.of(context).yes.toUpperCase(),
              ),
              onPressed: () async {
                Modular.to.pop();
                controller.remove(id);
              },
            ),
            FlatButton(
              child: Text(
                S.of(context).no.toUpperCase(),
              ),
              onPressed: () async {
                Modular.to.pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<CategoryModel>> _getCategories(
      List<CategoryModel> categories) {
    if (categories == null) return [];

    return categories
        .map(
          (e) => DropdownMenuItem<CategoryModel>(
            value: e,
            child: Text(e.name),
          ),
        )
        .toList()
          ..insert(
            0,
            DropdownMenuItem<CategoryModel>(
              value: null,
              child: Text(
                S.of(context).all,
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    if (controller.model == null) controller.loadList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).products,
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Observer(
          builder: (context) {
            if (controller.isInAsyncCall) return Loading();

            switch (controller.model.status) {
              case FutureStatus.pending:
                return Loading();
                break;
              case FutureStatus.fulfilled:
                if (controller.model.value != null) {
                  return Column(
                    children: [
                      controller.categories != null
                          ? Container(
                              height: 50,
                              alignment: Alignment.centerRight,
                              child: DropdownButton(
                                value: controller.category,
                                items: _getCategories(
                                  controller.categories,
                                ),
                                onChanged: (value) =>
                                    controller.setCategory(value),
                              ),
                            )
                          : Container(),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            controller.loadList();
                          },
                          child: Scrollbar(
                            child: ListView.separated(
                              padding: EdgeInsets.only(bottom: 76),
                              separatorBuilder: (_, __) => Divider(),
                              itemCount: controller.model.value.length,
                              itemBuilder: (context, index) {
                                var data = controller.model.value[index];

                                return ListTile(
                                  leading:
                                      data.url != null && data.url.isNotEmpty
                                          ? Image.network(
                                              data.url,
                                            )
                                          : Image.asset(
                                              'assets/images/phone_mockup.png',
                                            ),
                                  title: Text(
                                    data.name,
                                  ),
                                  subtitle: Text(
                                    data.brand,
                                  ),
                                  trailing: IconButton(
                                    tooltip: S.of(context).delete,
                                    icon: Icon(
                                      Icons.delete_forever,
                                    ),
                                    onPressed: () => _delete(
                                      data.id,
                                    ),
                                  ),
                                  onTap: () => _edit(
                                    data.id,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else
                  return CenterText(
                    S.of(context).noData,
                  );
                break;
              case FutureStatus.rejected:
              default:
                return CenterText(
                  S.of(context).failLoadData,
                  action: RaisedButton(
                    child: Text(
                      S.of(context).tryAgain,
                    ),
                    onPressed: controller.loadList,
                  ),
                );
                break;
            }
          },
        ),
      ),
      floatingActionButton: Observer(
        builder: (_) => Visibility(
          visible: !controller.isInAsyncCall,
          child: FloatingActionButton(
            onPressed: _add,
            tooltip: S.of(context).add,
            child: Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}
