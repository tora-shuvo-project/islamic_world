import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as HTTP;
import 'package:searchtosu/FinalModels/place_search_models.dart';

class PlaceProvider with ChangeNotifier{

  PlaceSearchModels _placeSearchModels;
  PlaceSearchModels get currentPlacesearch=>_placeSearchModels;

  Future<void> getcurrentPlaces(Position position,int distance)async{
    final url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=$distance&types=mosque&key=AIzaSyDzOwSmMbs9aTvU5wx6mrDgeldGmGe-1BE';
    print("Current Location ${position.latitude} and ${position.longitude} and $distance");
    try{
      final response=await HTTP.get(url);
      final map=json.decode(response.body);
      _placeSearchModels=PlaceSearchModels.fromJson(map);
      notifyListeners();
    }catch(error){
      throw error;
    }
  }

  Future<void> getcurrentNextPlaces(Position position,int distance)async{
    final url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude},${position.longitude}&radius=$distance&types=mosque&key=AIzaSyDzOwSmMbs9aTvU5wx6mrDgeldGmGe-1BE&next_page_token=${_placeSearchModels.nextPageToken}';

    try{
      final response=await HTTP.get(url);
      final map=json.decode(response.body);
      print(map);
      _placeSearchModels=PlaceSearchModels.fromJson(map);
      notifyListeners();
    }catch(error){
      throw error;
    }
  }

}