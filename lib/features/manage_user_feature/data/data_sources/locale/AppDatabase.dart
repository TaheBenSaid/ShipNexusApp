import 'package:floor/floor.dart';
import 'package:shipnexusapp/features/manage_user_feature/data/data_sources/locale/user_dao.dart';
import 'package:shipnexusapp/features/manage_user_feature/data/data_sources/locale/user_entity.dart';


@Database(version: 5, entities: [UserEntity])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}
