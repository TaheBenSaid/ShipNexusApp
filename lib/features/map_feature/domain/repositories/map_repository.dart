import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/place.dart';
import '../../data/models/place_search.dart';
abstract class MapRepository {
  Future<Either<Failure, List<PlaceSearch>>> getAutoComplete(
      String search);
  Future<Either<Failure, Place>> getPlace(
      String placeId);
  Future<Either<Failure, List<Place>>> getPlaces(
      double lat, double lng, String placeType);
}
