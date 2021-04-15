import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_login/models/new.dart';
import 'package:google_login/utils/news_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'noticias_event.dart';
part 'noticias_state.dart';

class NoticiasBloc extends Bloc<NoticiasEvent, NoticiasState> {
  NoticiasBloc() : super(NoticiasInitial());
  String _word = "sports";
  Box _newsBox = Hive.box("Noticias");

  @override
  Stream<NoticiasState> mapEventToState(
    NoticiasEvent event,
  ) async* {
    var news = await NewsRepository().getAvailableNoticias(0, "sports");
    print(news);
    await _newsBox.put("noticias", news);
    print("AAAAAAAAA");
    print(_newsBox.get(""));
    if (event is SearchNewsEvent) {
      try {
        yield NoticiasLoadingState();
        _word = event.queryText;
        var news = await NewsRepository().getAvailableNoticias(1, _word);
        print(news);
        yield NoticiasLoadedState(
          newsList: news.toList(),
        );
      } catch (e) {
        yield NewsErrorState(errorMessage: "$e");
      }
    }
  }
}
