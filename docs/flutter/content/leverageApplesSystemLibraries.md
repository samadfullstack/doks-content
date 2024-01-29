1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [iOS](https://docs.flutter.dev/platform-integration/ios)
3.  [Leveraging Apple's System APIs and Frameworks](https://docs.flutter.dev/platform-integration/ios/apple-frameworks)

When you come from iOS development, you might need to find Flutter plugins that offer the same abilities as Apple’s system libraries. This might include accessing device hardware or interacting with specific frameworks like `HealthKit` or `MapKit`.

For an overview of how the SwiftUI framework compares to Flutter, see [Flutter for SwiftUI developers](https://docs.flutter.dev/get-started/flutter-for/swiftui-devs).

### Introducing Flutter plugins

Dart calls libraries that contain platform-specific code _plugins_. When developing an app with Flutter, you use _plugins_ to interact with system libraries.

In your Dart code, you use the plugin’s Dart API to call the native code from the system library being used. This means that you can write the code to call the Dart API. The API then makes it work for all platforms that the plugin supports.

To learn more about plugins, see [Using packages](https://docs.flutter.dev/packages-and-plugins/using-packages). Though this page links to some popular plugins, you can find thousands more, along with examples, on [pub.dev](https://pub.dev/packages). The following table does not endorse any particular plugin. If you can’t find a package that meets your need, you can create your own or use platform channels directly in your project. To learn more, see [Writing platform-specific code](https://docs.flutter.dev/platform-integration/platform-channels).

### Adding a plugin to your project

To use an Apple framework within your native project, import it into your Swift or Objective-C file.

To add a Flutter plugin, run `flutter pub add package_name` from the root of your project. This adds the dependency to your [`pubspec.yaml`](https://docs.flutter.dev/tools/pubspec) file. After you add the dependency, add an `import` statement for the package in your Dart file.

You might need to change app settings or initialization logic. If that’s needed, the package’s “Readme” page on [pub.dev](https://pub.dev/packages) should provide details.

### Flutter Plugins and Apple Frameworks

| Use Case | Apple Framework or Class | Flutter Plugin |
| --- | --- | --- |
| 
Access the photo library

 | 

-   `PhotoKit`  
    using the `Photos` and `PhotosUI` frameworks
-   `UIImagePickerController`

 | 

[`image_picker`](https://pub.dev/packages/image_picker)

 |
| 

Access the camera

 | 

`UIImagePickerController`  
using the `.camera` `sourceType`

 | 

[`image_picker`](https://pub.dev/packages/image_picker)

 |
| 

Use advanced camera features

 | 

`AVFoundation`

 | 

[`camera`](https://pub.dev/packages/camera)

 |
| 

Offer In-app purchases

 | 

`StoreKit`

 | 

[`in_app_purchase`](https://pub.dev/packages/in_app_purchase)<sup id="fnref:1" role="doc-noteref"><a href="https://docs.flutter.dev/platform-integration/ios/apple-frameworks#fn:1" rel="footnote">1</a></sup>

 |
| 

Process payments

 | 

`PassKit`

 | 

[`pay`](https://pub.dev/packages/pay)<sup id="fnref:2" role="doc-noteref"><a href="https://docs.flutter.dev/platform-integration/ios/apple-frameworks#fn:2" rel="footnote">2</a></sup>

 |
| 

Send push notifications

 | 

`UserNotifications`

 | 

[`firebase_messaging`](https://pub.dev/packages/firebase_messaging)<sup id="fnref:3" role="doc-noteref"><a href="https://docs.flutter.dev/platform-integration/ios/apple-frameworks#fn:3" rel="footnote">3</a></sup>

 |
| 

Access GPS coordinates

 | 

`CoreLocation`

 | 

[`geolocator`](https://pub.dev/packages/geolocator)

 |
| 

Access sensor data<sup id="fnref:4" role="doc-noteref"><a href="https://docs.flutter.dev/platform-integration/ios/apple-frameworks#fn:4" rel="footnote">4</a></sup>

 | 

`CoreMotion`

 | 

[`sensors_plus`](https://pub.dev/packages/sensors_plus)

 |
| 

Embed maps

 | 

`MapKit`

 | 

[`google_maps_flutter`](https://pub.dev/packages/google_maps_flutter)

 |
| 

Make network requests

 | 

`URLSession`

 | 

[`http`](https://pub.dev/packages/http)

 |
| 

Store key-values

 | 

-   `@AppStorage` property wrapper
-   `NSUserDefaults`

 | 

[`shared_preferences`](https://pub.dev/packages/shared_preferences)

 |
| 

Persist to a database

 | 

`CoreData` or SQLite

 | 

[`sqflite`](https://pub.dev/packages/sqflite)

 |
| 

Access health data

 | 

`HealthKit`

 | 

[`health`](https://pub.dev/packages/health)

 |
| 

Use machine learning

 | 

`CoreML`

 | 

[`google_ml_kit`](https://pub.dev/packages/google_ml_kit)<sup id="fnref:5" role="doc-noteref"><a href="https://docs.flutter.dev/platform-integration/ios/apple-frameworks#fn:5" rel="footnote">5</a></sup>

 |
| 

Recognize text

 | 

`VisionKit`

 | 

[`google_ml_kit`](https://pub.dev/packages/google_ml_kit)<sup id="fnref:5:1" role="doc-noteref"><a href="https://docs.flutter.dev/platform-integration/ios/apple-frameworks#fn:5" rel="footnote">5</a></sup>

 |
| 

Recognize speech

 | 

`Speech`

 | 

[`speech_to_text`](https://pub.dev/packages/speech_to_text)

 |
| 

Use augmented reality

 | 

`ARKit`

 | 

[`ar_flutter_plugin`](https://pub.dev/packages/ar_flutter_plugin)

 |
| 

Access weather data

 | 

`WeatherKit`

 | 

[`weather`](https://pub.dev/packages/weather)<sup id="fnref:6" role="doc-noteref"><a href="https://docs.flutter.dev/platform-integration/ios/apple-frameworks#fn:6" rel="footnote">6</a></sup>

 |
| 

Access and manage contacts

 | 

`Contacts`

 | 

[`contacts_service`](https://pub.dev/packages/contacts_service)

 |
| 

Expose quick actions on the home screen

 | 

`UIApplicationShortcutItem`

 | 

[`quick_actions`](https://pub.dev/packages/quick_actions)

 |
| 

Index items in Spotlight search

 | 

`CoreSpotlight`

 | 

[`flutter_core_spotlight`](https://pub.dev/packages/flutter_core_spotlight)

 |
| 

Configure, update and communicate with Widgets

 | 

`WidgetKit`

 | 

[`home_widget`](https://pub.dev/packages/home_widget)

 |