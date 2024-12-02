import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/ui/colors/colors.dart';
import '../../data/models/geometry.dart';
import '../../data/models/location.dart' as location;
import '../../data/models/place.dart';
import '../bloc/map_bloc.dart';

class MapWidget extends StatefulWidget {
  final MapState state;
  final Function(String, double, double) updateLocation;
  final Function(String, double, double)? onSelectLocationBtnClick;
  final void Function(String) searchPlaceFunc;
  final void Function(String) setSelectedLocationFunc;
  final void Function() clearSelectedLocationFunc;
  final bool isSearch;

  const MapWidget(
      {Key? key,
      required this.state,
      required this.isSearch,
      required this.searchPlaceFunc,
      required this.setSelectedLocationFunc,
      required this.clearSelectedLocationFunc,
      required this.updateLocation,
      this.onSelectLocationBtnClick})
      : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late Completer<GoogleMapController> _mapController = Completer();
  final _locationController = TextEditingController();
  final _finalLocationController = TextEditingController();
  Marker? _selectedMarker;

  double zoomLevel = 14.0;

  final _focus = FocusNode();
  final _streamController = StreamController<double>();

  Stream<double> get onZoomChanged => _streamController.stream;

  @override
  void initState() {
    super.initState();
    // Set initial marker and address in _finalLocationController
    if (widget.state.selectedLocationStatic != null) {
      _setInitialMarker();
    }

    onZoomChanged.listen((event) {
      setState(() {
        zoomLevel = event;
      });
    });
  }

  void _setInitialMarker() async {
    // Set initial position
    LatLng initialPosition = LatLng(
      widget.state.selectedLocationStatic!.geometry.location.lat,
      widget.state.selectedLocationStatic!.geometry.location.lng,
    );

    // Create a marker for the initial position
    _selectedMarker = Marker(
      markerId: MarkerId('initial_position'),
      position: initialPosition,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: "Stadium location",
      ),
    );

    // Get initial address and update _finalLocationController
    List<Placemark> placemarks = await placemarkFromCoordinates(
      initialPosition.latitude,
      initialPosition.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        _finalLocationController.text =
            "${place.street}, ${place.street == place.name ? '' : '${place.name},'} ${place.locality}, ${place.country}";
      });
    }

    widget.updateLocation(
      _finalLocationController.text,
      initialPosition.latitude,
      initialPosition.longitude,
    );
  }

  void onMapCreated(GoogleMapController controller) {
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
    }
  }

  @override
  void dispose() {
    _mapController = Completer();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        print('state.selectedLocationStatic ::${state.selectedLocationStatic}');
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              content: Text(state.errorMessage),
              duration: Duration(seconds: 3),
            ),
          );
        }
        if (state.success) {
          if (state.selectedLocationStatic?.name != null) {
            widget.updateLocation(
                state.selectedLocationStatic!.name!,
                state.selectedLocationStatic?.geometry.location.lat ?? 0.0,
                state.selectedLocationStatic?.geometry.location.lng ?? 0.0);
            _goToPlace(state.selectedLocationStatic!);
            setState(() {
              _finalLocationController.text =
                  state.selectedLocationStatic!.name!;
            });
          }
          // widget.clearSelectedLocationFunc();
        }
      },
      builder: (BuildContext context, MapState state) {
        return Scaffold(
            body: (widget.state.selectedLocationStatic == null)
                ? Center(
                    child: CircularProgressIndicator(
                        color: AppConstants.primaryColor),
                  )
                : SafeArea(
                    child: SizedBox(
                      // height: !widget.isSearch ? 150.h : null,
                      child: Column(
                        children: [
                          widget.isSearch
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    focusNode: _focus,
                                    controller: _locationController,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    decoration: InputDecoration(
                                      hintText: 'Search by City',
                                      hintStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      suffixIcon: state.isLoading
                                          ? Container(
                                              height: 5.h,
                                              width: 5.h,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 10.h),
                                              child: CircularProgressIndicator(
                                                  color: AppConstants
                                                      .primaryColor))
                                          : Icon(Icons.search),
                                    ),
                                    onChanged: (value) {
                                      widget.searchPlaceFunc(value);
                                    },
                                    onTap: () {
                                      widget.clearSelectedLocationFunc();
                                    },
                                  ),
                                )
                              : Container(),
                          Expanded(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: GoogleMap(
                                      onCameraMove: (cameraPosition) {
                                        _streamController.sink
                                            .add(cameraPosition.zoom);
                                      },
                                      // myLocationEnabled: true,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            widget.state.selectedLocationStatic!
                                                .geometry.location.lat,
                                            widget.state.selectedLocationStatic!
                                                .geometry.location.lng),
                                        zoom: zoomLevel,
                                      ),
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        if (!_mapController.isCompleted) {
                                          _mapController.complete(controller);
                                        }
                                      },
                                      markers: {
                                        if (_selectedMarker != null)
                                          _selectedMarker!,
                                      },
                                      onTap: (latLng) {
                                        widget.isSearch
                                            ? _onMapTapped(latLng, context)
                                            : null;
                                      }
                                      // markers: Set<Marker>.of(state.markers),
                                      ),
                                ),
                                if (state.searchResults != null &&
                                    state.searchResults!.isNotEmpty)
                                  Container(
                                      height: 300.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.6),
                                          backgroundBlendMode:
                                              BlendMode.darken)),
                                if (state.searchResults != null &&
                                    state.searchResults!.isNotEmpty)
                                  SizedBox(
                                    height: 300.h,
                                    child: ListView.builder(
                                        itemCount: state.searchResults!.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                              state.searchResults![index]
                                                  .description,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              widget.setSelectedLocationFunc(
                                                  widget
                                                      .state
                                                      .searchResults![index]
                                                      .placeId);
                                              // print(
                                              //     'splaceId:: ${state.searchResults![index].placeId}');
                                              // print(
                                              //     'state.selectedLocation:: ${state.selectedLocationStatic?.name}');
                                              _goToPlace(widget.state
                                                  .selectedLocationStatic!);
                                              //
                                              setState(() {
                                                _locationController.text = '';
                                              });
                                              widget
                                                  .clearSelectedLocationFunc();
                                            },
                                          );
                                        }),
                                  ),
                                widget.isSearch
                                    ? Positioned(
                                        bottom: 5.h,
                                        left: 5.w,
                                        right: 100.w,
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 3.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Text(
                                                //   'Selected Position:',
                                                //   style: TextStyle(
                                                //     fontWeight: FontWeight.bold,
                                                //     fontSize: 16.0,
                                                //   ),
                                                // ),
                                                SizedBox(height: 8.0),
                                                TextField(
                                                  controller:
                                                      _finalLocationController,
                                                  enabled: false,
                                                  style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontFamily: 'Outfit',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  decoration: InputDecoration(
                                                    // border: OutlineInputBorder(),
                                                    suffixIcon: IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons.location_on),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 8.0),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop("refresh");
                                                    widget
                                                        .onSelectLocationBtnClick
                                                        ?.call(
                                                            _finalLocationController
                                                                .text,
                                                            _selectedMarker
                                                                    ?.position
                                                                    .latitude ??
                                                                0,
                                                            _selectedMarker
                                                                    ?.position
                                                                    .longitude ??
                                                                0);
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty.all<
                                                                Color>(
                                                            AppConstants
                                                                .primaryColor),
                                                    textStyle:
                                                        MaterialStateProperty
                                                            .all<TextStyle>(
                                                      TextStyle(
                                                        fontSize: 15.sp,
                                                        fontFamily: 'Outfit',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors
                                                            .white, // Set text color
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Select Location',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp,
                                                      fontFamily: 'Outfit',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
      },
    );
  }

  void _onMapTapped(LatLng tappedPoint, BuildContext context) async {
    final latitude = tappedPoint.latitude;
    final longitude = tappedPoint.longitude;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      _selectedMarker = Marker(
        markerId: MarkerId('selected_position'),
        position: LatLng(latitude, longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: place.name ?? '',
        ),
      );
      // Update the search controller text with the address
      setState(() {
        _finalLocationController.text =
            "${place.street == place.name ? '' : '${place.name},'} ${place.locality}, ${place.country}";
      });
      widget.updateLocation(_finalLocationController.text, tappedPoint.latitude,
          tappedPoint.longitude);

      // Create a Place object with the tapped latitude and longitude
      Place tappedPlace = Place(
        name: place.name ?? 'Tapped Location',
        geometry: Geometry(
          location: location.Location(lat: latitude, lng: longitude),
        ),
        vicinity: '',
        // You can set other properties as needed for your Place model
      );

      // Show the tapped location on the map...
      _goToPlace(tappedPlace);

      print(
          'onMapTapped::: ${tappedPlace.geometry.location.lat} ${tappedPlace.geometry.location.lng}');
    }
  }

  Future<void> _goToPlace(Place place) async {
    print(
        '_goToPlace: ${place.geometry.location.lat} ${place.geometry.location.lng}');
    // final GoogleMapController controller = await _mapController.future;

    _mapController.future.then((value) {
      value
          .animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                place.geometry.location.lat,
                place.geometry.location.lng,
              ),
              zoom: zoomLevel),
        ),
      )
          .then((_) {
        if (_focus.hasFocus) {
          FocusScope.of(context).unfocus();
        }
        _selectedMarker = Marker(
          markerId: MarkerId('selected_position'),
          position:
              LatLng(place.geometry.location.lat, place.geometry.location.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(
            title: place.name ?? '',
          ),
        );
      });
    });

    print(
        '_goToPlace:::::: ${place.geometry.location.lat} ${place.geometry.location.lng}');
    // controller.animateCamera(
    //   CameraUpdate.newCameraPosition(
    //     CameraPosition(
    //         target: LatLng(
    //             place.geometry.location.lat, place.geometry.location.lng),
    //         zoom: 14.0),
    //   ),
    // );
  }
}
