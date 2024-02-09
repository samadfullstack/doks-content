1.  [Add to app](https://docs.flutter.dev/add-to-app)
2.  [Add Flutter to Android](https://docs.flutter.dev/add-to-app/android)
3.  [Integrate Flutter](https://docs.flutter.dev/add-to-app/android/project-setup)

Flutter can be embedded into your existing Android application piecemeal, as a source code Gradle subproject or as AARs.

The integration flow can be done using the Android Studio IDE with the [Flutter plugin](https://plugins.jetbrains.com/plugin/9212-flutter) or manually.

## Integrate your Flutter module

-   [With Android Studio](https://docs.flutter.dev/add-to-app/android/project-setup#with-android-studio)
-   [Without Android Studio](https://docs.flutter.dev/add-to-app/android/project-setup#without-android-studio)

### Integrate with Android Studio

The Android Studio IDE can help integrate your Flutter module. Using Android Studio, you can edit both your Android and Flutter code in the same IDE.

You can also use IntelliJ Flutter plugin functionality like Dart code completion, hot reload, and widget inspector.

Android Studio supports add-to-app flows on Android Studio 2022.2 or later with the [Flutter plugin](https://plugins.jetbrains.com/plugin/9212-flutter) for IntelliJ. To build your app, the Android Studio plugin configures your Android project to add your Flutter module as a dependency.

1.  Open your Android project in Android Studio.
    
2.  Go to **File** > **New** > **New Project…**. The **New Project** dialog displays.
    
3.  Click **Flutter**.
    
4.  If asked to provide your **Flutter SDK path**, do so and click **Next**.
    
5.  Complete the configuration of your Flutter module.
    
    -   If you have an existing project:
        
        1.  To choose an existing project, click **…** to the right of the **Project location** box.
        2.  Navigate to your Flutter project directory.
        3.  Click **Open**.
    -   If you need to create a new Flutter project:
        
        1.  Complete the configuration dialog.
        2.  In the **Project type** menu, select **Module**.
6.  Click **Finish**.
    

## Add the Flutter module as a dependency

Add the Flutter module as a dependency of your existing app in Gradle. You can achieve this in two ways.

1.  **Android archive** The AAR mechanism creates generic Android AARs as intermediaries that packages your Flutter module. This is good when your downstream app builders don’t want to have the Flutter SDK installed. But, it adds one more build step if you build frequently.
    
2.  **Module source code** The source code subproject mechanism is a convenient one-click build process, but requires the Flutter SDK. This is the mechanism used by the Android Studio IDE plugin.
    

-   [Android Archive](https://docs.flutter.dev/add-to-app/android/project-setup#android-archive)
-   [Module source code](https://docs.flutter.dev/add-to-app/android/project-setup#module-source)

### Depend on the Android Archive (AAR)

This option packages your Flutter library as a generic local Maven repository composed of AARs and POMs artifacts. This option allows your team to build the host app without installing the Flutter SDK. You can then distribute the artifacts from a local or remote repository.

Let’s assume you built a Flutter module at `some/path/flutter_module`, and then run:

```
<span>cd some/path/flutter_module
flutter build aar
</span>
```

Then, follow the on-screen instructions to integrate.

![](https://docs.flutter.dev/assets/images/docs/development/add-to-app/android/project-setup/build-aar-instructions.png)

More specifically, this command creates (by default all debug/profile/release modes) a [local repository](https://docs.gradle.org/current/userguide/declaring_repositories.html#sub:maven_local), with the following files:

```nocode
build/host/outputs/repo └── com └── example └── flutter_module ├── flutter_release │ ├── 1.0 │ │   ├── flutter_release-1.0.aar │ │   ├── flutter_release-1.0.aar.md5 │ │   ├── flutter_release-1.0.aar.sha1 │ │   ├── flutter_release-1.0.pom │ │   ├── flutter_release-1.0.pom.md5 │ │   └── flutter_release-1.0.pom.sha1 │ ├── maven-metadata.xml │ ├── maven-metadata.xml.md5 │ └── maven-metadata.xml.sha1 ├── flutter_profile │ ├── ... └── flutter_debug └── ...
```

To depend on the AAR, the host app must be able to find these files.

To do that, edit `settings.gradle` in your host app so that it includes the local repository and the dependency:

```
<span>dependencyResolutionManagement</span> <span>{</span>
  <span>repositoriesMode</span><span>.</span><span>set</span><span>(</span><span>RepositoriesMode</span><span>.</span><span>PREFER_SETTINGS</span><span>)</span>
  <span>repositories</span> <span>{</span>
    <span>google</span><span>()</span>
    <span>mavenCentral</span><span>()</span>

  <span>// Add the new repositories starting on the next line...</span>
    <span>maven</span> <span>{</span>
      <span>url</span> <span>'some/path/flutter_module/build/host/outputs/repo'</span>
      <span>// This is relative to the location of the build.gradle file</span>
      <span>// if using a relative path.</span>
    <span>}</span>
    <span>maven</span> <span>{</span>
      <span>url</span> <span>'https://storage.googleapis.com/download.flutter.io'</span>
    <span>}</span>
  <span>// ...to before this line  </span>
  <span>}</span>
<span>}</span>

```

Your app now includes the Flutter module as a dependency.

Continue to the [Adding a Flutter screen to an Android app](https://docs.flutter.dev/add-to-app/android/add-flutter-screen) guide.