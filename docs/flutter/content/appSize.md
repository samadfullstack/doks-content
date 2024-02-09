1.  [Performance](https://docs.flutter.dev/perf)
2.  [Measuring your app's size](https://docs.flutter.dev/perf/app-size)

Many developers are concerned with the size of their compiled app. As the APK, app bundle, or IPA version of a Flutter app is self-contained and holds all the code and assets needed to run the app, its size can be a concern. The larger an app, the more space it requires on a device, the longer it takes to download, and it might break the limit of useful features like Android instant apps.

## Debug builds are not representative

By default, launching your app with `flutter run`, or by clicking the **Play** button in your IDE (as used in [Test drive](https://docs.flutter.dev/get-started/test-drive) and [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)), generates a _debug_ build of the Flutter app. The app size of a debug build is large due to the debugging overhead that allows for hot reload and source-level debugging. As such, it is not representative of a production app end users download.

## Checking the total size

A default release build, such as one created by `flutter build apk` or `flutter build ios`, is built to conveniently assemble your upload package to the Play Store and App Store. As such, they’re also not representative of your end-users’ download size. The stores generally reprocess and split your upload package to target the specific downloader and the downloader’s hardware, such as filtering for assets targeting the phone’s DPI, filtering native libraries targeting the phone’s CPU architecture.

### Estimating total size

To get the closest approximate size on each platform, use the following instructions.

#### Android

Follow the Google [Play Console’s instructions](https://support.google.com/googleplay/android-developer/answer/9302563?hl=en) for checking app download and install sizes.

Produce an upload package for your application:

Log into your [Google Play Console](https://play.google.com/apps/publish/). Upload your application binary by drag dropping the .aab file.

View the application’s download and install size in the **Android vitals** -> **App size** tab.

![App size tab in Google Play Console](https://docs.flutter.dev/assets/images/docs/perf/vital-size.png)

The download size is calculated based on an XXXHDPI (~640dpi) device on an arm64-v8a architecture. Your end users’ download sizes might vary depending on their hardware.

The top tab has a toggle for download size and install size. The page also contains optimization tips further below.

#### iOS

Create an [Xcode App Size Report](https://developer.apple.com/documentation/xcode/reducing_your_app_s_size#3458589).

First, by configuring the app version and build as described in the [iOS create build archive instructions](https://docs.flutter.dev/deployment/ios#update-the-apps-build-and-version-numbers).

Then:

1.  Run `flutter build ipa --export-method development`.
2.  Run `open build/ios/archive/*.xcarchive` to open the archive in Xcode.
3.  Click **Distribute App**.
4.  Select a method of distribution. **Development** is the simplest if you don’t intend to distribute the application.
5.  In **App Thinning**, select ‘all compatible device variants’.
6.  Select **Strip Swift symbols**.

Sign and export the IPA. The exported directory contains `App Thinning Size Report.txt` with details about your projected application size on different devices and versions of iOS.

The App Size Report for the default demo app in Flutter 1.17 shows:

```
Variant: Runner-7433FC8E-1DF4-4299-A7E8-E00768671BEB.ipa
Supported variant descriptors: [device: iPhone12,1, os-version: 13.0] and [device: iPhone11,8, os-version: 13.0]
App + On Demand Resources size: 5.4 MB compressed, 13.7 MB uncompressed
App size: 5.4 MB compressed, 13.7 MB uncompressed
On Demand Resources size: Zero KB compressed, Zero KB uncompressed
```

In this example, the app has an approximate download size of 5.4 MB and an approximate install size of 13.7 MB on an iPhone12,1 ([Model ID / Hardware number](https://en.wikipedia.org/wiki/List_of_iOS_devices#Models) for iPhone 11) and iPhone11,8 (iPhone XR) running iOS 13.0.

To measure an iOS app exactly, you have to upload a release IPA to Apple’s App Store Connect ([instructions](https://docs.flutter.dev/deployment/ios)) and obtain the size report from there. IPAs are commonly larger than APKs as explained in [How big is the Flutter engine?](https://docs.flutter.dev/resources/faq#how-big-is-the-flutter-engine), a section in the Flutter [FAQ](https://docs.flutter.dev/resources/faq).

## Breaking down the size

Starting in Flutter version 1.22 and DevTools version 0.9.1, a size analysis tool is included to help developers understand the breakdown of the release build of their application.

The size analysis tool is invoked by passing the `--analyze-size` flag when building:

-   `flutter build apk --analyze-size`
-   `flutter build appbundle --analyze-size`
-   `flutter build ios --analyze-size`
-   `flutter build linux --analyze-size`
-   `flutter build macos --analyze-size`
-   `flutter build windows --analyze-size`

This build is different from a standard release build in two ways.

1.  The tool compiles Dart in a way that records code size usage of Dart packages.
2.  The tool displays a high level summary of the size breakdown in the terminal, and leaves a `*-code-size-analysis_*.json` file for more detailed analysis in DevTools.

In addition to analyzing a single build, two builds can also be diffed by loading two `*-code-size-analysis_*.json` files into DevTools. See [DevTools documentation](https://docs.flutter.dev/tools/devtools/app-size) for details.

![Size summary of an Android application in terminal](https://docs.flutter.dev/assets/images/docs/perf/size-summary.png)

Through the summary, you can get a quick idea of the size usage per category (such as asset, native code, Flutter libraries, etc). The compiled Dart native library is further broken down by package for quick analysis.

### Deeper analysis in DevTools

The `*-code-size-analysis_*.json` file produced above can be further analyzed in deeper detail in DevTools where a tree or a treemap view can break down the contents of the application into the individual file level and up to function level for the Dart AOT artifact.

This can be done by `flutter pub global run devtools`, selecting `Open app size tool` and uploading the JSON file.

![Example breakdown of app in DevTools](https://docs.flutter.dev/assets/images/docs/perf/devtools-size.png)

For further information on using the DevTools app size tool, see [DevTools documentation](https://docs.flutter.dev/tools/devtools/app-size).

## Reducing app size

When building a release version of your app, consider using the `--split-debug-info` tag. This tag can dramatically reduce code size. For an example of using this tag, see [Obfuscating Dart code](https://docs.flutter.dev/deployment/obfuscate).

Some other things you can do to make your app smaller are:

-   Remove unused resources
-   Minimize resource imported from libraries
-   Compress PNG and JPEG files