import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/place.dart';
import '../repositories/map_repository.dart';

@injectable
class GetPlaceUseCase {
  final MapRepository mapRepository;

  GetPlaceUseCase({required this.mapRepository});

  Future<Either<Failure, Place>> call(String placeId) async {
    return await mapRepository.getPlace(placeId);
  }
}
