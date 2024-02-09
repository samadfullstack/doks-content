[_description_](https://github.com/flutter/website/tree/main/src/perf/web-performance.md "View page source") [_bug\_report_](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&title=[PAGE%20ISSUE]:%20%27Debugging%20performance%20for%20web%20apps%27&page-url=https://docs.flutter.dev/perf/web-performance/&page-source=https://github.com/flutter/website/tree/main/src/perf/web-performance.md "Report an issue with this page")

1.  [Performance](https://docs.flutter.dev/perf)
2.  [Debugging performance for web apps](https://docs.flutter.dev/perf/web-performance)

The Flutter framework emits timeline events as it works to build frames, draw scenes, and track other activity such as garbage collections. These events are exposed in the [Chrome DevTools performance panel](https://developer.chrome.com/docs/devtools/performance) for debugging.

You can also emit your own timeline events using the `dart:developer` [Timeline](https://api.flutter.dev/flutter/dart-developer/Timeline-class.html) and [TimelineTask](https://api.flutter.dev/flutter/dart-developer/TimelineTask-class.html) APIs for further performance analysis.

![Screenshot of the Chrome DevTools performance panel](https://docs.flutter.dev/assets/images/docs/tools/devtools/chrome-devtools-performance-panel.png)

## Optional flags to enhance tracing

To configure which timeline events are tracked, set any of the following top-level properties to `true` in your app’s `main` method.

-   [debugProfileBuildsEnabled](https://api.flutter.dev/flutter/widgets/debugProfileBuildsEnabled.html): Adds `Timeline` events for every `Widget` built.
-   [debugProfileBuildsEnabledUserWidgets](https://api.flutter.dev/flutter/widgets/debugProfileBuildsEnabledUserWidgets.html): Adds `Timeline` events for every user-created `Widget` built.
-   [debugProfileLayoutsEnabled](https://api.flutter.dev/flutter/rendering/debugProfileLayoutsEnabled.html): Adds `Timeline` events for every `RenderObject` layout.
-   [debugProfilePaintsEnabled](https://api.flutter.dev/flutter/rendering/debugProfilePaintsEnabled.html): Adds `Timeline` events for every `RenderObject` painted.

## Instructions

1.  _\[Optional\]_ Set any desired tracing flags to true from your app’s main method.
2.  Run your Flutter web app in [profile mode](https://docs.flutter.dev/testing/build-modes#profile).
3.  Open up the [Chrome DevTools Performance panel](https://developer.chrome.com/docs/devtools/performance) for your application, and [start recording](https://developer.chrome.com/docs/devtools/performance/#record) to capture timeline events.