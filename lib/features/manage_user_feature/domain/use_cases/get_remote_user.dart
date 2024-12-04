import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/manage_user_repository.dart';

@Injectable()
class GetRemoteUserUseCase {
  final ManageUserRepository manageUserRepository;

  GetRemoteUserUseCase({required this.manageUserRepository});

  Future<Either<Failure, User?>> call(String userId) async {
    return await manageUserRepository.getRemoteUser(userId);
  }
}
