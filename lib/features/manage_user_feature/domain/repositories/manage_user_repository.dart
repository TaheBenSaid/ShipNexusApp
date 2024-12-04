import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class ManageUserRepository {
  Future<Unit> cacheUser(User user);

  Future<User?> getCachedUser(String userId);

  Future<Either<Failure, User>> getRemoteUser(String userId);
}
