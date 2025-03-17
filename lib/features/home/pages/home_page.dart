import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app/core/provider/t.dart';
import 'package:news_app/core/routers/router_name.dart';
import 'package:news_app/features/home/controllers/get_all_news/fetch_all_news_provider.dart';
import 'package:news_app/features/home/provider/search_provider.dart';
import 'package:news_app/features/home/widgets/news_item_widget.dart';
import 'package:news_app/core/helpers/widgets/custom_searchfield.dart';
import 'package:news_app/core/helpers/widgets/shimmer_loading_widget.dart';
import 'package:news_app/core/provider/sqlite_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late ScrollController _scrollController;
  int _currentItemCount = 5; // Jumlah item yang ditampilkan
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _currentItemCount += 5; // Tambah 5 item lagi
        _isLoadingMore = false;
      });
    });
  }

  Future<void> _refreshNews() async {
    ref.invalidate(fetchAllNewsProvider);
    ref.invalidate(fetchFavoriteNewsProvider);
    setState(() {
      _currentItemCount = 5; // Reset pagination saat refresh
    });
  }

  @override
  Widget build(BuildContext context) {
    final allNews = ref.watch(fetchAllNewsProvider);
    final themePreference = ref.watch(themePreferenceProvider);
    final favoriteNews = ref.watch(fetchFavoriteNewsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: const Icon(Icons.newspaper),
        title: const Text(
          'Latest News',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  context.pushNamed(RouterName.favorite);
                },
                icon: const Icon(Icons.favorite_border),
              ),
              favoriteNews.when(
                data: (data) => data.isNotEmpty
                    ? Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${data.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                loading: () => const SizedBox.shrink(),
                error: (error, stackTrace) => const SizedBox.shrink(),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              final newTheme = themePreference == ThemePreference.dark
                  ? ThemePreference.light
                  : ThemePreference.dark;
              ref.read(themePreferenceProvider.notifier).setTheme(newTheme);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => RotationTransition(
                turns: child.key == const ValueKey('dark')
                    ? anim
                    : ReverseAnimation(anim),
                child: child,
              ),
              child: themePreference == ThemePreference.dark
                  ? const Icon(Icons.wb_sunny,
                      key: ValueKey('light'), color: Colors.yellow)
                  : const Icon(Icons.nightlight_round,
                      key: ValueKey('dark'), color: Colors.blueGrey),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            CustomSearchField(
              hintText: 'Search for news',
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
                setState(() {
                  _currentItemCount = 5; // Reset pagination saat pencarian
                });
              },
            ),
            const Gap(16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshNews,
                child: allNews.when(
                  data: (data) {
                    final filteredNews = searchQuery.isEmpty
                        ? data
                        : data!
                            .where((news) =>
                                news.title
                                    ?.toLowerCase()
                                    .contains(searchQuery.toLowerCase()) ??
                                false)
                            .toList();

                    if (filteredNews!.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off),
                            Gap(8),
                            Text(
                              'No news found',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    final displayedNews = filteredNews.take(_currentItemCount);

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount:
                          displayedNews.length + (_isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == displayedNews.length) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final news = displayedNews.elementAt(index);
                        return NewsItemWidget(news: news);
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    if (error.toString().contains('Connection error')) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _showNoConnectionDialog(context, ref);
                      });
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error),
                          const Gap(8),
                          Text(
                            error.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => const ShimmerLoading(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showNoConnectionDialog(BuildContext context, WidgetRef ref) {
  if (ModalRoute.of(context)?.isCurrent == true) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("No Internet Connection"),
        content:
            const Text("Please check your internet connection and try again."),
        actions: [
          TextButton(
            onPressed: () async {
              context.pop();
              ref.invalidate(fetchAllNewsProvider);
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
