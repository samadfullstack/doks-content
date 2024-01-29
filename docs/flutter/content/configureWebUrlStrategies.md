1.  [UI](https://docs.flutter.dev/ui)
2.  [Navigation and routing](https://docs.flutter.dev/ui/navigation)
3.  [Configuring the URL strategy on the web](https://docs.flutter.dev/ui/navigation/url-strategies)

Flutter web apps support two ways of configuring URL-based navigation on the web:

**Hash (default)**

Paths are read and written to the [hash fragment](https://en.wikipedia.org/wiki/Uniform_Resource_Locator#Syntax). For example, `flutterexample.dev/#/path/to/screen`.

**Path**

Paths are read and written without a hash. For example, `flutterexample.dev/path/to/screen`.

## Configuring the URL strategy

To configure Flutter to use the path instead, use the [usePathUrlStrategy](https://api.flutter.dev/flutter/flutter_web_plugins/usePathUrlStrategy.html) function provided by the [flutter\_web\_plugins](https://api.flutter.dev/flutter/flutter_web_plugins/flutter_web_plugins-library.html) library in the SDK:

```
<span>import</span> <span>'package:flutter_web_plugins/url_strategy.dart'</span><span>;</span>

<span>void</span> <span>main</span><span>()</span> <span>{</span>
  <span>usePathUrlStrategy</span><span>();</span>
  <span>runApp</span><span>(</span><span>ExampleApp</span><span>());</span>
<span>}</span>
```

## Configuring your web server

PathUrlStrategy uses the [History API](https://developer.mozilla.org/en-US/docs/Web/API/History_API), which requires additional configuration for web servers.

To configure your web server to support PathUrlStrategy, check your web server’s documentation to rewrite requests to `index.html`.Check your web server’s documentation for details on how to configure single-page apps.

If you are using Firebase Hosting, choose the “Configure as a single-page app” option when initializing your project. For more information see Firebase’s [Configure rewrites](https://firebase.google.com/docs/hosting/full-config#rewrites) documentation.

The local dev server created by running `flutter run -d chrome` is configured to handle any path gracefully and fallback to your app’s `index.html` file.

## Hosting a Flutter app at a non-root location

Update the `<base href="/">` tag in `web/index.html` to the path where your app is hosted. For example, to host your Flutter app at `my_app.dev/flutter_app`, change this tag to `<base href="/flutter_app/">`.