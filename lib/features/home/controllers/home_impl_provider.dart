import 'package:news_app/core/provider/dio_provider.dart';
import 'package:news_app/features/home/data/datasources/home_remote_datasources.dart';
import 'package:news_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:news_app/features/home/domain/repository/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_impl_provider.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl(
      homeRemoteDatasources:
          HomeRemoteDataSouceImpl(httpClient: ref.watch(dioProvider)));
}
