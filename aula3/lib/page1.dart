import 'package:flutter/material.dart';
import 'package:aula3/app_drawer.dart';
import 'package:aula3/models/image_model.dart';
import 'package:aula3/page2.dart';
import 'package:aula3/like_button.dart';
import 'package:aula3/repositories/image_repository.dart';
import 'package:aula3/repositories/interfaces/iimage_repository.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  var tela = "";
  IImageRepository repository = ImageRepository();
  Future<ImageModel> _model;

  @override
  void initState() {
    super.initState();

    _model = repository.get();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Page 1'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              setState(() {
                tela = "page3";
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page2(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: size.width,
        child: FutureBuilder<ImageModel>(
          future: _model,
          builder: (context, snapshot) {
            Widget result = Container();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                result = Text("Carregando...");
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  result = Scrollbar(
                    child: ListView.builder(
                      itemCount: snapshot.data.hits.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data.hits[index];

                        return ListTile(
                          leading: Image.network(data.previewURL),
                          title: Text(data.tags),
                          subtitle: Text(
                              'Altura: ${data.imageHeight} / Largura: ${data.imageWidth}'),
                        );
                      },
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
    );
  }
}
