1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Android](https://docs.flutter.dev/platform-integration/android)
3.  [Restore state on Android](https://docs.flutter.dev/platform-integration/android/restore-state-android)

When a user runs a mobile app and then selects another app to run, the first app is moved to the background, or _backgrounded_. The operating system (both iOS and Android) might kill the backgrounded app to release memory and improve performance for the app running in the foreground.

When the user selects the app again, bringing it back to the foreground, the OS relaunches it. But, unless you’ve set up a way to save the state of the app before it was killed, you’ve lost the state and the app starts from scratch. The user has lost the continuity they expect, which is clearly not ideal. (Imagine filling out a lengthy form and being interrupted by a phone call _before_ clicking **Submit**.)

So, how can you restore the state of the app so that it looks like it did before it was sent to the background?

Flutter has a solution for this with the [`RestorationManager`](https://api.flutter.dev/flutter/services/RestorationManager-class.html) (and related classes) in the [services](https://api.flutter.dev/flutter/services/services-library.html) library. With the `RestorationManager`, the Flutter framework provides the state data to the engine _as the state changes_, so that the app is ready when the OS signals that it’s about to kill the app, giving the app only moments to prepare.

## Overview

You can enable state restoration with just a few tasks:

1.  Define a `restorationId` or a `restorationScopeId` for all widgets that support it, such as [`TextField`](https://api.flutter.dev/flutter/material/TextField/restorationId.html) and [`ScrollView`](https://api.flutter.dev/flutter/widgets/ScrollView/restorationId.html). This automatically enables built-in state restoration for those widgets.
    
2.  For custom widgets, you must decide what state you want to restore and hold that state in a [`RestorableProperty`](https://api.flutter.dev/flutter/widgets/RestorableProperty-class.html). (The Flutter API provides various subclasses for different data types.) Define those `RestorableProperty` widgets in a `State` class that uses the [`RestorationMixin`](https://api.flutter.dev/flutter/widgets/RestorationMixin-mixin.html). Register those widgets with the mixin in a `restoreState` method.
    
3.  If you use any Navigator API (like `push`, `pushNamed`, and so on) migrate to the API that has “restorable” in the name (`restorablePush`, `resstorablePushNamed`, and so on) to restore the navigation stack.
    

Other considerations:

-   Providing a `restorationId` to `MaterialApp`, `CupertinoApp`, or `WidgetsApp` automatically enables state restoration by injecting a `RootRestorationScope`. If you need to restore state _above_ the app class, inject a `RootRestorationScope` manually.
    
-   **The difference between a `restorationId` and a `restorationScopeId`:** Widgets that take a `restorationScopeID` create a new `restorationScope` (a new `RestorationBucket`) into which all children store their state. A `restorationId` means the widget (and its children) store the data in the surrounding bucket.
    

## Restoring navigation state

If you want your app to return to a particular route that the user was most recently viewing (the shopping cart, for example), then you must implement restoration state for navigation, as well.

If you use the Navigator API directly, migrate the standard methods to restorable methods (that have “restorable” in the name). For example, replace `push` with [`restorablePush`](https://api.flutter.dev/flutter/widgets/Navigator/restorablePush.html).

The VeggieSeasons example (listed under “Other resources” below) implements navigation with the [`go_router`](https://pub.dev/packages/go_router) package. Setting the `restorationId` values occur in the `lib/screens` classes.

## Testing state restoration

To test state restoration, set up your mobile device so that it doesn’t save state once an app is backgrounded. To learn how to do this for both iOS and Android, check out [Testing state restoration](https://api.flutter.dev/flutter/services/RestorationManager-class.html#testing-state-restoration) on the [`RestorationManager`](https://api.flutter.dev/flutter/services/RestorationManager-class.html) page.

## Other resources

For further information on state restoration, check out the following resources:

-   For an example that implements state restoration, check out [VeggieSeasons](https://github.com/flutter/samples/tree/main/veggieseasons), a sample app written for iOS that uses Cupertino widgets. An iOS app requires [a bit of extra setup](https://api.flutter.dev/flutter/services/RestorationManager-class.html#state-restoration-on-ios) in Xcode, but the restoration classes otherwise work the same on both iOS and Android.  
    The following list links to relevant parts of the VeggieSeasons example:
    -   [Defining a `RestorablePropery` as an instance property](https://github.com/flutter/samples/blob/604c82cd7c9c7807ff6c5ca96fbb01d44a4f2c41/veggieseasons/lib/widgets/trivia.dart#L33-L37)
    -   [Registering the properties](https://github.com/flutter/samples/blob/604c82cd7c9c7807ff6c5ca96fbb01d44a4f2c41/veggieseasons/lib/widgets/trivia.dart#L49-L54)
    -   [Updating the property values](https://github.com/flutter/samples/blob/604c82cd7c9c7807ff6c5ca96fbb01d44a4f2c41/veggieseasons/lib/widgets/trivia.dart#L108-L109)
    -   [Using property values in build](https://github.com/flutter/samples/blob/604c82cd7c9c7807ff6c5ca96fbb01d44a4f2c41/veggieseasons/lib/widgets/trivia.dart#L205-L210)  
        
-   To learn more about short term and long term state, check out [Differentiate between ephemeral state and app state](https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app).
    
-   You might want to check out packages on pub.dev that perform state restoration, such as [`statePersistence`](https://pub.dev/packages/state_persistence).
    
-   For more information on navigation and the `go_router` package, check out [Navigation and routing](https://docs.flutter.dev/ui/navigation).