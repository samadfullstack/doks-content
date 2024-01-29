1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Android](https://docs.flutter.dev/platform-integration/android)
3.  [Splash screen](https://docs.flutter.dev/platform-integration/android/splash-screen)

![A graphic outlining the launch flow of an app including a splash screen](https://docs.flutter.dev/assets/images/docs/development/ui/splash-screen/android-splash-screen/splash-screens_header.png)

Splash screens (also known as launch screens) provide a simple initial experience while your Android app loads. They set the stage for your application, while allowing time for the app engine to load and your app to initialize.

## Overview

In Android, there are two separate screens that you can control: a _launch screen_ shown while your Android app initializes, and a _splash screen_ that displays while the Flutter experience initializes.

## Initializing the app

Every Android app requires initialization time while the operating system sets up the app’s process. Android provides the concept of a [launch screen](https://developer.android.com/topic/performance/vitals/launch-time#themed) to display a `Drawable` while the app is initializing.

A `Drawable` is an Android graphic. To learn how to add a `Drawable` to your Flutter project in Android Studio, check out [Import drawables into your project](https://developer.android.com/studio/write/resource-manager#import) in the Android developer documentation.

The default Flutter project template includes a definition of a launch theme and a launch background. You can customize this by editing `styles.xml`, where you can define a theme whose `windowBackground` is set to the `Drawable` that should be displayed as the launch screen.

```
<span>&lt;style</span> <span>name=</span><span>"LaunchTheme"</span> <span>parent=</span><span>"@android:style/Theme.Black.NoTitleBar"</span><span>&gt;</span>
    <span>&lt;item</span> <span>name=</span><span>"android:windowBackground"</span><span>&gt;</span>@drawable/launch_background<span>&lt;/item&gt;</span>
<span>&lt;/style&gt;</span>
```

In addition, `styles.xml` defines a _normal theme_ to be applied to `FlutterActivity` after the launch screen is gone. The normal theme background only shows for a very brief moment after the splash screen disappears, and during orientation change and `Activity` restoration. Therefore, it’s recommended that the normal theme use a solid background color that looks similar to the primary background color of the Flutter UI.

```
<span>&lt;style</span> <span>name=</span><span>"NormalTheme"</span> <span>parent=</span><span>"@android:style/Theme.Black.NoTitleBar"</span><span>&gt;</span>
    <span>&lt;item</span> <span>name=</span><span>"android:windowBackground"</span><span>&gt;</span>@drawable/normal_background<span>&lt;/item&gt;</span>
<span>&lt;/style&gt;</span>
```

## Set up the FlutterActivity in AndroidManifest.xml

In `AndroidManifest.xml`, set the `theme` of `FlutterActivity` to the launch theme. Then, add a metadata element to the desired `FlutterActivity` to instruct Flutter to switch from the launch theme to the normal theme at the appropriate time.

```
<span>&lt;activity</span>
    <span>android:name=</span><span>".MyActivity"</span>
    <span>android:theme=</span><span>"@style/LaunchTheme"</span>
    <span>//</span> <span>...</span>
    <span>&gt;</span>
    <span>&lt;meta-data</span>
        <span>android:name=</span><span>"io.flutter.embedding.android.NormalTheme"</span>
        <span>android:resource=</span><span>"@style/NormalTheme"</span>
        <span>/&gt;</span>
    <span>&lt;intent-filter&gt;</span>
        <span>&lt;action</span> <span>android:name=</span><span>"android.intent.action.MAIN"</span><span>/&gt;</span>
        <span>&lt;category</span> <span>android:name=</span><span>"android.intent.category.LAUNCHER"</span><span>/&gt;</span>
    <span>&lt;/intent-filter&gt;</span>
<span>&lt;/activity&gt;</span>
```

The Android app now displays the desired launch screen while the app initializes.

## Android 12

To configure your launch screen on Android 12, check out [Android Splash Screens](https://developer.android.com/about/versions/12/features/splash-screen).

As of Android 12, you must use the new splash screen API in your `styles.xml` file. Consider creating an alternate resource file for Android 12 and higher. Also make sure that your background image is in line with the icon guidelines; check out [Android Splash Screens](https://developer.android.com/about/versions/12/features/splash-screen) for more details.

```
<span>&lt;style</span> <span>name=</span><span>"LaunchTheme"</span> <span>parent=</span><span>"@android:style/Theme.Black.NoTitleBar"</span><span>&gt;</span>
    <span>&lt;item</span> <span>name=</span><span>"android:windowSplashScreenBackground"</span><span>&gt;</span>@color/bgColor<span>&lt;/item&gt;</span>
    <span>&lt;item</span> <span>name=</span><span>"android:windowSplashScreenAnimatedIcon"</span><span>&gt;</span>@drawable/launch_background<span>&lt;/item&gt;</span>
<span>&lt;/style&gt;</span>
```

Make sure that `io.flutter.embedding.android.SplashScreenDrawable` is **not** set in your manifest, and that `provideSplashScreen` is **not** implemented, as these APIs are deprecated. Doing so causes the Android launch screen to fade smoothly into the Flutter when the app is launched and the app might crash.

Some apps might want to continue showing the last frame of the Android launch screen in Flutter. For example, this preserves the illusion of a single frame while additional loading continues in Dart. To achieve this, the following Android APIs might be helpful:

-   [Java](https://docs.flutter.dev/platform-integration/android/splash-screen#android-splash-alignment-java-tab)
-   [Kotlin](https://docs.flutter.dev/platform-integration/android/splash-screen#android-splash-alignment-kotlin-tab)

```
<span>import</span><span> android</span><span>.</span><span>os</span><span>.</span><span>Build</span><span>;</span><span>
</span><span>import</span><span> android</span><span>.</span><span>os</span><span>.</span><span>Bundle</span><span>;</span><span>
</span><span>import</span><span> android</span><span>.</span><span>window</span><span>.</span><span>SplashScreenView</span><span>;</span><span>
</span><span>import</span><span> androidx</span><span>.</span><span>core</span><span>.</span><span>view</span><span>.</span><span>WindowCompat</span><span>;</span><span>
</span><span>import</span><span> io</span><span>.</span><span>flutter</span><span>.</span><span>embedding</span><span>.</span><span>android</span><span>.</span><span>FlutterActivity</span><span>;</span><span>

</span><span>public</span><span> </span><span>class</span><span> </span><span>MainActivity</span><span> </span><span>extends</span><span> </span><span>FlutterActivity</span><span> </span><span>{</span><span>
    </span><span>@Override</span><span>
    </span><span>protected</span><span> </span><span>void</span><span> onCreate</span><span>(</span><span>Bundle</span><span> savedInstanceState</span><span>)</span><span> </span><span>{</span><span>
        </span><span>// Aligns the Flutter view vertically with the window.</span><span>
        </span><span>WindowCompat</span><span>.</span><span>setDecorFitsSystemWindows</span><span>(</span><span>getWindow</span><span>(),</span><span> </span><span>false</span><span>);</span><span>

        </span><span>if</span><span> </span><span>(</span><span>Build</span><span>.</span><span>VERSION</span><span>.</span><span>SDK_INT </span><span>&gt;=</span><span> </span><span>Build</span><span>.</span><span>VERSION_CODES</span><span>.</span><span>S</span><span>)</span><span> </span><span>{</span><span>
            </span><span>// Disable the Android splash screen fade out animation to avoid</span><span>
            </span><span>// a flicker before the similar frame is drawn in Flutter.</span><span>
            getSplashScreen</span><span>()</span><span>
                </span><span>.</span><span>setOnExitAnimationListener</span><span>(</span><span>
                    </span><span>(</span><span>SplashScreenView</span><span> splashScreenView</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>{</span><span>
                        splashScreenView</span><span>.</span><span>remove</span><span>();</span><span>
                    </span><span>});</span><span>
        </span><span>}</span><span>

        </span><span>super</span><span>.</span><span>onCreate</span><span>(</span><span>savedInstanceState</span><span>);</span><span>
    </span><span>}</span><span>
</span><span>}</span>
```

Then, you can reimplement the first frame in Flutter that shows elements of your Android launch screen in the same positions on screen. For an example of this, check out the [Android splash screen sample app](https://github.com/flutter/samples/tree/main/android_splash_screen).