import 'package:dartz/dartz.dart';
import '../entities/sub_data.dart';

import '../../../../core/errors/failures.dart';

abstract class PostRepository {
  Future<Either<Failure, SubData>> getAListOfPostsFromFlutterDev();
}
