1.  [Add to app](https://docs.flutter.dev/add-to-app)
2.  [Add Flutter to Android](https://docs.flutter.dev/add-to-app/android)
3.  [Add a Flutter screen](https://docs.flutter.dev/add-to-app/android/add-flutter-screen)

This guide describes how to add a single Flutter screen to an existing Android app. A Flutter screen can be added as a normal, opaque screen, or as a see-through, translucent screen. Both options are described in this guide.

## Add a normal Flutter screen

![Add Flutter Screen Header](https://docs.flutter.dev/assets/images/docs/development/add-to-app/android/add-flutter-screen/add-single-flutter-screen_header.png)

### Step 1: Add FlutterActivity to AndroidManifest.xml

Flutter provides [`FlutterActivity`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterActivity.html) to display a Flutter experience within an Android app. Like any other [`Activity`](https://developer.android.com/reference/android/app/Activity), `FlutterActivity` must be registered in your `AndroidManifest.xml`. Add the following XML to your `AndroidManifest.xml` file under your `application` tag:

```
<span>&lt;activity</span>
  <span>android:name=</span><span>"io.flutter.embedding.android.FlutterActivity"</span>
  <span>android:theme=</span><span>"@style/LaunchTheme"</span>
  <span>android:configChanges=</span><span>"orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"</span>
  <span>android:hardwareAccelerated=</span><span>"true"</span>
  <span>android:windowSoftInputMode=</span><span>"adjustResize"</span>
  <span>/&gt;</span>
```

The reference to `@style/LaunchTheme` can be replaced by any Android theme that want to apply to your `FlutterActivity`. The choice of theme dictates the colors applied to Android’s system chrome, like Android’s navigation bar, and to the background color of the `FlutterActivity` just before the Flutter UI renders itself for the first time.

### Step 2: Launch FlutterActivity

With `FlutterActivity` registered in your manifest file, add code to launch `FlutterActivity` from whatever point in your app that you’d like. The following example shows `FlutterActivity` being launched from an `OnClickListener`.

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#default-activity-launch-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#default-activity-launch-kotlin-tab)

```
<span>myButton</span><span>.</span><span>setOnClickListener</span><span>(</span><span>new</span><span> </span><span>OnClickListener</span><span>()</span><span> </span><span>{</span><span>
  </span><span>@Override</span><span>
  </span><span>public</span><span> </span><span>void</span><span> onClick</span><span>(</span><span>View</span><span> v</span><span>)</span><span> </span><span>{</span><span>
    startActivity</span><span>(</span><span>
      </span><span>FlutterActivity</span><span>.</span><span>createDefaultIntent</span><span>(</span><span>currentActivity</span><span>)</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>});</span>
```

The previous example assumes that your Dart entrypoint is called `main()`, and your initial Flutter route is ‘/’. The Dart entrypoint can’t be changed using `Intent`, but the initial route can be changed using `Intent`. The following example demonstrates how to launch a `FlutterActivity` that initially renders a custom route in Flutter.

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#custom-activity-launch-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#custom-activity-launch-kotlin-tab)

```
<span>myButton</span><span>.</span><span>addOnClickListener</span><span>(</span><span>new</span><span> </span><span>OnClickListener</span><span>()</span><span> </span><span>{</span><span>
  </span><span>@Override</span><span>
  </span><span>public</span><span> </span><span>void</span><span> onClick</span><span>(</span><span>View</span><span> v</span><span>)</span><span> </span><span>{</span><span>
    startActivity</span><span>(</span><span>
      </span><span>FlutterActivity</span><span>
        </span><span>.</span><span>withNewEngine</span><span>()</span><span>
        </span><span>.</span><span>initialRoute</span><span>(</span><span>"/my_route"</span><span>)</span><span>
        </span><span>.</span><span>build</span><span>(</span><span>currentActivity</span><span>)</span><span>
      </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>});</span>
```

Replace `"/my_route"` with your desired initial route.

The use of the `withNewEngine()` factory method configures a `FlutterActivity` that internally create its own [`FlutterEngine`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html) instance. This comes with a non-trivial initialization time. The alternative approach is to instruct `FlutterActivity` to use a pre-warmed, cached `FlutterEngine`, which minimizes Flutter’s initialization time. That approach is discussed next.

### Step 3: (Optional) Use a cached FlutterEngine

Every `FlutterActivity` creates its own `FlutterEngine` by default. Each `FlutterEngine` has a non-trivial warm-up time. This means that launching a standard `FlutterActivity` comes with a brief delay before your Flutter experience becomes visible. To minimize this delay, you can warm up a `FlutterEngine` before arriving at your `FlutterActivity`, and then you can use your pre-warmed `FlutterEngine` instead.

To pre-warm a `FlutterEngine`, find a reasonable location in your app to instantiate a `FlutterEngine`. The following example arbitrarily pre-warms a `FlutterEngine` in the `Application` class:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#prewarm-engine-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#prewarm-engine-kotlin-tab)

```
<span>public</span><span> </span><span>class</span><span> </span><span>MyApplication</span><span> </span><span>extends</span><span> </span><span>Application</span><span> </span><span>{</span><span>
  </span><span>public</span><span> </span><span>FlutterEngine</span><span> flutterEngine</span><span>;</span><span>
  
  </span><span>@Override</span><span>
  </span><span>public</span><span> </span><span>void</span><span> onCreate</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>onCreate</span><span>();</span><span>
    </span><span>// Instantiate a FlutterEngine.</span><span>
    flutterEngine </span><span>=</span><span> </span><span>new</span><span> </span><span>FlutterEngine</span><span>(</span><span>this</span><span>);</span><span>

    </span><span>// Start executing Dart code to pre-warm the FlutterEngine.</span><span>
    flutterEngine</span><span>.</span><span>getDartExecutor</span><span>().</span><span>executeDartEntrypoint</span><span>(</span><span>
      </span><span>DartEntrypoint</span><span>.</span><span>createDefault</span><span>()</span><span>
    </span><span>);</span><span>

    </span><span>// Cache the FlutterEngine to be used by FlutterActivity.</span><span>
    </span><span>FlutterEngineCache</span><span>
      </span><span>.</span><span>getInstance</span><span>()</span><span>
      </span><span>.</span><span>put</span><span>(</span><span>"my_engine_id"</span><span>,</span><span> flutterEngine</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The ID passed to the [`FlutterEngineCache`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngineCache.html) can be whatever you want. Make sure that you pass the same ID to any `FlutterActivity` or [`FlutterFragment`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment.html) that should use the cached `FlutterEngine`. Using `FlutterActivity` with a cached `FlutterEngine` is discussed next.

With a pre-warmed, cached `FlutterEngine`, you now need to instruct your `FlutterActivity` to use the cached `FlutterEngine` instead of creating a new one. To accomplish this, use `FlutterActivity`’s `withCachedEngine()` builder:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#cached-engine-activity-launch-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#cached-engine-activity-launch-kotlin-tab)

```
<span>myButton</span><span>.</span><span>addOnClickListener</span><span>(</span><span>new</span><span> </span><span>OnClickListener</span><span>()</span><span> </span><span>{</span><span>
  </span><span>@Override</span><span>
  </span><span>public</span><span> </span><span>void</span><span> onClick</span><span>(</span><span>View</span><span> v</span><span>)</span><span> </span><span>{</span><span>
    startActivity</span><span>(</span><span>
      </span><span>FlutterActivity</span><span>
        </span><span>.</span><span>withCachedEngine</span><span>(</span><span>"my_engine_id"</span><span>)</span><span>
        </span><span>.</span><span>build</span><span>(</span><span>currentActivity</span><span>)</span><span>
      </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>});</span>
```

When using the `withCachedEngine()` factory method, pass the same ID that you used when caching the desired `FlutterEngine`.

Now, when you launch `FlutterActivity`, there is significantly less delay in the display of Flutter content.

#### Initial route with a cached engine

The concept of an initial route is available when configuring a `FlutterActivity` or a `FlutterFragment` with a new `FlutterEngine`. However, `FlutterActivity` and `FlutterFragment` don’t offer the concept of an initial route when using a cached engine. This is because a cached engine is expected to already be running Dart code, which means it’s too late to configure the initial route.

Developers that would like their cached engine to begin with a custom initial route can configure their cached `FlutterEngine` to use a custom initial route just before executing the Dart entrypoint. The following example demonstrates the use of an initial route with a cached engine:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#cached-engine-with-initial-route-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#cached-engine-with-initial-route-kotlin-tab)

```
<span>public</span><span> </span><span>class</span><span> </span><span>MyApplication</span><span> </span><span>extends</span><span> </span><span>Application</span><span> </span><span>{</span><span>
  </span><span>@Override</span><span>
  </span><span>public</span><span> </span><span>void</span><span> onCreate</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>onCreate</span><span>();</span><span>
    </span><span>// Instantiate a FlutterEngine.</span><span>
    flutterEngine </span><span>=</span><span> </span><span>new</span><span> </span><span>FlutterEngine</span><span>(</span><span>this</span><span>);</span><span>
    </span><span>// Configure an initial route.</span><span>
    flutterEngine</span><span>.</span><span>getNavigationChannel</span><span>().</span><span>setInitialRoute</span><span>(</span><span>"your/route/here"</span><span>);</span><span>
    </span><span>// Start executing Dart code to pre-warm the FlutterEngine.</span><span>
    flutterEngine</span><span>.</span><span>getDartExecutor</span><span>().</span><span>executeDartEntrypoint</span><span>(</span><span>
      </span><span>DartEntrypoint</span><span>.</span><span>createDefault</span><span>()</span><span>
    </span><span>);</span><span>
    </span><span>// Cache the FlutterEngine to be used by FlutterActivity or FlutterFragment.</span><span>
    </span><span>FlutterEngineCache</span><span>
      </span><span>.</span><span>getInstance</span><span>()</span><span>
      </span><span>.</span><span>put</span><span>(</span><span>"my_engine_id"</span><span>,</span><span> flutterEngine</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

By setting the initial route of the navigation channel, the associated `FlutterEngine` displays the desired route upon initial execution of the `runApp()` Dart function.

Changing the initial route property of the navigation channel after the initial execution of `runApp()` has no effect. Developers who would like to use the same `FlutterEngine` between different `Activity`s and `Fragment`s and switch the route between those displays need to setup a method channel and explicitly instruct their Dart code to change `Navigator` routes.

## Add a translucent Flutter screen

![Add Flutter Screen With Translucency Header](https://docs.flutter.dev/assets/images/docs/development/add-to-app/android/add-flutter-screen/add-single-flutter-screen-transparent_header.png)

Most full-screen Flutter experiences are opaque. However, some apps would like to deploy a Flutter screen that looks like a modal, for example, a dialog or bottom sheet. Flutter supports translucent `FlutterActivity`s out of the box.

To make your `FlutterActivity` translucent, make the following changes to the regular process of creating and launching a `FlutterActivity`.

### Step 1: Use a theme with translucency

Android requires a special theme property for `Activity`s that render with a translucent background. Create or update an Android theme with the following property:

```
<span>&lt;style</span> <span>name=</span><span>"MyTheme"</span> <span>parent=</span><span>"@style/MyParentTheme"</span><span>&gt;</span>
  <span>&lt;item</span> <span>name=</span><span>"android:windowIsTranslucent"</span><span>&gt;</span>true<span>&lt;/item&gt;</span>
<span>&lt;/style&gt;</span>
```

Then, apply the translucent theme to your `FlutterActivity`.

```
<span>&lt;activity</span>
  <span>android:name=</span><span>"io.flutter.embedding.android.FlutterActivity"</span>
  <span>android:theme=</span><span>"@style/MyTheme"</span>
  <span>android:configChanges=</span><span>"orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"</span>
  <span>android:hardwareAccelerated=</span><span>"true"</span>
  <span>android:windowSoftInputMode=</span><span>"adjustResize"</span>
  <span>/&gt;</span>
```

Your `FlutterActivity` now supports translucency. Next, you need to launch your `FlutterActivity` with explicit transparency support.

### Step 2: Start FlutterActivity with transparency

To launch your `FlutterActivity` with a transparent background, pass the appropriate `BackgroundMode` to the `IntentBuilder`:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#transparent-activity-launch-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-screen#transparent-activity-launch-kotlin-tab)

```
<span>// Using a new FlutterEngine.</span><span>
startActivity</span><span>(</span><span>
  </span><span>FlutterActivity</span><span>
    </span><span>.</span><span>withNewEngine</span><span>()</span><span>
    </span><span>.</span><span>backgroundMode</span><span>(</span><span>FlutterActivityLaunchConfigs</span><span>.</span><span>BackgroundMode</span><span>.</span><span>transparent</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>(</span><span>context</span><span>)</span><span>
</span><span>);</span><span>

</span><span>// Using a cached FlutterEngine.</span><span>
startActivity</span><span>(</span><span>
  </span><span>FlutterActivity</span><span>
    </span><span>.</span><span>withCachedEngine</span><span>(</span><span>"my_engine_id"</span><span>)</span><span>
    </span><span>.</span><span>backgroundMode</span><span>(</span><span>FlutterActivityLaunchConfigs</span><span>.</span><span>BackgroundMode</span><span>.</span><span>transparent</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>(</span><span>context</span><span>)</span><span>
</span><span>);</span>
```

You now have a `FlutterActivity` with a transparent background.