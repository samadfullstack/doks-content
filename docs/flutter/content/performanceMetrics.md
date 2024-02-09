1.  [Performance](https://docs.flutter.dev/perf)
2.  [Performance metrics](https://docs.flutter.dev/perf/metrics)

-   Startup time to the first frame
    -   Check the time when [WidgetsBinding.instance.firstFrameRasterized](https://api.flutter.dev/flutter/widgets/WidgetsBinding/firstFrameRasterized.html) is true.
    -   See the [perf dashboard](https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3DtimeToFirstFrameRasterizedMicros).
-   Frame buildDuration, rasterDuration, and totalSpan
    -   See [`FrameTiming`](https://api.flutter.dev/flutter/dart-ui/FrameTiming-class.html) in the API docs.
-   Statistics of frame `buildDuration` (`*_frame_build_time_millis`)
    -   We recommend monitoring four stats: average, 90th percentile, 99th percentile, and worst frame build time.
    -   See, for example, [metrics](https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3D90th_percentile_frame_build_time_millis%26sub_result%3D99th_percentile_frame_build_time_millis%26sub_result%3Daverage_frame_build_time_millis%26sub_result%3Dworst_frame_build_time_millis%26test%3Dflutter_gallery__transition_perf) for the `flutter_gallery__transition_perf` test.
-   Statistics of frame `rasterDuration` (`*_frame_build_time_millis`)
    -   We recommend monitoring four stats: average, 90th percentile, 99th percentile, and worst frame build time.
    -   See, for example, [metrics](https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3D90th_percentile_frame_rasterizer_time_millis%26sub_result%3D99th_percentile_frame_rasterizer_time_millis%26sub_result%3Daverage_frame_rasterizer_time_millis%26sub_result%3Dworst_frame_rasterizer_time_millis%26test%3Dflutter_gallery__transition_perf) for the `flutter_gallery__transition_perf` test.
-   CPU/GPU usage (a good approximation for energy use)
    -   The usage is currently only available through trace events. See [profiling\_summarizer.dart](https://github.com/flutter/flutter/blob/master/packages/flutter_driver/lib/src/driver/profiling_summarizer.dart).
    -   See [metrics](https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3Daverage_cpu_usage%26sub_result%3Daverage_gpu_usage%26test%3Dsimple_animation_perf_ios) for the `simple_animation_perf_ios` test.
-   release\_size\_bytes to approximately measure the size of a Flutter app
    -   See the [basic\_material\_app\_android](https://github.com/flutter/flutter/blob/master/dev/devicelab/bin/tasks/basic_material_app_android__compile.dart), [basic\_material\_app\_ios](https://github.com/flutter/flutter/blob/master/dev/devicelab/bin/tasks/basic_material_app_ios__compile.dart), [hello\_world\_android](https://github.com/flutter/flutter/blob/master/dev/devicelab/bin/tasks/hello_world_android__compile.dart), [hello\_world\_ios](https://github.com/flutter/flutter/blob/master/dev/devicelab/bin/tasks/hello_world_ios__compile.dart), [flutter\_gallery\_android](https://github.com/flutter/flutter/blob/master/dev/devicelab/bin/tasks/flutter_gallery_android__compile.dart), and [flutter\_gallery\_ios](https://github.com/flutter/flutter/blob/master/dev/devicelab/bin/tasks/flutter_gallery_ios__compile.dart) tests.
    -   See [metrics](https://flutter-flutter-perf.skia.org/e/?queries=sub_result%3Drelease_size_bytes%26test%3Dbasic_material_app_android__compile%26test%3Dbasic_material_app_ios__compile%26test%3Dhello_world_android__compile%26test%3Dhello_world_ios__compile%26test%3Dflutter_gallery_ios__compile%26test%3Dflutter_gallery_android__compile) in the dashboard.
    -   For info on how to measure the size more accurately, see the [app size](https://docs.flutter.dev/perf/app-size) page.

For a complete list of performance metrics Flutter measures per commit, visit the following sites, click **Query**, and filter the **test** and **sub\_result** fields:

-   [https://flutter-flutter-perf.skia.org/e/](https://flutter-flutter-perf.skia.org/e/)
-   [https://flutter-engine-perf.skia.org/e/](https://flutter-engine-perf.skia.org/e/)