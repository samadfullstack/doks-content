1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [iOS](https://docs.flutter.dev/platform-integration/ios)
3.  [Restore state on iOS](https://docs.flutter.dev/platform-integration/ios/restore-state-ios)

When a user runs a mobile app and then selects another app to run, the first app is moved to the background, or _backgrounded_. The operating system (both iOS and Android) often kill the backgrounded app to release memory or improve performance for the app running in the foreground.

You can use the [`RestorationManager`](https://api.flutter.dev/flutter/services/RestorationManager-class.html) (and related) classes to handle state restoration. An iOS app requires [a bit of extra setup](https://api.flutter.dev/flutter/services/RestorationManager-class.html#state-restoration-on-ios) in Xcode, but the restoration classes otherwise work the same on both iOS and Android.

For more information, check out [State restoration on Android](https://docs.flutter.dev/platform-integration/android/restore-state-android) and the [VeggieSeasons](https://github.com/flutter/samples/tree/main/veggieseasons) code sample.