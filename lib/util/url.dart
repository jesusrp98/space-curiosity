import 'keys.dart';

/// URL FILE
/// It has all urls used in the app as static const strings.
class Url {
  //Base URLs
  static const String spacexBaseUrl = 'https://api.spacexdata.com/v3';
  static const String nasaBaseUrl = 'https://api.nasa.gov/planetary/apod';
  static const String issBaseUrl = 'http://api.open-notify.org';

  // Home page lists
  static const String rocketList = '$spacexBaseUrl/rockets';
  static const String capsuleList = '$spacexBaseUrl/dragons';
  static const String roadsterPage = '$spacexBaseUrl/roadster';
  static const String upcomingList = '$spacexBaseUrl/launches/upcoming';
  static const String launchesList = '$spacexBaseUrl/launches/past?order=desc';
  static const String shipsList = '$spacexBaseUrl/ships?active=true';

  // Upcoming launch for Home screen
  static const String nextLaunch = '$spacexBaseUrl/launches/next';

  // FH maiden launch
  static const String roadsterVideo = 'https://youtu.be/wbSwFU6tY1c';

  // Details dialogs
  static const String coreDialog = '$spacexBaseUrl/cores/';
  static const String capsuleDialog = '$spacexBaseUrl/capsules/';
  static const String launchpadDialog = '$spacexBaseUrl/launchpads/';
  static const String landingpadDialog = '$spacexBaseUrl/landpads/';

  // SpaceX related info
  static const String spacexCompany = '$spacexBaseUrl/info';
  static const String spacexAchievements = '$spacexBaseUrl/history';

  // Map URL
  static const String lightMap =
      'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png';
  static const String darkMap =
      'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png';

  // Share details message
  static const String shareDetails = '#spaceCuriosity';

  // About page
  static const List<String> authorsReddit = [
    'https://www.reddit.com/user/SoundDr',
    'https://www.reddit.com/user/jesusrp98'
  ];

  static const List<String> authorsStore = [
    'https://itunes.apple.com/us/developer/rody-davis/id1200052810',
    'https://play.google.com/store/apps/developer?id=Jes%C3%BAs+Rodr%C3%ADguez+P%C3%A9rez'
  ];

  static const String githubPage =
      'https://github.com/jesusrp98/space-curiosity';
  static const Map<String, String> email = {
    'subject': 'About Space Curiosity',
    'address': 'space.curiosity.app@gmail.com',
  };

  static const String flutterPage = 'https://flutter.dev/';

  // NASA APOD service
  static const String dailyPicture = '$nasaBaseUrl?api_key=$nasaApiKey';
  static const String morePictures =
      '$nasaBaseUrl?api_key=$nasaApiKey&count=10';

  // ISS URLs
  static const String issLocation = '$issBaseUrl/iss-now.json';
  static const String issPassTimes = '$issBaseUrl/iss-pass.json';
  static const String issAstronauts = '$issBaseUrl/astros.json';
}
