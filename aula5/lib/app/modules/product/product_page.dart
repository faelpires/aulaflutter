import 'package:aula5/app/shared/utils/default_validation.dart';
import 'package:aula5/app/shared/widgets/center_text.dart';
import 'package:aula5/app/shared/widgets/loading.dart';
import 'package:aula5/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ModularState<ProductPage, ProductController> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _save() async {
    if (_formKey.currentState.validate()) {
      try {
        await controller.save();

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
        controller.categories != null
            ? Container(
                alignment: Alignment.centerRight,
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: S.of(context).category,
                  ),
                  validator: validateMandatoryField,
                  value: controller.model.categoryId,
                  items: _getCategories(),
                  onChanged: (value) => controller.model.categoryId = value,
                ),
              )
            : Container(),
        TextFormField(
          initialValue: controller.model.name,
          onChanged: (value) => controller.model.name = value,
          decoration: InputDecoration(
            labelText: S.of(context).productPageName,
          ),
          validator: validateMandatoryField,
        ),
        SizedBox(
          height: 16.0,
        ),
        TextFormField(
          initialValue: controller.model.brand,
          onChanged: (value) => controller.model.brand = value,
          decoration: InputDecoration(
            labelText: S.of(context).productPageBrand,
          ),
          validator: validateMandatoryField,
        ),
        SizedBox(
          height: 16.0,
        ),
        TextFormField(
          initialValue: controller.model.url,
          onChanged: (value) => controller.model.url = value,
          decoration: InputDecoration(
            labelText: S.of(context).productPageImageUrl,
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    if (controller.isInAsyncCall) return Loading();
    if (controller.hasLoadError)
      return CenterText(
        S.of(context).failLoadData,
        action: RaisedButton(
          child: Text(
            S.of(context).tryAgain,
          ),
          onPressed: () => controller.load(widget.id),
        ),
      );

    if (controller.model != null)
      return _buildFormFields();
    else
      return CenterText(
        S.of(context).noData,
      );
  }

  List<DropdownMenuItem<int>> _getCategories() {
    if (controller.categories == null) return [];
    return controller.categories
        .map(
          (e) => DropdownMenuItem<int>(
            value: e.id,
            child: Text(e.name),
          ),
        )
        .toList();
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
          builder: (_) =>
              !controller.isInAsyncCall ? BackButton() : Container(),
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
            visible: !controller.isInAsyncCall && !controller.hasLoadError,
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
