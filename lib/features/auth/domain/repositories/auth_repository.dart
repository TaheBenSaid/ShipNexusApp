import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../manage_user_feature/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> refreshToken();

  Future<Either<Failure, String>> register(
      String name, String email, String phoneNumber, String password);
  Future<Either<Failure, dynamic>> resendCode(String email);

  Future<Either<Failure, Unit>> resetCodeConfirmation(String resetCode);

  Future<Either<Failure, Unit>> confirmCodeRegister(
      String code, String confirmationType);

  Future<Either<Failure, Unit>> newPassword(String resetCode, String password);

  Future<Either<Failure, Unit>> mailVerification(String userId);

  Future<Either<Failure, Unit>> smsVerification(String userId);
}
