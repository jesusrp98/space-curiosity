import 'package:location/location.dart';

import 'latlng.dart';

class LocationUtils {
  LocationUtils._();

  static Future<LatLang> getLocation() async {
    final loc = await Location().getLocation();
    if (loc != null) {
      return LatLang(loc.latitude, loc.longitude);
    }
    return null;
  }
}
