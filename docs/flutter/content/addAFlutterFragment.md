1.  [Add to app](https://docs.flutter.dev/add-to-app)
2.  [Add Flutter to Android](https://docs.flutter.dev/add-to-app/android)
3.  [Add a Flutter Fragment](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment)

![Add Flutter Fragment Header](https://docs.flutter.dev/assets/images/docs/development/add-to-app/android/add-flutter-fragment/add-flutter-fragment_header.png)

This guide describes how to add a Flutter `Fragment` to an existing Android app. In Android, a [`Fragment`](https://developer.android.com/guide/components/fragments) represents a modular piece of a larger UI. A `Fragment` might be used to present a sliding drawer, tabbed content, a page in a `ViewPager`, or it might simply represent a normal screen in a single-`Activity` app. Flutter provides a [`FlutterFragment`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterFragment.html) so that developers can present a Flutter experience any place that they can use a regular `Fragment`.

If an `Activity` is equally applicable for your application needs, consider [using a `FlutterActivity`](https://docs.flutter.dev/add-to-app/android/add-flutter-screen) instead of a `FlutterFragment`, which is quicker and easier to use.

`FlutterFragment` allows developers to control the following details of the Flutter experience within the `Fragment`:

-   Initial Flutter route
-   Dart entrypoint to execute
-   Opaque vs translucent background
-   Whether `FlutterFragment` should control its surrounding `Activity`
-   Whether a new [`FlutterEngine`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngine.html) or a cached `FlutterEngine` should be used

`FlutterFragment` also comes with a number of calls that must be forwarded from its surrounding `Activity`. These calls allow Flutter to react appropriately to OS events.

All varieties of `FlutterFragment`, and its requirements, are described in this guide.

## Add a `FlutterFragment` to an `Activity` with a new `FlutterEngine`

The first thing to do to use a `FlutterFragment` is to add it to a host `Activity`.

To add a `FlutterFragment` to a host `Activity`, instantiate and attach an instance of `FlutterFragment` in `onCreate()` within the `Activity`, or at another time that works for your app:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#add-fragment-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#add-fragment-kotlin-tab)

```
<span>public</span><span> </span><span>class</span><span> </span><span>MyActivity</span><span> </span><span>extends</span><span> </span><span>FragmentActivity</span><span> </span><span>{</span><span>
    </span><span>// Define a tag String to represent the FlutterFragment within this</span><span>
    </span><span>// Activity's FragmentManager. This value can be whatever you'd like.</span><span>
    </span><span>private</span><span> </span><span>static</span><span> </span><span>final</span><span> </span><span>String</span><span> TAG_FLUTTER_FRAGMENT </span><span>=</span><span> </span><span>"flutter_fragment"</span><span>;</span><span>

    </span><span>// Declare a local variable to reference the FlutterFragment so that you</span><span>
    </span><span>// can forward calls to it later.</span><span>
    </span><span>private</span><span> </span><span>FlutterFragment</span><span> flutterFragment</span><span>;</span><span>

    </span><span>@Override</span><span>
    </span><span>protected</span><span> </span><span>void</span><span> onCreate</span><span>(</span><span>Bundle</span><span> savedInstanceState</span><span>)</span><span> </span><span>{</span><span>
        </span><span>super</span><span>.</span><span>onCreate</span><span>(</span><span>savedInstanceState</span><span>);</span><span>

        </span><span>// Inflate a layout that has a container for your FlutterFragment.</span><span>
        </span><span>// For this example, assume that a FrameLayout exists with an ID of</span><span>
        </span><span>// R.id.fragment_container.</span><span>
        setContentView</span><span>(</span><span>R</span><span>.</span><span>layout</span><span>.</span><span>my_activity_layout</span><span>);</span><span>

        </span><span>// Get a reference to the Activity's FragmentManager to add a new</span><span>
        </span><span>// FlutterFragment, or find an existing one.</span><span>
        </span><span>FragmentManager</span><span> fragmentManager </span><span>=</span><span> getSupportFragmentManager</span><span>();</span><span>

        </span><span>// Attempt to find an existing FlutterFragment,</span><span>
        </span><span>// in case this is not the first time that onCreate() was run.</span><span>
        flutterFragment </span><span>=</span><span> </span><span>(</span><span>FlutterFragment</span><span>)</span><span> fragmentManager
            </span><span>.</span><span>findFragmentByTag</span><span>(</span><span>TAG_FLUTTER_FRAGMENT</span><span>);</span><span>

        </span><span>// Create and attach a FlutterFragment if one does not exist.</span><span>
        </span><span>if</span><span> </span><span>(</span><span>flutterFragment </span><span>==</span><span> </span><span>null</span><span>)</span><span> </span><span>{</span><span>
            flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>createDefault</span><span>();</span><span>

            fragmentManager
                </span><span>.</span><span>beginTransaction</span><span>()</span><span>
                </span><span>.</span><span>add</span><span>(</span><span>
                    R</span><span>.</span><span>id</span><span>.</span><span>fragment_container</span><span>,</span><span>
                    flutterFragment</span><span>,</span><span>
                    TAG_FLUTTER_FRAGMENT
                </span><span>)</span><span>
                </span><span>.</span><span>commit</span><span>();</span><span>
        </span><span>}</span><span>
    </span><span>}</span><span>
</span><span>}</span>
```

The previous code is sufficient to render a Flutter UI that begins with a call to your `main()` Dart entrypoint, an initial Flutter route of `/`, and a new `FlutterEngine`. However, this code is not sufficient to achieve all expected Flutter behavior. Flutter depends on various OS signals that must be forwarded from your host `Activity` to `FlutterFragment`. These calls are shown in the following example:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#forward-activity-calls-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#forward-activity-calls-kotlin-tab)

```
<span>public</span><span> </span><span>class</span><span> </span><span>MyActivity</span><span> </span><span>extends</span><span> </span><span>FragmentActivity</span><span> </span><span>{</span><span>
    </span><span>@Override</span><span>
    </span><span>public</span><span> </span><span>void</span><span> onPostResume</span><span>()</span><span> </span><span>{</span><span>
        </span><span>super</span><span>.</span><span>onPostResume</span><span>();</span><span>
        flutterFragment</span><span>.</span><span>onPostResume</span><span>();</span><span>
    </span><span>}</span><span>

    </span><span>@Override</span><span>
    </span><span>protected</span><span> </span><span>void</span><span> onNewIntent</span><span>(</span><span>@NonNull</span><span> </span><span>Intent</span><span> intent</span><span>)</span><span> </span><span>{</span><span>
        flutterFragment</span><span>.</span><span>onNewIntent</span><span>(</span><span>intent</span><span>);</span><span>
    </span><span>}</span><span>

    </span><span>@Override</span><span>
    </span><span>public</span><span> </span><span>void</span><span> onBackPressed</span><span>()</span><span> </span><span>{</span><span>
        flutterFragment</span><span>.</span><span>onBackPressed</span><span>();</span><span>
    </span><span>}</span><span>

    </span><span>@Override</span><span>
    </span><span>public</span><span> </span><span>void</span><span> onRequestPermissionsResult</span><span>(</span><span>
        </span><span>int</span><span> requestCode</span><span>,</span><span>
        </span><span>@NonNull</span><span> </span><span>String</span><span>[]</span><span> permissions</span><span>,</span><span>
        </span><span>@NonNull</span><span> </span><span>int</span><span>[]</span><span> grantResults
    </span><span>)</span><span> </span><span>{</span><span>
        flutterFragment</span><span>.</span><span>onRequestPermissionsResult</span><span>(</span><span>
            requestCode</span><span>,</span><span>
            permissions</span><span>,</span><span>
            grantResults
        </span><span>);</span><span>
    </span><span>}</span><span>

    </span><span>@Override</span><span>
    </span><span>public</span><span> </span><span>void</span><span> onActivityResult</span><span>(</span><span>
        </span><span>int</span><span> requestCode</span><span>,</span><span>
        </span><span>int</span><span> resultCode</span><span>,</span><span>
        </span><span>@Nullable</span><span> </span><span>Intent</span><span> data
    </span><span>)</span><span> </span><span>{</span><span>
        </span><span>super</span><span>.</span><span>onActivityResult</span><span>(</span><span>requestCode</span><span>,</span><span> resultCode</span><span>,</span><span> data</span><span>);</span><span>
        flutterFragment</span><span>.</span><span>onActivityResult</span><span>(</span><span>
            requestCode</span><span>,</span><span>
            resultCode</span><span>,</span><span>
            data
        </span><span>);</span><span>
    </span><span>}</span><span>

    </span><span>@Override</span><span>
    </span><span>public</span><span> </span><span>void</span><span> onUserLeaveHint</span><span>()</span><span> </span><span>{</span><span>
        flutterFragment</span><span>.</span><span>onUserLeaveHint</span><span>();</span><span>
    </span><span>}</span><span>

    </span><span>@Override</span><span>
    </span><span>public</span><span> </span><span>void</span><span> onTrimMemory</span><span>(</span><span>int</span><span> level</span><span>)</span><span> </span><span>{</span><span>
        </span><span>super</span><span>.</span><span>onTrimMemory</span><span>(</span><span>level</span><span>);</span><span>
        flutterFragment</span><span>.</span><span>onTrimMemory</span><span>(</span><span>level</span><span>);</span><span>
    </span><span>}</span><span>
</span><span>}</span>
```

With the OS signals forwarded to Flutter, your `FlutterFragment` works as expected. You have now added a `FlutterFragment` to your existing Android app.

The simplest integration path uses a new `FlutterEngine`, which comes with a non-trivial initialization time, leading to a blank UI until Flutter is initialized and rendered the first time. Most of this time overhead can be avoided by using a cached, pre-warmed `FlutterEngine`, which is discussed next.

## Using a pre-warmed `FlutterEngine`

By default, a `FlutterFragment` creates its own instance of a `FlutterEngine`, which requires non-trivial warm-up time. This means your user sees a blank `Fragment` for a brief moment. You can mitigate most of this warm-up time by using an existing, pre-warmed instance of `FlutterEngine`.

To use a pre-warmed `FlutterEngine` in a `FlutterFragment`, instantiate a `FlutterFragment` with the `withCachedEngine()` factory method.

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#use-prewarmed-engine-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#use-prewarmed-engine-kotlin-tab)

```
<span>// Somewhere in your app, before your FlutterFragment is needed,</span><span>
</span><span>// like in the Application class ...</span><span>
</span><span>// Instantiate a FlutterEngine.</span><span>
</span><span>FlutterEngine</span><span> flutterEngine </span><span>=</span><span> </span><span>new</span><span> </span><span>FlutterEngine</span><span>(</span><span>context</span><span>);</span><span>

</span><span>// Start executing Dart code in the FlutterEngine.</span><span>
flutterEngine</span><span>.</span><span>getDartExecutor</span><span>().</span><span>executeDartEntrypoint</span><span>(</span><span>
    </span><span>DartEntrypoint</span><span>.</span><span>createDefault</span><span>()</span><span>
</span><span>);</span><span>

</span><span>// Cache the pre-warmed FlutterEngine to be used later by FlutterFragment.</span><span>
</span><span>FlutterEngineCache</span><span>
  </span><span>.</span><span>getInstance</span><span>()</span><span>
  </span><span>.</span><span>put</span><span>(</span><span>"my_engine_id"</span><span>,</span><span> flutterEngine</span><span>);</span>
```

```
<span>FlutterFragment</span><span>.</span><span>withCachedEngine</span><span>(</span><span>"my_engine_id"</span><span>).</span><span>build</span><span>();</span>
```

`FlutterFragment` internally knows about [`FlutterEngineCache`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/FlutterEngineCache.html) and retrieves the pre-warmed `FlutterEngine` based on the ID given to `withCachedEngine()`.

By providing a pre-warmed `FlutterEngine`, as previously shown, your app renders the first Flutter frame as quickly as possible.

#### Initial route with a cached engine

The concept of an initial route is available when configuring a `FlutterActivity` or a `FlutterFragment` with a new `FlutterEngine`. However, `FlutterActivity` and `FlutterFragment` don’t offer the concept of an initial route when using a cached engine. This is because a cached engine is expected to already be running Dart code, which means it’s too late to configure the initial route.

Developers that would like their cached engine to begin with a custom initial route can configure their cached `FlutterEngine` to use a custom initial route just before executing the Dart entrypoint. The following example demonstrates the use of an initial route with a cached engine:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#cached-engine-with-initial-route-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#cached-engine-with-initial-route-kotlin-tab)

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

## Display a splash screen

The initial display of Flutter content requires some wait time, even if a pre-warmed `FlutterEngine` is used. To help improve the user experience around this brief waiting period, Flutter supports the display of a splash screen (also known as “launch screen”) until Flutter renders its first frame. For instructions about how to show a launch screen, see the [splash screen guide](https://docs.flutter.dev/platform-integration/android/splash-screen).

## Run Flutter with a specified initial route

An Android app might contain many independent Flutter experiences, running in different `FlutterFragment`s, with different `FlutterEngine`s. In these scenarios, it’s common for each Flutter experience to begin with different initial routes (routes other than `/`). To facilitate this, `FlutterFragment`’s `Builder` allows you to specify a desired initial route, as shown:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#launch-with-initial-route-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#launch-with-initial-route-kotlin-tab)

```
<span>// With a new FlutterEngine.</span><span>
</span><span>FlutterFragment</span><span> flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>withNewEngine</span><span>()</span><span>
    </span><span>.</span><span>initialRoute</span><span>(</span><span>"myInitialRoute/"</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>();</span>
```

## Run Flutter from a specified entrypoint

Similar to varying initial routes, different `FlutterFragment`s might want to execute different Dart entrypoints. In a typical Flutter app, there is only one Dart entrypoint: `main()`, but you can define other entrypoints.

`FlutterFragment` supports specification of the desired Dart entrypoint to execute for the given Flutter experience. To specify an entrypoint, build `FlutterFragment`, as shown:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#launch-with-custom-entrypoint-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#launch-with-custom-entrypoint-kotlin-tab)

```
<span>FlutterFragment</span><span> flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>withNewEngine</span><span>()</span><span>
    </span><span>.</span><span>dartEntrypoint</span><span>(</span><span>"mySpecialEntrypoint"</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>();</span>
```

The `FlutterFragment` configuration results in the execution of a Dart entrypoint called `mySpecialEntrypoint()`. Notice that the parentheses `()` are not included in the `dartEntrypoint` `String` name.

## Control `FlutterFragment`’s render mode

`FlutterFragment` can either use a `SurfaceView` to render its Flutter content, or it can use a `TextureView`. The default is `SurfaceView`, which is significantly better for performance than `TextureView`. However, `SurfaceView` can’t be interleaved in the middle of an Android `View` hierarchy. A `SurfaceView` must either be the bottommost `View` in the hierarchy, or the topmost `View` in the hierarchy. Additionally, on Android versions before Android N, `SurfaceView`s can’t be animated because their layout and rendering aren’t synchronized with the rest of the `View` hierarchy. If either of these use cases are requirements for your app, then you need to use `TextureView` instead of `SurfaceView`. Select a `TextureView` by building a `FlutterFragment` with a `texture` `RenderMode`:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#launch-with-rendermode-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#launch-with-rendermode-kotlin-tab)

```
<span>// With a new FlutterEngine.</span><span>
</span><span>FlutterFragment</span><span> flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>withNewEngine</span><span>()</span><span>
    </span><span>.</span><span>renderMode</span><span>(</span><span>FlutterView</span><span>.</span><span>RenderMode</span><span>.</span><span>texture</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>();</span><span>

</span><span>// With a cached FlutterEngine.</span><span>
</span><span>FlutterFragment</span><span> flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>withCachedEngine</span><span>(</span><span>"my_engine_id"</span><span>)</span><span>
    </span><span>.</span><span>renderMode</span><span>(</span><span>FlutterView</span><span>.</span><span>RenderMode</span><span>.</span><span>texture</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>();</span>
```

Using the configuration shown, the resulting `FlutterFragment` renders its UI to a `TextureView`.

## Display a `FlutterFragment` with transparency

By default, `FlutterFragment` renders with an opaque background, using a `SurfaceView`. (See “Control `FlutterFragment`’s render mode.”) That background is black for any pixels that aren’t painted by Flutter. Rendering with an opaque background is the preferred rendering mode for performance reasons. Flutter rendering with transparency on Android negatively affects performance. However, there are many designs that require transparent pixels in the Flutter experience that show through to the underlying Android UI. For this reason, Flutter supports translucency in a `FlutterFragment`.

To enable transparency for a `FlutterFragment`, build it with the following configuration:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#launch-with-transparency-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#launch-with-transparency-kotlin-tab)

```
<span>// Using a new FlutterEngine.</span><span>
</span><span>FlutterFragment</span><span> flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>withNewEngine</span><span>()</span><span>
    </span><span>.</span><span>transparencyMode</span><span>(</span><span>FlutterView</span><span>.</span><span>TransparencyMode</span><span>.</span><span>transparent</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>();</span><span>

</span><span>// Using a cached FlutterEngine.</span><span>
</span><span>FlutterFragment</span><span> flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>withCachedEngine</span><span>(</span><span>"my_engine_id"</span><span>)</span><span>
    </span><span>.</span><span>transparencyMode</span><span>(</span><span>FlutterView</span><span>.</span><span>TransparencyMode</span><span>.</span><span>transparent</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>();</span>
```

## The relationship between `FlutterFragment` and its `Activity`

Some apps choose to use `Fragment`s as entire Android screens. In these apps, it would be reasonable for a `Fragment` to control system chrome like Android’s status bar, navigation bar, and orientation.

![Fullscreen Flutter](https://docs.flutter.dev/assets/images/docs/development/add-to-app/android/add-flutter-fragment/add-flutter-fragment_fullscreen.png)

In other apps, `Fragment`s are used to represent only a portion of a UI. A `FlutterFragment` might be used to implement the inside of a drawer, a video player, or a single card. In these situations, it would be inappropriate for the `FlutterFragment` to affect Android’s system chrome because there are other UI pieces within the same `Window`.

![Flutter as Partial UI](https://docs.flutter.dev/assets/images/docs/development/add-to-app/android/add-flutter-fragment/add-flutter-fragment_partial-ui.png)

`FlutterFragment` comes with a concept that helps differentiate between the case when a `FlutterFragment` should be able to control its host `Activity`, and the cases when a `FlutterFragment` should only affect its own behavior. To prevent a `FlutterFragment` from exposing its `Activity` to Flutter plugins, and to prevent Flutter from controlling the `Activity`’s system UI, use the `shouldAttachEngineToActivity()` method in `FlutterFragment`’s `Builder`, as shown:

-   [Java](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#attach-to-activity-java-tab)
-   [Kotlin](https://docs.flutter.dev/add-to-app/android/add-flutter-fragment#attach-to-activity-kotlin-tab)

```
<span>// Using a new FlutterEngine.</span><span>
</span><span>FlutterFragment</span><span> flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>withNewEngine</span><span>()</span><span>
    </span><span>.</span><span>shouldAttachEngineToActivity</span><span>(</span><span>false</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>();</span><span>

</span><span>// Using a cached FlutterEngine.</span><span>
</span><span>FlutterFragment</span><span> flutterFragment </span><span>=</span><span> </span><span>FlutterFragment</span><span>.</span><span>withCachedEngine</span><span>(</span><span>"my_engine_id"</span><span>)</span><span>
    </span><span>.</span><span>shouldAttachEngineToActivity</span><span>(</span><span>false</span><span>)</span><span>
    </span><span>.</span><span>build</span><span>();</span>
```

Passing `false` to the `shouldAttachEngineToActivity()` `Builder` method prevents Flutter from interacting with the surrounding `Activity`. The default value is `true`, which allows Flutter and Flutter plugins to interact with the surrounding `Activity`.