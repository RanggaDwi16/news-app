import 'package:news_app/features/home/controllers/get_all_news/get_all_news_provider.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';
import 'package:news_app/features/home/domain/usecases/get_all_news.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_all_news_provider.g.dart';

@riverpod
class FetchAllNews extends _$FetchAllNews {
  @override
  FutureOr<List<NewsModel>?> build() async {
    GetAllNews getAllNews = ref.watch(getAllNewsProvider);
    final result = await getAllNews.call(null);
    return result.fold(
      (error) => throw Exception(error),
      (newsList) => newsList,
    );
  }
}
