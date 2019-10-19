import 'package:location/location.dart';

import 'latlng.dart';

class LocationUtils {
  LocationUtils._();

  static Future<LatLang> getLocation() async {
    try {
      final loc = await Location().getLocation();
      if (loc != null) {
        return LatLang(loc.latitude, loc.longitude);
      }
    } catch (e) {}
    return null;
  }
}
