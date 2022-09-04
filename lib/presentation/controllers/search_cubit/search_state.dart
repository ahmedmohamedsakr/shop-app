part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchSuccessState extends SearchState {
  final SearchProduct model;
  SearchSuccessState(this.model);
}
class SearchErrorState extends SearchState {
  final String error;
  SearchErrorState(this.error);
}
class SearchLoadingState extends SearchState {}
