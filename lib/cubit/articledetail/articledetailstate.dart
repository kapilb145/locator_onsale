import 'package:flutter/cupertino.dart';





@immutable
abstract class ArticleDetailState{
}

class ArticleDetailInitial extends ArticleDetailState {}



class ArticleDetailSuccess extends ArticleDetailState {
  final String   newsDetailResponse ;
  ArticleDetailSuccess(this.newsDetailResponse);


}
class ArticleDetailLoading extends ArticleDetailState {}
class ArticleDetailError extends ArticleDetailState {
  final String message;

  ArticleDetailError(this.message);
}