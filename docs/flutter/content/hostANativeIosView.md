1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [iOS](https://docs.flutter.dev/platform-integration/ios)
3.  [iOS platform-views](https://docs.flutter.dev/platform-integration/ios/platform-views)

Platform views allow you to embed native views in a Flutter app, so you can apply transforms, clips, and opacity to the native view from Dart.

This allows you, for example, to use the native Google Maps from the Android and iOS SDKs directly inside your Flutter app.

iOS only uses Hybrid composition, which means that the native `UIView` is appended to the view hierarchy.

To create a platform view on iOS, use the following instructions:

### On the Dart side

On the Dart side, create a `Widget` and add the build implementation, as shown in the following steps.

In the Dart widget file, make changes similar to those shown in `native_view_example.dart`:

1.  Add the following imports:
    
    ```
    <span>import</span><span> </span><span>'package:flutter/foundation.dart'</span><span>;</span><span>
    </span><span>import</span><span> </span><span>'package:flutter/services.dart'</span><span>;</span>
    ```
    
2.  Implement a `build()` method:
    
    ```
    <span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// This is used in the platform side to register the view.</span><span>
      </span><span>const</span><span> </span><span>String</span><span> viewType </span><span>=</span><span> </span><span>'&lt;platform-view-type&gt;'</span><span>;</span><span>
      </span><span>// Pass parameters to the platform side.</span><span>
      </span><span>final</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> creationParams </span><span>=</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;{};</span><span>
    
      </span><span>return</span><span> </span><span>UiKitView</span><span>(</span><span>
        viewType</span><span>:</span><span> viewType</span><span>,</span><span>
        layoutDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
        creationParams</span><span>:</span><span> creationParams</span><span>,</span><span>
        creationParamsCodec</span><span>:</span><span> </span><span>const</span><span> </span><span>StandardMessageCodec</span><span>(),</span><span>
      </span><span>);</span><span>
    </span><span>}</span>
    ```
    

For more information, see the API docs for: [`UIKitView`](https://api.flutter.dev/flutter/widgets/UiKitView-class.html).

### On the platform side

On the platform side, use either Swift or Objective-C:

-   [Swift](https://docs.flutter.dev/platform-integration/ios/platform-views#ios-platform-views-swift-tab)
-   [Objective-C](https://docs.flutter.dev/platform-integration/ios/platform-views#ios-platform-views-objective-c-tab)

Implement the factory and the platform view. The `FLNativeViewFactory` creates the platform view, and the platform view provides a reference to the `UIView`. For example, `FLNativeView.swift`:

```
<span>import</span> <span>Flutter</span>
<span>import</span> <span>UIKit</span>

<span>class</span> <span>FLNativeViewFactory</span><span>:</span> <span>NSObject</span><span>,</span> <span>FlutterPlatformViewFactory</span> <span>{</span>
    <span>private</span> <span>var</span> <span>messenger</span><span>:</span> <span>FlutterBinaryMessenger</span>

    <span>init</span><span>(</span><span>messenger</span><span>:</span> <span>FlutterBinaryMessenger</span><span>)</span> <span>{</span>
        <span>self</span><span>.</span><span>messenger</span> <span>=</span> <span>messenger</span>
        <span>super</span><span>.</span><span>init</span><span>()</span>
    <span>}</span>

    <span>func</span> <span>create</span><span>(</span>
        <span>withFrame</span> <span>frame</span><span>:</span> <span>CGRect</span><span>,</span>
        <span>viewIdentifier</span> <span>viewId</span><span>:</span> <span>Int64</span><span>,</span>
        <span>arguments</span> <span>args</span><span>:</span> <span>Any</span><span>?</span>
    <span>)</span> <span>-&gt;</span> <span>FlutterPlatformView</span> <span>{</span>
        <span>return</span> <span>FLNativeView</span><span>(</span>
            <span>frame</span><span>:</span> <span>frame</span><span>,</span>
            <span>viewIdentifier</span><span>:</span> <span>viewId</span><span>,</span>
            <span>arguments</span><span>:</span> <span>args</span><span>,</span>
            <span>binaryMessenger</span><span>:</span> <span>messenger</span><span>)</span>
    <span>}</span>

    <span>/// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.</span>
    <span>public</span> <span>func</span> <span>createArgsCodec</span><span>()</span> <span>-&gt;</span> <span>FlutterMessageCodec</span> <span>&amp;</span> <span>NSObjectProtocol</span> <span>{</span>
          <span>return</span> <span>FlutterStandardMessageCodec</span><span>.</span><span>sharedInstance</span><span>()</span>
    <span>}</span>
<span>}</span>

<span>class</span> <span>FLNativeView</span><span>:</span> <span>NSObject</span><span>,</span> <span>FlutterPlatformView</span> <span>{</span>
    <span>private</span> <span>var</span> <span>_view</span><span>:</span> <span>UIView</span>

    <span>init</span><span>(</span>
        <span>frame</span><span>:</span> <span>CGRect</span><span>,</span>
        <span>viewIdentifier</span> <span>viewId</span><span>:</span> <span>Int64</span><span>,</span>
        <span>arguments</span> <span>args</span><span>:</span> <span>Any</span><span>?,</span>
        <span>binaryMessenger</span> <span>messenger</span><span>:</span> <span>FlutterBinaryMessenger</span><span>?</span>
    <span>)</span> <span>{</span>
        <span>_view</span> <span>=</span> <span>UIView</span><span>()</span>
        <span>super</span><span>.</span><span>init</span><span>()</span>
        <span>// iOS views can be created here</span>
        <span>createNativeView</span><span>(</span><span>view</span><span>:</span> <span>_view</span><span>)</span>
    <span>}</span>

    <span>func</span> <span>view</span><span>()</span> <span>-&gt;</span> <span>UIView</span> <span>{</span>
        <span>return</span> <span>_view</span>
    <span>}</span>

    <span>func</span> <span>createNativeView</span><span>(</span><span>view</span> <span>_view</span><span>:</span> <span>UIView</span><span>){</span>
        <span>_view</span><span>.</span><span>backgroundColor</span> <span>=</span> <span>UIColor</span><span>.</span><span>blue</span>
        <span>let</span> <span>nativeLabel</span> <span>=</span> <span>UILabel</span><span>()</span>
        <span>nativeLabel</span><span>.</span><span>text</span> <span>=</span> <span>"Native text from iOS"</span>
        <span>nativeLabel</span><span>.</span><span>textColor</span> <span>=</span> <span>UIColor</span><span>.</span><span>white</span>
        <span>nativeLabel</span><span>.</span><span>textAlignment</span> <span>=</span> <span>.</span><span>center</span>
        <span>nativeLabel</span><span>.</span><span>frame</span> <span>=</span> <span>CGRect</span><span>(</span><span>x</span><span>:</span> <span>0</span><span>,</span> <span>y</span><span>:</span> <span>0</span><span>,</span> <span>width</span><span>:</span> <span>180</span><span>,</span> <span>height</span><span>:</span> <span>48.0</span><span>)</span>
        <span>_view</span><span>.</span><span>addSubview</span><span>(</span><span>nativeLabel</span><span>)</span>
    <span>}</span>
<span>}</span>
```

Finally, register the platform view. This can be done in an app or a plugin.

For app registration, modify the App’s `AppDelegate.swift`:

```
<span>import</span> <span>Flutter</span>
<span>import</span> <span>UIKit</span>

<span>@UIApplicationMain</span>
<span>@objc</span> <span>class</span> <span>AppDelegate</span><span>:</span> <span>FlutterAppDelegate</span> <span>{</span>
    <span>override</span> <span>func</span> <span>application</span><span>(</span>
        <span>_</span> <span>application</span><span>:</span> <span>UIApplication</span><span>,</span>
        <span>didFinishLaunchingWithOptions</span> <span>launchOptions</span><span>:</span> <span>[</span><span>UIApplication</span><span>.</span><span>LaunchOptionsKey</span> <span>:</span> <span>Any</span><span>]?</span>
    <span>)</span> <span>-&gt;</span> <span>Bool</span> <span>{</span>
        <span>GeneratedPluginRegistrant</span><span>.</span><span>register</span><span>(</span><span>with</span><span>:</span> <span>self</span><span>)</span>

        <span>weak</span> <span>var</span> <span>registrar</span> <span>=</span> <span>self</span><span>.</span><span>registrar</span><span>(</span><span>forPlugin</span><span>:</span> <span>"plugin-name"</span><span>)</span>

        <span>let</span> <span>factory</span> <span>=</span> <span>FLNativeViewFactory</span><span>(</span><span>messenger</span><span>:</span> <span>registrar</span><span>!.</span><span>messenger</span><span>())</span>
        <span>self</span><span>.</span><span>registrar</span><span>(</span><span>forPlugin</span><span>:</span> <span>"&lt;plugin-name&gt;"</span><span>)</span><span>!.</span><span>register</span><span>(</span>
            <span>factory</span><span>,</span>
            <span>withId</span><span>:</span> <span>"&lt;platform-view-type&gt;"</span><span>)</span>
        <span>return</span> <span>super</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span> <span>didFinishLaunchingWithOptions</span><span>:</span> <span>launchOptions</span><span>)</span>
    <span>}</span>
<span>}</span>
```

For plugin registration, modify the plugin’s main file (for example, `FLPlugin.swift`):

```
<span>import</span> <span>Flutter</span>
<span>import</span> <span>UIKit</span>

<span>class</span> <span>FLPlugin</span><span>:</span> <span>NSObject</span><span>,</span> <span>FlutterPlugin</span> <span>{</span>
    <span>public</span> <span>static</span> <span>func</span> <span>register</span><span>(</span><span>with</span> <span>registrar</span><span>:</span> <span>FlutterPluginRegistrar</span><span>)</span> <span>{</span>
        <span>let</span> <span>factory</span> <span>=</span> <span>FLNativeViewFactory</span><span>(</span><span>messenger</span><span>:</span> <span>registrar</span><span>.</span><span>messenger</span><span>())</span>
        <span>registrar</span><span>.</span><span>register</span><span>(</span><span>factory</span><span>,</span> <span>withId</span><span>:</span> <span>"&lt;platform-view-type&gt;"</span><span>)</span>
    <span>}</span>
<span>}</span>
```

For more information, see the API docs for:

-   [`FlutterPlatformViewFactory`](https://api.flutter.dev/ios-embedder/protocol_flutter_platform_view_factory-p.html)
-   [`FlutterPlatformView`](https://api.flutter.dev/ios-embedder/protocol_flutter_platform_view-p.html)
-   [`PlatformView`](https://api.flutter.dev/javadoc/io/flutter/plugin/platform/PlatformView.html)

## Putting it together

When implementing the `build()` method in Dart, you can use [`defaultTargetPlatform`](https://api.flutter.dev/flutter/foundation/defaultTargetPlatform.html) to detect the platform, and decide which widget to use:

```
<span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>// This is used in the platform side to register the view.</span><span>
  </span><span>const</span><span> </span><span>String</span><span> viewType </span><span>=</span><span> </span><span>'&lt;platform-view-type&gt;'</span><span>;</span><span>
  </span><span>// Pass parameters to the platform side.</span><span>
  </span><span>final</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> creationParams </span><span>=</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;{};</span><span>

  </span><span>switch</span><span> </span><span>(</span><span>defaultTargetPlatform</span><span>)</span><span> </span><span>{</span><span>
    </span><span>case</span><span> </span><span>TargetPlatform</span><span>.</span><span>android</span><span>:</span><span>
    </span><span>// return widget on Android.</span><span>
    </span><span>case</span><span> </span><span>TargetPlatform</span><span>.</span><span>iOS</span><span>:</span><span>
    </span><span>// return widget on iOS.</span><span>
    </span><span>default</span><span>:</span><span>
      </span><span>throw</span><span> </span><span>UnsupportedError</span><span>(</span><span>'Unsupported platform view'</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Performance

Platform views in Flutter come with performance trade-offs.

For example, in a typical Flutter app, the Flutter UI is composed on a dedicated raster thread. This allows Flutter apps to be fast, as the main platform thread is rarely blocked.

When a platform view is rendered with hybrid composition, the Flutter UI is composed from the platform thread. The platform thread competes with other tasks like handling OS or plugin messages.

When an iOS PlatformView is on screen, the screen refresh rate is capped at 80fps to avoid rendering janks.

For complex cases, there are some techniques that can be used to mitigate performance issues.

For example, you could use a placeholder texture while an animation is happening in Dart. In other words, if an animation is slow while a platform view is rendered, then consider taking a screenshot of the native view and rendering it as a texture.

## Composition limitations

There are some limitations when composing iOS Platform Views.

-   The [`ShaderMask`](https://api.flutter.dev/flutter/foundation/ShaderMask.html) and [`ColorFiltered`](https://api.flutter.dev/flutter/foundation/ColorFiltered.html) widgets are not supported.
-   The [`BackdropFilter`](https://api.flutter.dev/flutter/foundation/BackdropFilter.html) widget is supported, but there are some limitations on how it can be used. For more details, check out the [iOS Platform View Backdrop Filter Blur design doc](https://flutter.dev/go/ios-platformview-backdrop-filter-blur).