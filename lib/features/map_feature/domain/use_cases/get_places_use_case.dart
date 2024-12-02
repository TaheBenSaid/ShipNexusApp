import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/place.dart';
import '../repositories/map_repository.dart';

@injectable
class GetPlacesUseCase {
  final MapRepository mapRepository;
  GetPlacesUseCase({required this.mapRepository});
  Future<Either<Failure, List<Place>>> call(
      double lat, double lng, String placeType) async {
    return await mapRepository.getPlaces(lat, lng, placeType);
  }
}
