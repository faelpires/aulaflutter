import 'package:aula4/models/product_model.dart';
import 'package:aula4/product_form.dart';
import 'package:aula4/repositories/interfaces/iproduct_repository.dart';
import 'package:aula4/repositories/product_repository.dart';
import 'package:flutter/material.dart';

class ProductsList extends StatefulWidget {
  ProductsList({Key key}) : super(key: key);

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  IProductRepository _repository = ProductRepository();
  Future<List<ProductModel>> _model;

  @override
  void initState() {
    super.initState();

    _loadList();
  }

  void _loadList() {
    setState(() {
      _model = _repository.getAll();
    });
  }

  void _edit(int id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductForm(
          id: id,
        ),
      ),
    );
    _loadList();
  }

  void _add() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductForm(),
      ),
    );
    _loadList();
  }

  void _delete(int id) async {
    Widget noButton = FlatButton(
      child: Text("NÃO"),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("SIM"),
      onPressed: () async {
        await _repository.remove(id);
        Navigator.pop(context);
        _loadList();
      },
    );

    var alertDialog = AlertDialog(
      title: Text("Excluir"),
      content: Text(
        'Confirma a exclusão deste registro? Esta ação não\ '
        'poderá ser desfeita.',
      ),
      actions: [
        yesButton,
        noButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: FutureBuilder<List<ProductModel>>(
          future: _model,
          builder: (context, snapshot) {
            Widget result = Container();

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
                  result = RefreshIndicator(
                    onRefresh: () async {
                      _loadList();
                    },
                    child: Scrollbar(
                      child: ListView.separated(
                        padding: EdgeInsets.only(bottom: 76),
                        separatorBuilder: (_, __) => Divider(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[index];

                          return ListTile(
                            leading: data.url != null && data.url.isNotEmpty
                                ? Image.network(data.url)
                                : Image.asset('assets/images/phone_mockup.png'),
                            title: Text(data.name),
                            subtitle: Text(data.brand),
                            trailing: IconButton(
                              icon: Icon(Icons.delete_forever),
                              onPressed: () => _delete(data.id),
                            ),
                            onTap: () => _edit(data.id),
                          );
                        },
                      ),
                    ),
                  );
                } else
                  result = Text("Não tem dados para exibir");

                break;
              default:
            }

            return result;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Adicionar',
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
