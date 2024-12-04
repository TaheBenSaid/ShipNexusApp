import 'package:floor/floor.dart';
import 'package:shipnexusapp/features/manage_user_feature/data/data_sources/locale/user_entity.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users WHERE id = :id')
  Future<UserEntity?> getUserById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUser(UserEntity userEntity);
}
