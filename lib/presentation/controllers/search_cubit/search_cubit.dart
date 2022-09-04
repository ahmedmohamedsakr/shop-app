import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/services/service_locator.dart';
import 'package:shop_app/domain/entities/home/products.dart';
import 'package:shop_app/domain/entities/search_product/search_product.dart';
import 'package:shop_app/domain/usecases/search_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchProduct? searchModel;

  void search({required String text}) {
    emit(SearchLoadingState());
    sl<SearchUsecase>().execute(data: {
      'text': text,
    }).then(
      (value) {
        searchModel = value;
        // log('${searchModel?.data[0].image}');
        emit(SearchSuccessState(searchModel!));
      },
    ).catchError((error) {
      emit(SearchErrorState(error.toString()));
    });
  }

  Future<List<Products?>> getUserSuggestion(String text) async {
    SearchProduct? searchSuggestModel =
        await sl<SearchUsecase>().execute(data: {
      'text': text,
    });
    return searchSuggestModel.data;
  }
}
