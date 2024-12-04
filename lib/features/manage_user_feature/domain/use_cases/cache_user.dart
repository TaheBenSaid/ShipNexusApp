import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../entities/user.dart';
import '../repositories/manage_user_repository.dart';

@Injectable()
class CacheUserUseCase {
  final ManageUserRepository manageUserRepository;

  CacheUserUseCase({required this.manageUserRepository});

  Future<Unit> call(User user) async {
    return await manageUserRepository.cacheUser(user);
  }
}
