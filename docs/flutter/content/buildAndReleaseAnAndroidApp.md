1.  [Deployment](https://docs.flutter.dev/deployment)
2.  [Android](https://docs.flutter.dev/deployment/android)

During a typical development cycle, you test an app using `flutter run` at the command line, or by using the **Run** and **Debug** options in your IDE. By default, Flutter builds a _debug_ version of your app.

When you’re ready to prepare a _release_ version of your app, for example to [publish to the Google Play Store](https://developer.android.com/distribute), this page can help. Before publishing, you might want to put some finishing touches on your app. This page covers the following topics:

-   [Adding a launcher icon](https://docs.flutter.dev/deployment/android#adding-a-launcher-icon)
-   [Enabling Material Components](https://docs.flutter.dev/deployment/android#enabling-material-components)
-   [Signing the app](https://docs.flutter.dev/deployment/android#signing-the-app)
-   [Shrinking your code with R8](https://docs.flutter.dev/deployment/android#shrinking-your-code-with-r8)
-   [Enabling multidex support](https://docs.flutter.dev/deployment/android#enabling-multidex-support)
-   [Reviewing the app manifest](https://docs.flutter.dev/deployment/android#reviewing-the-app-manifest)
-   [Reviewing the build configuration](https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration)
-   [Building the app for release](https://docs.flutter.dev/deployment/android#building-the-app-for-release)
-   [Publishing to the Google Play Store](https://docs.flutter.dev/deployment/android#publishing-to-the-google-play-store)
-   [Updating the app’s version number](https://docs.flutter.dev/deployment/android#updating-the-apps-version-number)
-   [Android release FAQ](https://docs.flutter.dev/deployment/android#android-release-faq)

## Adding a launcher icon

When a new Flutter app is created, it has a default launcher icon. To customize this icon, you might want to check out the [flutter\_launcher\_icons](https://pub.dev/packages/flutter_launcher_icons) package.

Alternatively, you can do it manually using the following steps:

1.  Review the [Material Design product icons](https://m3.material.io/styles/icons) guidelines for icon design.
    
2.  In the `[project]/android/app/src/main/res/` directory, place your icon files in folders named using [configuration qualifiers](https://developer.android.com/guide/topics/resources/providing-resources#AlternativeResources). The default `mipmap-` folders demonstrate the correct naming convention.
    
3.  In `AndroidManifest.xml`, update the [`application`](https://developer.android.com/guide/topics/manifest/application-element) tag’s `android:icon` attribute to reference icons from the previous step (for example, `<application android:icon="@mipmap/ic_launcher" ...`).
    
4.  To verify that the icon has been replaced, run your app and inspect the app icon in the Launcher.
    

## Enabling Material Components

If your app uses [Platform Views](https://docs.flutter.dev/platform-integration/android/platform-views), you might want to enable Material Components by following the steps described in the [Getting Started guide for Android](https://m3.material.io/develop/android/mdc-android).

For example:

1.  Add the dependency on Android’s Material in `<my-app>/android/app/build.gradle`:

```
<span>dependencies</span> <span>{</span>
    <span>// ...</span>
    <span>implementation</span> <span>'com.google.android.material:material:&lt;version&gt;'</span>
    <span>// ...</span>
<span>}</span>
```

To find out the latest version, visit [Google Maven](https://maven.google.com/web/index.html#com.google.android.material:material).

1.  Set the light theme in `<my-app>/android/app/src/main/res/values/styles.xml`:

```
<span>-&lt;style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar"&gt;
</span><span>+&lt;style name="NormalTheme" parent="Theme.MaterialComponents.Light.NoActionBar"&gt;
</span>
```

1.  Set the dark theme in `<my-app>/android/app/src/main/res/values-night/styles.xml`

```
<span>-&lt;style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar"&gt;
</span><span>+&lt;style name="NormalTheme" parent="Theme.MaterialComponents.DayNight.NoActionBar"&gt;
</span>
```

## Sign the app

To publish on the Play Store, you need to sign your app with a digital certificate.

Android uses two signing keys: _upload_ and _app signing_.

-   Developers upload an `.aab` or `.apk` file signed with an _upload key_ to the Play Store.
-   The end-users download the `.apk` file signed with an _app signing key_.

To create your app signing key, use Play App Signing as described in the [official Play Store documentation](https://support.google.com/googleplay/android-developer/answer/7384423?hl=en).

To sign your app, use the following instructions.

### Create an upload keystore

If you have an existing keystore, skip to the next step. If not, create one using one of the following methods:

1.  Follow the [Android Studio key generation steps](https://developer.android.com/studio/publish/app-signing#generate-key)
2.  Run the following command at the command line:
    
    On macOS or Linux, use the following command:
    
    ```
    <span>keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
            -keysize 2048 -validity 10000 -alias upload
    </span>
    ```
    
    On Windows, use the following command in PowerShell:
    
    ```
    <span>keytool</span><span> </span><span>-genkey</span><span> </span><span>-v</span><span> </span><span>-keystore</span><span> </span><span>%</span><span>userprofile</span><span>%</span><span>\upload-keystore.jks</span><span> </span><span>^</span><span>
            </span><span>-storetype</span><span> </span><span>JKS</span><span> </span><span>-keyalg</span><span> </span><span>RSA</span><span> </span><span>-keysize</span><span> </span><span>2048</span><span> </span><span>-validity</span><span> </span><span>10000</span><span> </span><span>^</span><span>
            </span><span>-alias</span><span> </span><span>upload</span><span>
    </span>
    ```
    
    This command stores the `upload-keystore.jks` file in your home directory. If you want to store it elsewhere, change the argument you pass to the `-keystore` parameter. **However, keep the `keystore` file private; don’t check it into public source control!**
    

### Reference the keystore from the app

Create a file named `[project]/android/key.properties` that contains a reference to your keystore. Don’t include the angle brackets (`< >`). They indicate that the text serves as a placeholder for your values.

```
<span>storePassword</span><span>=</span><span>&lt;password-from-previous-step&gt;</span>
<span>keyPassword</span><span>=</span><span>&lt;password-from-previous-step&gt;</span>
<span>keyAlias</span><span>=</span><span>upload</span>
<span>storeFile</span><span>=</span><span>&lt;keystore-file-location&gt;</span>
```

The `storeFile` might be located at `/Users/<user name>/upload-keystore.jks` on macOS or `C:\\Users\\<user name>\\upload-keystore.jks` on Windows.

### Configure signing in gradle

Configure gradle to use your upload key when building your app in release mode by editing the `[project]/android/app/build.gradle` file.

1.  Add the keystore information from your properties file before the `android` block:
    
    ```
       def keystoreProperties = new Properties()
       def keystorePropertiesFile = rootProject.file('key.properties')
       if (keystorePropertiesFile.exists()) {
           keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
       }
    
       android {
             ...
       }
    ```
    
    Load the `key.properties` file into the `keystoreProperties` object.
    
2.  Find the `buildTypes` block:
    
    ```
       buildTypes {
           release {
               // TODO: Add your own signing config for the release build.
               // Signing with the debug keys for now,
               // so `flutter run --release` works.
               signingConfig signingConfigs.debug
           }
       }
    ```
    
    And replace it with the following signing configuration info:
    
    ```
       signingConfigs {
           release {
               keyAlias keystoreProperties['keyAlias']
               keyPassword keystoreProperties['keyPassword']
               storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
               storePassword keystoreProperties['storePassword']
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }
    ```
    

Release builds of your app will now be signed automatically.

For more information on signing your app, check out [Sign your app](https://developer.android.com/studio/publish/app-signing.html#generate-key) on developer.android.com.

## Shrinking your code with R8

[R8](https://developer.android.com/studio/build/shrink-code) is the new code shrinker from Google, and it’s enabled by default when you build a release APK or AAB. To disable R8, pass the `--no-shrink` flag to `flutter build apk` or `flutter build appbundle`.

## Enabling multidex support

When writing large apps or making use of large plugins, you might encounter Android’s dex limit of 64k methods when targeting a minimum API of 20 or below. This might also be encountered when running debug versions of your app using `flutter run` that does not have shrinking enabled.

Flutter tool supports easily enabling multidex. The simplest way is to opt into multidex support when prompted. The tool detects multidex build errors and asks before making changes to your Android project. Opting in allows Flutter to automatically depend on `androidx.multidex:multidex` and use a generated `FlutterMultiDexApplication` as the project’s application.

When you try to build and run your app with the **Run** and **Debug** options in your IDE, your build might fail with the following message:

![screenshot of build failure because Multidex support is required](https://docs.flutter.dev/assets/images/docs/deployment/android/ide-build-failure-multidex.png)

To enable multidex from the command line, run `flutter run --debug` and select an Android device:

![screenshot of selecting an Android device](https://docs.flutter.dev/assets/images/docs/deployment/android/cli-select-device.png)

When prompted, enter `y`. The Flutter tool enables multidex support and retries the build:

![screenshot of a successful build after adding multidex](https://docs.flutter.dev/assets/images/docs/deployment/android/cli-multidex-added-build.png)

You might also choose to manually support multidex by following Android’s guides and modifying your project’s Android directory configuration. A [multidex keep file](https://developer.android.com/studio/build/multidex#keep) must be specified to include:

```
io/flutter/embedding/engine/loader/FlutterLoader.class
io/flutter/util/PathUtils.class
```

Also, include any other classes used in app startup. For more detailed guidance on adding multidex support manually, check out the official [Android documentation](https://developer.android.com/studio/build/multidex).

## Reviewing the app manifest

Review the default [App Manifest](https://developer.android.com/guide/topics/manifest/manifest-intro) file, `AndroidManifest.xml`. This file is located in `[project]/android/app/src/main`. Verify the following values:

`application`

Edit the `android:label` in the [`application`](https://developer.android.com/guide/topics/manifest/application-element) tag to reflect the final name of the app.

`uses-permission`

Add the `android.permission.INTERNET` [permission](https://developer.android.com/guide/topics/manifest/uses-permission-element) if your application code needs Internet access. The standard template doesn’t include this tag but allows Internet access during development to enable communication between Flutter tools and a running app.

## Reviewing the Gradle build configuration

Review the default [Gradle build file](https://developer.android.com/studio/build/#module-level) (`build.gradle`, located in `[project]/android/app`), to verify that the values are correct.

#### Under the `defaultConfig` block

`applicationId`

Specify the final, unique [application ID](https://developer.android.com/studio/build/application-id).

`minSdkVersion`

Specify the [minimum API level](https://developer.android.com/studio/publish/versioning#minsdk) on which you designed the app to run. Defaults to `flutter.minSdkVersion`.

`targetSdkVersion`

Specify the target API level on which you designed the app to run. Defaults to `flutter.targetSdkVersion`.

`versionCode`

A positive integer used as an [internal version number](https://developer.android.com/studio/publish/versioning). This number is used only to determine whether one version is more recent than another, with higher numbers indicating more recent versions. This version isn’t shown to users.

`versionName`

A string used as the version number shown to users. This setting can be specified as a raw string or as a reference to a string resource.

`buildToolsVersion`

The Gradle plugin specifies the default version of the build tools that your project uses. You can use this option to specify a different version of the build tools.

#### Under the `android` block

`compileSdkVersion`

Specify the API level Gradle should use to compile your app. Defaults to `flutter.compileSdkVersion`.

For more information, check out the module-level build section in the [Gradle build file](https://developer.android.com/studio/build/#module-level).

## Building the app for release

You have two possible release formats when publishing to the Play Store.

-   App bundle (preferred)
-   APK

### Build an app bundle

This section describes how to build a release app bundle. If you completed the signing steps, the app bundle will be signed. At this point, you might consider [obfuscating your Dart code](https://docs.flutter.dev/deployment/obfuscate) to make it more difficult to reverse engineer. Obfuscating your code involves adding a couple flags to your build command, and maintaining additional files to de-obfuscate stack traces.

From the command line:

1.  Enter `cd [project]`  
    
2.  Run `flutter build appbundle`  
    (Running `flutter build` defaults to a release build.)

The release bundle for your app is created at `[project]/build/app/outputs/bundle/release/app.aab`.

By default, the app bundle contains your Dart code and the Flutter runtime compiled for [armeabi-v7a](https://developer.android.com/ndk/guides/abis#v7a) (ARM 32-bit), [arm64-v8a](https://developer.android.com/ndk/guides/abis#arm64-v8a) (ARM 64-bit), and [x86-64](https://developer.android.com/ndk/guides/abis#86-64) (x86 64-bit).

### Test the app bundle

An app bundle can be tested in multiple ways. This section describes two.

#### Offline using the bundle tool

1.  If you haven’t done so already, download `bundletool` from the [GitHub repository](https://github.com/google/bundletool/releases/latest).
2.  [Generate a set of APKs](https://developer.android.com/studio/command-line/bundletool#generate_apks) from your app bundle.
3.  [Deploy the APKs](https://developer.android.com/studio/command-line/bundletool#deploy_with_bundletool) to connected devices.

#### Online using Google Play

1.  Upload your bundle to Google Play to test it. You can use the internal test track, or the alpha or beta channels to test the bundle before releasing it in production.
2.  Follow [these steps to upload your bundle](https://developer.android.com/studio/publish/upload-bundle) to the Play Store.

### Build an APK

Although app bundles are preferred over APKs, there are stores that don’t yet support app bundles. In this case, build a release APK for each target ABI (Application Binary Interface).

If you completed the signing steps, the APK will be signed. At this point, you might consider [obfuscating your Dart code](https://docs.flutter.dev/deployment/obfuscate) to make it more difficult to reverse engineer. Obfuscating your code involves adding a couple flags to your build command.

From the command line:

1.  Enter `cd [project]`.
    
2.  Run `flutter build apk --split-per-abi`. (The `flutter build` command defaults to `--release`.)
    

This command results in three APK files:

-   `[project]/build/app/outputs/apk/release/app-armeabi-v7a-release.apk`
-   `[project]/build/app/outputs/apk/release/app-arm64-v8a-release.apk`
-   `[project]/build/app/outputs/apk/release/app-x86_64-release.apk`

Removing the `--split-per-abi` flag results in a fat APK that contains your code compiled for _all_ the target ABIs. Such APKs are larger in size than their split counterparts, causing the user to download native binaries that are not applicable to their device’s architecture.

### Install an APK on a device

Follow these steps to install the APK on a connected Android device.

From the command line:

1.  Connect your Android device to your computer with a USB cable.
2.  Enter `cd [project]`.
3.  Run `flutter install`.

## Publishing to the Google Play Store

For detailed instructions on publishing your app to the Google Play Store, check out the [Google Play launch](https://developer.android.com/distribute) documentation.

## Updating the app’s version number

The default version number of the app is `1.0.0`. To update it, navigate to the `pubspec.yaml` file and update the following line:

`version: 1.0.0+1`

The version number is three numbers separated by dots, such as `1.0.0` in the example above, followed by an optional build number such as `1` in the example above, separated by a `+`.

Both the version and the build number can be overridden in Flutter’s build by specifying `--build-name` and `--build-number`, respectively.

In Android, `build-name` is used as `versionName` while `build-number` used as `versionCode`. For more information, check out [Version your app](https://developer.android.com/studio/publish/versioning) in the Android documentation.

When you rebuild the app for Android, any updates in the version number from the pubspec file will update the `versionName` and `versionCode` in the `local.properties` file.

## Android release FAQ

Here are some commonly asked questions about deployment for Android apps.

### When should I build app bundles versus APKs?

The Google Play Store recommends that you deploy app bundles over APKs because they allow a more efficient delivery of the application to your users. However, if you’re distributing your application by means other than the Play Store, an APK might be your only option.

### What is a fat APK?

A [fat APK](https://en.wikipedia.org/wiki/Fat_binary) is a single APK that contains binaries for multiple ABIs embedded within it. This has the benefit that the single APK runs on multiple architectures and thus has wider compatibility, but it has the drawback that its file size is much larger, causing users to download and store more bytes when installing your application. When building APKs instead of app bundles, it is strongly recommended to build split APKs, as described in [build an APK](https://docs.flutter.dev/deployment/android#build-an-apk) using the `--split-per-abi` flag.

### What are the supported target architectures?

When building your application in release mode, Flutter apps can be compiled for [armeabi-v7a](https://developer.android.com/ndk/guides/abis#v7a) (ARM 32-bit), [arm64-v8a](https://developer.android.com/ndk/guides/abis#arm64-v8a) (ARM 64-bit), and [x86-64](https://developer.android.com/ndk/guides/abis#86-64) (x86 64-bit). Flutter supports building for x86 Android through ARM emulation.

### How do I sign the app bundle created by `flutter build appbundle`?

See [Signing the app](https://docs.flutter.dev/deployment/android#signing-the-app).

### How do I build a release from within Android Studio?

In Android Studio, open the existing `android/` folder under your app’s folder. Then, select **build.gradle (Module: app)** in the project panel:

![screenshot of gradle build script menu](https://docs.flutter.dev/assets/images/docs/deployment/android/gradle-script-menu.png)

Next, select the build variant. Click **Build > Select Build Variant** in the main menu. Select any of the variants in the **Build Variants** panel (debug is the default):

![screenshot of build variant menu](https://docs.flutter.dev/assets/images/docs/deployment/android/build-variant-menu.png)

The resulting app bundle or APK files are located in `build/app/outputs` within your app’s folder.