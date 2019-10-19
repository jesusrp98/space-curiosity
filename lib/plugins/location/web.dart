import 'package:universal_html/prefer_universal/html.dart' as html;

import 'latlng.dart';

class LocationUtils {
  LocationUtils._();

  static Future<LatLang> getLocation() async {
    try {
      final loc = await html.window.navigator.geolocation.getCurrentPosition();
      if (loc != null) {
        return LatLang(loc.coords.latitude, loc.coords.longitude);
      }
    } catch (e) {}
    return null;
  }
}
