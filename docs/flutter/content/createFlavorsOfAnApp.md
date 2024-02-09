1.  [Deployment](https://docs.flutter.dev/deployment)
2.  [Flavors](https://docs.flutter.dev/deployment/flavors)

## What are flavors

Have you ever wondered how to set up different environments in your Flutter app? Flavors (known as _build configurations_ in iOS and macOS), allow you (the developer) to create separate environments for your app using the same code base. For example, you might have one flavor for your full-fledged production app, another as a limited “free” app, another for testing experimental features, and so on.

Say you want to make both free and paid versions of your Flutter app. You can use flavors to set up both app versions without writing two separate apps. For example, the free version of the app has basic functionality and ads. In contrast, the paid version has basic app functionality, extra features, different styles for paid users, and no ads.

You also might use flavors for feature development. If you’ve built a new feature and want to try it out, you could set up a flavor to test it out. Your production code remains unaffected until you’re ready to deploy your new feature.

Flavors let you define compile-time configurations and set parameters that are read at runtime to customize your app’s behavior.

This document guides you through setting up Flutter flavors for iOS, macOS, and Android.

## Environment set up

Prerequisites:

-   Xcode installed
-   An existing Flutter project

To set up flavors in iOS and macOS, you’ll define build configurations in Xcode.

## Creating flavors in iOS and macOS

1.  Open your project in Xcode.
    
2.  Select **Product** > **Scheme** > **New Scheme** from the menu to add a new `Scheme`.
    
    -   A scheme describes how Xcode runs different actions. For the purposes of this guide, the example _flavor_ and _scheme_ are named `free`. The build configurations in the `free` scheme have the `-free` suffix.
3.  Duplicate the build configurations to differentiate between the default configurations that are already available and the new configurations for the `free` scheme.
    
    -   Under the **Info** tab at the end of the **Configurations** dropdown list, click the plus button and duplicate each configuration name (Debug, Release, and Profile). Duplicate the existing configurations, once for each environment.
    
    ![Step 3 Xcode image](https://docs.flutter.dev/assets/images/docs/flavors/step3-ios-build-config.png)
    
4.  To match the free flavor, add `-free` at the end of each new configuration name.
    
5.  Change the `free` scheme to match the build configurations already created.
    
    -   In the **Runner** project, click **Manage Schemes…** and a pop up window opens.
    -   Double click the free scheme. In the next step (as shown in the screenshot), you’ll modify each scheme to match its free build configuration:
    
    ![Step 5 Xcode image](https://docs.flutter.dev/assets/images/docs/flavors/step-5-ios-scheme-free.png)
    

## Using flavors in iOS and macOS

Now that you’ve set up your free flavor, you can, for example, add different product bundle identifiers per flavor. A _bundle identifier_ uniquely identifies your application. In this example, we set the **Debug-free** value to equal `com.flavor-test.free`.

1.  Change the app bundle identifier to differentiate between schemes. In **Product Bundle Identifier**, append `.free` to each -free scheme value.
    
    ![Step 1 using flavors image.](https://docs.flutter.dev/assets/images/docs/flavors/step-1-using-flavors-free.png)
    
2.  In the **Build Settings**, set the **Product Name** value to match each flavor. For example, add Debug Free.
    
    ![Step 2 using flavors image.](https://docs.flutter.dev/assets/images/docs/flavors/step-2-using-flavors-free.png)
    
3.  Add the display name to **Info.plist**. Update the **Bundle Display Name** value to `$(PRODUCT_NAME)`.
    
    ![Step 3 using flavors image.](https://docs.flutter.dev/assets/images/docs/flavors/step3-using-flavors.png)
    

Now you have set up your flavor by making a `free` scheme in Xcode and setting the build configurations for that scheme.

For more information, skip to the [Launching your app flavors](https://docs.flutter.dev/deployment/flavors/#launching-your-app-flavors) section at the end of this document.

### Plugin configurations

If your app uses a Flutter plugin, you need to update `ios/Podfile` (if developing for iOS) and `macos/Podfile` (if developing for macOS).

1.  In `ios/Podfile` and `macos/Podfile`, change the default for **Debug**, **Profile**, and **Release** to match the Xcode build configurations for the `free` scheme.

```
<span>project</span> <span>'Runner'</span><span>,</span> <span>{</span>
  <span>'Debug-free'</span> <span>=&gt;</span> <span>:debug</span><span>,</span>
  <span>'Profile-free'</span> <span>=&gt;</span> <span>:release</span><span>,</span>
  <span>'Release-free'</span> <span>=&gt;</span> <span>:release</span><span>,</span>
<span>}</span>
```

## Using flavors in Android

Setting up flavors in Android can be done in your project’s **build.gradle** file.

1.  Inside your Flutter project, navigate to **android**/**app**/**build.gradle**.
    
2.  Create a [`flavorDimension`](https://developer.android.com/studio/build/build-variants#flavor-dimensions) to group your added product flavors. Gradle doesn’t combine product flavors that share the same `dimension`.
    
3.  Add a `productFlavors` object with the desired flavors along with values for **dimension**, **resValue**, and **applicationId** or **applicationIdSuffix**.
    
    -   The name of the application for each build is located in **resValue**.
    -   If you specify a **applicationIdSuffix** instead of a **applicationId**, it is appended to the “base” application id.

```
<span>flavorDimensions</span> <span>"default"</span>

<span>productFlavors</span> <span>{</span>
    <span>free</span> <span>{</span>
        <span>dimension</span> <span>"default"</span>
        <span>resValue</span> <span>"string"</span><span>,</span> <span>"app_name"</span><span>,</span> <span>"free flavor example"</span>
        <span>applicationIdSuffix</span> <span>".free"</span>
    <span>}</span>
<span>}</span>
```

## Setting up launch configurations

Next, add a **launch.json** file; this allows you to run the command `flutter run --flavor [environment name]`.

In VSCode, set up the launch configurations as follows:

1.  In the root directory of your project, add a folder called **.vscode**.
2.  Inside the **.vscode** folder, create a file named **launch.json**.
3.  In the **launch.json** file, add a configuration object for each flavor. Each configuration has a **name**, **request**, **type**, **program**, and **args** key.

```
<span>{</span><span>
  </span><span>"version"</span><span>:</span><span> </span><span>"0.2.0"</span><span>,</span><span>
  </span><span>"configurations"</span><span>:</span><span> </span><span>[</span><span>
    </span><span>{</span><span>
      </span><span>"name"</span><span>:</span><span> </span><span>"free"</span><span>,</span><span>
      </span><span>"request"</span><span>:</span><span> </span><span>"launch"</span><span>,</span><span>
      </span><span>"type"</span><span>:</span><span> </span><span>"dart"</span><span>,</span><span>
      </span><span>"program"</span><span>:</span><span> </span><span>"lib/main_development.dart"</span><span>,</span><span>
      </span><span>"args"</span><span>:</span><span> </span><span>[</span><span>"--flavor"</span><span>,</span><span> </span><span>"free"</span><span>,</span><span> </span><span>"--target"</span><span>,</span><span> </span><span>"lib/main_free.dart"</span><span> </span><span>]</span><span>
    </span><span>}</span><span>
  </span><span>],</span><span>
  </span><span>"compounds"</span><span>:</span><span> </span><span>[]</span><span>
</span><span>}</span><span>
</span>
```

You can now run the terminal command `flutter run --flavor free` or you can set up a run configuration in your IDE.

## Launching your app flavors

1.  Once the flavors are set up, modify the Dart code in **lib** / **main.dart** to consume the flavors.
2.  Test the setup using `flutter run --flavor free` at the command line, or in your IDE.

For examples of build flavors for [iOS](https://github.com/flutter/flutter/tree/master/dev/integration_tests/flavors/ios), [macOS](https://github.com/flutter/flutter/tree/master/dev/integration_tests/flavors/macos), and [Android](https://github.com/flutter/flutter/tree/master/dev/integration_tests/flavors/android), check out the integration test samples in the [Flutter repo](https://github.com/flutter/flutter/blob/master/dev/integration_tests/flavors/lib/main.dart).

## Retrieving your app’s flavor at runtime

From your Dart code, you can use the [`appFlavor`](https://api.flutter.dev/flutter/services/appFlavor-constant.html) API to determine what flavor your app was built with.

## Conditionally bundling assets based on flavor

If you aren’t familiar with how to add assets to your app, see [Adding assets and images](https://docs.flutter.dev/ui/assets/assets-and-images).

If you have assets that are only used in a specific flavor in your app, you can configure them to only be bundled into your app when building for that flavor. This prevents your app bundle size from being bloated by unused assets.

Here is an example:

```
<span>flutter</span><span>:</span>
  <span>assets</span><span>:</span>
    <span>-</span> <span>assets/common/</span>
    <span>-</span> <span>path</span><span>:</span> <span>assets/free/</span>
      <span>flavors</span><span>:</span>
        <span>-</span> <span>free</span>
    <span>-</span> <span>path</span><span>:</span> <span>assets/premium/</span>
      <span>flavors</span><span>:</span>
        <span>-</span> <span>premium</span>
```

In this example, files within the `assets/common/` directory will always be bundled when app is built during `flutter run` or `flutter build`. Files within the `assets/free/` directory are bundled _only_ when the `--flavor` option is set to `free`. Similarly, files within the `assets/premium` directory are bundled _only_ if `--flavor` is set to `premium`.

## More information

For more information on creating and using flavors, check out the following resources:

-   [Build flavors in Flutter (Android and iOS) with different Firebase projects per flavor Flutter Ready to Go](https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)
-   [Flavoring Flutter Applications (Android & iOS)](https://medium.com/flutter-community/flavoring-flutter-applications-android-ios-ea39d3155346)
-   [Flutter Flavors Setup with multiple Firebase Environments using FlutterFire and Very Good CLI](https://codewithandrea.com/articles/flutter-flavors-for-firebase-apps/)

### Packages

For packages that support creating flavors, check out the following:

-   [`flutter_flavor`](https://pub.dev/packages/flutter_flavor)
-   [`flutter_flavorizr`](https://pub.dev/packages/flutter_flavorizr)