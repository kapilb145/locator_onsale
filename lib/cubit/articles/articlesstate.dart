import 'package:flutter/cupertino.dart';

import '../../model/shoplistresponse.dart';



@immutable
abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ArticlesSuccess extends ArticlesState {
  final List<Art> articleResponse;

  ArticlesSuccess(this.articleResponse);
}



class ArticlesLoading extends ArticlesState {}

class ArticlesError extends ArticlesState {
  final String message;

  ArticlesError(this.message);
}
