1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Android](https://docs.flutter.dev/platform-integration/android)
3.  [Android platform-views](https://docs.flutter.dev/platform-integration/android/platform-views)

Platform views allow you to embed native views in a Flutter app, so you can apply transforms, clips, and opacity to the native view from Dart.

This allows you, for example, to use the native Google Maps from the Android SDK directly inside your Flutter app.

Flutter supports two modes: Hybrid composition and virtual displays.

Which one to use depends on the use case. Let’s take a look:

-   [Hybrid composition](https://docs.flutter.dev/platform-integration/android/platform-views#hybrid-composition) appends the native `android.view.View` to the view hierarchy. Therefore, keyboard handling, and accessibility work out of the box. Prior to Android 10, this mode might significantly reduce the frame throughput (FPS) of the Flutter UI. For more context, see [Performance](https://docs.flutter.dev/platform-integration/android/platform-views#performance).
    
-   [Virtual displays](https://docs.flutter.dev/platform-integration/android/platform-views#virtual-display) render the `android.view.View` instance to a texture, so it’s not embedded within the Android Activity’s view hierarchy. Certain platform interactions such as keyboard handling and accessibility features might not work.
    

To create a platform view on Android, use the following steps:

### On the Dart side

On the Dart side, create a `Widget` and add one of the following build implementations.

#### Hybrid composition

In your Dart file, for example `native_view_example.dart`, use the following instructions:

1.  Add the following imports:
    
    ```
    <span>import</span><span> </span><span>'package:flutter/foundation.dart'</span><span>;</span><span>
    </span><span>import</span><span> </span><span>'package:flutter/gestures.dart'</span><span>;</span><span>
    </span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
    </span><span>import</span><span> </span><span>'package:flutter/rendering.dart'</span><span>;</span><span>
    </span><span>import</span><span> </span><span>'package:flutter/services.dart'</span><span>;</span>
    ```
    
2.  Implement a `build()` method:
    
    ```
    <span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// This is used in the platform side to register the view.</span><span>
      </span><span>const</span><span> </span><span>String</span><span> viewType </span><span>=</span><span> </span><span>'&lt;platform-view-type&gt;'</span><span>;</span><span>
      </span><span>// Pass parameters to the platform side.</span><span>
      </span><span>const</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> creationParams </span><span>=</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;{};</span><span>
    
      </span><span>return</span><span> </span><span>PlatformViewLink</span><span>(</span><span>
        viewType</span><span>:</span><span> viewType</span><span>,</span><span>
        surfaceFactory</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> controller</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> </span><span>AndroidViewSurface</span><span>(</span><span>
            controller</span><span>:</span><span> controller </span><span>as</span><span> </span><span>AndroidViewController</span><span>,</span><span>
            gestureRecognizers</span><span>:</span><span> </span><span>const</span><span> </span><span>&lt;</span><span>Factory</span><span>&lt;</span><span>OneSequenceGestureRecognizer</span><span>&gt;&gt;{},</span><span>
            hitTestBehavior</span><span>:</span><span> </span><span>PlatformViewHitTestBehavior</span><span>.</span><span>opaque</span><span>,</span><span>
          </span><span>);</span><span>
        </span><span>},</span><span>
        onCreatePlatformView</span><span>:</span><span> </span><span>(</span><span>params</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> </span><span>PlatformViewsService</span><span>.</span><span>initSurfaceAndroidView</span><span>(</span><span>
            id</span><span>:</span><span> params</span><span>.</span><span>id</span><span>,</span><span>
            viewType</span><span>:</span><span> viewType</span><span>,</span><span>
            layoutDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
            creationParams</span><span>:</span><span> creationParams</span><span>,</span><span>
            creationParamsCodec</span><span>:</span><span> </span><span>const</span><span> </span><span>StandardMessageCodec</span><span>(),</span><span>
            onFocus</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
              params</span><span>.</span><span>onFocusChanged</span><span>(</span><span>true</span><span>);</span><span>
            </span><span>},</span><span>
          </span><span>)</span><span>
            </span><span>..</span><span>addOnPlatformViewCreatedListener</span><span>(</span><span>params</span><span>.</span><span>onPlatformViewCreated</span><span>)</span><span>
            </span><span>..</span><span>create</span><span>();</span><span>
        </span><span>},</span><span>
      </span><span>);</span><span>
    </span><span>}</span>
    ```
    

For more information, see the API docs for:

-   [`PlatformViewLink`](https://api.flutter.dev/flutter/widgets/PlatformViewLink-class.html)
-   [`AndroidViewSurface`](https://api.flutter.dev/flutter/widgets/AndroidViewSurface-class.html)
-   [`PlatformViewsService`](https://api.flutter.dev/flutter/services/PlatformViewsService-class.html)

#### Virtual display

In your Dart file, for example `native_view_example.dart`, use the following instructions:

1.  Add the following imports:
    
    ```
    <span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
    </span><span>import</span><span> </span><span>'package:flutter/services.dart'</span><span>;</span>
    ```
    
2.  Implement a `build()` method:
    
    ```
    <span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// This is used in the platform side to register the view.</span><span>
      </span><span>const</span><span> </span><span>String</span><span> viewType </span><span>=</span><span> </span><span>'&lt;platform-view-type&gt;'</span><span>;</span><span>
      </span><span>// Pass parameters to the platform side.</span><span>
      </span><span>final</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> creationParams </span><span>=</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;{};</span><span>
    
      </span><span>return</span><span> </span><span>AndroidView</span><span>(</span><span>
        viewType</span><span>:</span><span> viewType</span><span>,</span><span>
        layoutDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
        creationParams</span><span>:</span><span> creationParams</span><span>,</span><span>
        creationParamsCodec</span><span>:</span><span> </span><span>const</span><span> </span><span>StandardMessageCodec</span><span>(),</span><span>
      </span><span>);</span><span>
    </span><span>}</span>
    ```
    

For more information, see the API docs for:

-   [`AndroidView`](https://api.flutter.dev/flutter/widgets/AndroidView-class.html)

### On the platform side

On the platform side, use the standard `io.flutter.plugin.platform` package in either Java or Kotlin:

-   [Kotlin](https://docs.flutter.dev/platform-integration/android/platform-views#android-platform-views-kotlin-tab)
-   [Java](https://docs.flutter.dev/platform-integration/android/platform-views#android-platform-views-java-tab)

In your native code, implement the following:

Extend `io.flutter.plugin.platform.PlatformView` to provide a reference to the `android.view.View` (for example, `NativeView.kt`):

```
<span>package</span> <span>dev.flutter.example</span>

<span>import</span> <span>android.content.Context</span>
<span>import</span> <span>android.graphics.Color</span>
<span>import</span> <span>android.view.View</span>
<span>import</span> <span>android.widget.TextView</span>
<span>import</span> <span>io.flutter.plugin.platform.PlatformView</span>

<span>internal</span> <span>class</span> <span>NativeView</span><span>(</span><span>context</span><span>:</span> <span>Context</span><span>,</span> <span>id</span><span>:</span> <span>Int</span><span>,</span> <span>creationParams</span><span>:</span> <span>Map</span><span>&lt;</span><span>String</span><span>?,</span> <span>Any</span><span>?&gt;?)</span> <span>:</span> <span>PlatformView</span> <span>{</span>
    <span>private</span> <span>val</span> <span>textView</span><span>:</span> <span>TextView</span>

    <span>override</span> <span>fun</span> <span>getView</span><span>():</span> <span>View</span> <span>{</span>
        <span>return</span> <span>textView</span>
    <span>}</span>

    <span>override</span> <span>fun</span> <span>dispose</span><span>()</span> <span>{}</span>

    <span>init</span> <span>{</span>
        <span>textView</span> <span>=</span> <span>TextView</span><span>(</span><span>context</span><span>)</span>
        <span>textView</span><span>.</span><span>textSize</span> <span>=</span> <span>72f</span>
        <span>textView</span><span>.</span><span>setBackgroundColor</span><span>(</span><span>Color</span><span>.</span><span>rgb</span><span>(</span><span>255</span><span>,</span> <span>255</span><span>,</span> <span>255</span><span>))</span>
        <span>textView</span><span>.</span><span>text</span> <span>=</span> <span>"Rendered on a native Android view (id: $id)"</span>
    <span>}</span>
<span>}</span>
```

Create a factory class that creates an instance of the `NativeView` created earlier (for example, `NativeViewFactory.kt`):

```
<span>package</span> <span>dev.flutter.example</span>

<span>import</span> <span>android.content.Context</span>
<span>import</span> <span>io.flutter.plugin.common.StandardMessageCodec</span>
<span>import</span> <span>io.flutter.plugin.platform.PlatformView</span>
<span>import</span> <span>io.flutter.plugin.platform.PlatformViewFactory</span>

<span>class</span> <span>NativeViewFactory</span> <span>:</span> <span>PlatformViewFactory</span><span>(</span><span>StandardMessageCodec</span><span>.</span><span>INSTANCE</span><span>)</span> <span>{</span>
    <span>override</span> <span>fun</span> <span>create</span><span>(</span><span>context</span><span>:</span> <span>Context</span><span>,</span> <span>viewId</span><span>:</span> <span>Int</span><span>,</span> <span>args</span><span>:</span> <span>Any</span><span>?):</span> <span>PlatformView</span> <span>{</span>
        <span>val</span> <span>creationParams</span> <span>=</span> <span>args</span> <span>as</span> <span>Map</span><span>&lt;</span><span>String</span><span>?,</span> <span>Any</span><span>?&gt;?</span>
        <span>return</span> <span>NativeView</span><span>(</span><span>context</span><span>,</span> <span>viewId</span><span>,</span> <span>creationParams</span><span>)</span>
    <span>}</span>
<span>}</span>
```

Finally, register the platform view. You can do this in an app or a plugin.

For app registration, modify the app’s main activity (for example, `MainActivity.kt`):

```
<span>package</span> <span>dev.flutter.example</span>

<span>import</span> <span>io.flutter.embedding.android.FlutterActivity</span>
<span>import</span> <span>io.flutter.embedding.engine.FlutterEngine</span>

<span>class</span> <span>MainActivity</span> <span>:</span> <span>FlutterActivity</span><span>()</span> <span>{</span>
    <span>override</span> <span>fun</span> <span>configureFlutterEngine</span><span>(</span><span>flutterEngine</span><span>:</span> <span>FlutterEngine</span><span>)</span> <span>{</span>
        <span>super</span><span>.</span><span>configureFlutterEngine</span><span>(</span><span>flutterEngine</span><span>)</span>
        <span>flutterEngine</span>
                <span>.</span><span>platformViewsController</span>
                <span>.</span><span>registry</span>
                <span>.</span><span>registerViewFactory</span><span>(</span><span>"&lt;platform-view-type&gt;"</span><span>,</span> 
                                      <span>NativeViewFactory</span><span>())</span>
    <span>}</span>
<span>}</span>
```

For plugin registration, modify the plugin’s main class (for example, `PlatformViewPlugin.kt`):

```
<span>package</span> <span>dev.flutter.plugin.example</span>

<span>import</span> <span>io.flutter.embedding.engine.plugins.FlutterPlugin</span>
<span>import</span> <span>io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding</span>

<span>class</span> <span>PlatformViewPlugin</span> <span>:</span> <span>FlutterPlugin</span> <span>{</span>
    <span>override</span> <span>fun</span> <span>onAttachedToEngine</span><span>(</span><span>binding</span><span>:</span> <span>FlutterPluginBinding</span><span>)</span> <span>{</span>
        <span>binding</span>
                <span>.</span><span>platformViewRegistry</span>
                <span>.</span><span>registerViewFactory</span><span>(</span><span>"&lt;platform-view-type&gt;"</span><span>,</span> <span>NativeViewFactory</span><span>())</span>
    <span>}</span>

    <span>override</span> <span>fun</span> <span>onDetachedFromEngine</span><span>(</span><span>binding</span><span>:</span> <span>FlutterPluginBinding</span><span>)</span> <span>{}</span>
<span>}</span>
```

For more information, see the API docs for:

-   [`FlutterPlugin`](https://api.flutter.dev/javadoc/io/flutter/embedding/engine/plugins/FlutterPlugin.html)
-   [`PlatformViewRegistry`](https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformViewRegistry.html)
-   [`PlatformViewFactory`](https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformViewFactory.html)
-   [`PlatformView`](https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformView.html)

Finally, modify your `build.gradle` file to require one of the minimal Android SDK versions:

```
<span>android</span> <span>{</span>
    <span>defaultConfig</span> <span>{</span>
        <span>minSdkVersion</span> <span>19</span> <span>// if using hybrid composition</span>
        <span>minSdkVersion</span> <span>20</span> <span>// if using virtual display.</span>
    <span>}</span>
<span>}</span>
```

#### Manual view invalidation

Certain Android Views do not invalidate themselves when their content changes. Some example views include `SurfaceView` and `SurfaceTexture`. When your Platform View includes these views you are required to manually invalidate the view after they have been drawn to (or more specifically: after the swap chain is flipped). Manual view invalidation is done by calling `invalidate` on the View or one of its parent views.

## Performance

Platform views in Flutter come with performance trade-offs.

For example, in a typical Flutter app, the Flutter UI is composed on a dedicated raster thread. This allows Flutter apps to be fast, as the main platform thread is rarely blocked.

While a platform view is rendered with hybrid composition, the Flutter UI is composed from the platform thread, which competes with other tasks like handling OS or plugin messages.

Prior to Android 10, hybrid composition copied each Flutter frame out of the graphic memory into main memory, and then copied it back to a GPU texture. As this copy happens per frame, the performance of the entire Flutter UI might be impacted. In Android 10 or above, the graphics memory is copied only once.

Virtual display, on the other hand, makes each pixel of the native view flow through additional intermediate graphic buffers, which cost graphic memory and drawing performance.

For complex cases, there are some techniques that can be used to mitigate these issues.

For example, you could use a placeholder texture while an animation is happening in Dart. In other words, if an animation is slow while a platform view is rendered, then consider taking a screenshot of the native view and rendering it as a texture.

For more information, see:

-   [`TextureLayer`](https://api.flutter.dev/flutter/rendering/TextureLayer-class.html)
-   [`TextureRegistry`](https://api.flutter.dev/javadoc/io/flutter/view/TextureRegistry.html)
-   [`FlutterTextureRegistry`](https://api.flutter.dev/ios-embedder/protocol_flutter_texture_registry-p.html)
-   [`FlutterImageView`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterImageView.html)