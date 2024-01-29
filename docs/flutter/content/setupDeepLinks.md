1.  [UI](https://docs.flutter.dev/ui)
2.  [Navigation and routing](https://docs.flutter.dev/ui/navigation)
3.  [Deep linking](https://docs.flutter.dev/ui/navigation/deep-linking)

Flutter supports deep linking on iOS, Android, and web browsers. Opening a URL displays that screen in your app. With the following steps, you can launch and display routes by using named routes (either with the [`routes`](https://api.flutter.dev/flutter/material/MaterialApp/routes.html) parameter or [`onGenerateRoute`](https://api.flutter.dev/flutter/material/MaterialApp/onGenerateRoute.html)), or by using the [`Router`](https://api.flutter.dev/flutter/widgets/Router-class.html) widget.

If you’re running the app in a web browser, there’s no additional setup required. Route paths are handled in the same way as an iOS or Android deep link. By default, web apps read the deep link path from the url fragment using the pattern: `/#/path/to/app/screen`, but this can be changed by [configuring the URL strategy](https://docs.flutter.dev/ui/navigation/url-strategies) for your app.

If you are a visual learner, check out the following video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/KNAb2XL7k2g?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Deep linking in Flutter" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="141768796" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

**Deep linking in Flutter**

## Get started

To get started, see our cookbooks for Android and iOS:

## Migrating from plugin-based deep linking

If you have written a plugin to handle deep links, as described in [Deep Links and Flutter applications](https://medium.com/flutter-community/deep-links-and-flutter-applications-how-to-handle-them-properly-8c9865af9283) (a free article on Medium), it will continue to work until you opt-in to this behavior by adding `FlutterDeepLinkingEnabled` to `Info.plist` or `flutter_deeplinking_enabled` to `AndroidManifest.xml`, respectively.

## Behavior

The behavior varies slightly based on the platform and whether the app is launched and running.

| Platform / Scenario | Using Navigator | Using Router |
| --- | --- | --- |
| iOS (not launched) | App gets initialRoute (“/”) and a short time after gets a pushRoute | App gets initialRoute (“/”) and a short time after uses the RouteInformationParser to parse the route and call RouterDelegate.setNewRoutePath, which configures the Navigator with the corresponding Page. |
| Android - (not launched) | App gets initialRoute containing the route (“/deeplink”) | App gets initialRoute (“/deeplink”) and passes it to the RouteInformationParser to parse the route and call RouterDelegate.setNewRoutePath, which configures the Navigator with the corresponding Pages. |
| iOS (launched) | pushRoute is called | Path is parsed, and the Navigator is configured with a new set of Pages. |
| Android (launched) | pushRoute is called | Path is parsed, and the Navigator is configured with a new set of Pages. |

When using the [`Router`](https://api.flutter.dev/flutter/widgets/Router-class.html) widget, your app has the ability to replace the current set of pages when a new deep link is opened while the app is running.

## For more information

[Learning Flutter’s new navigation and routing system](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade) provides an introduction to the Router system.