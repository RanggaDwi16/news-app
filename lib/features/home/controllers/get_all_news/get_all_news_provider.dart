import 'package:news_app/features/home/controllers/home_impl_provider.dart';
import 'package:news_app/features/home/domain/usecases/get_all_news.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_all_news_provider.g.dart';

@riverpod
GetAllNews getAllNews (GetAllNewsRef ref) {
  return GetAllNews(homeRepository: ref.watch(homeRepositoryProvider));
}