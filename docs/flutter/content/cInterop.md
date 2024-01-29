1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [macOS](https://docs.flutter.dev/platform-integration/macos)
3.  [Binding to native macOS code using dart:ffi](https://docs.flutter.dev/platform-integration/macos/c-interop)

Flutter mobile and desktop apps can use the [dart:ffi](https://api.dart.dev/dev/dart-ffi/dart-ffi-library.html) library to call native C APIs. _FFI_ stands for [_foreign function interface._](https://en.wikipedia.org/wiki/Foreign_function_interface) Other terms for similar functionality include _native interface_ and _language bindings._

Before your library or program can use the FFI library to bind to native code, you must ensure that the native code is loaded and its symbols are visible to Dart. This page focuses on compiling, packaging, and loading macOS native code within a Flutter plugin or app.

This tutorial demonstrates how to bundle C/C++ sources in a Flutter plugin and bind to them using the Dart FFI library on macOS. In this walkthrough, you’ll create a C function that implements 32-bit addition and then exposes it through a Dart plugin named “native\_add”.

### Dynamic vs static linking

A native library can be linked into an app either dynamically or statically. A statically linked library is embedded into the app’s executable image, and is loaded when the app starts.

Symbols from a statically linked library can be loaded using `DynamicLibrary.executable` or `DynamicLibrary.process`.

A dynamically linked library, by contrast, is distributed in a separate file or folder within the app, and loaded on-demand. On macOS, the dynamically linked library is distributed as a `.framework` folder.

A dynamically linked library can be loaded into Dart using `DynamicLibrary.open`.

API documentation is available from the Dart dev channel: [Dart API reference documentation](https://api.dart.dev/dev/).

## Step 1: Create a plugin

If you already have a plugin, skip this step.

To create a plugin called “native\_add”, do the following:

```
<span>$</span><span> </span>flutter create <span>--platforms</span><span>=</span>macos <span>--template</span><span>=</span>plugin native_add
<span>$</span><span> </span><span>cd </span>native_add
```

## Step 2: Add C/C++ sources

You need to inform the macOS build system about the native code so the code can be compiled and linked appropriately into the final application.

Add the sources to the `macos` folder, because CocoaPods doesn’t allow including sources above the `podspec` file.

The FFI library can only bind against C symbols, so in C++ these symbols must be marked `extern C`. You should also add attributes to indicate that the symbols are referenced from Dart, to prevent the linker from discarding the symbols during link-time optimization.

For example, to create a C++ file named `macos/Classes/native_add.cpp`, use the following instructions. (Note that the template has already created this file for you.) Start from the root directory of your project:

```
<span>cat</span> <span>&gt;</span> macos/Classes/native_add.cpp <span>&lt;&lt;</span> <span>EOF</span><span>
#include &lt;stdint.h&gt;

extern "C" __attribute__((visibility("default"))) __attribute__((used))
int32_t native_add(int32_t x, int32_t y) {
    return x + y;
}
</span><span>EOF
</span>
```

On macOS, you need to tell Xcode to statically link the file:

1.  In Xcode, open `Runner.xcworkspace`.
2.  Add the C/C++/Objective-C/Swift source files to the Xcode project.

## Step 3: Load the code using the FFI library

In this example, you can add the following code to `lib/native_add.dart`. However the location of the Dart binding code isn’t important.

First, you must create a `DynamicLibrary` handle to the native code.

```
<span>import</span> <span>'dart:ffi'</span><span>;</span> <span>// For FFI</span>

<span>final</span> <span>DynamicLibrary</span> <span>nativeAddLib</span> <span>=</span> <span>DynamicLibrary</span><span>.</span><span>process</span><span>();</span>
```

With a handle to the enclosing library, you can resolve the `native_add` symbol:

```
<span>final</span><span> </span><span>int</span><span> </span><span>Function</span><span>(</span><span>int</span><span> x</span><span>,</span><span> </span><span>int</span><span> y</span><span>)</span><span> nativeAdd </span><span>=</span><span> nativeAddLib
    </span><span>.</span><span>lookup</span><span>&lt;</span><span>NativeFunction</span><span>&lt;</span><span>Int32</span><span> </span><span>Function</span><span>(</span><span>Int32</span><span>,</span><span> </span><span>Int32</span><span>)&gt;&gt;(</span><span>'native_add'</span><span>)</span><span>
    </span><span>.</span><span>asFunction</span><span>();</span>
```

Finally, you can call it. To demonstrate this within the auto-generated “example” app (`example/lib/main.dart`):

```nocode
// Inside of _MyAppState.build: body: Center( child: Text('1 + 2 == ${nativeAdd(1, 2)}'), ),
```

## Other use cases

### iOS and macOS

Dynamically linked libraries are automatically loaded by the dynamic linker when the app starts. Their constituent symbols can be resolved using [`DynamicLibrary.process`](https://api.dart.dev/dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html). You can also get a handle to the library with [`DynamicLibrary.open`](https://api.dart.dev/dev/dart-ffi/DynamicLibrary/DynamicLibrary.open.html) to restrict the scope of symbol resolution, but it’s unclear how Apple’s review process handles this.

Symbols statically linked into the application binary can be resolved using [`DynamicLibrary.executable`](https://api.dart.dev/dev/dart-ffi/DynamicLibrary/DynamicLibrary.executable.html) or [`DynamicLibrary.process`](https://api.dart.dev/dev/dart-ffi/DynamicLibrary/DynamicLibrary.process.html).

#### Platform library

To link against a platform library, use the following instructions:

1.  In Xcode, open `Runner.xcworkspace`.
2.  Select the target platform.
3.  Click **+** in the **Linked Frameworks and Libraries** section.
4.  Select the system library to link against.

#### First-party library

A first-party native library can be included either as source or as a (signed) `.framework` file. It’s probably possible to include statically linked archives as well, but it requires testing.

#### Source code

To link directly to source code, use the following instructions:

1.  In Xcode, open `Runner.xcworkspace`.
2.  Add the C/C++/Objective-C/Swift source files to the Xcode project.
3.  Add the following prefix to the exported symbol declarations to ensure they are visible to Dart:
    
    **C/C++/Objective-C**
    
    ```objective
    extern "C" /* <= C++ only */ __attribute__((visibility("default"))) __attribute__((used))
    ```
    
    **Swift**
    
    ```
    <span>@_cdecl</span><span>(</span><span>"myFunctionName"</span><span>)</span>
    ```
    

#### Compiled (dynamic) library

To link to a compiled dynamic library, use the following instructions:

1.  If a properly signed `Framework` file is present, open `Runner.xcworkspace`.
2.  Add the framework file to the **Embedded Binaries** section.
3.  Also add it to the **Linked Frameworks & Libraries** section of the target in Xcode.

#### Compiled (dynamic) library (macOS)

To add a closed source library to a [Flutter macOS Desktop](https://docs.flutter.dev/platform-integration/macos/building) app, use the following instructions:

1.  Follow the instructions for Flutter desktop to create a Flutter desktop app.
2.  Open the `yourapp/macos/Runner.xcworkspace` in Xcode.
    1.  Drag your precompiled library (`libyourlibrary.dylib`) into `Runner/Frameworks`.
    2.  Click `Runner` and go to the `Build Phases` tab.
        1.  Drag `libyourlibrary.dylib` into the `Copy Bundle Resources` list.
        2.  Under `Embed Libraries`, check `Code Sign on Copy`.
        3.  Under `Link Binary With Libraries`, set status to `Optional`. (We use dynamic linking, no need to statically link.)
    3.  Click `Runner` and go to the `General` tab.
        1.  Drag `libyourlibrary.dylib` into the **Frameworks, Libraries and Embedded Content** list.
        2.  Select **Embed & Sign**.
    4.  Click **Runner** and go to the **Build Settings** tab.
        1.  In the **Search Paths** section configure the **Library Search Paths** to include the path where `libyourlibrary.dylib` is located.
3.  Edit `lib/main.dart`.
    1.  Use `DynamicLibrary.open('libyourlibrary.dylib')` to dynamically link to the symbols.
    2.  Call your native function somewhere in a widget.
4.  Run `flutter run` and check that your native function gets called.
5.  Run `flutter build macos` to build a self-contained release version of your app.

## Other Resources

To learn more about C interoperability, check out these videos:

-   [C interoperability with Dart FFI](https://docs.flutter.dev/platform-integration/macos/c-interop?v=2MMK7YoFgaA)
-   [How to Use Dart FFI to Build a Retro Audio Player](https://docs.flutter.dev/platform-integration/macos/c-interop?v=05Wn2oM_nWw)