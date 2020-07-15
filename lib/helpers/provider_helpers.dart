import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class LocationProvider with ChangeNotifier{
  Position _position=Position(latitude: 0.0,longitude: 0.0);
  Position get pos=>_position;

  void setNewPosition(Position position){
    this._position=position;
    notifyListeners();
  }

  Future<Position> getDeviceCurrentLocation()async{
    return await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }


  void getLocationAdress() async {
    final coordinates = new Coordinates(_position.latitude, _position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;
    notifyListeners();
    print(" ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}");
  }
}