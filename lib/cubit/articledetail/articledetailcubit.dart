import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator_sample/services/repository.dart';

import 'articledetailstate.dart';

class ArticleDetailCubit extends  Cubit<ArticleDetailState>{

  final MarketPlaceRepository  _repository;

 ArticleDetailCubit(this._repository) : super(ArticleDetailInitial());


  Future<void> getArticleDetail() async {
    try {

      emit(ArticleDetailLoading());

      String newsDetailResponse = await _repository.shopListDetail();

      emit(ArticleDetailSuccess(newsDetailResponse));

      print(newsDetailResponse );
    }catch(e){
      emit(ArticleDetailError(e.toString()));
    }
  }

}