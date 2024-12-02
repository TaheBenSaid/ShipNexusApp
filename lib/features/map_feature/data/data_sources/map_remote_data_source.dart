import 'dart:convert' as convert;
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/handle_server_failure.dart';
import '../../../../core/network/interceptor/HttpInterceptor.dart';
import '../models/place.dart';
import '../models/place_search.dart';

abstract class MapRemoteDataSource {
  Future<List<PlaceSearch>> getAutocomplete(String search);

  Future<Place> getPlace(String placeId);

  Future<List<Place>> getPlaces(double lat, double lng, String placeType);
}

@Injectable(as: MapRemoteDataSource)
class MapRemoteDataSourceImpl extends MapRemoteDataSource {
  final HttpInterceptor httpClient;
  final key = 'AIzaSyCgHZUm-KqS2_ycPW8xrWk9lo3XceUY41s';

  MapRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    final Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&key=$key');
    var response = await httpClient.httpInterceptor().get(url);
    if (response.statusCode == 200) {
      print('maps response: ${response.body}');


      var json = convert.jsonDecode(response.body);
      var jsonResults = json['predictions'] as List;
      return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }

  @override
  Future<Place> getPlace(String placeId) async {
    try {
      var url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
      var response = await httpClient.httpInterceptor().get(Uri.parse(url));
      print('maps getPlace: ${response.body}');

      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);
        var jsonResult = json['result'] as Map<String, dynamic>;
        return Place.fromJson(jsonResult);
      } else {
        throw ServerException(message: getErrorMessage(response));
      }
    } catch(e){
      print('data source error: $e');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Place>> getPlaces(
      double lat, double lng, String placeType) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';

    var response = await httpClient.httpInterceptor().get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var jsonResults = json['results'] as List;
      return jsonResults.map((place) => Place.fromJson(place)).toList();
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }
}
