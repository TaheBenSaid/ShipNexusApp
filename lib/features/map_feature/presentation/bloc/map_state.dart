part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isLoading;
  final bool success;
  final String errorMessage;
  final Position? currentLocation;
  final List<PlaceSearch>? searchResults;
  final Place? selectedLocationStatic;
  final List<Place>? placeResults;

  const MapState({
    this.currentLocation,
    this.errorMessage = '',
    this.searchResults,
    this.selectedLocationStatic,
    this.placeResults,
    this.isLoading = false,
    this.success = false,
  });

  MapState copyWith({
    bool? isLoading,
    bool? success,
    String? errorMessage,
    Position? currentLocation,
    List<PlaceSearch>? searchResults,
    Place? selectedLocationStatic,
    List<Place>? placeResults,
  }) {
    return MapState(
        isLoading: isLoading ?? this.isLoading,
        success: success ?? this.success,
        errorMessage: errorMessage ?? this.errorMessage,
        currentLocation: currentLocation ?? this.currentLocation,
        searchResults: searchResults ?? this.searchResults,
        selectedLocationStatic:
            selectedLocationStatic ?? this.selectedLocationStatic,
        placeResults: placeResults ?? this.placeResults);
  }

  @override
  List<Object?> get props => [
        isLoading,
        success,
        errorMessage,
        currentLocation,
        searchResults,
        selectedLocationStatic
      ];
}
