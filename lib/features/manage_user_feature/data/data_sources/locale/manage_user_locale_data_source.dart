import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shipnexusapp/features/manage_user_feature/data/data_sources/locale/user_entity.dart';

import '../../models/user_model.dart';
import 'AppDatabase.dart';

abstract class ManageUserLocaleDataSource {
  Future<UserEntity?> getCachedUser(String userId);

  Future<Unit> cacheUser(UserModel userModel);
}

@Injectable(as: ManageUserLocaleDataSource)
class ManageUserLocaleDataSourceImpl implements ManageUserLocaleDataSource {
  final AppDatabase appDatabase;

  const ManageUserLocaleDataSourceImpl({required this.appDatabase});

  @override
  Future<Unit> cacheUser(UserModel userModel) async {
    final userDao = appDatabase.userDao;
    await userDao.insertUser(userModel.toUserEntity());
    return Future.value(unit);
  }

  @override
  Future<UserEntity?> getCachedUser(String userId) async {
    final userDao = appDatabase.userDao;
    final user = await userDao.getUserById(userId);
    return Future.value(user);
  }
}
