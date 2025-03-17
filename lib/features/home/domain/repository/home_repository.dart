import 'package:dartz/dartz.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';

abstract class HomeRepository {
  Future<Either<String, List<NewsModel>>> getAllNews();
}
