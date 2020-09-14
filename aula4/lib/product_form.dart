import 'package:aula4/models/product_model.dart';
import 'package:aula4/repositories/interfaces/iproduct_repository.dart';
import 'package:aula4/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  ProductForm({this.id});

  final int id;

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  Future<ProductModel> _model;
  final IProductRepository _repository = ProductRepository();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _controllerBrand = TextEditingController();
  var _controllerName = TextEditingController();
  var _controllerUrl = TextEditingController();
  var _isSaving = false;

  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      _model = _repository.getById(widget.id);
    }
  }

  void _save() async {
    if (_formKey.currentState.validate()) {
      try {
        setState(() {
          _isSaving = true;
        });

        var model = ProductModel(
          id: widget.id,
          name: _controllerName.text,
          brand: _controllerBrand.text,
          url: _controllerUrl.text.isNotEmpty ? _controllerUrl.text : null,
        );

        if (widget.id == null) {
          await _repository.add(model);
        } else {
          await _repository.update(widget.id, model);
        }

        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () async {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );

        var alertDialog = AlertDialog(
          title: Text("Sucesso"),
          content: Text(
            'Registro salvo com sucesso!',
          ),
          actions: [
            okButton,
          ],
        );

        setState(() {
          _isSaving = false;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          },
        );
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Não foi possível salvar os dados.'),
            action: SnackBarAction(
              label: 'TENTAR NOVAMENTE',
              onPressed: _save,
            ),
          ),
        );
      }
    }
  }

  Widget _buildForm() {
    return Column(
      children: [
        TextFormField(
          controller: _controllerName,
          decoration: InputDecoration(
            labelText: 'Nome',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'O campo é obrigatório.';
            }
            return null;
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        TextFormField(
          controller: _controllerBrand,
          decoration: InputDecoration(
            labelText: 'Marca',
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'O campo é obrigatório.';
            }
            return null;
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        TextFormField(
          controller: _controllerUrl,
          decoration: InputDecoration(
            labelText: 'Url Imagem',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Produto'),
        automaticallyImplyLeading: !_isSaving,
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
            child: _isSaving
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                : FutureBuilder<ProductModel>(
                    future: _model,
                    builder: (context, snapshot) {
                      Widget result = _buildForm();

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          result = Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          );
                          break;
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            if (_controllerName.text.isEmpty)
                              _controllerName.text = snapshot.data.name;

                            if (_controllerBrand.text.isEmpty)
                              _controllerBrand.text = snapshot.data.brand;

                            if (_controllerUrl.text.isEmpty)
                              _controllerUrl.text = snapshot.data.url;

                            result = _buildForm();
                          } else
                            result = Text("Não tem dados para exibir");

                          break;
                        default:
                      }

                      return result;
                    },
                  ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !_isSaving,
        child: FloatingActionButton(
          onPressed: _save,
          tooltip: 'Salvar',
          child: Icon(
            Icons.check,
          ),
        ),
      ),
    );
  }
}
