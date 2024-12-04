import 'package:injectable/injectable.dart';
import '../entities/user.dart';
import '../repositories/manage_user_repository.dart';

@Injectable()
class GetCachedUserUseCase {
  final ManageUserRepository manageUserRepository;

  GetCachedUserUseCase({required this.manageUserRepository});

  Future<User?> call(String userId) async {
    return await manageUserRepository.getCachedUser(userId);
  }
}
