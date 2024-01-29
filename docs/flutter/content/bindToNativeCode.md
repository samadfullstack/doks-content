1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Android](https://docs.flutter.dev/platform-integration/android)
3.  [Binding to native Android code using dart:ffi](https://docs.flutter.dev/platform-integration/android/c-interop)

Flutter mobile and desktop apps can use the [dart:ffi](https://api.dart.dev/dev/dart-ffi/dart-ffi-library.html) library to call native C APIs. _FFI_ stands for [_foreign function interface._](https://en.wikipedia.org/wiki/Foreign_function_interface) Other terms for similar functionality include _native interface_ and _language bindings._

Before your library or program can use the FFI library to bind to native code, you must ensure that the native code is loaded and its symbols are visible to Dart. This page focuses on compiling, packaging, and loading Android native code within a Flutter plugin or app.

This tutorial demonstrates how to bundle C/C++ sources in a Flutter plugin and bind to them using the Dart FFI library on both Android and iOS. In this walkthrough, you’ll create a C function that implements 32-bit addition and then exposes it through a Dart plugin named “native\_add”.

### Dynamic vs static linking

A native library can be linked into an app either dynamically or statically. A statically linked library is embedded into the app’s executable image, and is loaded when the app starts.

Symbols from a statically linked library can be loaded using [`DynamicLibrary.executable`](https://api.dart.dev/dev/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html) or [`DynamicLibrary.process`](https://api.dart.dev/dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html).

A dynamically linked library, by contrast, is distributed in a separate file or folder within the app, and loaded on-demand. On Android, a dynamically linked library is distributed as a set of `.so` (ELF) files, one for each architecture.

A dynamically linked library can be loaded into Dart via [`DynamicLibrary.open`](https://api.dart.dev/dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html).

API documentation is available from the Dart dev channel: [Dart API reference documentation](https://api.dart.dev/dev/).

On Android, only dynamic libraries are supported (because the main executable is the JVM, which we don’t link to statically).

## Create an FFI plugin

To create an FFI plugin called “native\_add”, do the following:

```
<span>$</span><span> </span>flutter create <span>--platforms</span><span>=</span>android,ios,macos,windows,linux <span>--template</span><span>=</span>plugin_ffi native_add
<span>$</span><span> </span><span>cd </span>native_add
```

This will create a plugin with C/C++ sources in `native_add/src`. These sources are built by the native build files in the various os build folders.

The FFI library can only bind against C symbols, so in C++ these symbols are marked `extern "C"`.

You should also add attributes to indicate that the symbols are referenced from Dart, to prevent the linker from discarding the symbols during link-time optimization. `__attribute__((visibility("default"))) __attribute__((used))`.

On Android, the `native_add/android/build.gradle` links the code.

The native code is invoked from dart in `lib/native_add_bindings_generated.dart`.

The bindings are generated with [package:ffigen](https://pub.dev/packages/ffigen).

## Other use cases

### Platform library

To link against a platform library, use the following instructions:

1.  Find the desired library in the [Android NDK Native APIs](https://developer.android.com/ndk/guides/stable_apis) list in the Android docs. This lists stable native APIs.
2.  Load the library using [`DynamicLibrary.open`](https://api.dart.dev/dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html). For example, to load OpenGL ES (v3):
    
    ```
    <span>DynamicLibrary</span><span>.</span><span>open</span><span>(</span><span>'libGLES_v3.so'</span><span>);</span>
    ```
    

You might need to update the Android manifest file of the app or plugin if indicated by the documentation.

#### First-party library

The process for including native code in source code or binary form is the same for an app or plugin.

#### Open-source third-party

Follow the [Add C and C++ code to your project](https://developer.android.com/studio/projects/add-native-code) instructions in the Android docs to add native code and support for the native code toolchain (either CMake or `ndk-build`).

#### Closed-source third-party library

To create a Flutter plugin that includes Dart source code, but distribute the C/C++ library in binary form, use the following instructions:

1.  Open the `android/build.gradle` file for your project.
2.  Add the AAR artifact as a dependency. **Don’t** include the artifact in your Flutter package. Instead, it should be downloaded from a repository, such as JCenter.

[Android guidelines](https://developer.android.com/topic/performance/reduce-apk-size#extract-false) in general recommend distributing native shared objects uncompressed because that actually saves on device space. Shared objects can be directly loaded from the APK instead of unpacking them on device into a temporary location and then loading. APKs are additionally packed in transit—that’s why you should be looking at download size.

Flutter APKs by default don’t follow these guidelines and compress `libflutter.so` and `libapp.so`—this leads to smaller APK size but larger on device size.

Shared objects from third parties can change this default setting with `android:extractNativeLibs="true"` in their `AndroidManifest.xml` and stop the compression of `libflutter.so`, `libapp.so`, and any user-added shared objects. To re-enable compression, override the setting in `your_app_name/android/app/src/main/AndroidManifest.xml` in the following way.

```
<span>@@ -1,5 +1,6 @@</span>
 &lt;manifest xmlns:android="http://schemas.android.com/apk/res/android"
<span>-    package="com.example.your_app_name"&gt;
</span><span>+    xmlns:tools="http://schemas.android.com/tools"
+    package="com.example.your_app_name" &gt;
</span>     &lt;!-- io.flutter.app.FlutterApplication is an android.app.Application that
          calls FlutterMain.startInitialization(this); in its onCreate method.
          In most cases you can leave this as-is, but you if you want to provide
          additional functionality it is fine to subclass or reimplement
          FlutterApplication and put your custom class here. --&gt;
<span>@@ -8,7 +9,9 @@</span>
     &lt;application
         android:name="io.flutter.app.FlutterApplication"
         android:label="your_app_name"
<span>-        android:icon="@mipmap/ic_launcher"&gt;
</span><span>+        android:icon="@mipmap/ic_launcher"
+        android:extractNativeLibs="true"
+        tools:replace="android:extractNativeLibs"&gt;
</span>
```

## Other Resources

To learn more about C interoperability, check out these videos:

-   [C interoperability with Dart FFI](https://docs.flutter.dev/platform-integration/android/c-interop?v=2MMK7YoFgaA)
-   [How to Use Dart FFI to Build a Retro Audio Player](https://docs.flutter.dev/platform-integration/android/c-interop?v=05Wn2oM_nWw)