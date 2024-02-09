1.  [Performance](https://docs.flutter.dev/perf)
2.  [Shader jank](https://docs.flutter.dev/perf/shader)

If the animations on your mobile app appear to be janky, but only on the first run, this is likely due to shader compilation. Flutter’s long term solution to shader compilation jank is [Impeller](https://github.com/flutter/flutter/wiki/Impeller), which is in the stable release for iOS and in preview behind a flag on Android.

While we work on making Impeller fully production ready, you can mitigate shader compilation jank by bundling precompiled shaders with an iOS app. Unfortunately, this approach doesn’t work well on Android due to precompiled shaders being device or GPU-specific. The Android hardware ecosystem is large enough that the GPU-specific precompiled shaders bundled with an application will work on only a small subset of devices, and will likely make jank worse on the other devices, or even create rendering errors.

Also, note that we aren’t planning to make improvements to the developer experience for creating precompiled shaders described below. Instead, we are focusing our energies on the more robust solution to this problem that Impeller offers.

## What is shader compilation jank?

A shader is a piece of code that runs on a GPU (graphics processing unit). When the Skia graphics backend that Flutter uses for rendering sees a new sequence of draw commands for the first time, it sometimes generates and compiles a custom GPU shader for that sequence of commands. This allows that sequence and potentially similar sequences to render as fast as possible.

Unfortunately, Skia’s shader generation and compilation happens in sequence with the frame workload. The compilation could cost up to a few hundred milliseconds whereas a smooth frame needs to be drawn within 16 milliseconds for a 60 fps (frame-per-second) display. Therefore, a compilation could cause tens of frames to be missed, and drop the fps from 60 to 6. This is _compilation jank_. After the compilation is complete, the animation should be smooth.

On the other hand, Impeller generates and compiles all necessary shaders when we build the Flutter Engine. Therefore apps running on Impeller already have all the shaders they need, and the shaders can be used without introducing jank into animations.

Definitive evidence for the presence of shader compilation jank is to set `GrGLProgramBuilder::finalize` in the tracing with `--trace-skia` enabled. The following screenshot shows an example timeline tracing.

![A tracing screenshot verifying jank](https://docs.flutter.dev/assets/images/docs/perf/render/tracing.png)

## What do we mean by “first run”?

On iOS, “first run” means that the user might see jank when an animation first occurs every time the user opens the app from scratch.

## How to use SkSL warmup

Flutter provides command line tools for app developers to collect shaders that might be needed for end-users in the SkSL (Skia Shader Language) format. The SkSL shaders can then be packaged into the app, and get warmed up (pre-compiled) when an end-user first opens the app, thereby reducing the compilation jank in later animations. Use the following instructions to collect and package the SkSL shaders:

1.  Run the app with `--cache-sksl` turned on to capture shaders in SkSL:
    
    ```
    <span>flutter run --profile --cache-sksl
    </span>
    ```
    
    If the same app has been previously run without `--cache-sksl`, then the `--purge-persistent-cache` flag might be needed:
    
    ```
    <span>flutter run --profile --cache-sksl --purge-persistent-cache
    </span>
    ```
    
    This flag removes older non-SkSL shader caches that could interfere with SkSL shader capturing. It also purges the SkSL shaders so use it _only_ on the first `--cache-sksl` run.
    
2.  Play with the app to trigger as many animations as needed; particularly those with compilation jank.
    
3.  Press `M` at the command line of `flutter run` to write the captured SkSL shaders into a file named something like `flutter_01.sksl.json`. For best results, capture SkSL shaders on an actual iOS device. A shader captured on a simulator isn’t likely to work correctly on actual hardware.
    
4.  Build the app with SkSL warm-up using the following, as appropriate:
    
    ```
    <span>flutter build ios --bundle-sksl-path flutter_01.sksl.json
    </span>
    ```
    
    If it’s built for a driver test like `test_driver/app.dart`, make sure to also specify `--target=test_driver/app.dart` (for example, `flutter build ios --bundle-sksl-path flutter_01.sksl.json --target=test_driver/app.dart`).
    
5.  Test the newly built app.
    

Alternatively, you can write some integration tests to automate the first three steps using a single command. For example:

```
<span>flutter drive --profile --cache-sksl --write-sksl-on-exit flutter_01.sksl.json -t test_driver/app.dart
</span>
```

With such [integration tests](https://docs.flutter.dev/cookbook/testing/integration/introduction), you can easily and reliably get the new SkSLs when the app code changes, or when Flutter upgrades. Such tests can also be used to verify the performance change before and after the SkSL warm-up. Even better, you can put those tests into a CI (continuous integration) system so the SkSLs are generated and tested automatically over the lifetime of an app.

Take the original version of [Flutter Gallery](https://github.com/flutter/flutter/tree/main/dev/integration_tests/flutter_gallery) as an example. The CI system is set up to generate SkSLs for every Flutter commit, and verifies the performance, in the [`transitions_perf_test.dart`](https://github.com/flutter/flutter/blob/master/dev/integration_tests/flutter_gallery/test_driver/transitions_perf_test.dart) test. For more details, check out the [`flutter_gallery_sksl_warmup__transition_perf`](https://github.com/flutter/flutter/blob/master/dev/devicelab/bin/tasks/flutter_gallery_sksl_warmup__transition_perf.dart) and [`flutter_gallery_sksl_warmup__transition_perf_e2e_ios32`](https://github.com/flutter/flutter/blob/master/dev/devicelab/bin/tasks/flutter_gallery_sksl_warmup__transition_perf_e2e_ios32.dart) tasks.

The worst frame rasterization time is a useful metric from such integration tests to indicate the severity of shader compilation jank. For instance, the steps above reduce Flutter gallery’s shader compilation jank and speeds up its worst frame rasterization time on a Moto G4 from ~90 ms to ~40 ms. On iPhone 4s, it’s reduced from ~300 ms to ~80 ms. That leads to the visual difference as illustrated in the beginning of this article.