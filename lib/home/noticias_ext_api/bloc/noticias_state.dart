part of 'noticias_bloc.dart';

abstract class NoticiasState extends Equatable {
  const NoticiasState();

  @override
  List<Object> get props => [];
}

class NoticiasInitial extends NoticiasState {}

class NoticiasLoadingState extends NoticiasState {}

class NoticiasLoadedState extends NoticiasState {
  final List<New> newsList;

  NoticiasLoadedState({@required this.newsList});
  @override
  List<Object> get props => [newsList];
}  

class NewsErrorState extends NoticiasState {
  final String errorMessage;

  NewsErrorState({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
