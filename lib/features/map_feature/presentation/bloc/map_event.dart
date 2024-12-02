part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class SearchPlaceEvent extends MapEvent {
  final String searchTerm;

  const SearchPlaceEvent({required this.searchTerm});

  @override
  List<Object?> get props => [searchTerm];
}

class SetSelectedLocationEvent extends MapEvent {
  final String placeId;

  const SetSelectedLocationEvent({required this.placeId});

  @override
  List<Object?> get props => [placeId];
}

class SetCurrentLocationEvent extends MapEvent {
  final num? initialLatitude;
  final num? initialLongitude;

  const SetCurrentLocationEvent(this.initialLatitude, this.initialLongitude);

  @override
  List<Object?> get props => [initialLatitude, initialLongitude];
}

class ClearSelectedLocationEvent extends MapEvent {
  const ClearSelectedLocationEvent();

  @override
  List<Object?> get props => [];
}
