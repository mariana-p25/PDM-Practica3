import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/models/new.dart';
import 'package:google_login/utils/news_repository.dart';
import 'package:hive/hive.dart';

import 'bloc/noticias_bloc.dart';
import 'item_noticia.dart';

class Noticias extends StatefulWidget {
  const Noticias({Key key}) : super(key: key);

  @override
  _NoticiasState createState() => _NoticiasState();
}

class _NoticiasState extends State<Noticias> {
  var input = new TextEditingController();
  Box _newsBox = Hive.box("Noticias");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NoticiasBloc(),
        child: BlocConsumer<NoticiasBloc, NoticiasState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is NoticiasLoadedState) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: input,
                      decoration: InputDecoration(
                        hintText: "Palabra a buscar",
                        suffixIcon: IconButton(
                          onPressed: () {
                            BlocProvider.of<NoticiasBloc>(context)
                                .add(SearchNewsEvent(queryText: input.text));
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                      onSubmitted: (content) {
                        BlocProvider.of<NoticiasBloc>(context)
                            .add(SearchNewsEvent(queryText: input.text));
                      },
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        itemCount: state.newsList.length,
                        itemBuilder: (context, index) {
                          return ItemNoticia(
                            noticia: state.newsList[index],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is NoticiasLoadingState) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: input,
                      decoration: InputDecoration(
                        hintText: "Palabra a buscar",
                        suffixIcon: IconButton(
                          onPressed: () {
                            BlocProvider.of<NoticiasBloc>(context)
                                .add(SearchNewsEvent(queryText: input.text));
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                      onSubmitted: (content) {
                        BlocProvider.of<NoticiasBloc>(context)
                            .add(SearchNewsEvent(queryText: input.text));
                      },
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: input,
                    decoration: InputDecoration(
                      hintText: "Palabra a buscar",
                      suffixIcon: IconButton(
                        onPressed: () {
                          BlocProvider.of<NoticiasBloc>(context)
                              .add(SearchNewsEvent(queryText: input.text));
                        },
                        icon: Icon(Icons.search),
                      ),
                    ),
                    onSubmitted: (content) {
                      BlocProvider.of<NoticiasBloc>(context)
                          .add(SearchNewsEvent(queryText: input.text));
                    },
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: NewsRepository().getAvailableNoticias(0, "sports"),
                    builder: (context, snapshot) {
                      print(snapshot.hasError);
                      if (snapshot.hasError) {
                        /*List<New> sportsList = _newsBox.get("noticias");
                        print(sportsList);
                        return ListView.builder(
                          itemCount: sportsList.length,
                          itemBuilder: (context, index) {
                            return ItemNoticia(
                              noticia: sportsList[index],
                            );
                          },
                        );*/
                        return Center(
                          child: Text("Algo salio mal",
                              style: TextStyle(fontSize: 32)),
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ItemNoticia(
                              noticia: snapshot.data[index],
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ));
  }
}
