part of 'noticias_bloc.dart';

@immutable
abstract class NoticiasEvent extends Equatable {
  const NoticiasEvent();

  @override
  List<Object> get props => [];
}

class SearchNewsEvent extends NoticiasEvent {
  final String queryText;

  SearchNewsEvent({@required this.queryText});
  @override
  List<Object> get props => [queryText];
}
