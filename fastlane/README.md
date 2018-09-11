fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### beta
```
fastlane beta
```
Deploy a new version to the Google Play Beta and TestFlight
### release
```
fastlane release
```
Deploy a new version to the Google Play and the App Store
### build
```
fastlane build
```


----

## Android
### android beta_badge
```
fastlane android beta_badge
```
Add Badge to Launcher Icon
### android prepare
```
fastlane android prepare
```
Prepare and archive app
### android beta
```
fastlane android beta
```
Deploy a new version to the Google Play Beta
### android release
```
fastlane android release
```
Deploy a new version to the Google Play Production

----

## iOS
### ios screenshots
```
fastlane ios screenshots
```
Capture Screenshots
### ios beta_badge
```
fastlane ios beta_badge
```
Add Badge to App Icon
### ios prepare
```
fastlane ios prepare
```
Prepare and archive app
### ios beta
```
fastlane ios beta
```
Push a new beta build to TestFlight
### ios release
```
fastlane ios release
```
Push a new release build to the App Store

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
