import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/strings/messages.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../../core/utils/services/navigation_service.dart';
import '../../../manage_user_feature/domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final PrefUtils prefUtils;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.prefUtils,
    required this.networkInfo,
  });

  // Login user with email and password...
  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await authRemoteDataSource.login(email, password);
        return Right(userModel);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.logout();
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        print("qwertyuio");
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, Unit>> refreshToken() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRefreshToken = await authRemoteDataSource.refreshToken();
        return Right(remoteRefreshToken);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> resendCode(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final userData =
            await authRemoteDataSource.resendCodeForgetPassword(email);
        return Right(userData);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetCodeConfirmation(String resetCode) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.resetCodeConfirmation(resetCode);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, Unit>> confirmCodeRegister(
      String code, String confirmationType) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.confirmCodeRegister(code, confirmationType);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, Unit>> newPassword(
      String resetCode, String password) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.newPassword(resetCode, password);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  // Mail verification...
  @override
  Future<Either<Failure, Unit>> mailVerification(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.mailVerification(userId);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  // Sms verification...
  @override
  Future<Either<Failure, Unit>> smsVerification(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.smsVerification(userId);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        print(e);
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, String>> register(
      String name, String email, String phoneNumber, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userId = await authRemoteDataSource.register(
            name, email, phoneNumber, password);
        return Right(userId);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message:
              NavigationService.instance.navigationKey.currentContext != null
                  ? OFFLINE_FAILURE_MESSAGE
                  : OFFLINE_FAILURE_MESSAGE));
    }
  }
}
