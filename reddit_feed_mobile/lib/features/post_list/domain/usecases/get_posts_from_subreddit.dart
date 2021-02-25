import 'package:dartz/dartz.dart';
import '../entities/sub_data.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/post_repository.dart';

class GetPostsFromSubreddit implements UseCase<SubData, NoParams> {
  final PostRepository repository;

  GetPostsFromSubreddit(this.repository);

  @override
  Future<Either<Failure, SubData>> call(NoParams params) async {
    return await repository.getAListOfPostsFromFlutterDev();
  }
}
