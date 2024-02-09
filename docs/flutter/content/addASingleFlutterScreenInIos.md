1.  [Add to app](https://docs.flutter.dev/add-to-app)
2.  [Add Flutter to iOS](https://docs.flutter.dev/add-to-app/ios)
3.  [Add a Flutter screen](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen)

This guide describes how to add a single Flutter screen to an existing iOS app.

## Start a FlutterEngine and FlutterViewController

To launch a Flutter screen from an existing iOS, you start a [`FlutterEngine`](https://api.flutter.dev/ios-embedder/interface_flutter_engine.html) and a [`FlutterViewController`](https://api.flutter.dev/ios-embedder/interface_flutter_view_controller.html).

The `FlutterEngine` might have the same lifespan as your `FlutterViewController` or outlive your `FlutterViewController`.

See [Loading sequence and performance](https://docs.flutter.dev/add-to-app/performance) for more analysis on the latency and memory trade-offs of pre-warming an engine.

### Create a FlutterEngine

Where you create a `FlutterEngine` depends on your host app.

-   [SwiftUI](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#engine-swiftui-tab)
-   [UIKit-Swift](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#engine-uikit-swift-tab)
-   [UIKit-ObjC](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#engine-uikit-objc-tab)

In this example, we create a `FlutterEngine` object inside a SwiftUI `ObservableObject`. We then pass this `FlutterEngine` into a `ContentView` using the `environmentObject()` property.

```
<span>import</span><span> </span><span>SwiftUI</span><span>
 </span><span>import</span><span> </span><span>Flutter</span><span>
 </span><span>// The following library connects plugins with iOS platform code to this app.</span><span>
 </span><span>import</span><span> </span><span>FlutterPluginRegistrant</span><span>

 </span><span>class</span><span> </span><span>FlutterDependencies</span><span>:</span><span> </span><span>ObservableObject</span><span> </span><span>{</span><span>
   </span><span>let</span><span> flutterEngine </span><span>=</span><span> </span><span>FlutterEngine</span><span>(</span><span>name</span><span>:</span><span> </span><span>"my flutter engine"</span><span>)</span><span>
   init</span><span>(){</span><span>
     </span><span>// Runs the default Dart entrypoint with a default Flutter route.</span><span>
     flutterEngine</span><span>.</span><span>run</span><span>()</span><span>
     </span><span>// Connects plugins with iOS platform code to this app.</span><span>
     </span><span>GeneratedPluginRegistrant</span><span>.</span><span>register</span><span>(</span><span>with</span><span>:</span><span> </span><span>self</span><span>.</span><span>flutterEngine</span><span>);</span><span>
   </span><span>}</span><span>
 </span><span>}</span><span>

 </span><span>@main</span><span>
 </span><span>struct</span><span> </span><span>MyApp</span><span>:</span><span> </span><span>App</span><span> </span><span>{</span><span>
   </span><span>// flutterDependencies will be injected using EnvironmentObject.</span><span>
   </span><span>@StateObject</span><span> </span><span>var</span><span> flutterDependencies </span><span>=</span><span> </span><span>FlutterDependencies</span><span>()</span><span>
     </span><span>var</span><span> body</span><span>:</span><span> some </span><span>Scene</span><span> </span><span>{</span><span>
       </span><span>WindowGroup</span><span> </span><span>{</span><span>
         </span><span>ContentView</span><span>().</span><span>environmentObject</span><span>(</span><span>flutterDependencies</span><span>)</span><span>
       </span><span>}</span><span>
     </span><span>}</span><span>
 </span><span>}</span>
```

### Show a FlutterViewController with your FlutterEngine

-   [SwiftUI](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#vc-swiftui-tab)
-   [UIKit-Swift](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#vc-uikit-swift-tab)
-   [UIKit-ObjC](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#vc-uikit-objc-tab)

The following example shows a generic `ContentView` with a `Button` hooked to present a [`FlutterViewController`](https://api.flutter.dev/ios-embedder/interface_flutter_view_controller.html). The `FlutterViewController` constructor takes the pre-warmed `FlutterEngine` as an argument. `FlutterEngine` is passed in as an `EnvironmentObject` via `flutterDependencies`.

```
<span>import</span><span> </span><span>SwiftUI</span><span>
</span><span>import</span><span> </span><span>Flutter</span><span>

</span><span>struct</span><span> </span><span>ContentView</span><span>:</span><span> </span><span>View</span><span> </span><span>{</span><span>
  </span><span>// Flutter dependencies are passed in an EnvironmentObject.</span><span>
  </span><span>@EnvironmentObject</span><span> </span><span>var</span><span> flutterDependencies</span><span>:</span><span> </span><span>FlutterDependencies</span><span>

  </span><span>// Button is created to call the showFlutter function when pressed.</span><span>
  </span><span>var</span><span> body</span><span>:</span><span> some </span><span>View</span><span> </span><span>{</span><span>
    </span><span>Button</span><span>(</span><span>"Show Flutter!"</span><span>)</span><span> </span><span>{</span><span>
      showFlutter</span><span>()</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

func showFlutter</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Get the RootViewController.</span><span>
    guard
      </span><span>let</span><span> windowScene </span><span>=</span><span> </span><span>UIApplication</span><span>.</span><span>shared</span><span>.</span><span>connectedScenes
        </span><span>.</span><span>first</span><span>(</span><span>where</span><span>:</span><span> </span><span>{</span><span> $0</span><span>.</span><span>activationState </span><span>==</span><span> </span><span>.</span><span>foregroundActive </span><span>&amp;&amp;</span><span> $0 </span><span>is</span><span> </span><span>UIWindowScene</span><span> </span><span>})</span><span> </span><span>as</span><span>?</span><span> </span><span>UIWindowScene</span><span>,</span><span>
      </span><span>let</span><span> window </span><span>=</span><span> windowScene</span><span>.</span><span>windows</span><span>.</span><span>first</span><span>(</span><span>where</span><span>:</span><span> \.isKeyWindow</span><span>),</span><span>
      </span><span>let</span><span> rootViewController </span><span>=</span><span> window</span><span>.</span><span>rootViewController
    </span><span>else</span><span> </span><span>{</span><span> </span><span>return</span><span> </span><span>}</span><span>

    </span><span>// Create the FlutterViewController.</span><span>
    </span><span>let</span><span> flutterViewController </span><span>=</span><span> </span><span>FlutterViewController</span><span>(</span><span>
      engine</span><span>:</span><span> flutterDependencies</span><span>.</span><span>flutterEngine</span><span>,</span><span>
      nibName</span><span>:</span><span> </span><span>nil</span><span>,</span><span>
      bundle</span><span>:</span><span> </span><span>nil</span><span>)</span><span>
    flutterViewController</span><span>.</span><span>modalPresentationStyle </span><span>=</span><span> </span><span>.</span><span>overCurrentContext
    flutterViewController</span><span>.</span><span>isViewOpaque </span><span>=</span><span> </span><span>false</span><span>

    rootViewController</span><span>.</span><span>present</span><span>(</span><span>flutterViewController</span><span>,</span><span> animated</span><span>:</span><span> </span><span>true</span><span>)</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Now, you have a Flutter screen embedded in your iOS app.

### _Alternatively_ - Create a FlutterViewController with an implicit FlutterEngine

As an alternative to the previous example, you can let the `FlutterViewController` implicitly create its own `FlutterEngine` without pre-warming one ahead of time.

This is not usually recommended because creating a `FlutterEngine` on-demand could introduce a noticeable latency between when the `FlutterViewController` is presented and when it renders its first frame. This could, however, be useful if the Flutter screen is rarely shown, when there are no good heuristics to determine when the Dart VM should be started, and when Flutter doesn’t need to persist state between view controllers.

To let the `FlutterViewController` present without an existing `FlutterEngine`, omit the `FlutterEngine` construction, and create the `FlutterViewController` without an engine reference.

-   [SwiftUI](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#no-engine-vc-swiftui-tab)
-   [UIKit-Swift](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#no-engine-vc-uikit-swift-tab)
-   [UIKit-ObjC](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#no-engine-vc-uikit-objc-tab)

```
<span>import</span> <span>SwiftUI</span>
<span>import</span> <span>Flutter</span>

<span>struct</span> <span>ContentView</span><span>:</span> <span>View</span> <span>{</span>
  <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>View</span> <span>{</span>
    <span>Button</span><span>(</span><span>"Show Flutter!"</span><span>)</span> <span>{</span>
      <span>openFlutterApp</span><span>()</span>
    <span>}</span>
  <span>}</span>

<span>func</span> <span>openFlutterApp</span><span>()</span> <span>{</span>
    <span>// Get the RootViewController.</span>
    <span>guard</span>
      <span>let</span> <span>windowScene</span> <span>=</span> <span>UIApplication</span><span>.</span><span>shared</span><span>.</span><span>connectedScenes</span>
        <span>.</span><span>first</span><span>(</span><span>where</span><span>:</span> <span>{</span> <span>$0</span><span>.</span><span>activationState</span> <span>==</span> <span>.</span><span>foregroundActive</span> <span>&amp;&amp;</span> <span>$0</span> <span>is</span> <span>UIWindowScene</span> <span>})</span> <span>as?</span> <span>UIWindowScene</span><span>,</span>
      <span>let</span> <span>window</span> <span>=</span> <span>windowScene</span><span>.</span><span>windows</span><span>.</span><span>first</span><span>(</span><span>where</span><span>:</span> <span>\</span><span>.</span><span>isKeyWindow</span><span>),</span>
      <span>let</span> <span>rootViewController</span> <span>=</span> <span>window</span><span>.</span><span>rootViewController</span>
    <span>else</span> <span>{</span> <span>return</span> <span>}</span>

    <span>// Create the FlutterViewController without an existing FlutterEngine.</span>
    <span>let</span> <span>flutterViewController</span> <span>=</span> <span>FlutterViewController</span><span>(</span>
      <span>project</span><span>:</span> <span>nil</span><span>,</span>
      <span>nibName</span><span>:</span> <span>nil</span><span>,</span>
      <span>bundle</span><span>:</span> <span>nil</span><span>)</span>
    <span>flutterViewController</span><span>.</span><span>modalPresentationStyle</span> <span>=</span> <span>.</span><span>overCurrentContext</span>
    <span>flutterViewController</span><span>.</span><span>isViewOpaque</span> <span>=</span> <span>false</span>

    <span>rootViewController</span><span>.</span><span>present</span><span>(</span><span>flutterViewController</span><span>,</span> <span>animated</span><span>:</span> <span>true</span><span>)</span>
  <span>}</span>
<span>}</span>
```

See [Loading sequence and performance](https://docs.flutter.dev/add-to-app/performance) for more explorations on latency and memory usage.

## Using the FlutterAppDelegate

Letting your application’s `UIApplicationDelegate` subclass `FlutterAppDelegate` is recommended but not required.

The `FlutterAppDelegate` performs functions such as:

-   Forwarding application callbacks such as [`openURL`](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application) to plugins such as [local\_auth](https://pub.dev/packages/local_auth).
-   Keeping the Flutter connection open in debug mode when the phone screen locks.

### Creating a FlutterAppDelegate subclass

Creating a subclass of the the `FlutterAppDelegate` in UIKit apps was shown in the [Start a FlutterEngine and FlutterViewController section](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen/#start-a-flutterengine-and-flutterviewcontroller). In a SwiftUI app, you can create a subclass of the `FlutterAppDelegate` that conforms to the `ObservableObject` protocol as follows:

```
<span>import</span> <span>SwiftUI</span>
<span>import</span> <span>Flutter</span>
<span>import</span> <span>FlutterPluginRegistrant</span>

<span>class</span> <span>AppDelegate</span><span>:</span> <span>FlutterAppDelegate</span><span>,</span> <span>ObservableObject</span> <span>{</span>
  <span>let</span> <span>flutterEngine</span> <span>=</span> <span>FlutterEngine</span><span>(</span><span>name</span><span>:</span> <span>"my flutter engine"</span><span>)</span>

  <span>override</span> <span>func</span> <span>application</span><span>(</span>
    <span>_</span> <span>application</span><span>:</span> <span>UIApplication</span><span>,</span>
    <span>didFinishLaunchingWithOptions</span> <span>launchOptions</span><span>:</span> <span>[</span><span>UIApplication</span><span>.</span><span>LaunchOptionsKey</span><span>:</span> <span>Any</span><span>]?)</span> <span>-&gt;</span> <span>Bool</span> <span>{</span>
      <span>// Runs the default Dart entrypoint with a default Flutter route.</span>
      <span>flutterEngine</span><span>.</span><span>run</span><span>();</span>
      <span>// Used to connect plugins (only if you have plugins with iOS platform code).</span>
      <span>GeneratedPluginRegistrant</span><span>.</span><span>register</span><span>(</span><span>with</span><span>:</span> <span>self</span><span>.</span><span>flutterEngine</span><span>);</span>
      <span>return</span> <span>true</span><span>;</span>
    <span>}</span>
<span>}</span>

<span>@main</span>
<span>struct</span> <span>MyApp</span><span>:</span> <span>App</span> <span>{</span>
<span>//  Use this property wrapper to tell SwiftUI</span>
<span>//  it should use the AppDelegate class for the application delegate</span>
  <span>@UIApplicationDelegateAdaptor</span><span>(</span><span>AppDelegate</span><span>.</span><span>self</span><span>)</span> <span>var</span> <span>appDelegate</span>

  <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>Scene</span> <span>{</span>
      <span>WindowGroup</span> <span>{</span>
        <span>ContentView</span><span>()</span>
      <span>}</span>
  <span>}</span>
<span>}</span>
```

Then, in your view, the `AppDelegate`is accessible as an `EnvironmentObject`.

```
<span>import</span> <span>SwiftUI</span>
<span>import</span> <span>Flutter</span>

<span>struct</span> <span>ContentView</span><span>:</span> <span>View</span> <span>{</span>
  <span>// Access the AppDelegate using an EnvironmentObject.</span>
  <span>@EnvironmentObject</span> <span>var</span> <span>appDelegate</span><span>:</span> <span>AppDelegate</span>

  <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>View</span> <span>{</span>
    <span>Button</span><span>(</span><span>"Show Flutter!"</span><span>)</span> <span>{</span>
      <span>openFlutterApp</span><span>()</span>
    <span>}</span>
  <span>}</span>

<span>func</span> <span>openFlutterApp</span><span>()</span> <span>{</span>
    <span>// Get the RootViewController.</span>
    <span>guard</span>
      <span>let</span> <span>windowScene</span> <span>=</span> <span>UIApplication</span><span>.</span><span>shared</span><span>.</span><span>connectedScenes</span>
        <span>.</span><span>first</span><span>(</span><span>where</span><span>:</span> <span>{</span> <span>$0</span><span>.</span><span>activationState</span> <span>==</span> <span>.</span><span>foregroundActive</span> <span>&amp;&amp;</span> <span>$0</span> <span>is</span> <span>UIWindowScene</span> <span>})</span> <span>as?</span> <span>UIWindowScene</span><span>,</span>
      <span>let</span> <span>window</span> <span>=</span> <span>windowScene</span><span>.</span><span>windows</span><span>.</span><span>first</span><span>(</span><span>where</span><span>:</span> <span>\</span><span>.</span><span>isKeyWindow</span><span>),</span>
      <span>let</span> <span>rootViewController</span> <span>=</span> <span>window</span><span>.</span><span>rootViewController</span>
    <span>else</span> <span>{</span> <span>return</span> <span>}</span>

    <span>// Create the FlutterViewController.</span>
    <span>let</span> <span>flutterViewController</span> <span>=</span> <span>FlutterViewController</span><span>(</span>
      <span>// Access the Flutter Engine via AppDelegate.</span>
      <span>engine</span><span>:</span> <span>appDelegate</span><span>.</span><span>flutterEngine</span><span>,</span>
      <span>nibName</span><span>:</span> <span>nil</span><span>,</span>
      <span>bundle</span><span>:</span> <span>nil</span><span>)</span>
    <span>flutterViewController</span><span>.</span><span>modalPresentationStyle</span> <span>=</span> <span>.</span><span>overCurrentContext</span>
    <span>flutterViewController</span><span>.</span><span>isViewOpaque</span> <span>=</span> <span>false</span>

    <span>rootViewController</span><span>.</span><span>present</span><span>(</span><span>flutterViewController</span><span>,</span> <span>animated</span><span>:</span> <span>true</span><span>)</span>
  <span>}</span>
<span>}</span>

```

### If you can’t directly make FlutterAppDelegate a subclass

If your app delegate can’t directly make `FlutterAppDelegate` a subclass, make your app delegate implement the `FlutterAppLifeCycleProvider` protocol in order to make sure your plugins receive the necessary callbacks. Otherwise, plugins that depend on these events might have undefined behavior.

For instance:

-   [Swift](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#app-delegate-swift-tab)
-   [Objective-C](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#app-delegate-objective-c-tab)

```
<span>import</span><span> </span><span>Foundation</span><span>
</span><span>import</span><span> </span><span>Flutter</span><span>

</span><span>class</span><span> </span><span>AppDelegate</span><span>:</span><span> </span><span>UIResponder</span><span>,</span><span> </span><span>UIApplicationDelegate</span><span>,</span><span> </span><span>FlutterAppLifeCycleProvider</span><span>,</span><span> </span><span>ObservableObject</span><span> </span><span>{</span><span>

  </span><span>private</span><span> </span><span>let</span><span> lifecycleDelegate </span><span>=</span><span> </span><span>FlutterPluginAppLifeCycleDelegate</span><span>()</span><span>

  </span><span>let</span><span> flutterEngine </span><span>=</span><span> </span><span>FlutterEngine</span><span>(</span><span>name</span><span>:</span><span> </span><span>"flutter_nps_engine"</span><span>)</span><span>

  </span><span>override</span><span> func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> didFinishLaunchingWithOptions launchOptions</span><span>:</span><span> </span><span>[</span><span>UIApplication</span><span>.</span><span>LaunchOptionsKey</span><span> </span><span>:</span><span> </span><span>Any</span><span>]?</span><span> </span><span>=</span><span> </span><span>nil</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Bool</span><span> </span><span>{</span><span>
  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> didFinishLaunchingWithOptions launchOptions</span><span>:</span><span> </span><span>[</span><span>UIApplication</span><span>.</span><span>LaunchOptionsKey</span><span> </span><span>:</span><span> </span><span>Any</span><span>]?</span><span> </span><span>=</span><span> </span><span>nil</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Bool</span><span> </span><span>{</span><span>
    flutterEngine</span><span>.</span><span>run</span><span>()</span><span>
    </span><span>return</span><span> lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> didFinishLaunchingWithOptions</span><span>:</span><span> launchOptions </span><span>??</span><span> </span><span>[:])</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> didRegisterForRemoteNotificationsWithDeviceToken deviceToken</span><span>:</span><span> </span><span>Data</span><span>)</span><span> </span><span>{</span><span>
    lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> didRegisterForRemoteNotificationsWithDeviceToken</span><span>:</span><span> deviceToken</span><span>)</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> didFailToRegisterForRemoteNotificationsWithError error</span><span>:</span><span> </span><span>Error</span><span>)</span><span> </span><span>{</span><span>
    lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> didFailToRegisterForRemoteNotificationsWithError</span><span>:</span><span> error</span><span>)</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> didReceiveRemoteNotification userInfo</span><span>:</span><span> </span><span>[</span><span>AnyHashable</span><span> </span><span>:</span><span> </span><span>Any</span><span>],</span><span> fetchCompletionHandler completionHandler</span><span>:</span><span> </span><span>@escaping</span><span> </span><span>(</span><span>UIBackgroundFetchResult</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Void</span><span>)</span><span> </span><span>{</span><span>
    lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> didReceiveRemoteNotification</span><span>:</span><span> userInfo</span><span>,</span><span> fetchCompletionHandler</span><span>:</span><span> completionHandler</span><span>)</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ app</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> open url</span><span>:</span><span> URL</span><span>,</span><span> options</span><span>:</span><span> </span><span>[</span><span>UIApplication</span><span>.</span><span>OpenURLOptionsKey</span><span> </span><span>:</span><span> </span><span>Any</span><span>]</span><span> </span><span>=</span><span> </span><span>[:])</span><span> </span><span>-&gt;</span><span> </span><span>Bool</span><span> </span><span>{</span><span>
    </span><span>return</span><span> lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>app</span><span>,</span><span> open</span><span>:</span><span> url</span><span>,</span><span> options</span><span>:</span><span> options</span><span>)</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> handleOpen url</span><span>:</span><span> URL</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Bool</span><span> </span><span>{</span><span>
    </span><span>return</span><span> lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> handleOpen</span><span>:</span><span> url</span><span>)</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> open url</span><span>:</span><span> URL</span><span>,</span><span> sourceApplication</span><span>:</span><span> </span><span>String</span><span>?,</span><span> annotation</span><span>:</span><span> </span><span>Any</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Bool</span><span> </span><span>{</span><span>
    </span><span>return</span><span> lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> open</span><span>:</span><span> url</span><span>,</span><span> sourceApplication</span><span>:</span><span> sourceApplication </span><span>??</span><span> </span><span>""</span><span>,</span><span> annotation</span><span>:</span><span> annotation</span><span>)</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> performActionFor shortcutItem</span><span>:</span><span> </span><span>UIApplicationShortcutItem</span><span>,</span><span> completionHandler</span><span>:</span><span> </span><span>@escaping</span><span> </span><span>(</span><span>Bool</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Void</span><span>)</span><span> </span><span>{</span><span>
    lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> performActionFor</span><span>:</span><span> shortcutItem</span><span>,</span><span> completionHandler</span><span>:</span><span> completionHandler</span><span>)</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> handleEventsForBackgroundURLSession identifier</span><span>:</span><span> </span><span>String</span><span>,</span><span> completionHandler</span><span>:</span><span> </span><span>@escaping</span><span> </span><span>()</span><span> </span><span>-&gt;</span><span> </span><span>Void</span><span>)</span><span> </span><span>{</span><span>
    lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> handleEventsForBackgroundURLSession</span><span>:</span><span> identifier</span><span>,</span><span> completionHandler</span><span>:</span><span> completionHandler</span><span>)</span><span>
  </span><span>}</span><span>

  func application</span><span>(</span><span>_ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span> performFetchWithCompletionHandler completionHandler</span><span>:</span><span> </span><span>@escaping</span><span> </span><span>(</span><span>UIBackgroundFetchResult</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Void</span><span>)</span><span> </span><span>{</span><span>
    lifecycleDelegate</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> performFetchWithCompletionHandler</span><span>:</span><span> completionHandler</span><span>)</span><span>
  </span><span>}</span><span>

  func </span><span>add</span><span>(</span><span>_ </span><span>delegate</span><span>:</span><span> </span><span>FlutterApplicationLifeCycleDelegate</span><span>)</span><span> </span><span>{</span><span>
    lifecycleDelegate</span><span>.</span><span>add</span><span>(</span><span>delegate</span><span>)</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Launch options

The examples demonstrate running Flutter using the default launch settings.

In order to customize your Flutter runtime, you can also specify the Dart entrypoint, library, and route.

### Dart entrypoint

Calling `run` on a `FlutterEngine`, by default, runs the `main()` Dart function of your `lib/main.dart` file.

You can also run a different entrypoint function by using [`runWithEntrypoint`](https://api.flutter.dev/ios-embedder/interface_flutter_engine.html#a019d6b3037eff6cfd584fb2eb8e9035e) with an `NSString` specifying a different Dart function.

### Dart library

In addition to specifying a Dart function, you can specify an entrypoint function in a specific file.

For instance the following runs `myOtherEntrypoint()` in `lib/other_file.dart` instead of `main()` in `lib/main.dart`:

-   [Swift](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#entrypoint-library-swift-tab)
-   [Objective-C](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#entrypoint-library-objective-c-tab)

```
<span>flutterEngine</span><span>.</span><span>run</span><span>(</span><span>withEntrypoint</span><span>:</span> <span>"myOtherEntrypoint"</span><span>,</span> <span>libraryURI</span><span>:</span> <span>"other_file.dart"</span><span>)</span>
```

### Route

Starting in Flutter version 1.22, an initial route can be set for your Flutter [`WidgetsApp`](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html) when constructing the FlutterEngine or the FlutterViewController.

-   [Swift](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#initial-route-swift-tab)
-   [Objective-C](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#initial-route-objective-c-tab)

```
<span>let</span> <span>flutterEngine</span> <span>=</span> <span>FlutterEngine</span><span>()</span>
<span>// FlutterDefaultDartEntrypoint is the same as nil, which will run main().</span>
<span>engine</span><span>.</span><span>run</span><span>(</span>
  <span>withEntrypoint</span><span>:</span> <span>"main"</span><span>,</span> <span>initialRoute</span><span>:</span> <span>"/onboarding"</span><span>)</span>
```

This code sets your `dart:ui`’s [`window.defaultRouteName`](https://api.flutter.dev/flutter/dart-ui/SingletonFlutterWindow/defaultRouteName.html) to `"/onboarding"` instead of `"/"`.

Alternatively, to construct a FlutterViewController directly without pre-warming a FlutterEngine:

-   [Swift](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#initial-route-without-pre-warming-swift-tab)
-   [Objective-C](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen#initial-route-without-pre-warming-objective-c-tab)

```
<span>let</span> <span>flutterViewController</span> <span>=</span> <span>FlutterViewController</span><span>(</span>
      <span>project</span><span>:</span> <span>nil</span><span>,</span> <span>initialRoute</span><span>:</span> <span>"/onboarding"</span><span>,</span> <span>nibName</span><span>:</span> <span>nil</span><span>,</span> <span>bundle</span><span>:</span> <span>nil</span><span>)</span>
```

See [Navigation and routing](https://docs.flutter.dev/ui/navigation) for more about Flutter’s routes.

### Other

The previous example only illustrates a few ways to customize how a Flutter instance is initiated. Using [platform channels](https://docs.flutter.dev/platform-integration/platform-channels), you’re free to push data or prepare your Flutter environment in any way you’d like, before presenting the Flutter UI using a `FlutterViewController`.