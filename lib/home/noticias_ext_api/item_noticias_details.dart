import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';
import 'package:share/share.dart';

class ItemNewDetailsPage extends StatefulWidget {
  final New noticia;
  ItemNewDetailsPage({
    Key key,
    @required this.noticia,
  }) : super(key: key);

  @override
  ItemNewDetailsPageState createState() => ItemNewDetailsPageState();
}

class ItemNewDetailsPageState extends State<ItemNewDetailsPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var noticia = widget.noticia;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Detalles de noticia"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: <Widget>[
                        Container(
                          child: Image.network(
                            noticia.urlToImage==null ? 'https://cima-afrique.org/cima/images/not-available.png':noticia.urlToImage,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ]
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          width: 300,
                          child: Column(
                            children: <Widget>[
                              Text("${noticia.title}",
                                  style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Column(
                            children: <Widget>[
                              Text("${noticia.author}\n${noticia.source==null?'': noticia.source.name}\n${noticia.publishedAt}",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8.0, left: 8.0),
                          width: 300,
                          child: Column (
                            children: <Widget>[
                              Text("${noticia.content==null?noticia.description:noticia.content}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0, top: 48.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      padding: EdgeInsets.all(20.0),
                      color: Colors.purple,
                      child: Text(
                        "Compartir noticia",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        final RenderBox box = context.findRenderObject() as RenderBox;
                        await Share.share(noticia.url==null?noticia.description:noticia.url,
                          subject: noticia.title,
                          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}