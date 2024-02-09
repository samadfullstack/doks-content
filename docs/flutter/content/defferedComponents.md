1.  [Performance](https://docs.flutter.dev/perf)
2.  [Deferred components](https://docs.flutter.dev/perf/deferred-components)

## Introduction

Flutter has the capability to build apps that can download additional Dart code and assets at runtime. This allows apps to reduce install apk size and download features and assets when needed by the user.

We refer to each uniquely downloadable bundle of Dart libraries and assets as a “deferred component”. To load these components, use [Dart’s deferred imports](https://dart.dev/language/libraries#lazily-loading-a-library). They can be compiled into split AOT and JavaScript shared libraries.

Though you can defer loading modules, you must build the entire app and upload that app as a single [Android App Bundle](https://developer.android.com/guide/app-bundle) (`*.aab`). Flutter doesn’t support dispatching partial updates without re-uploading new Android App Bundles for the entire application.

Flutter performs deferred loading when you compile your app in [release or profile mode](https://docs.flutter.dev/testing/build-modes). Debug mode treats all deferred components as regular imports. The components are present at launch and load immediately. This allows debug builds to hot reload.

For a deeper dive into the technical details of how this feature works, see [Deferred Components](https://github.com/flutter/flutter/wiki/Deferred-Components) on the [Flutter wiki](https://github.com/flutter/flutter/wiki).

## How to set your project up for deferred components

The following instructions explain how to set up your Android app for deferred loading.

### Step 1: Dependencies and initial project setup

1.  Add Play Core to the Android app’s build.gradle dependencies. In `android/app/build.gradle` add the following:
    
    ```
    <span>...</span>
    <span>dependencies</span> <span>{</span>
      <span>...</span>
      <span>implementation</span> <span>"com.google.android.play:core:1.8.0"</span>
      <span>...</span>
    <span>}</span>
    ```
    
2.  If using the Google Play Store as the distribution model for dynamic features, the app must support `SplitCompat` and provide an instance of a `PlayStoreDeferredComponentManager`. Both of these tasks can be accomplished by setting the `android:name` property on the application in `android/app/src/main/AndroidManifest.xml` to `io.flutter.embedding.android.FlutterPlayStoreSplitApplication`:
    
    ```
    <span>&lt;manifest</span> <span>...</span>
      <span>&lt;application</span>
         <span>android:name=</span><span>"io.flutter.embedding.android.FlutterPlayStoreSplitApplication"</span>
            <span>...</span>
      <span>&lt;/application</span><span>&gt;</span>
    <span>&lt;/manifest&gt;</span>
    ```
    
    `io.flutter.app.FlutterPlayStoreSplitApplication` handles both of these tasks for you. If you use `FlutterPlayStoreSplitApplication`, you can skip to step 1.3.
    
    If your Android application is large or complex, you might want to separately support `SplitCompat` and provide the `PlayStoreDynamicFeatureManager` manually.
    
    To support `SplitCompat`, there are three methods (as detailed in the [Android docs](https://developer.android.com/guide/playcore/feature-delivery#declare_splitcompatapplication_in_the_manifest)), any of which are valid:
    
    -   Make your application class extend `SplitCompatApplication`:
        
        ```
        <span>public</span> <span>class</span> <span>MyApplication</span> <span>extends</span> <span>SplitCompatApplication</span> <span>{</span>
            <span>...</span>
        <span>}</span>
        ```
        
    -   Call `SplitCompat.install(this);` in the `attachBaseContext()` method:
        
        ```
        <span>@Override</span>
        <span>protected</span> <span>void</span> <span>attachBaseContext</span><span>(</span><span>Context</span> <span>base</span><span>)</span> <span>{</span>
            <span>super</span><span>.</span><span>attachBaseContext</span><span>(</span><span>base</span><span>);</span>
            <span>// Emulates installation of future on demand modules using SplitCompat.</span>
            <span>SplitCompat</span><span>.</span><span>install</span><span>(</span><span>this</span><span>);</span>
        <span>}</span>
        ```
        
    -   Declare `SplitCompatApplication` as the application subclass and add the Flutter compatibility code from `FlutterApplication` to your application class:
        
        ```
        <span>&lt;</span><span>application</span>
            <span>...</span>
            <span>android</span><span>:</span><span>name</span><span>=</span><span>"</span><span>com.google.android.play.core.splitcompat.SplitCompatApplication</span><span>"</span><span>&gt;</span>
        <span>&lt;</span><span>/application</span><span>&gt;
        </span>
        ```
        
    
    The embedder relies on an injected `DeferredComponentManager` instance to handle install requests for deferred components. Provide a `PlayStoreDeferredComponentManager` into the Flutter embedder by adding the following code to your app initialization:
    
    ```
    <span>import</span> <span>io.flutter.embedding.engine.dynamicfeatures.PlayStoreDeferredComponentManager</span><span>;</span>
    <span>import</span> <span>io.flutter.FlutterInjector</span><span>;</span>
    <span>...</span> 
    <span>PlayStoreDeferredComponentManager</span> <span>deferredComponentManager</span> <span>=</span> <span>new</span>
      <span>PlayStoreDeferredComponentManager</span><span>(</span><span>this</span><span>,</span> <span>null</span><span>);</span>
    <span>FlutterInjector</span><span>.</span><span>setInstance</span><span>(</span><span>new</span> <span>FlutterInjector</span><span>.</span><span>Builder</span><span>()</span>
        <span>.</span><span>setDeferredComponentManager</span><span>(</span><span>deferredComponentManager</span><span>).</span><span>build</span><span>());</span>
    ```
    
3.  Opt into deferred components by adding the `deferred-components` entry to the app’s `pubspec.yaml` under the `flutter` entry:
    
    ```
      <span>...</span>
      <span>flutter</span><span>:</span>
        <span>...</span>
        <span>deferred-components</span><span>:</span>
        <span>...</span>
    ```
    
    The `flutter` tool looks for the `deferred-components` entry in the `pubspec.yaml` to determine whether the app should be built as deferred or not. This can be left empty for now unless you already know the components desired and the Dart deferred libraries that go into each. You will fill in this section later in [step 3.3](https://docs.flutter.dev/perf/deferred-components#step-3.3) once `gen_snapshot` produces the loading units.
    

### Step 2: Implementing deferred Dart libraries

Next, implement deferred loaded Dart libraries in your app’s Dart code. The implementation does not need to be feature complete yet. The example in the rest of this page adds a new simple deferred widget as a placeholder. You can also convert existing code to be deferred by modifying the imports and guarding usages of deferred code behind `loadLibrary()` `Futures`.

1.  Create a new Dart library. For example, create a new `DeferredBox` widget that can be downloaded at runtime. This widget can be of any complexity but, for the purposes of this guide, create a simple box as a stand-in. To create a simple blue box widget, create `box.dart` with the following contents:
    
    ```
    <span>// box.dart</span><span>
    </span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
    
    </span><span>/// A simple blue 30x30 box.</span><span>
    </span><span>class</span><span> </span><span>DeferredBox</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
      </span><span>const</span><span> </span><span>DeferredBox</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
      @override
      </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>Container</span><span>(</span><span>
          height</span><span>:</span><span> </span><span>30</span><span>,</span><span>
          width</span><span>:</span><span> </span><span>30</span><span>,</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>,</span><span>
        </span><span>);</span><span>
      </span><span>}</span><span>
    </span><span>}</span>
    ```
    
2.  Import the new Dart library with the `deferred` keyword in your app and call `loadLibrary()` (see [lazily loading a library](https://dart.dev/language/libraries#lazily-loading-a-library)). The following example uses `FutureBuilder` to wait for the `loadLibrary` `Future` (created in `initState`) to complete and display a `CircularProgressIndicator` as a placeholder. When the `Future` completes, it returns the `DeferredBox` widget. `SomeWidget` can then be used in the app as normal and won’t ever attempt to access the deferred Dart code until it has successfully loaded.
    
    ```
    <span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
    </span><span>import</span><span> </span><span>'box.dart'</span><span> </span><span>deferred</span><span> </span><span>as</span><span> box</span><span>;</span><span>
    
    </span><span>class</span><span> </span><span>SomeWidget</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
      </span><span>const</span><span> </span><span>SomeWidget</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
      @override
      </span><span>State</span><span>&lt;</span><span>SomeWidget</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SomeWidgetState</span><span>();</span><span>
    </span><span>}</span><span>
    
    </span><span>class</span><span> _SomeWidgetState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SomeWidget</span><span>&gt;</span><span> </span><span>{</span><span>
      </span><span>late</span><span> </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _libraryFuture</span><span>;</span><span>
    
      @override
      </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
        </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
        _libraryFuture </span><span>=</span><span> box</span><span>.</span><span>loadLibrary</span><span>();</span><span>
      </span><span>}</span><span>
    
      @override
      </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>FutureBuilder</span><span>&lt;</span><span>void</span><span>&gt;(</span><span>
          future</span><span>:</span><span> _libraryFuture</span><span>,</span><span>
          builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
            </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>connectionState </span><span>==</span><span> </span><span>ConnectionState</span><span>.</span><span>done</span><span>)</span><span> </span><span>{</span><span>
              </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasError</span><span>)</span><span> </span><span>{</span><span>
                </span><span>return</span><span> </span><span>Text</span><span>(</span><span>'Error: ${snapshot.error}'</span><span>);</span><span>
              </span><span>}</span><span>
              </span><span>return</span><span> box</span><span>.</span><span>DeferredBox</span><span>();</span><span>
            </span><span>}</span><span>
            </span><span>return</span><span> </span><span>const</span><span> </span><span>CircularProgressIndicator</span><span>();</span><span>
          </span><span>},</span><span>
        </span><span>);</span><span>
      </span><span>}</span><span>
    </span><span>}</span>
    ```
    
    The `loadLibrary()` function returns a `Future<void>` that completes successfully when the code in the library is available for use and completes with an error otherwise. All usage of symbols from the deferred library should be guarded behind a completed `loadLibrary()` call. All imports of the library must be marked as `deferred` for it to be compiled appropriately to be used in a deferred component. If a component has already been loaded, additional calls to `loadLibrary()` complete quickly (but not synchronously). The `loadLibrary()` function can also be called early to trigger a pre-load to help mask the loading time.
    
    You can find another example of deferred import loading in [Flutter Gallery’s lib/deferred\_widget.dart](https://github.com/flutter/gallery/blob/main/lib/deferred_widget.dart).
    

### Step 3: Building the app

Use the following `flutter` command to build a deferred components app:

```
<span>$</span><span> </span>flutter build appbundle
```

This command assists you by validating that your project is properly set up to build deferred components apps. By default, the build fails if the validator detects any issues and guides you through suggested changes to fix them.

1.  The `flutter build appbundle` command runs the validator and attempts to build the app with `gen_snapshot` instructed to produce split AOT shared libraries as separate `.so` files. On the first run, the validator will likely fail as it detects issues; the tool makes recommendations for how to set up the project and fix these issues.
    
    The validator is split into two sections: prebuild and post-gen\_snapshot validation. This is because any validation referencing loading units cannot be performed until `gen_snapshot` completes and produces a final set of loading units.
    
    The validator detects any new, changed, or removed loading units generated by `gen_snapshot`. The current generated loading units are tracked in your `<projectDirectory>/deferred_components_loading_units.yaml` file. This file should be checked into source control to ensure that changes to the loading units by other developers can be caught.
    
    The validator also checks for the following in the `android` directory:
    
    -   **`<projectDir>/android/app/src/main/res/values/strings.xml`**  
        An entry for every deferred component mapping the key `${componentName}Name` to `${componentName}`. This string resource is used by the `AndroidManifest.xml` of each feature module to define the `dist:title property`. For example:
        
        ```
        <span>&lt;?xml version="1.0" encoding="utf-8"?&gt;</span>
        <span>&lt;resources&gt;</span>
          ...
          <span>&lt;string</span> <span>name=</span><span>"boxComponentName"</span><span>&gt;</span>boxComponent<span>&lt;/string&gt;</span>
        <span>&lt;/resources&gt;</span>
        ```
        
    -   **`<projectDir>/android/<componentName>`**  
        An Android dynamic feature module for each deferred component exists and contains a `build.gradle` and `src/main/AndroidManifest.xml` file. This only checks for existence and does not validate the contents of these files. If a file does not exist, it generates a default recommended one.
        
    -   **`<projectDir>/android/app/src/main/res/values/AndroidManifest.xml`**  
        Contains a meta-data entry that encodes the mapping between loading units and component name the loading unit is associated with. This mapping is used by the embedder to convert Dart’s internal loading unit id to the name of a deferred component to install. For example:
        
        ```
            <span>...</span>
            <span>&lt;</span><span>application</span>
                <span>android</span><span>:</span><span>label</span><span>=</span><span>"</span><span>MyApp</span><span>"</span>
                <span>android</span><span>:</span><span>name</span><span>=</span><span>"</span><span>io.flutter.app.FlutterPlayStoreSplitApplication</span><span>"</span>
                <span>android</span><span>:</span><span>icon</span><span>=</span><span>"</span><span>@mipmap/ic_launcher</span><span>"</span><span>&gt;</span>
                <span>...</span>
                <span>&lt;</span><span>meta</span><span>-</span><span>data</span> <span>android</span><span>:</span><span>name</span><span>=</span><span>"</span><span>io.flutter.embedding.engine.deferredcomponents.DeferredComponentManager.loadingUnitMapping</span><span>"</span> <span>android</span><span>:</span><span>value</span><span>=</span><span>"</span><span>2:boxComponent</span><span>"</span><span>/&gt;</span>
            <span>&lt;</span><span>/application</span><span>&gt;
        </span>    <span>...</span>
        ```
        
    
    The `gen_snapshot` validator won’t run until the prebuild validator passes.
    
2.  For each of these checks, the tool produces the modified or new files needed to pass the check. These files are placed in the `<projectDir>/build/android_deferred_components_setup_files` directory. It is recommended that the changes be applied by copying and overwriting the same files in the project’s `android` directory. Before overwriting, the current project state should be committed to source control and the recommended changes should be reviewed to be appropriate. The tool won’t make any changes to your `android/` directory automatically.
    
3.  Once the available loading units are generated and logged in `<projectDirectory>/deferred_components_loading_units.yaml`, it is possible to fully configure the pubspec’s `deferred-components` section so that the loading units are assigned to deferred components as desired. To continue with the box example, the generated `deferred_components_loading_units.yaml` file would contain:
    
    ```
    <span>loading-units</span><span>:</span>
      <span>-</span> <span>id</span><span>:</span> <span>2</span>
        <span>libraries</span><span>:</span>
          <span>-</span> <span>package:MyAppName/box.Dart</span>
    ```
    
    The loading unit id (‘2’ in this case) is used internally by Dart, and can be ignored. The base loading unit (id ‘1’) is not listed and contains everything not explicitly contained in another loading unit.
    
    You can now add the following to `pubspec.yaml`:
    
    ```
    <span>...</span>
    <span>flutter</span><span>:</span>
      <span>...</span>
      <span>deferred-components</span><span>:</span>
        <span>-</span> <span>name</span><span>:</span> <span>boxComponent</span>
          <span>libraries</span><span>:</span>
            <span>-</span> <span>package:MyAppName/box.Dart</span>
      <span>...</span>
    ```
    
    To assign a loading unit to a deferred component, add any Dart lib in the loading unit into the libraries section of the feature module. Keep the following guidelines in mind:
    
    -   Loading units should not be included in more than one component.
        
    -   Including one Dart library from a loading unit indicates that the entire loading unit is assigned to the deferred component.
        
    -   All loading units not assigned to a deferred component are included in the base component, which always exists implicitly.
        
    -   Loading units assigned to the same deferred component are downloaded, installed, and shipped together.
        
    -   The base component is implicit and need not be defined in the pubspec.
        
4.  Assets can also be included by adding an assets section in the deferred component configuration:
    
    ```
      <span>deferred-components</span><span>:</span>
        <span>-</span> <span>name</span><span>:</span> <span>boxComponent</span>
          <span>libraries</span><span>:</span>
            <span>-</span> <span>package:MyAppName/box.Dart</span>
          <span>assets</span><span>:</span>
            <span>-</span> <span>assets/image.jpg</span>
            <span>-</span> <span>assets/picture.png</span>
              <span># wildcard directory</span>
            <span>-</span> <span>assets/gallery/</span>
    ```
    
    An asset can be included in multiple deferred components, but installing both components results in a replicated asset. Assets-only components can also be defined by omitting the libraries section. These assets-only components must be installed with the [`DeferredComponent`](https://api.flutter.dev/flutter/services/DeferredComponent-class.html) utility class in services rather than `loadLibrary()`. Since Dart libs are packaged together with assets, if a Dart library is loaded with `loadLibrary()`, any assets in the component are loaded as well. However, installing by component name and the services utility won’t load any dart libraries in the component.
    
    You are free to include assets in any component, as long as they are installed and loaded when they are first referenced, though typically, assets and the Dart code that uses those assets are best packed in the same component.
    
5.  Manually add all deferred components that you defined in `pubspec.yaml` into the `android/settings.gradle` file as includes. For example, if there are three deferred components defined in the pubspec named, `boxComponent`, `circleComponent`, and `assetComponent`, ensure that `android/settings.gradle` contains the following:
    
    ```
    <span>include</span> <span>':app'</span><span>,</span> <span>':boxComponent'</span><span>,</span> <span>':circleComponent'</span><span>,</span> <span>':assetComponent'</span>
    <span>...</span>
    ```
    
6.  Repeat steps [3.1](https://docs.flutter.dev/perf/deferred-components#step-3.1) through 3.6 (this step) until all validator recommendations are handled and the tool runs without further recommendations.
    
    When successful, this command outputs an `app-release.aab` file in `build/app/outputs/bundle/release`.
    
    A successful build does not always mean the app was built as intended. It is up to you to ensure that all loading units and Dart libraries are included in the way you intended. For example, a common mistake is accidentally importing a Dart library without the `deferred` keyword, resulting in a deferred library being compiled as part of the base loading unit. In this case, the Dart lib would load properly because it is always present in the base, and the lib would not be split off. This can be checked by examining the `deferred_components_loading_units.yaml` file to verify that the generated loading units are described as intended.
    
    When adjusting the deferred components configurations, or making Dart changes that add, modify, or remove loading units, you should expect the validator to fail. Follow steps [3.1](https://docs.flutter.dev/perf/deferred-components#step-3.1) through 3.6 (this step) to apply any recommended changes to continue the build.
    

### Running the app locally

Once your app has successfully built an `.aab` file, use Android’s [`bundletool`](https://developer.android.com/studio/command-line/bundletool) to perform local testing with the `--local-testing` flag.

To run the `.aab` file on a test device, download the bundletool jar executable from [github.com/google/bundletool/releases](https://github.com/google/bundletool/releases) and run:

```
<span>$</span><span> </span>java <span>-jar</span> bundletool.jar build-apks <span>--bundle</span><span>=</span>&lt;your_app_project_dir&gt;/build/app/outputs/bundle/release/app-release.aab <span>--output</span><span>=</span>&lt;your_temp_dir&gt;/app.apks <span>--local-testing</span>
<span>
</span><span>$</span><span> </span>java <span>-jar</span> bundletool.jar install-apks <span>--apks</span><span>=</span>&lt;your_temp_dir&gt;/app.apks
```

Where `<your_app_project_dir>` is the path to your app’s project directory and `<your_temp_dir>` is any temporary directory used to store the outputs of bundletool. This unpacks your `.aab` file into an `.apks` file and installs it on the device. All available Android dynamic features are loaded onto the device locally and installation of deferred components is emulated.

Before running `build-apks` again, remove the existing app .apks file:

```
<span>$</span><span> </span><span>rm</span> &lt;your_temp_dir&gt;/app.apks
```

Changes to the Dart codebase require either incrementing the Android build ID or uninstalling and reinstalling the app, as Android won’t update the feature modules unless it detects a new version number.

### Releasing to the Google Play store

The built `.aab` file can be uploaded directly to the Play store as normal. When `loadLibrary()` is called, the needed Android module containing the Dart AOT lib and assets is downloaded by the Flutter engine using the Play store’s delivery feature.