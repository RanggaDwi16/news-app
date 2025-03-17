import 'package:dartz/dartz.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';
import 'package:news_app/features/home/domain/repository/home_repository.dart';
import 'package:news_app/core/utils/usecase/usecase.dart';

class GetAllNews implements UseCase<List<NewsModel>, void> {
  final HomeRepository homeRepository;

  GetAllNews({required this.homeRepository});

  @override
  Future<Either<String, List<NewsModel>>> call(void params) {
    return homeRepository.getAllNews();
  }

  
}
