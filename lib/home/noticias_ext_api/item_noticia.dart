import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_login/models/new.dart';
import 'package:extended_image/extended_image.dart';

import 'item_noticias_details.dart';

class ItemNoticia extends StatefulWidget {
  final New noticia;
  ItemNoticia({Key key, @required this.noticia}) : super(key: key);
  
  @override
  _ItemNoticiaState createState() => _ItemNoticiaState();
}

class _ItemNoticiaState extends State<ItemNoticia> {
  @override
  Widget build(BuildContext context) {
    var noticia = widget.noticia;

    return Container(
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: GestureDetector(
        onTap: _openDetails,
          child: Card(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ExtendedImage.network(
                    noticia.urlToImage==null ? 'https://cima-afrique.org/cima/images/not-available.png':noticia.urlToImage,
                    height: MediaQuery.of(context).size.height / 5.7,
                    fit: BoxFit.cover,
                    cache: true,
                  )
                  /*Image.network(
                    "${noticia.urlToImage==null ? :noticia.urlToImage}",
                    height: MediaQuery.of(context).size.height / 5.5,
                    fit: BoxFit.cover,
                  ),*/
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width-180.0,
                              child: Text(
                                "${noticia.title}",
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Container(
                              child: noticia.source == null
                              ? Container()
                              : IconButton(
                                icon: Icon(Icons.upload,
                                    color: Colors.black),
                                onPressed: () async {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection("noticias")
                                        .add(noticia.toJson());
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                        SnackBar(
                                          content: Text("Guardado en Firebase"),
                                        ),
                                      );
                                    return true;
                                  } catch (e) {
                                    print("Error: $e");
                                    return false;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${noticia.publishedAt}",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "${noticia.description ?? "Descripcion no disponible"}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "${noticia.author ?? "Autor no disponible"}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _openDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ItemNewDetailsPage(
            noticia: widget.noticia,
          );
        },
      ),
    );
  }
}
