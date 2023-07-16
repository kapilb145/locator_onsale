
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator_sample/model/shoplistresponse.dart';
import 'package:locator_sample/services/repository.dart';


import 'articlesstate.dart';

class ArticlesCubit extends Cubit<ArticlesState> {

  final MarketPlaceRepository  _repository;

  ArticlesCubit(this._repository) : super(ArticlesInitial());

  Future<void> articles() async {
    try {
      emit(ArticlesLoading());

      List<Art> art = await _repository.getArts();

      emit(ArticlesSuccess(art));
    } catch (e) {
      emit(ArticlesError(e.toString()));
    }
  }


}
