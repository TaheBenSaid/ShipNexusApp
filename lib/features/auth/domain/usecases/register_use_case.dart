import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failure, String>> call(
      String name, String email, String phoneNumber, String password) async {
    return await authRepository.register(name, email, phoneNumber, password);
  }
}
