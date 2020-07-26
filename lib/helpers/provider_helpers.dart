import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier{
  Position _position=Position(latitude: 23.8103,longitude: 90.4125);
  Position get pos=>_position;

  void setNewPosition(Position position){
    this._position=position;
    notifyListeners();
  }

  Future<Position> getDeviceCurrentLocation({ @required Position postion})async{
    return await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((value) {
      _position= value;
      notifyListeners();
    });
  }


}