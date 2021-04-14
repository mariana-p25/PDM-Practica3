import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_login/models/new.dart';
import 'package:google_login/utils/news_repository.dart';
import 'package:meta/meta.dart';

part 'noticias_event.dart';
part 'noticias_state.dart';

class NoticiasBloc extends Bloc<NoticiasEvent, NoticiasState> {
  NoticiasBloc() : super(NoticiasInitial());
  String _word = "sports";

  @override
  Stream<NoticiasState> mapEventToState(
    NoticiasEvent event,
  ) async* {
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
