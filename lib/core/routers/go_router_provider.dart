import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/features/favorite/pages/favorite_page.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';
import 'package:news_app/features/home/pages/detail_news_page.dart';
import 'package:news_app/features/home/pages/home_page.dart';
import 'package:news_app/features/splash/pages/splash_page.dart';
import 'package:news_app/core/routers/router_name.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) {
  return GoRouter(
    initialLocation: RouterName.splash,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: RouterName.home,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                  child: child,
                ),
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/splash',
        name: RouterName.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/detail-news',
        name: RouterName.detailNews,
        pageBuilder: (context, state) {
          final news = state.extra as NewsModel;
          return CustomTransitionPage(
            key: state.pageKey,
            child: DetailNewsPage(news: news),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(animation),
                  child: child,
                ),
              );
            },
          );
        },
      ),
      GoRoute(
        path: '/favorite',
        name: RouterName.favorite,
        builder: (context, state) => const FavoritePage(),
      ),
    ],
  );
}
