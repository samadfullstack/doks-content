1.  [Performance](https://docs.flutter.dev/perf)
2.  [Performance FAQ](https://docs.flutter.dev/perf/faq)

This page collects some frequently asked questions about evaluating and debugging Flutter’s performance.

-   Which performance dashboards have metrics that are related to Flutter?
    -   [Flutter dashboard on appspot](https://flutter-dashboard.appspot.com/)
    -   [Flutter Skia dashboard](https://flutter-flutter-perf.skia.org/t/?subset=regressions)
    -   [Flutter Engine Skia dashboard](https://flutter-engine-perf.skia.org/t/?subset=regressions)

-   How do I add a benchmark to Flutter?
    -   [How to write a render speed test for Flutter](https://github.com/flutter/flutter/wiki/How-to-write-a-render-speed-test-for-Flutter)
    -   [How to write a memory test for Flutter](https://github.com/flutter/flutter/wiki/How-to-write-a-memory-test-for-Flutter)

-   What are some tools for capturing and analyzing performance metrics?
    -   [Dart DevTools](https://docs.flutter.dev/tools/devtools)
    -   [Apple instruments](https://en.wikipedia.org/wiki/Instruments_(software))
    -   [Linux perf](https://en.wikipedia.org/wiki/Perf_(Linux))
    -   [Chrome tracing (enter `about:tracing` in your Chrome URL field)](https://www.chromium.org/developers/how-tos/trace-event-profiling-tool)
    -   [Android systrace (`adb systrace`)](https://developer.android.com/studio/profile/systrace)
    -   [Fuchsia `fx traceutil`](https://fuchsia.dev/fuchsia-src/development/tracing/usage-guide)
    -   [Perfetto](https://ui.perfetto.dev/)
    -   [speedscope](https://www.speedscope.app/)

-   My Flutter app looks janky or stutters. How do I fix it?
    -   [Improving rendering performance](https://docs.flutter.dev/perf/rendering-performance)

-   What are some costly performance operations that I need to be careful with?
    -   [`Opacity`](https://api.flutter.dev/flutter/widgets/Opacity-class.html), [`Clip.antiAliasWithSaveLayer`](https://api.flutter.dev/flutter/dart-ui/Clip.html#antiAliasWithSaveLayer), or anything that triggers [`saveLayer`](https://api.flutter.dev/flutter/dart-ui/Canvas/saveLayer.html)
    -   [`ImageFilter`](https://api.flutter.dev/flutter/dart-ui/ImageFilter-class.html)
    -   Also see [Performance best practices](https://docs.flutter.dev/perf/best-practices)

-   How do I tell which widgets in my Flutter app are rebuilt in each frame?
    -   Set [`debugProfileBuildsEnabled`](https://api.flutter.dev/flutter/widgets/debugProfileBuildsEnabled.html) true in [widgets/debug.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/debug.dart).
    -   Alternatively, change the `performRebuild` function in [widgets/framework.dart](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/framework.dart) to ignore `debugProfileBuildsEnabled` and always call `Timeline.startSync(...)/finish`.
    -   If you use IntelliJ, a GUI view of this data is available. Select **Track widget rebuilds**, and your IDE displays which the widgets rebuild.

-   How do I query the target frames per second (of the display)?
    -   [Get the display refresh rate](https://github.com/flutter/flutter/wiki/Engine-specific-Service-Protocol-extensions#get-the-display-refresh-rate-_fluttergetdisplayrefreshrate)

-   How to solve my app’s poor animations caused by an expensive Dart async function call that is blocking the UI thread?
    -   Spawn another isolate using the [`compute()`](https://api.flutter.dev/flutter/foundation/compute-constant.html) method, as demonstrated in [Parse JSON in the background](https://docs.flutter.dev/cookbook/networking/background-parsing) cookbook.

-   How do I determine my Flutter app’s package size that a user will download?
    -   See [Measuring your app’s size](https://docs.flutter.dev/perf/app-size)

-   How do I see the breakdown of the Flutter engine size?
    -   Visit the [binary size dashboard](https://storage.googleapis.com/flutter_infra_release/flutter/241c87ad800beeab545ab867354d4683d5bfb6ce/android-arm-release/sizes/index.html), and replace the git hash in the URL with a recent commit hash from [GitHub engine repository commits](https://github.com/flutter/engine/commits).

-   How can I take a screenshot of an app that is running and export it as a SKP file?
    -   Run `flutter screenshot --type=skia --observatory-uri=...`
    -   Note a known issue viewing screenshots:
        -   [Issue 21237](https://github.com/flutter/flutter/issues/21237): Doesn’t record images in real devices.
    -   To analyze and visualize the SKP file, check out the [Skia WASM debugger](https://debugger.skia.org/).

-   How do I retrieve the shader persistent cache from a device?
    -   On Android, you can do the following:
        
        ```
        <span>adb shell
        </span><span>run-as &lt;com.your_app_package_name&gt;</span><span>
        </span><span>cp &lt;your_folder&gt;</span><span> </span>&lt;some_public_folder, e.g., /sdcard&gt; <span>-r</span>
        <span>adb pull &lt;some_public_folder/your_folder&gt;</span><span>
        </span>
        ```
        
-   How do I perform a trace in Fuchsia?
    -   See [Fuchsia tracing guidelines](https://fuchsia.dev/fuchsia-src/development/tracing/usage-guide)