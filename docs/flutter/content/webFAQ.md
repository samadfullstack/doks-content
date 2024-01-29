1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Web](https://docs.flutter.dev/platform-integration/web)
3.  [Web FAQ](https://docs.flutter.dev/platform-integration/web/faq)

### What scenarios are ideal for Flutter on the web?

Not every web page makes sense in Flutter, but we think Flutter is particularly suited for app-centric experiences:

-   Progressive Web Apps
-   Single Page Apps
-   Existing Flutter mobile apps

At this time, Flutter is not suitable for static websites with text-rich flow-based content. For example, blog articles benefit from the document-centric model that the web is built around, rather than the app-centric services that a UI framework like Flutter can deliver. However, you _can_ use Flutter to embed interactive experiences into these websites.

For more information on how you can use Flutter on the web, see [Web support for Flutter](https://docs.flutter.dev/platform-integration/web).

### Search Engine Optimization (SEO)

In general, Flutter is geared towards dynamic application experiences. Flutter’s web support is no exception. Flutter web prioritizes performance, fidelity, and consistency. This means application output does not align with what search engines need to properly index. For web content that is static or document-like, we recommend using HTML—just like we do on [flutter.dev](https://flutter.dev/), [dart.dev](https://dart.dev/), and [pub.dev](https://pub.dev/). You should also consider separating your primary application experience—created in Flutter—from your landing page, marketing content, and help content—created using search-engine optimized HTML.

### How do I create an app that also runs on the web?

See [building a web app with Flutter](https://docs.flutter.dev/platform-integration/web/building).

### Does hot reload work with a web app?

No, but you can use hot restart. Hot restart is a fast way of seeing your changes without having to relaunch your web app and wait for it to compile and load. This works similarly to the hot reload feature for Flutter mobile development. The only difference is that hot reload remembers your state and hot restart doesn’t.

### How do I restart the app running in the browser?

You can either use the browser’s refresh button, or you can enter “R” in the console where “flutter run -d chrome” is running.

### Which web browsers are supported by Flutter?

Flutter web apps can run on the following browsers:

-   Chrome (mobile & desktop)
-   Safari (mobile & desktop)
-   Edge (mobile & desktop)
-   Firefox (mobile & desktop)

During development, Chrome (on macOS, Windows, and Linux) and Edge (on Windows) are supported as the default browsers for debugging your app.

### Can I build, run, and deploy web apps in any of the IDEs?

You can select **Chrome** or **Edge** as the target device in Android Studio/IntelliJ and VS Code.

The device pulldown should now include the **Chrome (web)** option for all channels.

### How do I build a responsive app for the web?

See [Creating responsive apps](https://docs.flutter.dev/ui/layout/responsive/adaptive-responsive).

### Can I use `dart:io` with a web app?

No. The file system is not accessible from the browser. For network functionality, use the [`http`](https://pub.dev/packages/http) package. Note that security works somewhat differently because the browser (and not the app) controls the headers on an HTTP request.

### How do I handle web-specific imports?

Some plugins require platform-specific imports, particularly if they use the file system, which is not accessible from the browser. To use these plugins in your app, see the [documentation for conditional imports](https://dart.dev/guides/libraries/create-library-packages#conditionally-importing-and-exporting-library-files) on [dart.dev](https://dart.dev/).

### Does Flutter web support concurrency?

Dart’s concurrency support via [isolates](https://dart.dev/guides/language/concurrency) is not currently supported in Flutter web.

Flutter web apps can potentially work around this by using [web workers](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers), although no such support is built in.

### How do I embed a Flutter web app in a web page?

You can embed a Flutter web app, as you would embed other content, in an [`iframe`](https://html.com/tags/iframe/) tag of an HTML file. In the following example, replace “URL” with the location of your hosted HTML page:

```
<span>&lt;iframe</span> <span>src=</span><span>"URL"</span><span>&gt;&lt;/iframe&gt;</span>
```

If you encounter problems, please [file an issue](https://github.com/flutter/flutter/issues/new?title=[web]:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version).

### How do I debug a web app?

Use [Flutter DevTools](https://docs.flutter.dev/tools/devtools/overview) for the following tasks:

-   [Debugging](https://docs.flutter.dev/tools/devtools/debugger)
-   [Logging](https://docs.flutter.dev/tools/devtools/logging)
-   [Running Flutter inspector](https://docs.flutter.dev/tools/devtools/inspector)

Use [Chrome DevTools](https://developers.google.com/web/tools/chrome-devtools) for the following tasks:

-   [Generating event timeline](https://developers.google.com/web/tools/chrome-devtools/evaluate-performance/performance-reference)
-   [Analyzing performance](https://developers.google.com/web/tools/chrome-devtools/evaluate-performance)—make sure to use a profile build

### How do I test a web app?

Use [widget tests](https://docs.flutter.dev/testing/overview#widget-tests) or integration tests. To learn more about running integration tests in a browser, see the [Integration testing](https://docs.flutter.dev/testing/integration-tests#running-in-a-browser) page.

### How do I deploy a web app?

See [Preparing a web app for release](https://docs.flutter.dev/deployment/web).

### Does `Platform.is` work on the web?

Not currently.