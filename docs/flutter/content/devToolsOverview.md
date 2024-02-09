1.  [Tools](https://docs.flutter.dev/tools)
2.  [DevTools](https://docs.flutter.dev/tools/devtools)
3.  [DevTools](https://docs.flutter.dev/tools/devtools/overview)

DevTools is a suite of performance and debugging tools for Dart and Flutter.

![Dart DevTools Screens](https://docs.flutter.dev/assets/images/docs/tools/devtools/dart-devtools.gif)

For a video introduction to DevTools, check out the following deep dive and use case walkthrough:

<iframe width="560" height="315" src="https://www.youtube.com/embed/_EYk-E29edo?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Dive into DevTools" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="413416767" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

[Dive in to DevTools](https://www.youtube.com/watch?v=_EYk-E29edo)

Here are some of the things you can do with DevTools:

-   Inspect the UI layout and state of a Flutter app.
-   Diagnose UI jank performance issues in a Flutter app.
-   CPU profiling for a Flutter or Dart app.
-   Network profiling for a Flutter app.
-   Source-level debugging of a Flutter or Dart app.
-   Debug memory issues in a Flutter or Dart command-line app.
-   View general log and diagnostics information about a running Flutter or Dart command-line app.
-   Analyze code and app size.

We expect you to use DevTools in conjunction with your existing IDE or command-line based development workflow.

See the [VS Code](https://docs.flutter.dev/tools/devtools/vscode), [Android Studio/IntelliJ](https://docs.flutter.dev/tools/devtools/android-studio), or [command line](https://docs.flutter.dev/tools/devtools/cli) pages for installation instructions.

## Troubleshooting some standard issues

**Question**: My app looks janky or stutters. How do I fix it?

**Answer**: Performance issues can cause [UI frames](https://docs.flutter.dev/perf/ui-performance) to be janky and/or slow down some operations.

1.  To detect which code impacts concrete late frames, start at [Performance > Timeline](https://docs.flutter.dev/tools/devtools/performance#timeline-events-tab).
2.  To learn which code takes the most CPU time in the background, use the [CPU profiler](https://docs.flutter.dev/tools/devtools/cpu-profiler).

For more information, check out the [Performance](https://docs.flutter.dev/perf) page.

**Question**: I see a lot of garbage collection (GC) events occurring. Is this a problem?

**Answer**: Frequent GC events might display on the DevTools > Memory > Memory chart. In most cases, it’s not a problem.

If your app has frequent background activity with some idle time, Flutter might use that opportunity to collect the created objects without performance impact.

## Providing feedback

Please give DevTools a try, provide feedback, and file issues in the [DevTools issue tracker](https://github.com/flutter/devtools/issues). Thanks!

## Other resources

For more information on debugging and profiling Flutter apps, see the [Debugging](https://docs.flutter.dev/testing/debugging) page and, in particular, its list of [other resources](https://docs.flutter.dev/testing/debugging#other-resources).

For more information on using DevTools with Dart command-line apps, see the [DevTools documentation on dart.dev](https://dart.dev/tools/dart-devtools).