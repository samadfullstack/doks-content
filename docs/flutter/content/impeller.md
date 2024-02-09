1.  [Performance](https://docs.flutter.dev/perf)
2.  [Impeller rendering engine](https://docs.flutter.dev/perf/impeller)

## What is Impeller?

Impeller provides a new rendering runtime for Flutter. The Flutter team’s believes this solves Flutter’s [early-onset jank](https://github.com/flutter/flutter/projects/188) issue. Impeller precompiles a [smaller, simpler set of shaders](https://github.com/flutter/flutter/issues/77412) at Engine build time so they don’t compile at runtime.

For a video introduction to Impeller, check out the following talk from Google I/O 2023.

<iframe width="560" height="315" src="https://www.youtube.com/embed/vd5NqS01rlA?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Introducing Impeller - Flutter's new rendering engine" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" id="167030630" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

[Introducing Impeller - Flutter’s new rendering engine](https://www.youtube.com/watch?v=vd5NqS01rlA)

Impeller has the following objectives:

-   **Predictable performance**: Impeller compiles all shaders and reflection offline at build time. It builds all pipeline state objects upfront. The engine controls caching and caches explicitly.
-   **Instrumentable**: Impeller tags and labels all graphics resources like textures, and buffers. It can capture and persist animations to disk without affecting per-frame rendering performance.
-   **Portable**: Flutter doesn’t tie Impeller to a specific client rendering API. You can author shaders once and convert them to backend-specific formats as necessary.
-   **Leverages modern graphics APIs**: Impeller uses, but doesn’t depend on, features available in modern APIs like Metal and Vulkan.
-   **Leverages concurrency**: Impeller can distribute single-frame workloads across multiple threads if necessary.

## Availability

Where can you use Impeller?

### iOS

Flutter enables Impeller by default on iOS.

-   To _disable_ Impeller on iOS when debugging, pass `--no-enable-impeller` to the `flutter run` command.
    
    ```
    <span>flutter run --no-enable-impeller
    </span>
    ```
    
-   To _disable_ Impeller on iOS when deploying your app, add the following tags under the top-level `<dict>` tag in your app’s `Info.plist` file.
    
    ```
      <span>&lt;key&gt;</span>FLTEnableImpeller<span>&lt;/key&gt;</span>
      <span>&lt;false</span> <span>/&gt;</span>
    ```
    

The team continues to improve iOS support. If you encounter performance or fidelity issues with Impeller on iOS, file an issue in the [GitHub tracker](https://github.com/flutter/flutter/issues/new/choose). Prefix the issue title with `[Impeller]` and include a small reproducible test case.

### macOS

Impeller is available for macOS in preview as of the Flutter 3.13 stable release. It continues to be in preview as of the 3.16 release.

To enable Impeller on macOS when debugging, pass `--enable-impeller` to the `flutter run` command.

```
<span>flutter run --enable-impeller
</span>
```

To enable Impeller on macOS when deploying your app, add the following tags under the top-level `<dict>` tag in your app’s `Info.plist` file.

```
  <span>&lt;key&gt;</span>FLTEnableImpeller<span>&lt;/key&gt;</span>
  <span>&lt;true</span> <span>/&gt;</span>
```

### Android

As of Flutter 3.16, Impeller is available behind a flag on Android devices that support Vulkan.

You can try Impeller on Vulkan-capable Android devices by passing `--enable-impeller` to `flutter run`:

```
<span>flutter run --enable-impeller
</span>
```

Or, you can add the following setting to your project’s `AndroidManifest.xml` file under the `<application>` tag:

```
<span>&lt;meta-data</span>
    <span>android:name=</span><span>"io.flutter.embedding.android.EnableImpeller"</span>
    <span>android:value=</span><span>"true"</span> <span>/&gt;</span>
```

### Bugs and issues

For the full list of Impeller’s known bugs and missing features, the most up-to-date information is on the [Impeller project board](https://github.com/orgs/flutter/projects/21) on GitHub.

The team continues to improve Impeller support. If you encounter performance or fidelity issues with Impeller on any platform, file an issue in the [GitHub tracker](https://github.com/flutter/flutter/issues/new/choose). Prefix the issue title with `[Impeller]` and include a small reproducible test case.

Please include the following information when submitting an issue for Impeller:

-   The device you are running on, including the chip information.
-   Screenshots or recordings of any visible issues.
-   An [export of the performance trace](https://docs.flutter.dev/tools/devtools/performance#import-and-export). Zip the file and attach it to the GitHub issue.

## Architecture

To learn more details about Impeller’s design and architecture, check out the [README.md](https://github.com/flutter/engine/blob/main/impeller/README.md) file in the source tree.

## Additional Information

-   [Frequently asked questions](https://github.com/flutter/engine/blob/main/impeller/docs/faq.md)
-   [Impeller’s coordinate system](https://github.com/flutter/engine/blob/main/impeller/docs/coordinate_system.md)
-   [How to set up Xcode for GPU frame captures with metal](https://github.com/flutter/engine/blob/main/impeller/docs/xcode_frame_capture.md)
-   [Learning to read GPU frame captures](https://github.com/flutter/engine/blob/main/impeller/docs/read_frame_captures.md)
-   [How to enable metal validation for command line apps](https://github.com/flutter/engine/blob/main/impeller/docs/metal_validation.md)
-   [How Impeller works around the lack of uniform buffers in Open GL ES 2.0](https://github.com/flutter/engine/blob/main/impeller/docs/ubo_gles2.md)
-   [Guidance for writing efficient shaders](https://github.com/flutter/engine/blob/main/impeller/docs/shader_optimization.md)
-   [How color blending works in Impeller](https://github.com/flutter/engine/blob/main/impeller/docs/blending.md)