import 'package:dartz/dartz.dart';
import 'package:news_app/features/home/data/datasources/home_remote_datasources.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';
import 'package:news_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasources homeRemoteDatasources;

  HomeRepositoryImpl({required this.homeRemoteDatasources});

  @override
  Future<Either<String, List<NewsModel>>> getAllNews() async {
    try {
      final result = await homeRemoteDatasources.getAllNews();
      return result.fold(
        (error) => Left(error),
        (newsList) => Right(newsList),
      );
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
