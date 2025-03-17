import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app/core/helpers/widgets/shimmer_loading_widget.dart';
import 'package:news_app/core/provider/sqlite_provider.dart';
import 'package:news_app/core/utils/constant/app_colors.dart';
import 'package:news_app/features/favorite/widgets/item_news_favorite_widget.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  Future<void> _removeFromFavorites(NewsModel news) async {
    await DatabaseHelper.deleteNews(news.title ?? '');
    ref.invalidate(fetchFavoriteNewsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteNews = ref.watch(fetchFavoriteNewsProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Favorites',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: favoriteNews.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 50,
                  ),
                  Gap(10),
                  Text(
                    'No favorite news yet',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ));
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: data.length,
              separatorBuilder: (context, index) => Divider(
                color: isDarkMode
                    ? AppColor.lightModeGrey
                    : AppColor.darkModeBlack,
                thickness: 0.8,
              ),
              itemBuilder: (context, index) {
                final news = data[index];

                return ItemNewsFavoriteWidget(
                  news: news,
                  onTap: () => _removeFromFavorites(news),
                );
              },
            );
          },
          error: (error, stackTrace) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => const ShimmerLoading(),
        ),
      ),
    );
  }
}
