import 'package:geolocator/geolocator.dart';

String locationMessage = "Current location";
late String lat;
late String long;

//Get current location
Future<Position> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Locatoon permission are denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error("Location permissions are permanently denied");
  }
  return await Geolocator.getCurrentPosition();
}

//Live location
// void _liveLocation() {
//   LocationSettings locationSettings = const LocationSettings(
//     accuracy: LocationAccuracy.high, //Accuracy of location
//     distanceFilter: 100,
//   );

//   Geolocator.getPositionStream(locationSettings: locationSettings)
//       .listen((Position position) {
//     lat = position.latitude.toString();
//     long = position.longitude.toString();

//     setState(() {
//       locationMessage = 'Latitude: $lat, Longitude: $long';
//     });
//   });
// }