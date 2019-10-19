# Space Curiosity

Space Curiosity is an agregator of all about space-related things. Built for space enthusiasts, by space enthusiasts. It has been developed using Flutter, an open-source SDK that helps us create amazing cross-platform apps.

## Features

* **Daily NASA pictures**: using the NASA APOD services.
* **SpaceX launch tracker**: this project includes the entire SpaceX GO! experience.
* **Latest space news**: be up-to-date with all space-related recent highlights.
* **ISS tracker**: know exactly when and where the biggest floating space laboratory will be in each moment.
* **Weight calculator**: have you ever wondered about how much would you weight in other worlds?

## Download & install

First, clone the repository with the 'clone' command, or just download the zip.

```bash
git clone git@github.com:jesusrp98/space-curiosity.git
```

Then, download either Android Studio or Visual Studio Code, with their respective [Flutter editor plugins](https://flutter.io/get-started/editor/). For more information about Flutter installation procedure, check the [official install guide](https://flutter.io/get-started/install/).

Install dependencies from pubspec.yaml by running `flutter packages get` from the project root (see [using packages documentation](https://flutter.io/using-packages/#adding-a-package-dependency-to-an-app) for details and how to do this in the editor).

There you go, you can now open & edit the project. Enjoy!

## Built with

* [Flutter](https://flutter.io/) - Hybrid mobile SDK from Google.
* [Android Studio](https://developer.android.com/studio/index.html/) - Android SDK & phone emulation.
* [Visual Studio Code](https://code.visualstudio.com/) - Editor of choice.

## Credits

* [NASA APOD](https://api.nasa.gov/api.html) - Astronomical Picture Of the Day.
* [r/SpaceX API](https://github.com/r-spacex/SpaceX-API) - Open-source REST API about all SpaceX-related things.
* [Open Notify](http://open-notify.org/) - Open-source APIs related to NASA services.
* [Space News](https://spacenews.com/) - Latest Space news.

## Authors

* **Rody Davis** - [GitHub](https://github.com/AppleEducate), [Twitter](https://twitter.com/rodydavis).
* **Jesús Rodríguez** - [GitHub](https://github.com/jesusrp98), [Twitter](https://twitter.com/jesusrp98).

## License

This project is licensed under the GNU GPL v3 License - see the [LICENSE.md](LICENSE.md) file for details.

- Deploy: `gcloud builds submit --tag gcr.io/rodydavis/space-news-69376 .`
- `gcloud builds submit --tag gcr.io/space-news-69376/app:v1`
- `gcloud builds submit --tag gcr.io/space-news-69376/app:v1 .`
- `gcloud builds submit --tag gcr.io/space-news-69376/quickstart-image .`   