import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/place_search.dart';
import '../repositories/map_repository.dart';

@injectable
class GetAutoCompleteUseCase {
  final MapRepository mapRepository;

  GetAutoCompleteUseCase({required this.mapRepository});

  Future<Either<Failure, List<PlaceSearch>>> call(String search) async {
    return await mapRepository.getAutoComplete(search);
  }
}
