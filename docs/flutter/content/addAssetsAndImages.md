1.  [UI](https://docs.flutter.dev/ui)
2.  [Assets & media](https://docs.flutter.dev/ui/assets)
3.  [Assets and images](https://docs.flutter.dev/ui/assets/assets-and-images)

Flutter apps can include both code and _assets_ (sometimes called resources). An asset is a file that is bundled and deployed with your app, and is accessible at runtime. Common types of assets include static data (for example, JSON files), configuration files, icons, and images (JPEG, WebP, GIF, animated WebP/GIF, PNG, BMP, and WBMP).

## Specifying assets

Flutter uses the [`pubspec.yaml`](https://dart.dev/tools/pub/pubspec) file, located at the root of your project, to identify assets required by an app.

Here is an example:

```
<span>flutter</span><span>:</span>
  <span>assets</span><span>:</span>
    <span>-</span> <span>assets/my_icon.png</span>
    <span>-</span> <span>assets/background.png</span>
```

To include all assets under a directory, specify the directory name with the `/` character at the end:

```
<span>flutter</span><span>:</span>
  <span>assets</span><span>:</span>
    <span>-</span> <span>directory/</span>
    <span>-</span> <span>directory/subdirectory/</span>
```

### Asset bundling

The `assets` subsection of the `flutter` section specifies files that should be included with the app. Each asset is identified by an explicit path (relative to the `pubspec.yaml` file) where the asset file is located. The order in which the assets are declared doesn’t matter. The actual directory name used (`assets` in first example or `directory` in the above example) doesn’t matter.

During a build, Flutter places assets into a special archive called the _asset bundle_ that apps read from at runtime.

## Loading assets

Your app can access its assets through an [`AssetBundle`](https://api.flutter.dev/flutter/services/AssetBundle-class.html) object.

The two main methods on an asset bundle allow you to load a string/text asset (`loadString()`) or an image/binary asset (`load()`) out of the bundle, given a logical key. The logical key maps to the path to the asset specified in the `pubspec.yaml` file at build time.

### Loading text assets

Each Flutter app has a [`rootBundle`](https://api.flutter.dev/flutter/services/rootBundle.html) object for easy access to the main asset bundle. It is possible to load assets directly using the `rootBundle` global static from `package:flutter/services.dart`.

However, it’s recommended to obtain the `AssetBundle` for the current `BuildContext` using [`DefaultAssetBundle`](https://api.flutter.dev/flutter/widgets/DefaultAssetBundle-class.html), rather than the default asset bundle that was built with the app; this approach enables a parent widget to substitute a different `AssetBundle` at run time, which can be useful for localization or testing scenarios.

Typically, you’ll use `DefaultAssetBundle.of()` to indirectly load an asset, for example a JSON file, from the app’s runtime `rootBundle`.

Outside of a `Widget` context, or when a handle to an `AssetBundle` is not available, you can use `rootBundle` to directly load such assets. For example:

```
<span>import</span><span> </span><span>'package:flutter/services.dart'</span><span> </span><span>show</span><span> rootBundle</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>String</span><span>&gt;</span><span> loadAsset</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>await</span><span> rootBundle</span><span>.</span><span>loadString</span><span>(</span><span>'assets/config.json'</span><span>);</span><span>
</span><span>}</span>
```

### Loading images

To load an image, use the [`AssetImage`](https://api.flutter.dev/flutter/painting/AssetImage-class.html) class in a widget’s `build()` method.

For example, your app can load the background image from the asset declarations in the previous example:

```
<span>return</span><span> </span><span>const</span><span> </span><span>Image</span><span>(</span><span>image</span><span>:</span><span> </span><span>AssetImage</span><span>(</span><span>'assets/background.png'</span><span>));</span>
```

### Resolution-aware image assets

Flutter can load resolution-appropriate images for the current [device pixel ratio](https://api.flutter.dev/flutter/dart-ui/FlutterView/devicePixelRatio.html).

[`AssetImage`](https://api.flutter.dev/flutter/painting/AssetImage-class.html) will map a logical requested asset onto one that most closely matches the current [device pixel ratio](https://api.flutter.dev/flutter/dart-ui/FlutterView/devicePixelRatio.html).

For this mapping to work, assets should be arranged according to a particular directory structure:

```
.../image.png
.../Mx/image.png
.../Nx/image.png
...etc.
```

Where _M_ and _N_ are numeric identifiers that correspond to the nominal resolution of the images contained within. In other words, they specify the device pixel ratio that the images are intended for.

In this example, `image.png` is considered the _main asset_, while `Mx/image.png` and `Nx/image.png` are considered to be _variants_.

The main asset is assumed to correspond to a resolution of 1.0. For example, consider the following asset layout for an image named `my_icon.png`:

```
.../my_icon.png       (mdpi baseline)
.../1.5x/my_icon.png  (hdpi)
.../2.0x/my_icon.png  (xhdpi)
.../3.0x/my_icon.png  (xxhdpi)
.../4.0x/my_icon.png  (xxxhdpi)
```

On devices with a device pixel ratio of 1.8, the asset `.../2.0x/my_icon.png` is chosen. For a device pixel ratio of 2.7, the asset `.../3.0x/my_icon.png` is chosen.

If the width and height of the rendered image are not specified on the `Image` widget, the nominal resolution is used to scale the asset so that it occupies the same amount of screen space as the main asset would have, just with a higher resolution. That is, if `.../my_icon.png` is 72px by 72px, then `.../3.0x/my_icon.png` should be 216px by 216px; but they both render into 72px by 72px (in logical pixels), if width and height are not specified.

#### Bundling of resolution-aware image assets

You only need to specify the main asset or its parent directory in the `assets` section of `pubspec.yaml`. Flutter bundles the variants for you. Each entry should correspond to a real file, with the exception of the main asset entry. If the main asset entry doesn’t correspond to a real file, then the asset with the lowest resolution is used as the fallback for devices with device pixel ratios below that resolution. The entry should still be included in the `pubspec.yaml` manifest, however.

Anything using the default asset bundle inherits resolution awareness when loading images. (If you work with some of the lower level classes, like [`ImageStream`](https://api.flutter.dev/flutter/painting/ImageStream-class.html) or [`ImageCache`](https://api.flutter.dev/flutter/painting/ImageCache-class.html), you’ll also notice parameters related to scale.)

### Asset images in package dependencies

To load an image from a [package](https://docs.flutter.dev/packages-and-plugins/using-packages) dependency, the `package` argument must be provided to [`AssetImage`](https://api.flutter.dev/flutter/painting/AssetImage-class.html).

For instance, suppose your application depends on a package called `my_icons`, which has the following directory structure:

```
.../pubspec.yaml
.../icons/heart.png
.../icons/1.5x/heart.png
.../icons/2.0x/heart.png
...etc.
```

To load the image, use:

```
<span>return</span><span> </span><span>const</span><span> </span><span>AssetImage</span><span>(</span><span>'icons/heart.png'</span><span>,</span><span> package</span><span>:</span><span> </span><span>'my_icons'</span><span>);</span>
```

Assets used by the package itself should also be fetched using the `package` argument as above.

#### Bundling of package assets

If the desired asset is specified in the `pubspec.yaml` file of the package, it’s bundled automatically with the application. In particular, assets used by the package itself must be specified in its `pubspec.yaml`.

A package can also choose to have assets in its `lib/` folder that are not specified in its `pubspec.yaml` file. In this case, for those images to be bundled, the application has to specify which ones to include in its `pubspec.yaml`. For instance, a package named `fancy_backgrounds` could have the following files:

```
.../lib/backgrounds/background1.png
.../lib/backgrounds/background2.png
.../lib/backgrounds/background3.png
```

To include, say, the first image, the `pubspec.yaml` of the application should specify it in the `assets` section:

```
<span>flutter</span><span>:</span>
  <span>assets</span><span>:</span>
    <span>-</span> <span>packages/fancy_backgrounds/backgrounds/background1.png</span>
```

The `lib/` is implied, so it should not be included in the asset path.

If you are developing a package, to load an asset within the package, specify it in the `pubspec.yaml` of the package:

```
<span>flutter</span><span>:</span>
  <span>assets</span><span>:</span>
    <span>-</span> <span>assets/images/</span>
```

To load the image within your package, use:

```
<span>return</span> <span>const</span> <span>AssetImage</span><span>(</span><span>'packages/fancy_backgrounds/backgrounds/background1.png'</span><span>);</span>
```

## Sharing assets with the underlying platform

Flutter assets are readily available to platform code using the `AssetManager` on Android and `NSBundle` on iOS.

### Loading Flutter assets in Android

On Android the assets are available through the [`AssetManager`](https://developer.android.com/reference/android/content/res/AssetManager) API. The lookup key used in, for instance [`openFd`](https://developer.android.com/reference/android/content/res/AssetManager#openFd(java.lang.String)), is obtained from `lookupKeyForAsset` on [`PluginRegistry.Registrar`](https://api.flutter.dev/javadoc/io/flutter/plugin/common/PluginRegistry.Registrar.html) or `getLookupKeyForAsset` on [`FlutterView`](https://api.flutter.dev/javadoc/io/flutter/view/FlutterView.html). `PluginRegistry.Registrar` is available when developing a plugin while `FlutterView` would be the choice when developing an app including a platform view.

As an example, suppose you have specified the following in your pubspec.yaml

```
<span>flutter</span><span>:</span>
  <span>assets</span><span>:</span>
    <span>-</span> <span>icons/heart.png</span>
```

This reflects the following structure in your Flutter app.

```
.../pubspec.yaml
.../icons/heart.png
...etc.
```

To access `icons/heart.png` from your Java plugin code, do the following:

```
<span>AssetManager</span> <span>assetManager</span> <span>=</span> <span>registrar</span><span>.</span><span>context</span><span>().</span><span>getAssets</span><span>();</span>
<span>String</span> <span>key</span> <span>=</span> <span>registrar</span><span>.</span><span>lookupKeyForAsset</span><span>(</span><span>"icons/heart.png"</span><span>);</span>
<span>AssetFileDescriptor</span> <span>fd</span> <span>=</span> <span>assetManager</span><span>.</span><span>openFd</span><span>(</span><span>key</span><span>);</span>
```

### Loading Flutter assets in iOS

On iOS the assets are available through the [`mainBundle`](https://developer.apple.com/documentation/foundation/nsbundle/1410786-mainbundle). The lookup key used in, for instance [`pathForResource:ofType:`](https://developer.apple.com/documentation/foundation/nsbundle/1410989-pathforresource), is obtained from `lookupKeyForAsset` or `lookupKeyForAsset:fromPackage:` on [`FlutterPluginRegistrar`](https://api.flutter.dev/ios-embedder/protocol_flutter_plugin_registrar-p.html), or `lookupKeyForAsset:` or `lookupKeyForAsset:fromPackage:` on [`FlutterViewController`](https://api.flutter.dev/ios-embedder/interface_flutter_view_controller.html). `FlutterPluginRegistrar` is available when developing a plugin while `FlutterViewController` would be the choice when developing an app including a platform view.

As an example, suppose you have the Flutter setting from above.

To access `icons/heart.png` from your Objective-C plugin code you would do the following:

```objective
NSString* key = [registrar lookupKeyForAsset:@"icons/heart.png"]; NSString* path = [[NSBundle mainBundle] pathForResource:key ofType:nil];
```

To access `icons/heart.png` from your Swift app you would do the following:

```
<span>let</span> <span>key</span> <span>=</span> <span>controller</span><span>.</span><span>lookupKey</span><span>(</span><span>forAsset</span><span>:</span> <span>"icons/heart.png"</span><span>)</span>
<span>let</span> <span>mainBundle</span> <span>=</span> <span>Bundle</span><span>.</span><span>main</span>
<span>let</span> <span>path</span> <span>=</span> <span>mainBundle</span><span>.</span><span>path</span><span>(</span><span>forResource</span><span>:</span> <span>key</span><span>,</span> <span>ofType</span><span>:</span> <span>nil</span><span>)</span>
```

For a more complete example, see the implementation of the Flutter [`video_player` plugin](https://pub.dev/packages/video_player) on pub.dev.

The [`ios_platform_images`](https://pub.dev/packages/ios_platform_images) plugin on pub.dev wraps up this logic in a convenient category. You fetch an image as follows:

**Objective-C:**

```objective
[UIImage flutterImageWithName:@"icons/heart.png"];
```

**Swift:**

```
<span>UIImage</span><span>.</span><span>flutterImageNamed</span><span>(</span><span>"icons/heart.png"</span><span>)</span>
```

### Loading iOS images in Flutter

When implementing Flutter by [adding it to an existing iOS app](https://docs.flutter.dev/add-to-app/ios), you might have images hosted in iOS that you want to use in Flutter. To accomplish that, use the [`ios_platform_images`](https://pub.dev/packages/ios_platform_images) plugin available on pub.dev.

## Platform assets

There are other occasions to work with assets in the platform projects directly. Below are two common cases where assets are used before the Flutter framework is loaded and running.

### Updating the app icon

Updating a Flutter application’s launch icon works the same way as updating launch icons in native Android or iOS applications.

![Launch icon](https://docs.flutter.dev/assets/images/docs/assets-and-images/icon.png)

#### Android

In your Flutter project’s root directory, navigate to `.../android/app/src/main/res`. The various bitmap resource folders such as `mipmap-hdpi` already contain placeholder images named `ic_launcher.png`. Replace them with your desired assets respecting the recommended icon size per screen density as indicated by the [Android Developer Guide](https://developer.android.com/training/multiscreen/screendensities).

![Android icon location](https://docs.flutter.dev/assets/images/docs/assets-and-images/android-icon-path.png)

#### iOS

In your Flutter project’s root directory, navigate to `.../ios/Runner`. The `Assets.xcassets/AppIcon.appiconset` directory already contains placeholder images. Replace them with the appropriately sized images as indicated by their filename as dictated by the Apple [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/app-icons). Keep the original file names.

![iOS icon location](https://docs.flutter.dev/assets/images/docs/assets-and-images/ios-icon-path.png)

### Updating the launch screen

![Launch screen](https://docs.flutter.dev/assets/images/docs/assets-and-images/launch-screen.png)

Flutter also uses native platform mechanisms to draw transitional launch screens to your Flutter app while the Flutter framework loads. This launch screen persists until Flutter renders the first frame of your application.

#### Android

To add a launch screen (also known as “splash screen”) to your Flutter application, navigate to `.../android/app/src/main`. In `res/drawable/launch_background.xml`, use this [layer list drawable](https://developer.android.com/guide/topics/resources/drawable-resource#LayerList) XML to customize the look of your launch screen. The existing template provides an example of adding an image to the middle of a white splash screen in commented code. You can uncomment it or use other [drawables](https://developer.android.com/guide/topics/resources/drawable-resource) to achieve the intended effect.

For more details, see [Adding a splash screen to your Android app](https://docs.flutter.dev/platform-integration/android/splash-screen).

#### iOS

To add an image to the center of your “splash screen”, navigate to `.../ios/Runner`. In `Assets.xcassets/LaunchImage.imageset`, drop in images named `LaunchImage.png`, `LaunchImage@2x.png`, `LaunchImage@3x.png`. If you use different filenames, update the `Contents.json` file in the same directory.

You can also fully customize your launch screen storyboard in Xcode by opening `.../ios/Runner.xcworkspace`. Navigate to `Runner/Runner` in the Project Navigator and drop in images by opening `Assets.xcassets` or do any customization using the Interface Builder in `LaunchScreen.storyboard`.

![Adding launch icons in Xcode](https://docs.flutter.dev/assets/images/docs/assets-and-images/ios-launchscreen-xcode.png)

For more details, see [Adding a splash screen to your iOS app](https://docs.flutter.dev/platform-integration/ios/splash-screen).