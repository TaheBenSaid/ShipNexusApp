// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:shipnexusapp/core/di/core_module.dart' as _i1072;
import 'package:shipnexusapp/core/network/interceptor/AuthInterceptor.dart'
    as _i85;
import 'package:shipnexusapp/core/network/interceptor/HttpInterceptor.dart'
    as _i939;
import 'package:shipnexusapp/core/network/network_info.dart' as _i258;
import 'package:shipnexusapp/core/utils/pref_utils.dart' as _i615;
import 'package:shipnexusapp/features/auth/data/datasources/auth_remote_data_source.dart'
    as _i432;
import 'package:shipnexusapp/features/manage_user_feature/data/data_sources/locale/AppDatabase.dart'
    as _i217;
import 'package:shipnexusapp/features/manage_user_feature/data/data_sources/locale/manage_user_locale_data_source.dart'
    as _i142;
import 'package:shipnexusapp/features/manage_user_feature/data/data_sources/remote/manage_user_remote_data_source.dart'
    as _i67;
import 'package:shipnexusapp/features/manage_user_feature/data/repositories/manage_user_repository_impl.dart'
    as _i904;
import 'package:shipnexusapp/features/manage_user_feature/domain/repositories/manage_user_repository.dart'
    as _i201;
import 'package:shipnexusapp/features/manage_user_feature/domain/use_cases/cache_user.dart'
    as _i340;
import 'package:shipnexusapp/features/manage_user_feature/domain/use_cases/get_cached_user.dart'
    as _i696;
import 'package:shipnexusapp/features/manage_user_feature/domain/use_cases/get_remote_user.dart'
    as _i574;
import 'package:shipnexusapp/features/map_feature/data/data_sources/map_remote_data_source.dart'
    as _i1005;
import 'package:shipnexusapp/features/map_feature/data/repositories/map_repository_impl.dart'
    as _i660;
import 'package:shipnexusapp/features/map_feature/domain/repositories/map_repository.dart'
    as _i391;
import 'package:shipnexusapp/features/map_feature/domain/use_cases/get_autocomplete_use_case.dart'
    as _i245;
import 'package:shipnexusapp/features/map_feature/domain/use_cases/get_place_use_case.dart'
    as _i237;
import 'package:shipnexusapp/features/map_feature/domain/use_cases/get_places_use_case.dart'
    as _i1002;
import 'package:shipnexusapp/features/map_feature/presentation/bloc/map_bloc.dart'
    as _i531;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModule = _$CoreModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => coreModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i519.Client>(() => coreModule.httpClient);
    gh.lazySingleton<_i973.InternetConnectionChecker>(
        () => coreModule.dataConnectionChecker);
    gh.singleton<_i85.AuthenticatedHttpClient>(() =>
        _i85.AuthenticatedHttpClient(
            sharedPref: gh<_i460.SharedPreferences>()));
    gh.factory<_i142.ManageUserLocaleDataSource>(() =>
        _i142.ManageUserLocaleDataSourceImpl(
            appDatabase: gh<_i217.AppDatabase>()));
    gh.factory<_i615.PrefUtils>(() => _i615.PrefUtilsImpl(
          sharedPreferences: gh<_i460.SharedPreferences>(),
          httpClientInterceptor: gh<_i85.AuthenticatedHttpClient>(),
        ));
    gh.factory<_i939.HttpInterceptor>(() => _i939.HttpInterceptorImpl(
        httpClient: gh<_i85.AuthenticatedHttpClient>()));
    gh.factory<_i432.AuthRemoteDataSource>(() => _i432.AuthRemoteDataSourceImpl(
          httpClient: gh<_i939.HttpInterceptor>(),
          prefUtils: gh<_i615.PrefUtils>(),
        ));
    gh.factory<_i67.ManageUserRemoteDataSource>(() =>
        _i67.ManageUserRemoteDataSourceImpl(
            httpClient: gh<_i939.HttpInterceptor>()));
    gh.factory<_i1005.MapRemoteDataSource>(() => _i1005.MapRemoteDataSourceImpl(
        httpClient: gh<_i939.HttpInterceptor>()));
    gh.factory<_i391.MapRepository>(() => _i660.MapRepositoryImpl(
          mapRemoteDataSource: gh<_i1005.MapRemoteDataSource>(),
          networkInfo: gh<_i258.NetworkInfo>(),
        ));
    gh.factory<_i201.ManageUserRepository>(() => _i904.ManageUserRepositoryImpl(
          manageUserRemoteDataSource: gh<_i67.ManageUserRemoteDataSource>(),
          manageUserLocaleDataSource: gh<_i142.ManageUserLocaleDataSource>(),
          networkInfo: gh<_i258.NetworkInfo>(),
        ));
    gh.factory<_i245.GetAutoCompleteUseCase>(() =>
        _i245.GetAutoCompleteUseCase(mapRepository: gh<_i391.MapRepository>()));
    gh.factory<_i237.GetPlaceUseCase>(
        () => _i237.GetPlaceUseCase(mapRepository: gh<_i391.MapRepository>()));
    gh.factory<_i1002.GetPlacesUseCase>(() =>
        _i1002.GetPlacesUseCase(mapRepository: gh<_i391.MapRepository>()));
    gh.factory<_i531.MapBloc>(() => _i531.MapBloc(
          getPlacesUseCase: gh<_i1002.GetPlacesUseCase>(),
          getAutoCompleteUseCase: gh<_i245.GetAutoCompleteUseCase>(),
          getPlaceUseCase: gh<_i237.GetPlaceUseCase>(),
        ));
    gh.factory<_i574.GetRemoteUserUseCase>(() => _i574.GetRemoteUserUseCase(
        manageUserRepository: gh<_i201.ManageUserRepository>()));
    gh.factory<_i696.GetCachedUserUseCase>(() => _i696.GetCachedUserUseCase(
        manageUserRepository: gh<_i201.ManageUserRepository>()));
    gh.factory<_i340.CacheUserUseCase>(() => _i340.CacheUserUseCase(
        manageUserRepository: gh<_i201.ManageUserRepository>()));
    return this;
  }
}

class _$CoreModule extends _i1072.CoreModule {}
