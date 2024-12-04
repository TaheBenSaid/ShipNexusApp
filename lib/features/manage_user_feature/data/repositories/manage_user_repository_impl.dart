import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/manage_user_repository.dart';
import '../data_sources/locale/manage_user_locale_data_source.dart';
import '../data_sources/remote/manage_user_remote_data_source.dart';
import '../../../../core/strings/messages.dart';
import '../../../../core/utils/services/navigation_service.dart';

@Injectable(as: ManageUserRepository)
class ManageUserRepositoryImpl extends ManageUserRepository {
  final NetworkInfo networkInfo;
  final ManageUserRemoteDataSource manageUserRemoteDataSource;
  final ManageUserLocaleDataSource manageUserLocaleDataSource;

  ManageUserRepositoryImpl({
    required this.manageUserRemoteDataSource,
    required this.manageUserLocaleDataSource,
    required this.networkInfo,
  });



  @override
  Future<Unit> cacheUser(User user) async {
    return await manageUserLocaleDataSource.cacheUser(user.toUserModel());
  }

  @override
  Future<User?> getCachedUser(String userId) async {
    final user = await manageUserLocaleDataSource.getCachedUser(userId);
    return user?.toUser();
  }

  @override
  Future<Either<Failure, User>> getRemoteUser(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await manageUserRemoteDataSource.getRemoteUser();
        return Right(remoteUser);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(message: NavigationService.instance.navigationKey.currentContext != null ? OFFLINE_FAILURE_MESSAGE : OFFLINE_FAILURE_MESSAGE));
    }
  }

}
