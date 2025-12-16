import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

import '../../data/utilities/failure/failure.dart';

/*
[R] is the return type of the use case
[P] is the parameter type of the use case
 */
abstract class BaseUseCase<R, P> {
  const BaseUseCase();

  Future<Either<Failure, R>> call(P params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
