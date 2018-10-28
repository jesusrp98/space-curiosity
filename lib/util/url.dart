import 'keys.dart';

/// URL CLASS
/// It has all urls used in the app as static const strings
class Url {
  /// Home page lists
  static const String rocketList = 'https://api.spacexdata.com/v3/rockets';
  static const String capsuleList = 'https://api.spacexdata.com/v3/dragons';
  static const String roadsterPage = 'https://api.spacexdata.com/v3/roadster';
  static const String upcomingList =
      'https://api.spacexdata.com/v3/launches/upcoming';
  static const String launchesList =
      'https://api.spacexdata.com/v3/launches/past?order=desc';
  static const String shipsList =
      'https://api.spacexdata.com/v3/ships?active=true';

  /// Details dialogs
  static const List<String> detailsPage = [
    'https://api.spacexdata.com/v3/launchpads/',
    'https://api.spacexdata.com/v3/cores/',
    'https://api.spacexdata.com/v3/capsules/',
  ];

  static const List<String> spacexCompanyScreen = [
    'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/2014_-_11orbcomm_f9_in_hanger.jpg?itok=gqP7Qmrg',
    'https://farm1.staticflickr.com/342/18039170043_e2ca8b540a_c.jpg',
    'https://farm9.staticflickr.com/8571/16491695667_c2754ff48e_c.jpg',
    'https://farm9.staticflickr.com/8688/17024507155_2168c8d032_c.jpg',
    'https://www.spacex.com/sites/spacex/files/styles/media_gallery_large/public/first_reflight_-_05_crs8_recovered_first_stage_3.jpg?itok=nHqaeNdH',
  ];

  static const List<String> spacexUpcomingScreen = [
    'https://farm5.staticflickr.com/4183/34296430820_c48e601ca1_c.jpg',
    'https://farm1.staticflickr.com/293/32312415025_6841e30bf1_c.jpg',
    'https://farm5.staticflickr.com/4483/37610547226_c8002032bc_c.jpg',
    'https://farm5.staticflickr.com/4235/35359372730_99255c4a20_c.jpg',
    'https://farm9.staticflickr.com/8601/16512864369_27bb414c91_c.jpg',
  ];

  // SpaceX related info
  static const String companyDetails = 'https://api.spacexdata.com/v3/info';
  static const String companyHistory = 'https://api.spacexdata.com/v3/history';

  static const String defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/rocket.png?alt=media&token=66f2dde6-e6ff-4f64-a4a4-9fab6dbe90c5';

  /// About page
  static const String authorReddit = 'https://www.reddit.com/user/jesusrp98';
  static const String authorStore =
      'https://play.google.com/store/apps/developer?id=Chechu';
  static const String storePage =
      'https://play.google.com/store/apps/details?id=com.chechu.cherry';
  static const String cherryGithub = 'https://github.com/jesusrp98/spacex-go';
  static const String email =
      'mailto:jesusillorp98@gmail.com?subject=Email%20about%20SpaceX%20GO!';
  static const String spacexGithub = 'https://github.com/r-spacex/SpaceX-API';
  static const String internationalSystem =
      'https://en.wikipedia.org/wiki/International_System_of_Units';

  /// Nasa images
  static const String dailyPicture =
      'https://api.nasa.gov/planetary/apod?api_key=$nasaApiKey';
  static const String morePictures =
      'https://api.nasa.gov/planetary/apod?api_key=$nasaApiKey&count=10';
}
