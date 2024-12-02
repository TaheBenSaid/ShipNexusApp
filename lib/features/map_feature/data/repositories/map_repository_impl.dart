import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/services/navigation_service.dart';
import '../../domain/repositories/map_repository.dart';
import '../data_sources/map_remote_data_source.dart';
import '../models/place.dart';
import '../models/place_search.dart';
import '../../../../core/strings/messages.dart';

@Injectable(as: MapRepository)
class MapRepositoryImpl extends MapRepository {
  final MapRemoteDataSource mapRemoteDataSource;
  final NetworkInfo networkInfo;

  MapRepositoryImpl(
      {required this.mapRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<PlaceSearch>>> getAutoComplete(
      String search) async {
    if (await networkInfo.isConnected) {
      try {
        final map = await mapRemoteDataSource.getAutocomplete(search);
        return Right(map);
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
  Future<Either<Failure, Place>> getPlace(String placeId) async {
    if (await networkInfo.isConnected) {
      try {
        final map = await mapRemoteDataSource.getPlace(placeId);
        return Right(map);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure(
          message: NavigationService.instance.navigationKey.currentContext !=
                  null
              ? OFFLINE_FAILURE_MESSAGE

              : OFFLINE_FAILURE_MESSAGE));
    }
  }

  @override
  Future<Either<Failure, List<Place>>> getPlaces(
      double lat, double lng, String placeType) async {
    if (await networkInfo.isConnected) {
      try {
        final map = await mapRemoteDataSource.getPlaces(lat, lng, placeType);
        return Right(map);
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
