1.  [Add to app](https://docs.flutter.dev/add-to-app)
2.  [Add Flutter to Android](https://docs.flutter.dev/add-to-app/android)
3.  [Plugin setup](https://docs.flutter.dev/add-to-app/android/plugin-setup)

This guide describes how to set up your project to consume plugins and how to manage your Gradle library dependencies between your existing Android app and your Flutter module’s plugins.

## A. Simple scenario

In the simple cases:

-   Your Flutter module uses a plugin that has no additional Android Gradle dependency because it only uses Android OS APIs, such as the camera plugin.
-   Your Flutter module uses a plugin that has an Android Gradle dependency, such as [ExoPlayer from the video\_player plugin](https://github.com/flutter/packages/blob/main/packages/video_player/video_player_android/android/build.gradle), but your existing Android app didn’t depend on ExoPlayer.

There are no additional steps needed. Your add-to-app module will work the same way as a full-Flutter app. Whether you integrate using Android Studio, Gradle subproject or AARs, transitive Android Gradle libraries are automatically bundled as needed into your outer existing app.

## B. Plugins needing project edits

Some plugins require you to make some edits to the Android side of your project.

For example, the integration instructions for the [firebase\_crashlytics](https://pub.dev/packages/firebase_crashlytics) plugin require manual edits to your Android wrapper project’s `build.gradle` file.

For full-Flutter apps, these edits are done in your Flutter project’s `/android/` directory.

In the case of a Flutter module, there are only Dart files in your module project. Perform those Android Gradle file edits on your outer, existing Android app rather than in your Flutter module.

## C. Merging libraries

The scenario that requires slightly more attention is if your existing Android application already depends on the same Android library that your Flutter module does (transitively via a plugin).

For instance, your existing app’s Gradle might already have:

```
<span>…</span><span>
dependencies </span><span>{</span><span>
  </span><span>…</span><span>
  implementation </span><span>'com.crashlytics.sdk.android:crashlytics:2.10.1'</span><span>
  </span><span>…</span><span>
</span><span>}</span><span>
</span><span>…</span>
```

And your Flutter module also depends on [firebase\_crashlytics](https://pub.dev/packages/firebase_crashlytics) via `pubspec.yaml`:

```
<span>…
</span><span>dependencies:
</span><span>  …
  </span><span>firebase_crashlytics: </span><span>^0.1.3
  …
…</span>
```

This plugin usage transitively adds a Gradle dependency again via firebase\_crashlytics v0.1.3’s own [Gradle file](https://github.com/firebase/flutterfire/blob/bdb95fcacf7cf077d162d2f267eee54a8b0be3bc/packages/firebase_crashlytics/android/build.gradle#L40):

```
<span>…</span><span>
dependencies </span><span>{</span><span>
  </span><span>…</span><span>
  implementation </span><span>'com.crashlytics.sdk.android:crashlytics:2.9.9'</span><span>
  </span><span>…</span><span>
</span><span>}</span><span>
</span><span>…</span>
```

The two `com.crashlytics.sdk.android:crashlytics` dependencies might not be the same version. In this example, the host app requested v2.10.1 and the Flutter module plugin requested v2.9.9.

By default, Gradle v5 [resolves dependency version conflicts](https://docs.gradle.org/current/userguide/dependency_resolution.html#sub:resolution-strategy) by using the newest version of the library.

This is generally ok as long as there are no API or implementation breaking changes between the versions. For example, you might use the new Crashlytics library in your existing app as follows:

```
<span>…</span><span>
dependencies </span><span>{</span><span>
  </span><span>…</span><span>
  implementation </span><span>'com.google.firebase:firebase-crashlytics:17.0.0-beta03
  …
}
…</span>
```

This approach won’t work since there are major API differences between the Crashlytics’ Gradle library version v17.0.0-beta03 and v2.9.9.

For Gradle libraries that follow semantic versioning, you can generally avoid compilation and runtime errors by using the same major semantic version in your existing app and Flutter module plugin.