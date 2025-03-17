import 'package:dartz/dartz.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<String, Type>> call(Params params);
}