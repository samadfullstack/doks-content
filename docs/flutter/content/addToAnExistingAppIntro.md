1.  [Add to app](https://docs.flutter.dev/add-to-app)

## Add-to-app

It’s sometimes not practical to rewrite your entire application in Flutter all at once. For those situations, Flutter can be integrated into your existing application piecemeal, as a library or module. That module can then be imported into your Android or iOS (currently supported platforms) app to render a part of your app’s UI in Flutter. Or, just to run shared Dart logic.

In a few steps, you can bring the productivity and the expressiveness of Flutter into your own app.

The `add-to-app` feature supports integrating multiple instances of any screen size. This can help scenarios such as a hybrid navigation stack with mixed native and Flutter screens, or a page with multiple partial-screen Flutter views.

Having multiple Flutter instances allows each instance to maintain independent application and UI state while using minimal memory resources. See more in the [multiple Flutters](https://docs.flutter.dev/add-to-app/multiple-flutters) page.

## Supported features

### Add to Android applications

![Add-to-app steps on Android](https://docs.flutter.dev/assets/images/docs/development/add-to-app/android-overview.gif)

-   Auto-build and import the Flutter module by adding a Flutter SDK hook to your Gradle script.
-   Build your Flutter module into a generic [Android Archive (AAR)](https://developer.android.com/studio/projects/android-library) for integration into your own build system and for better Jetifier interoperability with AndroidX.
-   [`FlutterEngine`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html) API for starting and persisting your Flutter environment independently of attaching a [`FlutterActivity`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity.html)/[`FlutterFragment`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment.html) etc.
-   Android Studio Android/Flutter co-editing and module creation/import wizard.
-   Java and Kotlin host apps are supported.
-   Flutter modules can use [Flutter plugins](https://pub.dev/flutter) to interact with the platform.
-   Support for Flutter debugging and stateful hot reload by using `flutter attach` from IDEs or the command line to connect to an app that contains Flutter.

### Add to iOS applications

![Add-to-app steps on iOS](https://docs.flutter.dev/assets/images/docs/development/add-to-app/ios-overview.gif)

-   Auto-build and import the Flutter module by adding a Flutter SDK hook to your CocoaPods and to your Xcode build phase.
-   Build your Flutter module into a generic [iOS Framework](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/WhatAreFrameworks.html) for integration into your own build system.
-   [`FlutterEngine`](https://api.flutter.dev/ios-embedder/interface_flutter_engine.html) API for starting and persisting your Flutter environment independently of attaching a [`FlutterViewController`](https://api.flutter.dev/ios-embedder/interface_flutter_view_controller.html).
-   Objective-C and Swift host apps supported.
-   Flutter modules can use [Flutter plugins](https://pub.dev/flutter) to interact with the platform.
-   Support for Flutter debugging and stateful hot reload by using `flutter attach` from IDEs or the command line to connect to an app that contains Flutter.

See our [add-to-app GitHub Samples repository](https://github.com/flutter/samples/tree/main/add_to_app) for sample projects in Android and iOS that import a Flutter module for UI.

## Get started

To get started, see our project integration guide for Android and iOS:

## API usage

After Flutter is integrated into your project, see our API usage guides at the following links:

## Limitations

-   Packing multiple Flutter libraries into an application isn’t supported.
-   Plugins that don’t support `FlutterPlugin` might have unexpected behaviors if they make assumptions that are untenable in add-to-app (such as assuming that a Flutter `Activity` is always present).
-   On Android, the Flutter module only supports AndroidX applications.