import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/map_failure_to_message.dart';
import '../../data/models/place.dart';
import '../../data/models/geometry.dart';
import '../../data/models/location.dart';
import '../../data/models/place_search.dart';
import '../../domain/use_cases/get_autocomplete_use_case.dart';
import '../../domain/use_cases/get_place_use_case.dart';
import '../../domain/use_cases/get_places_use_case.dart';

part 'map_event.dart';

part 'map_state.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final GetPlacesUseCase getPlacesUseCase;
  final GetAutoCompleteUseCase getAutoCompleteUseCase;
  final GetPlaceUseCase getPlaceUseCase;

  MapBloc({
    required this.getPlacesUseCase,
    required this.getAutoCompleteUseCase,
    required this.getPlaceUseCase,
  }) : super(MapState()) {
    on<MapEvent>((event, emit) async {
      if (event is SearchPlaceEvent) {
        emit(state.copyWith(
          // isLoading: true,
          errorMessage: '',
          success: false,
        ));
        final searchResults = await getAutoCompleteUseCase(event.searchTerm);
        searchResults.fold(
            (failure) => emit(state.copyWith(
                isLoading: false,
                errorMessage: mapFailureToMessage(failure))), (searchResults) {
          emit(state.copyWith(
            isLoading: false,
            // success: true,
            searchResults: searchResults,
          ));
        });
      }
      if (event is SetSelectedLocationEvent) {
        emit(state.copyWith(isLoading: true, errorMessage: '', success: false));

        final sLocation = await getPlaceUseCase(event.placeId);
        sLocation.fold(
            (failure) => emit(state.copyWith(
                isLoading: false,
                errorMessage: mapFailureToMessage(failure))), (searchResult) {
          print('searchResult:::: ${searchResult.name}');
          print(
              'searchResult:::: ${searchResult.geometry.location.lat} ${searchResult.geometry.location.lng}');
          emit(state.copyWith(
            isLoading: false,
            success: true,
            selectedLocationStatic: searchResult,
            searchResults: [],
          ));
        });
      }
      if (event is SetCurrentLocationEvent) {
        emit(state.copyWith(isLoading: true, errorMessage: '', success: false));
        // try {
        //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        //   if (!serviceEnabled) {
        //     throw 'Location services are disabled.';
        //   }
        //
        //   LocationPermission permission = await Geolocator.checkPermission();
        //   if (permission == LocationPermission.deniedForever) {
        //     throw 'Location permissions are permanently denied, we cannot request permissions.';
        //   }
        //
        //   if (permission == LocationPermission.denied) {
        //     permission = await Geolocator.requestPermission();
        //     if (permission == LocationPermission.denied) {
        //       throw 'Location permissions are denied!';
        //     }
        //   }
        //
        //   Position position = await Geolocator.getCurrentPosition();
        //   lat = '${position.latitude}';
        //   long = '${position.longitude}';
        //   setState(() {
        //     currentAddress = "Latitude: $lat , Longitude: $long";
        //   });
        //
        //   await _getAddressFromLatLng();
        // } catch (e) {
        //   print('Error: $e');
        // }

        if (event.initialLatitude != null &&
            event.initialLatitude != 0.0 &&
            event.initialLongitude != null &&
            event.initialLongitude != 0.0) {
          final selectedLocationStatic = Place(
            name: null,
            geometry: Geometry(
              location: Location(
                  lat: event.initialLatitude!.toDouble(), lng: event.initialLongitude!.toDouble()),
            ),
            vicinity: '',
          );
          emit(state.copyWith(
            isLoading: false,
            // success: true,
            selectedLocationStatic: selectedLocationStatic,
          ));
        }
        bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage: 'Location services are disabled.',
          ));
        }

        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.deniedForever) {
          emit(state.copyWith(
            isLoading: false,
            errorMessage:
                'Location permissions are permanently denied, we cannot request permissions.',
          ));
        }

        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            emit(state.copyWith(
              isLoading: false,
              errorMessage: 'Location permissions are denied!',
            ));
          }
        }

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        final currentLocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        final selectedLocationStatic = Place(
          name: null,
          geometry: Geometry(
            location: Location(
                lat: currentLocation.latitude, lng: currentLocation.longitude),
          ),
          vicinity: '',
        );

        emit(state.copyWith(
          isLoading: false,
          // success: true,
          currentLocation: currentLocation,
          selectedLocationStatic: selectedLocationStatic,
        ));
      }

      if (event is ClearSelectedLocationEvent) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: '',
          // success: true,
          searchResults: [],
          selectedLocationStatic: null,
        ));
      }
    });
  }
}
