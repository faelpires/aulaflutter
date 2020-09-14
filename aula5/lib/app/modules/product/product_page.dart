import 'package:aula5/app/shared/models/product_model.dart';
import 'package:aula5/app/shared/utils/default_validation.dart';
import 'package:aula5/app/shared/widgets/center_text.dart';
import 'package:aula5/app/shared/widgets/loading.dart';
import 'package:aula5/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ModularState<ProductPage, ProductController> {
  var _controllerBrand = TextEditingController();
  var _controllerName = TextEditingController();
  var _controllerUrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _save() async {
    if (_formKey.currentState.validate()) {
      try {
        var model = ProductModel(
          id: widget.id,
          name: _controllerName.text,
          brand: _controllerBrand.text,
        );

        if (_controllerUrl.text.isNotEmpty) model.url = _controllerUrl.text;

        await controller.save(model);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(S.of(context).success),
              content: Text(
                S.of(context).savedSuccessfully,
              ),
              actions: [
                FlatButton(
                  child: Text(
                    S.of(context).ok.toUpperCase(),
                  ),
                  onPressed: () async {
                    Modular.to.popUntil((p) => p.isFirst);
                  },
                ),
              ],
            );
          },
        );
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).failSaveData,
            ),
            action: SnackBarAction(
              label: S.of(context).tryAgain,
              onPressed: _save,
            ),
          ),
        );
      }
    }
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        TextFormField(
          controller: _controllerName,
          decoration: InputDecoration(
            labelText: S.of(context).productPageName,
          ),
          validator: validateMandatoryField,
        ),
        SizedBox(
          height: 16.0,
        ),
        TextFormField(
          controller: _controllerBrand,
          decoration: InputDecoration(
            labelText: S.of(context).productPageBrand,
          ),
          validator: validateMandatoryField,
        ),
        SizedBox(
          height: 16.0,
        ),
        TextFormField(
          controller: _controllerUrl,
          decoration: InputDecoration(
            labelText: S.of(context).productPageImageUrl,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    if (controller.isInAsyncCall) return Loading();

    Widget result = Container();

    if (controller.model != null) {
      switch (controller.model.status) {
        case FutureStatus.rejected:
          result = CenterText(
            S.of(context).failLoadData,
          );
          break;
        case FutureStatus.pending:
          result = Loading();
          break;
        case FutureStatus.fulfilled:
          if (controller.model != null) {
            if (_controllerName.text.isEmpty)
              _controllerName.text = controller.model.value.name;

            if (_controllerBrand.text.isEmpty)
              _controllerBrand.text = controller.model.value.brand;

            if (_controllerUrl.text.isEmpty)
              _controllerUrl.text = controller.model.value.url;

            result = _buildFormFields();
          } else
            result = CenterText(
              S.of(context).noData,
            );

          break;
      }
    } else
      result = _buildFormFields();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    controller.load(widget.id);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(S.of(context).product),
        leading: Observer(
          builder: (_) {
            return !controller.isInAsyncCall ? BackButton() : Container();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ),
        child: Form(
          key: _formKey,
          child: Container(
            width: size.width,
            height: size.height,
            child: Observer(builder: (_) {
              return _buildForm();
            }),
          ),
        ),
      ),
      floatingActionButton: Observer(
        builder: (_) {
          return Visibility(
            visible: !controller.isInAsyncCall,
            child: FloatingActionButton(
              onPressed: _save,
              tooltip: S.of(context).save,
              child: Icon(
                Icons.check,
              ),
            ),
          );
        },
      ),
    );
  }
}
