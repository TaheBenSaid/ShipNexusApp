import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/ui/colors/colors.dart';
import '../../../../injection.dart';
import '../bloc/map_bloc.dart';
import '../widgets/map_widget.dart';

class MapPage extends StatefulWidget {
  bool isSearch;
  num? initialLatitude;
  num? initialLongitude;
  final Function(String, double, double) updateLocation;
  final Function(String, double, double)? onSelectLocationBtnClick;

  MapPage(
      {
      this.initialLatitude,
      this.initialLongitude,
      this.isSearch = false,
      required this.updateLocation,
      this.onSelectLocationBtnClick});

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    print('initial latitude: ${widget.initialLatitude}');
    print('initial longitude: ${widget.initialLongitude}');

    return BlocProvider(
      create: (context) {
        final mapBloc = getIt<MapBloc>();
        mapBloc.add(SetCurrentLocationEvent(
            widget.initialLatitude, widget.initialLongitude));

        return mapBloc;
      },
      child: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state.selectedLocationStatic == null && widget.isSearch) {
            return Scaffold(
              body: Center(
                child:
                    CircularProgressIndicator(color: AppConstants.primaryColor),
              ),
            );
          }
          if (state.selectedLocationStatic == null) {
            return Center(
              child:
                  CircularProgressIndicator(color: AppConstants.primaryColor),
            );
          }
          return MapWidget(
            updateLocation: widget.updateLocation,
            onSelectLocationBtnClick: widget.onSelectLocationBtnClick,
            isSearch: widget.isSearch,
            state: state,
            searchPlaceFunc: (String searchTerm) {
              BlocProvider.of<MapBloc>(context)
                  .add(SearchPlaceEvent(searchTerm: searchTerm));
            },
            setSelectedLocationFunc: (String placeId) {
              BlocProvider.of<MapBloc>(context)
                  .add(SetSelectedLocationEvent(placeId: placeId));
            },
            clearSelectedLocationFunc: () {
              setState(() {
                BlocProvider.of<MapBloc>(context)
                    .add(ClearSelectedLocationEvent());
              });
            },
          );
        },
      ),
    );
  }
}
