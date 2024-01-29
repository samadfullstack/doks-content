1.  [Packages & plugins](https://docs.flutter.dev/packages-and-plugins)
2.  [Using packages](https://docs.flutter.dev/packages-and-plugins/using-packages)

Flutter supports using shared packages contributed by other developers to the Flutter and Dart ecosystems. This allows quickly building an app without having to develop everything from scratch.

Existing packages enable many use cases—for example, making network requests ([`http`](https://docs.flutter.dev/cookbook/networking/fetch-data)), navigation/route handling ([`go_router`](https://pub.dev/packages/go_router)), integration with device APIs ([`url_launcher`](https://pub.dev/packages/url_launcher) and [`battery_plus`](https://pub.dev/packages/battery_plus)), and using third-party platform SDKs like Firebase ([FlutterFire](https://github.com/firebase/flutterfire)).

To write a new package, see [developing packages](https://docs.flutter.dev/packages-and-plugins/developing-packages). To add assets, images, or fonts, whether stored in files or packages, see [Adding assets and images](https://docs.flutter.dev/ui/assets/assets-and-images).

## Using packages

The following section describes how to use existing published packages.

### Searching for packages

Packages are published to [pub.dev](https://pub.dev/).

The [Flutter landing page](https://pub.dev/flutter) on pub.dev displays top packages that are compatible with Flutter (those that declare dependencies generally compatible with Flutter), and supports searching among all published packages.

The [Flutter Favorites](https://pub.dev/flutter/favorites) page on pub.dev lists the plugins and packages that have been identified as packages you should first consider using when writing your app. For more information on what it means to be a Flutter Favorite, see the [Flutter Favorites program](https://docs.flutter.dev/packages-and-plugins/favorites).

You can also browse the packages on pub.dev by filtering on [Android](https://pub.dev/packages?q=sdk%3Aflutter+platform%3Aandroid), [iOS](https://pub.dev/packages?q=sdk%3Aflutter+platform%3Aios), [web](https://pub.dev/packages?q=sdk%3Aflutter+platform%3Aweb), [Linux](https://docs.flutter.dev/packages-and-plugins/using-packages?q=sdk%3Aflutter+platform%3Alinux), [Windows](https://pub.dev/packages?q=sdk%3Aflutter+platform%3Awindows), [macOS](https://pub.dev/packages?q=sdk%3Aflutter+platform%3Amacos), or any combination thereof.

### Adding a package dependency to an app

To add the package, `css_colors`, to an app:

1.  Depend on it
    -   Open the `pubspec.yaml` file located inside the app folder, and add `css_colors:` under `dependencies`.
2.  Install it
    -   From the terminal: Run `flutter pub get`.  
        **OR**
    -   From VS Code: Click **Get Packages** located in right side of the action ribbon at the top of `pubspec.yaml` indicated by the Download icon.
    -   From Android Studio/IntelliJ: Click **Pub get** in the action ribbon at the top of `pubspec.yaml`.
3.  Import it
    -   Add a corresponding `import` statement in the Dart code.
4.  Stop and restart the app, if necessary
    -   If the package brings platform-specific code (Kotlin/Java for Android, Swift/Objective-C for iOS), that code must be built into your app. Hot reload and hot restart only update the Dart code, so a full restart of the app might be required to avoid errors like `MissingPluginException` when using the package.

### Adding a package dependency to an app using `flutter pub add`

To add the package, `css_colors`, to an app:

1.  Issue the command while being inside the project directory
    -   `flutter pub add css_colors`
2.  Import it
    -   Add a corresponding `import` statement in the Dart code.
3.  Stop and restart the app, if necessary
    -   If the package brings platform-specific code (Kotlin/Java for Android, Swift/Objective-C for iOS), that code must be built into your app. Hot reload and hot restart only update the Dart code, so a full restart of the app might be required to avoid errors like `MissingPluginException` when using the package.

### Removing a package dependency to an app using `flutter pub remove`

To remove the package, `css_colors`, to an app:

1.  Issue the command while being inside the project directory
    -   `flutter pub remove css_colors`

The [Installing tab](https://pub.dev/packages/css_colors/install), available on any package page on pub.dev, is a handy reference for these steps.

For a complete example, see the [css\_colors example](https://docs.flutter.dev/packages-and-plugins/using-packages#css-example) below.

### Conflict resolution

Suppose you want to use `some_package` and `another_package` in an app, and both of these depend on `url_launcher`, but in different versions. That causes a potential conflict. The best way to avoid this is for package authors to use [version ranges](https://dart.dev/tools/pub/dependencies#version-constraints) rather than specific versions when specifying dependencies.

```
<span>dependencies</span><span>:</span>
  <span>url_launcher</span><span>:</span> <span>^5.4.0</span>    <span># Good, any version &gt;= 5.4.0 but &lt; 6.0.0</span>
  <span>image_picker</span><span>:</span> <span>'</span><span>5.4.3'</span>   <span># Not so good, only version 5.4.3 works.</span>
```

If `some_package` declares the dependencies above and `another_package` declares a compatible `url_launcher` dependency like `'5.4.6'` or `^5.5.0`, pub resolves the issue automatically. Platform-specific dependencies on [Gradle modules](https://docs.gradle.org/current/userguide/declaring_dependencies.html) and/or [CocoaPods](https://guides.cocoapods.org/syntax/podspec.html#dependency) are solved in a similar way.

Even if `some_package` and `another_package` declare incompatible versions for `url_launcher`, they might actually use `url_launcher` in compatible ways. In this situation, the conflict can be resolved by adding a dependency override declaration to the app’s `pubspec.yaml` file, forcing the use of a particular version.

For example, to force the use of `url_launcher` version `5.4.0`, make the following changes to the app’s `pubspec.yaml` file:

```
<span>dependencies</span><span>:</span>
  <span>some_package</span><span>:</span>
  <span>another_package</span><span>:</span>
<span>dependency_overrides</span><span>:</span>
  <span>url_launcher</span><span>:</span> <span>'</span><span>5.4.0'</span>
```

If the conflicting dependency is not itself a package, but an Android-specific library like `guava`, the dependency override declaration must be added to Gradle build logic instead.

To force the use of `guava` version `28.0`, make the following changes to the app’s `android/build.gradle` file:

```
<span>configurations</span><span>.</span><span>all</span> <span>{</span>
    <span>resolutionStrategy</span> <span>{</span>
        <span>force</span> <span>'com.google.guava:guava:28.0-android'</span>
    <span>}</span>
<span>}</span>
```

CocoaPods doesn’t currently offer dependency override functionality.

## Developing new packages

If no package exists for your specific use case, you can [write a custom package](https://docs.flutter.dev/packages-and-plugins/developing-packages).

## Managing package dependencies and versions

To minimize the risk of version collisions, specify a version range in the `pubspec.yaml` file.

### Package versions

All packages have a version number, specified in the package’s `pubspec.yaml` file. The current version of a package is displayed next to its name (for example, see the [`url_launcher`](https://pub.dev/packages/url_launcher) package), as well as a list of all prior versions (see [`url_launcher` versions](https://pub.dev/packages/url_launcher/versions)).

To ensure that the app doesn’t break when you update a package, specify a version range using one of the following formats.

-   **Ranged constraints:** Specify a minimum and maximum version.
    
    ```
    <span>dependencies</span><span>:</span>
      <span>url_launcher</span><span>:</span> <span>'</span><span>&gt;=5.4.0</span><span> </span><span>&lt;6.0.0'</span>
    ```
    
-   **Ranged constraints using the [caret syntax](https://dart.dev/tools/pub/dependencies#caret-syntax):** Specify the version that serves as the inclusive minimum version. This covers all versions from that version to the next major version.
    
    ```
    <span>dependencies</span><span>:</span>
      <span>collection</span><span>:</span> <span>'</span><span>^5.4.0'</span>
    ```
    
    This syntax means the same as the one noted in the first bullet.
    

To learn more, check out the [package versioning guide](https://dart.dev/tools/pub/versioning).

### Updating package dependencies

When running `flutter pub get` for the first time after adding a package, Flutter saves the concrete package version found in the `pubspec.lock` [lockfile](https://dart.dev/tools/pub/glossary#lockfile). This ensures that you get the same version again if you, or another developer on your team, run `flutter pub get`.

To upgrade to a new version of the package, for example to use new features in that package, run `flutter pub upgrade` to retrieve the highest available version of the package that is allowed by the version constraint specified in `pubspec.yaml`. Note that this is a different command from `flutter upgrade` or `flutter update-packages`, which both update Flutter itself.

### Dependencies on unpublished packages

Packages can be used even when not published on pub.dev. For private packages, or for packages not ready for publishing, additional dependency options are available:

**Path dependency**

A Flutter app can depend on a package using a file system `path:` dependency. The path can be either relative or absolute. Relative paths are evaluated relative to the directory containing `pubspec.yaml`. For example, to depend on a package, packageA, located in a directory next to the app, use the following syntax:

```
  <span>dependencies</span><span>:</span>
  <span>packageA</span><span>:</span>
    <span>path</span><span>:</span> <span>../packageA/</span>
  
```

**Git dependency**

You can also depend on a package stored in a Git repository. If the package is located at the root of the repo, use the following syntax:

```
  <span>dependencies</span><span>:</span>
    <span>packageA</span><span>:</span>
      <span>git</span><span>:</span>
        <span>url</span><span>:</span> <span>https://github.com/flutter/packageA.git</span>
```

**Git dependency using SSH**

If the repository is private and you can connect to it using SSH, depend on the package by using the repo’s SSH url:

```
  <span>dependencies</span><span>:</span>
    <span>packageA</span><span>:</span>
      <span>git</span><span>:</span>
        <span>url</span><span>:</span> <span>git@github.com:flutter/packageA.git</span>
```

**Git dependency on a package in a folder**

Pub assumes the package is located in the root of the Git repository. If that isn’t the case, specify the location with the `path` argument. For example:

```
<span>dependencies</span><span>:</span>
  <span>packageA</span><span>:</span>
    <span>git</span><span>:</span>
      <span>url</span><span>:</span> <span>https://github.com/flutter/packages.git</span>
      <span>path</span><span>:</span> <span>packages/packageA</span>
```

Finally, use the `ref` argument to pin the dependency to a specific git commit, branch, or tag. For more details, see [Package dependencies](https://dart.dev/tools/pub/dependencies).

## Examples

The following examples walk through the necessary steps for using packages.

### Example: Using the css\_colors package

The [`css_colors`](https://pub.dev/packages/css_colors) package defines color constants for CSS colors, so use the constants wherever the Flutter framework expects the `Color` type.

To use this package:

1.  Create a new project called `cssdemo`.
    
2.  Open `pubspec.yaml`, and add the `css-colors` dependency:
    
    ```
    <span>dependencies</span><span>:</span>
      <span>flutter</span><span>:</span>
        <span>sdk</span><span>:</span> <span>flutter</span>
      <span>css_colors</span><span>:</span> <span>^1.0.0</span>
    ```
    
3.  Run `flutter pub get` in the terminal, or click **Get Packages** in VS Code.
    
4.  Open `lib/main.dart` and replace its full contents with:
    
    ```
    <span>import</span><span> </span><span>'package:css_colors/css_colors.dart'</span><span>;</span><span>
     </span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
    
     </span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
       runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
     </span><span>}</span><span>
    
     </span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
       </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
       @override
       </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
         </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
           home</span><span>:</span><span> </span><span>DemoPage</span><span>(),</span><span>
         </span><span>);</span><span>
       </span><span>}</span><span>
     </span><span>}</span><span>
    
     </span><span>class</span><span> </span><span>DemoPage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
       </span><span>const</span><span> </span><span>DemoPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
       @override
       </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
         </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>body</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> </span><span>CSSColors</span><span>.</span><span>orange</span><span>));</span><span>
       </span><span>}</span><span>
     </span><span>}</span>
    ```
    

1.  Run the app. The app’s background should now be orange.

### Example: Using the url\_launcher package to launch the browser

The [`url_launcher`](https://pub.dev/packages/url_launcher) plugin package enables opening the default browser on the mobile platform to display a given URL, and is supported on Android, iOS, web, Windows, Linux, and macos. This package is a special Dart package called a _plugin package_ (or _plugin_), which includes platform-specific code.

To use this plugin:

1.  Create a new project called `launchdemo`.
    
2.  Open `pubspec.yaml`, and add the `url_launcher` dependency:
    
    ```
    <span>dependencies</span><span>:</span>
      <span>flutter</span><span>:</span>
        <span>sdk</span><span>:</span> <span>flutter</span>
      <span>url_launcher</span><span>:</span> <span>^5.4.0</span>
    ```
    
3.  Run `flutter pub get` in the terminal, or click **Get Packages get** in VS Code.
    
4.  Open `lib/main.dart` and replace its full contents with the following:
    
    ```
    <span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
     </span><span>import</span><span> </span><span>'package:path/path.dart'</span><span> </span><span>as</span><span> p</span><span>;</span><span>
     </span><span>import</span><span> </span><span>'package:url_launcher/url_launcher.dart'</span><span>;</span><span>
    
     </span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
       runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
     </span><span>}</span><span>
    
     </span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
       </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
       @override
       </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
         </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
           home</span><span>:</span><span> </span><span>DemoPage</span><span>(),</span><span>
         </span><span>);</span><span>
       </span><span>}</span><span>
     </span><span>}</span><span>
    
     </span><span>class</span><span> </span><span>DemoPage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
       </span><span>const</span><span> </span><span>DemoPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
       </span><span>void</span><span> launchURL</span><span>()</span><span> </span><span>{</span><span>
         launchUrl</span><span>(</span><span>p</span><span>.</span><span>toUri</span><span>(</span><span>'https://flutter.dev'</span><span>));</span><span>
       </span><span>}</span><span>
    
       @override
       </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
         </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
           body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
             child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
               onPressed</span><span>:</span><span> launchURL</span><span>,</span><span>
               child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Show Flutter homepage'</span><span>),</span><span>
             </span><span>),</span><span>
           </span><span>),</span><span>
         </span><span>);</span><span>
       </span><span>}</span><span>
     </span><span>}</span>
    ```
    
5.  Run the app (or stop and restart it, if it was already running before adding the plugin). Click **Show Flutter homepage**. You should see the default browser open on the device, displaying the homepage for flutter.dev.