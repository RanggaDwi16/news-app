import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';
import 'package:news_app/core/utils/errors/dio_error.dart';

abstract class HomeRemoteDatasources {
  Future<Either<String, List<NewsModel>>> getAllNews();
}

class HomeRemoteDataSouceImpl implements HomeRemoteDatasources {
  final Dio httpClient;

  HomeRemoteDataSouceImpl({required this.httpClient});

  @override
  Future<Either<String, List<NewsModel>>> getAllNews() async {
    try {
      final response = await httpClient.get('');
      
      if(response.statusCode ==200) {
        final news = response.data['articles'];
        final newsList = news.map<NewsModel>((e) => NewsModel.fromJson(e)).toList();
        return Right(newsList);
      } else if (response.statusCode == 401) {
        return Left(response.data['message']);
      } else {
        return Left('Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final error = await DioErrorHandler.handleError(e);
      return Left('Error: $error');
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
