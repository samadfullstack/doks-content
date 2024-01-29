1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Platform-specific code](https://docs.flutter.dev/platform-integration/platform-channels)

This guide describes how to write custom platform-specific code. Some platform-specific functionality is available through existing packages; see [using packages](https://docs.flutter.dev/packages-and-plugins/using-packages).

Flutter uses a flexible system that allows you to call platform-specific APIs in a language that works directly with those APIs:

-   Kotlin or Java on Android
-   Swift or Objective-C on iOS
-   C++ on Windows
-   Objective-C on macOS
-   C on Linux

Flutter’s builtin platform-specific API support doesn’t rely on code generation, but rather on a flexible message passing style. Alternatively, you can use the [Pigeon](https://pub.dev/packages/pigeon) package for [sending structured typesafe messages](https://docs.flutter.dev/platform-integration/platform-channels#pigeon) with code generation:

-   The Flutter portion of the app sends messages to its _host_, the non-Dart portion of the app, over a platform channel.
    
-   The _host_ listens on the platform channel, and receives the message. It then calls into any number of platform-specific APIs—using the native programming language—and sends a response back to the _client_, the Flutter portion of the app.
    

## Architectural overview: platform channels

Messages are passed between the client (UI) and host (platform) using platform channels as illustrated in this diagram:

![Platform channels architecture](https://docs.flutter.dev/assets/images/docs/PlatformChannels.png)

Messages and responses are passed asynchronously, to ensure the user interface remains responsive.

On the client side, [`MethodChannel`](https://api.flutter.dev/flutter/services/MethodChannel-class.html) enables sending messages that correspond to method calls. On the platform side, `MethodChannel` on Android ([`MethodChannelAndroid`](https://api.flutter.dev/javadoc/io/flutter/plugin/common/MethodChannel.html)) and `FlutterMethodChannel` on iOS ([`MethodChanneliOS`](https://api.flutter.dev/ios-embedder/interface_flutter_method_channel.html)) enable receiving method calls and sending back a result. These classes allow you to develop a platform plugin with very little ‘boilerplate’ code.

### Platform channel data types support and codecs

The standard platform channels use a standard message codec that supports efficient binary serialization of simple JSON-like values, such as booleans, numbers, Strings, byte buffers, and Lists and Maps of these (see [`StandardMessageCodec`](https://api.flutter.dev/flutter/services/StandardMessageCodec-class.html) for details). The serialization and deserialization of these values to and from messages happens automatically when you send and receive values.

The following table shows how Dart values are received on the platform side and vice versa:

-   [Java](https://docs.flutter.dev/platform-integration/platform-channels#type-mappings-java-tab)
-   [Kotlin](https://docs.flutter.dev/platform-integration/platform-channels#type-mappings-kotlin-tab)
-   [Obj-C](https://docs.flutter.dev/platform-integration/platform-channels#type-mappings-obj-c-tab)
-   [Swift](https://docs.flutter.dev/platform-integration/platform-channels#type-mappings-swift-tab)
-   [C++](https://docs.flutter.dev/platform-integration/platform-channels#type-mappings-c-plus-plus-tab)
-   [C](https://docs.flutter.dev/platform-integration/platform-channels#type-mappings-c-tab)

| Dart | Java |
| --- | --- |
| null | null |
| bool | java.lang.Boolean |
| int | java.lang.Integer |
| int, if 32 bits not enough | java.lang.Long |
| double | java.lang.Double |
| String | java.lang.String |
| Uint8List | byte\[\] |
| Int32List | int\[\] |
| Int64List | long\[\] |
| Float32List | float\[\] |
| Float64List | double\[\] |
| List | java.util.ArrayList |
| Map | java.util.HashMap |

## Example: Calling platform-specific code using platform channels

The following code demonstrates how to call a platform-specific API to retrieve and display the current battery level. It uses the Android `BatteryManager` API, the iOS `device.batteryLevel` API, the Windows `GetSystemPowerStatus` API, and the Linux `UPower` API with a single platform message, `getBatteryLevel()`.

The example adds the platform-specific code inside the main app itself. If you want to reuse the platform-specific code for multiple apps, the project creation step is slightly different (see [developing packages](https://docs.flutter.dev/packages-and-plugins/developing-packages#plugin)), but the platform channel code is still written in the same way.

### Step 1: Create a new app project

Start by creating a new app:

-   In a terminal run: `flutter create batterylevel`

By default, our template supports writing Android code using Kotlin, or iOS code using Swift. To use Java or Objective-C, use the `-i` and/or `-a` flags:

-   In a terminal run: `flutter create -i objc -a java batterylevel`

### Step 2: Create the Flutter platform client

The app’s `State` class holds the current app state. Extend that to hold the current battery state.

First, construct the channel. Use a `MethodChannel` with a single platform method that returns the battery level.

The client and host sides of a channel are connected through a channel name passed in the channel constructor. All channel names used in a single app must be unique; prefix the channel name with a unique ‘domain prefix’, for example: `samples.flutter.dev/battery`.

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/services.dart'</span><span>;</span>
```

```
<span>class</span><span> _MyHomePageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> platform </span><span>=</span><span> </span><span>MethodChannel</span><span>(</span><span>'samples.flutter.dev/battery'</span><span>);</span><span>
  </span><span>// Get battery level.</span>
```

Next, invoke a method on the method channel, specifying the concrete method to call using the `String` identifier `getBatteryLevel`. The call might fail—for example, if the platform doesn’t support the platform API (such as when running in a simulator), so wrap the `invokeMethod` call in a try-catch statement.

Use the returned result to update the user interface state in `_batteryLevel` inside `setState`.

```
<span>// Get battery level.</span><span>
</span><span>String</span><span> _batteryLevel </span><span>=</span><span> </span><span>'Unknown battery level.'</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _getBatteryLevel</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>String</span><span> batteryLevel</span><span>;</span><span>
  </span><span>try</span><span> </span><span>{</span><span>
    </span><span>final</span><span> result </span><span>=</span><span> </span><span>await</span><span> platform</span><span>.</span><span>invokeMethod</span><span>&lt;</span><span>int</span><span>&gt;(</span><span>'getBatteryLevel'</span><span>);</span><span>
    batteryLevel </span><span>=</span><span> </span><span>'Battery level at $result % .'</span><span>;</span><span>
  </span><span>}</span><span> </span><span>on</span><span> </span><span>PlatformException</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
    batteryLevel </span><span>=</span><span> </span><span>"Failed to get battery level: '${e.message}'."</span><span>;</span><span>
  </span><span>}</span><span>

  setState</span><span>(()</span><span> </span><span>{</span><span>
    _batteryLevel </span><span>=</span><span> batteryLevel</span><span>;</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

Finally, replace the `build` method from the template to contain a small user interface that displays the battery state in a string, and a button for refreshing the value.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Material</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>spaceEvenly</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>ElevatedButton</span><span>(</span><span>
            onPressed</span><span>:</span><span> _getBatteryLevel</span><span>,</span><span>
            child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Get Battery Level'</span><span>),</span><span>
          </span><span>),</span><span>
          </span><span>Text</span><span>(</span><span>_batteryLevel</span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

### Step 3: Add an Android platform-specific implementation

-   [Kotlin](https://docs.flutter.dev/platform-integration/platform-channels#android-channel-kotlin-tab)
-   [Java](https://docs.flutter.dev/platform-integration/platform-channels#android-channel-java-tab)

Start by opening the Android host portion of your Flutter app in Android Studio:

1.  Start Android Studio
    
2.  Select the menu item **File > Open…**
    
3.  Navigate to the directory holding your Flutter app, and select the **android** folder inside it. Click **OK**.
    
4.  Open the file `MainActivity.kt` located in the **kotlin** folder in the Project view.
    

Inside the `configureFlutterEngine()` method, create a `MethodChannel` and call `setMethodCallHandler()`. Make sure to use the same channel name as was used on the Flutter client side.

```
<span>import</span><span> androidx</span><span>.</span><span>annotation</span><span>.</span><span>NonNull</span><span>
</span><span>import</span><span> io</span><span>.</span><span>flutter</span><span>.</span><span>embedding</span><span>.</span><span>android</span><span>.</span><span>FlutterActivity</span><span>
</span><span>import</span><span> io</span><span>.</span><span>flutter</span><span>.</span><span>embedding</span><span>.</span><span>engine</span><span>.</span><span>FlutterEngine</span><span>
</span><span>import</span><span> io</span><span>.</span><span>flutter</span><span>.</span><span>plugin</span><span>.</span><span>common</span><span>.</span><span>MethodChannel</span><span>

</span><span>class</span><span> </span><span>MainActivity</span><span>:</span><span> </span><span>FlutterActivity</span><span>()</span><span> </span><span>{</span><span>
  </span><span>private</span><span> val CHANNEL </span><span>=</span><span> </span><span>"samples.flutter.dev/battery"</span><span>

  </span><span>override</span><span> fun configureFlutterEngine</span><span>(</span><span>@NonNull</span><span> flutterEngine</span><span>:</span><span> </span><span>FlutterEngine</span><span>)</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>configureFlutterEngine</span><span>(</span><span>flutterEngine</span><span>)</span><span>
    </span><span>MethodChannel</span><span>(</span><span>flutterEngine</span><span>.</span><span>dartExecutor</span><span>.</span><span>binaryMessenger</span><span>,</span><span> CHANNEL</span><span>).</span><span>setMethodCallHandler </span><span>{</span><span>
      call</span><span>,</span><span> result </span><span>-&gt;</span><span>
      </span><span>// This method is invoked on the main thread.</span><span>
      </span><span>// TODO</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Add the Android Kotlin code that uses the Android battery APIs to retrieve the battery level. This code is exactly the same as you would write in a native Android app.

First, add the needed imports at the top of the file:

```
<span>import</span><span> android</span><span>.</span><span>content</span><span>.</span><span>Context</span><span>
</span><span>import</span><span> android</span><span>.</span><span>content</span><span>.</span><span>ContextWrapper</span><span>
</span><span>import</span><span> android</span><span>.</span><span>content</span><span>.</span><span>Intent</span><span>
</span><span>import</span><span> android</span><span>.</span><span>content</span><span>.</span><span>IntentFilter</span><span>
</span><span>import</span><span> android</span><span>.</span><span>os</span><span>.</span><span>BatteryManager</span><span>
</span><span>import</span><span> android</span><span>.</span><span>os</span><span>.</span><span>Build</span><span>.</span><span>VERSION
</span><span>import</span><span> android</span><span>.</span><span>os</span><span>.</span><span>Build</span><span>.</span><span>VERSION_CODES</span>
```

Next, add the following method in the `MainActivity` class, below the `configureFlutterEngine()` method:

```
<span>private</span><span> fun getBatteryLevel</span><span>():</span><span> </span><span>Int</span><span> </span><span>{</span><span>
  val batteryLevel</span><span>:</span><span> </span><span>Int</span><span>
  </span><span>if</span><span> </span><span>(</span><span>VERSION</span><span>.</span><span>SDK_INT </span><span>&gt;=</span><span> VERSION_CODES</span><span>.</span><span>LOLLIPOP</span><span>)</span><span> </span><span>{</span><span>
    val batteryManager </span><span>=</span><span> getSystemService</span><span>(</span><span>Context</span><span>.</span><span>BATTERY_SERVICE</span><span>)</span><span> </span><span>as</span><span> </span><span>BatteryManager</span><span>
    batteryLevel </span><span>=</span><span> batteryManager</span><span>.</span><span>getIntProperty</span><span>(</span><span>BatteryManager</span><span>.</span><span>BATTERY_PROPERTY_CAPACITY</span><span>)</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    val intent </span><span>=</span><span> </span><span>ContextWrapper</span><span>(</span><span>applicationContext</span><span>).</span><span>registerReceiver</span><span>(</span><span>null</span><span>,</span><span> </span><span>IntentFilter</span><span>(</span><span>Intent</span><span>.</span><span>ACTION_BATTERY_CHANGED</span><span>))</span><span>
    batteryLevel </span><span>=</span><span> intent</span><span>!!.</span><span>getIntExtra</span><span>(</span><span>BatteryManager</span><span>.</span><span>EXTRA_LEVEL</span><span>,</span><span> </span><span>-</span><span>1</span><span>)</span><span> </span><span>*</span><span> </span><span>100</span><span> </span><span>/</span><span> intent</span><span>.</span><span>getIntExtra</span><span>(</span><span>BatteryManager</span><span>.</span><span>EXTRA_SCALE</span><span>,</span><span> </span><span>-</span><span>1</span><span>)</span><span>
  </span><span>}</span><span>

  </span><span>return</span><span> batteryLevel
</span><span>}</span>
```

Finally, complete the `setMethodCallHandler()` method added earlier. You need to handle a single platform method, `getBatteryLevel()`, so test for that in the `call` argument. The implementation of this platform method calls the Android code written in the previous step, and returns a response for both the success and error cases using the `result` argument. If an unknown method is called, report that instead.

Remove the following code:

```
<span>MethodChannel</span><span>(</span><span>flutterEngine</span><span>.</span><span>dartExecutor</span><span>.</span><span>binaryMessenger</span><span>,</span><span> CHANNEL</span><span>).</span><span>setMethodCallHandler </span><span>{</span><span>
  call</span><span>,</span><span> result </span><span>-&gt;</span><span>
  </span><span>// This method is invoked on the main thread.</span><span>
  </span><span>// TODO</span><span>
</span><span>}</span>
```

And replace with the following:

```
<span>MethodChannel</span><span>(</span><span>flutterEngine</span><span>.</span><span>dartExecutor</span><span>.</span><span>binaryMessenger</span><span>,</span><span> CHANNEL</span><span>).</span><span>setMethodCallHandler </span><span>{</span><span>
  </span><span>// This method is invoked on the main thread.</span><span>
  call</span><span>,</span><span> result </span><span>-&gt;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>call</span><span>.</span><span>method </span><span>==</span><span> </span><span>"getBatteryLevel"</span><span>)</span><span> </span><span>{</span><span>
    val batteryLevel </span><span>=</span><span> getBatteryLevel</span><span>()</span><span>

    </span><span>if</span><span> </span><span>(</span><span>batteryLevel </span><span>!=</span><span> </span><span>-</span><span>1</span><span>)</span><span> </span><span>{</span><span>
      result</span><span>.</span><span>success</span><span>(</span><span>batteryLevel</span><span>)</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
      result</span><span>.</span><span>error</span><span>(</span><span>"UNAVAILABLE"</span><span>,</span><span> </span><span>"Battery level not available."</span><span>,</span><span> </span><span>null</span><span>)</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    result</span><span>.</span><span>notImplemented</span><span>()</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

You should now be able to run the app on Android. If using the Android Emulator, set the battery level in the Extended Controls panel accessible from the **…** button in the toolbar.

### Step 4: Add an iOS platform-specific implementation

-   [Swift](https://docs.flutter.dev/platform-integration/platform-channels#ios-channel-swift-tab)
-   [Objective-C](https://docs.flutter.dev/platform-integration/platform-channels#ios-channel-objective-c-tab)

Start by opening the iOS host portion of your Flutter app in Xcode:

1.  Start Xcode.
    
2.  Select the menu item **File > Open…**.
    
3.  Navigate to the directory holding your Flutter app, and select the **ios** folder inside it. Click **OK**.
    

Add support for Swift in the standard template setup that uses Objective-C:

1.  **Expand Runner > Runner** in the Project navigator.
    
2.  Open the file `AppDelegate.swift` located under **Runner > Runner** in the Project navigator.
    

Override the `application:didFinishLaunchingWithOptions:` function and create a `FlutterMethodChannel` tied to the channel name `samples.flutter.dev/battery`:

```
<span>@UIApplicationMain</span><span>
</span><span>@objc</span><span> </span><span>class</span><span> </span><span>AppDelegate</span><span>:</span><span> </span><span>FlutterAppDelegate</span><span> </span><span>{</span><span>
  </span><span>override</span><span> func application</span><span>(</span><span>
    _ application</span><span>:</span><span> </span><span>UIApplication</span><span>,</span><span>
    didFinishLaunchingWithOptions launchOptions</span><span>:</span><span> </span><span>[</span><span>UIApplication</span><span>.</span><span>LaunchOptionsKey</span><span>:</span><span> </span><span>Any</span><span>]?)</span><span> </span><span>-&gt;</span><span> </span><span>Bool</span><span> </span><span>{</span><span>

    </span><span>let</span><span> controller </span><span>:</span><span> </span><span>FlutterViewController</span><span> </span><span>=</span><span> window</span><span>?.</span><span>rootViewController </span><span>as</span><span>!</span><span> </span><span>FlutterViewController</span><span>
    </span><span>let</span><span> batteryChannel </span><span>=</span><span> </span><span>FlutterMethodChannel</span><span>(</span><span>name</span><span>:</span><span> </span><span>"samples.flutter.dev/battery"</span><span>,</span><span>
                                              binaryMessenger</span><span>:</span><span> controller</span><span>.</span><span>binaryMessenger</span><span>)</span><span>
    batteryChannel</span><span>.</span><span>setMethodCallHandler</span><span>({</span><span>
      </span><span>(</span><span>call</span><span>:</span><span> </span><span>FlutterMethodCall</span><span>,</span><span> result</span><span>:</span><span> </span><span>@escaping</span><span> </span><span>FlutterResult</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Void</span><span> </span><span>in</span><span>
      </span><span>// This method is invoked on the UI thread.</span><span>
      </span><span>// Handle battery messages.</span><span>
    </span><span>})</span><span>

    </span><span>GeneratedPluginRegistrant</span><span>.</span><span>register</span><span>(</span><span>with</span><span>:</span><span> </span><span>self</span><span>)</span><span>
    </span><span>return</span><span> </span><span>super</span><span>.</span><span>application</span><span>(</span><span>application</span><span>,</span><span> didFinishLaunchingWithOptions</span><span>:</span><span> launchOptions</span><span>)</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Next, add the iOS Swift code that uses the iOS battery APIs to retrieve the battery level. This code is exactly the same as you would write in a native iOS app.

Add the following as a new method at the bottom of `AppDelegate.swift`:

```
<span>private</span><span> func receiveBatteryLevel</span><span>(</span><span>result</span><span>:</span><span> </span><span>FlutterResult</span><span>)</span><span> </span><span>{</span><span>
  </span><span>let</span><span> device </span><span>=</span><span> </span><span>UIDevice</span><span>.</span><span>current
  device</span><span>.</span><span>isBatteryMonitoringEnabled </span><span>=</span><span> </span><span>true</span><span>
  </span><span>if</span><span> device</span><span>.</span><span>batteryState </span><span>==</span><span> </span><span>UIDevice</span><span>.</span><span>BatteryState</span><span>.</span><span>unknown </span><span>{</span><span>
    result</span><span>(</span><span>FlutterError</span><span>(</span><span>code</span><span>:</span><span> </span><span>"UNAVAILABLE"</span><span>,</span><span>
                        message</span><span>:</span><span> </span><span>"Battery level not available."</span><span>,</span><span>
                        details</span><span>:</span><span> </span><span>nil</span><span>))</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    result</span><span>(</span><span>Int</span><span>(</span><span>device</span><span>.</span><span>batteryLevel </span><span>*</span><span> </span><span>100</span><span>))</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Finally, complete the `setMethodCallHandler()` method added earlier. You need to handle a single platform method, `getBatteryLevel()`, so test for that in the `call` argument. The implementation of this platform method calls the iOS code written in the previous step. If an unknown method is called, report that instead.

```
<span>batteryChannel</span><span>.</span><span>setMethodCallHandler</span><span>({</span><span>
  </span><span>[</span><span>weak </span><span>self</span><span>]</span><span> </span><span>(</span><span>call</span><span>:</span><span> </span><span>FlutterMethodCall</span><span>,</span><span> result</span><span>:</span><span> </span><span>FlutterResult</span><span>)</span><span> </span><span>-&gt;</span><span> </span><span>Void</span><span> </span><span>in</span><span>
  </span><span>// This method is invoked on the UI thread.</span><span>
  guard call</span><span>.</span><span>method </span><span>==</span><span> </span><span>"getBatteryLevel"</span><span> </span><span>else</span><span> </span><span>{</span><span>
    result</span><span>(</span><span>FlutterMethodNotImplemented</span><span>)</span><span>
    </span><span>return</span><span>
  </span><span>}</span><span>
  </span><span>self</span><span>?.</span><span>receiveBatteryLevel</span><span>(</span><span>result</span><span>:</span><span> result</span><span>)</span><span>
</span><span>})</span>
```

You should now be able to run the app on iOS. If using the iOS Simulator, note that it doesn’t support battery APIs, and the app displays ‘Battery level not available’.

### Step 5: Add a Windows platform-specific implementation

Start by opening the Windows host portion of your Flutter app in Visual Studio:

1.  Run `flutter build windows` in your project directory once to generate the Visual Studio solution file.
    
2.  Start Visual Studio.
    
3.  Select **Open a project or solution**.
    
4.  Navigate to the directory holding your Flutter app, then into the **build** folder, then the **windows** folder, then select the `batterylevel.sln` file. Click **Open**.
    

Add the C++ implementation of the platform channel method:

1.  Expand **batterylevel > Source Files** in the Solution Explorer.
    
2.  Open the file `flutter_window.cpp`.
    

First, add the necessary includes to the top of the file, just after `#include "flutter_window.h"`:

```
<span>#include</span><span> </span><span>&lt;flutter/event_channel.h&gt;</span><span>
</span><span>#include</span><span> </span><span>&lt;flutter/event_sink.h&gt;</span><span>
</span><span>#include</span><span> </span><span>&lt;flutter/event_stream_handler_functions.h&gt;</span><span>
</span><span>#include</span><span> </span><span>&lt;flutter/method_channel.h&gt;</span><span>
</span><span>#include</span><span> </span><span>&lt;flutter/standard_method_codec.h&gt;</span><span>
</span><span>#include</span><span> </span><span>&lt;windows.h&gt;</span><span>

</span><span>#include</span><span> </span><span>&lt;memory&gt;</span>
```

Edit the `FlutterWindow::OnCreate` method and create a `flutter::MethodChannel` tied to the channel name `samples.flutter.dev/battery`:

```
<span>bool</span><span> </span><span>FlutterWindow</span><span>::</span><span>OnCreate</span><span>()</span><span> </span><span>{</span><span>
  </span><span>// ...</span><span>
  </span><span>RegisterPlugins</span><span>(</span><span>flutter_controller_</span><span>-&gt;</span><span>engine</span><span>());</span><span>

  flutter</span><span>::</span><span>MethodChannel</span><span>&lt;&gt;</span><span> channel</span><span>(</span><span>
      flutter_controller_</span><span>-&gt;</span><span>engine</span><span>()-&gt;</span><span>messenger</span><span>(),</span><span> </span><span>"samples.flutter.dev/battery"</span><span>,</span><span>
      </span><span>&amp;</span><span>flutter</span><span>::</span><span>StandardMethodCodec</span><span>::</span><span>GetInstance</span><span>());</span><span>
  channel</span><span>.</span><span>SetMethodCallHandler</span><span>(</span><span>
      </span><span>[](</span><span>const</span><span> flutter</span><span>::</span><span>MethodCall</span><span>&lt;&gt;&amp;</span><span> call</span><span>,</span><span>
         std</span><span>::</span><span>unique_ptr</span><span>&lt;</span><span>flutter</span><span>::</span><span>MethodResult</span><span>&lt;&gt;&gt;</span><span> result</span><span>)</span><span> </span><span>{</span><span>
        </span><span>// TODO</span><span>
      </span><span>});</span><span>

  </span><span>SetChildContent</span><span>(</span><span>flutter_controller_</span><span>-&gt;</span><span>view</span><span>()-&gt;</span><span>GetNativeWindow</span><span>());</span><span>
  </span><span>return</span><span> </span><span>true</span><span>;</span><span>
</span><span>}</span>
```

Next, add the C++ code that uses the Windows battery APIs to retrieve the battery level. This code is exactly the same as you would write in a native Windows application.

Add the following as a new function at the top of `flutter_window.cpp` just after the `#include` section:

```
<span>static</span><span> </span><span>int</span><span> </span><span>GetBatteryLevel</span><span>()</span><span> </span><span>{</span><span>
  SYSTEM_POWER_STATUS status</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>GetSystemPowerStatus</span><span>(&amp;</span><span>status</span><span>)</span><span> </span><span>==</span><span> </span><span>0</span><span> </span><span>||</span><span> status</span><span>.</span><span>BatteryLifePercent</span><span> </span><span>==</span><span> </span><span>255</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>-</span><span>1</span><span>;</span><span>
  </span><span>}</span><span>
  </span><span>return</span><span> status</span><span>.</span><span>BatteryLifePercent</span><span>;</span><span>
</span><span>}</span>
```

Finally, complete the `setMethodCallHandler()` method added earlier. You need to handle a single platform method, `getBatteryLevel()`, so test for that in the `call` argument. The implementation of this platform method calls the Windows code written in the previous step. If an unknown method is called, report that instead.

Remove the following code:

```
<span>channel</span><span>.</span><span>SetMethodCallHandler</span><span>(</span><span>
    </span><span>[](</span><span>const</span><span> flutter</span><span>::</span><span>MethodCall</span><span>&lt;&gt;&amp;</span><span> call</span><span>,</span><span>
       std</span><span>::</span><span>unique_ptr</span><span>&lt;</span><span>flutter</span><span>::</span><span>MethodResult</span><span>&lt;&gt;&gt;</span><span> result</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// TODO</span><span>
    </span><span>});</span>
```

And replace with the following:

```
<span>channel</span><span>.</span><span>SetMethodCallHandler</span><span>(</span><span>
    </span><span>[](</span><span>const</span><span> flutter</span><span>::</span><span>MethodCall</span><span>&lt;&gt;&amp;</span><span> call</span><span>,</span><span>
       std</span><span>::</span><span>unique_ptr</span><span>&lt;</span><span>flutter</span><span>::</span><span>MethodResult</span><span>&lt;&gt;&gt;</span><span> result</span><span>)</span><span> </span><span>{</span><span>
      </span><span>if</span><span> </span><span>(</span><span>call</span><span>.</span><span>method_name</span><span>()</span><span> </span><span>==</span><span> </span><span>"getBatteryLevel"</span><span>)</span><span> </span><span>{</span><span>
        </span><span>int</span><span> battery_level </span><span>=</span><span> </span><span>GetBatteryLevel</span><span>();</span><span>
        </span><span>if</span><span> </span><span>(</span><span>battery_level </span><span>!=</span><span> </span><span>-</span><span>1</span><span>)</span><span> </span><span>{</span><span>
          result</span><span>-&gt;</span><span>Success</span><span>(</span><span>battery_level</span><span>);</span><span>
        </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
          result</span><span>-&gt;</span><span>Error</span><span>(</span><span>"UNAVAILABLE"</span><span>,</span><span> </span><span>"Battery level not available."</span><span>);</span><span>
        </span><span>}</span><span>
      </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
        result</span><span>-&gt;</span><span>NotImplemented</span><span>();</span><span>
      </span><span>}</span><span>
    </span><span>});</span>
```

You should now be able to run the application on Windows. If your device doesn’t have a battery, it displays ‘Battery level not available’.

### Step 6: Add a macOS platform-specific implementation

Start by opening the macOS host portion of your Flutter app in Xcode:

1.  Start Xcode.
    
2.  Select the menu item **File > Open…**.
    
3.  Navigate to the directory holding your Flutter app, and select the **macos** folder inside it. Click **OK**.
    

Add the Swift implementation of the platform channel method:

1.  **Expand Runner > Runner** in the Project navigator.
    
2.  Open the file `MainFlutterWindow.swift` located under **Runner > Runner** in the Project navigator.
    

First, add the necessary import to the top of the file, just after `import FlutterMacOS`:

Create a `FlutterMethodChannel` tied to the channel name `samples.flutter.dev/battery` in the `awakeFromNib` method:

```
<span>  </span><span>override</span><span> func awakeFromNib</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// ...</span><span>
    </span><span>self</span><span>.</span><span>setFrame</span><span>(</span><span>windowFrame</span><span>,</span><span> display</span><span>:</span><span> </span><span>true</span><span>)</span><span>
  
    </span><span>let</span><span> batteryChannel </span><span>=</span><span> </span><span>FlutterMethodChannel</span><span>(</span><span>
      name</span><span>:</span><span> </span><span>"samples.flutter.dev/battery"</span><span>,</span><span>
      binaryMessenger</span><span>:</span><span> flutterViewController</span><span>.</span><span>engine</span><span>.</span><span>binaryMessenger</span><span>)</span><span>
    batteryChannel</span><span>.</span><span>setMethodCallHandler </span><span>{</span><span> </span><span>(</span><span>call</span><span>,</span><span> result</span><span>)</span><span> </span><span>in</span><span>
      </span><span>// This method is invoked on the UI thread.</span><span>
      </span><span>// Handle battery messages.</span><span>
    </span><span>}</span><span>

    </span><span>RegisterGeneratedPlugins</span><span>(</span><span>registry</span><span>:</span><span> flutterViewController</span><span>)</span><span>

    </span><span>super</span><span>.</span><span>awakeFromNib</span><span>()</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Next, add the macOS Swift code that uses the IOKit battery APIs to retrieve the battery level. This code is exactly the same as you would write in a native macOS app.

Add the following as a new method at the bottom of `MainFlutterWindow.swift`:

```
<span>private</span><span> func getBatteryLevel</span><span>()</span><span> </span><span>-&gt;</span><span> </span><span>Int</span><span>?</span><span> </span><span>{</span><span>
  </span><span>let</span><span> info </span><span>=</span><span> </span><span>IOPSCopyPowerSourcesInfo</span><span>().</span><span>takeRetainedValue</span><span>()</span><span>
  </span><span>let</span><span> sources</span><span>:</span><span> </span><span>Array</span><span>&lt;</span><span>CFTypeRef</span><span>&gt;</span><span> </span><span>=</span><span> </span><span>IOPSCopyPowerSourcesList</span><span>(</span><span>info</span><span>).</span><span>takeRetainedValue</span><span>()</span><span> </span><span>as</span><span> </span><span>Array</span><span>
  </span><span>if</span><span> </span><span>let</span><span> source </span><span>=</span><span> sources</span><span>.</span><span>first </span><span>{</span><span>
    </span><span>let</span><span> description </span><span>=</span><span>
      </span><span>IOPSGetPowerSourceDescription</span><span>(</span><span>info</span><span>,</span><span> source</span><span>).</span><span>takeUnretainedValue</span><span>()</span><span> </span><span>as</span><span>!</span><span> </span><span>[</span><span>String</span><span>:</span><span> </span><span>AnyObject</span><span>]</span><span>
    </span><span>if</span><span> </span><span>let</span><span> level </span><span>=</span><span> description</span><span>[</span><span>kIOPSCurrentCapacityKey</span><span>]</span><span> </span><span>as</span><span>?</span><span> </span><span>Int</span><span> </span><span>{</span><span>
      </span><span>return</span><span> level
    </span><span>}</span><span>
  </span><span>}</span><span>
  </span><span>return</span><span> </span><span>nil</span><span>
</span><span>}</span>
```

Finally, complete the `setMethodCallHandler` method added earlier. You need to handle a single platform method, `getBatteryLevel()`, so test for that in the `call` argument. The implementation of this platform method calls the macOS code written in the previous step. If an unknown method is called, report that instead.

```
<span>batteryChannel</span><span>.</span><span>setMethodCallHandler </span><span>{</span><span> </span><span>(</span><span>call</span><span>,</span><span> result</span><span>)</span><span> </span><span>in</span><span>
  </span><span>switch</span><span> call</span><span>.</span><span>method </span><span>{</span><span>
  </span><span>case</span><span> </span><span>"getBatteryLevel"</span><span>:</span><span>
    guard </span><span>let</span><span> level </span><span>=</span><span> getBatteryLevel</span><span>()</span><span> </span><span>else</span><span> </span><span>{</span><span>
      result</span><span>(</span><span>
        </span><span>FlutterError</span><span>(</span><span>
          code</span><span>:</span><span> </span><span>"UNAVAILABLE"</span><span>,</span><span>
          message</span><span>:</span><span> </span><span>"Battery level not available"</span><span>,</span><span>
          details</span><span>:</span><span> </span><span>nil</span><span>))</span><span>
     </span><span>return</span><span>
    </span><span>}</span><span>
    result</span><span>(</span><span>level</span><span>)</span><span>
  </span><span>default</span><span>:</span><span>
    result</span><span>(</span><span>FlutterMethodNotImplemented</span><span>)</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

You should now be able to run the application on macOS. If your device doesn’t have a battery, it displays ‘Battery level not available’.

### Step 7: Add a Linux platform-specific implementation

For this example you need to install the `upower` developer headers. This is likely available from your distribution, for example with:

```
<span>sudo </span>apt <span>install </span>libupower-glib-dev
```

Start by opening the Linux host portion of your Flutter app in the editor of your choice. The instructions below are for Visual Studio Code with the “C/C++” and “CMake” extensions installed, but can be adjusted for other IDEs.

1.  Launch Visual Studio Code.
    
2.  Open the **linux** directory inside your project.
    
3.  Choose **Yes** in the prompt asking: `Would you like to configure project "linux"?`. This enables C++ autocomplete.
    
4.  Open the file `my_application.cc`.
    

First, add the necessary includes to the top of the file, just after `#include <flutter_linux/flutter_linux.h`:

```
<span>#include</span><span> </span><span>&lt;math.h&gt;</span><span>
</span><span>#include</span><span> </span><span>&lt;upower.h&gt;</span>
```

Add an `FlMethodChannel` to the `_MyApplication` struct:

```
<span>struct</span><span> </span><span>_MyApplication</span><span> </span><span>{</span><span>
  </span><span>GtkApplication</span><span> parent_instance</span><span>;</span><span>
  </span><span>char</span><span>**</span><span> dart_entrypoint_arguments</span><span>;</span><span>
  </span><span>FlMethodChannel</span><span>*</span><span> battery_channel</span><span>;</span><span>
</span><span>};</span>
```

Make sure to clean it up in `my_application_dispose`:

```
<span>static</span><span> </span><span>void</span><span> my_application_dispose</span><span>(</span><span>GObject</span><span>*</span><span> object</span><span>)</span><span> </span><span>{</span><span>
  </span><span>MyApplication</span><span>*</span><span> self </span><span>=</span><span> MY_APPLICATION</span><span>(</span><span>object</span><span>);</span><span>
  g_clear_pointer</span><span>(&amp;</span><span>self</span><span>-&gt;</span><span>dart_entrypoint_arguments</span><span>,</span><span> g_strfreev</span><span>);</span><span>
  g_clear_object</span><span>(&amp;</span><span>self</span><span>-&gt;</span><span>battery_channel</span><span>);</span><span>
  G_OBJECT_CLASS</span><span>(</span><span>my_application_parent_class</span><span>)-&gt;</span><span>dispose</span><span>(</span><span>object</span><span>);</span><span>
</span><span>}</span>
```

Edit the `my_application_activate` method and initialize `battery_channel` using the channel name `samples.flutter.dev/battery`, just after the call to `fl_register_plugins`:

```
<span>static</span><span> </span><span>void</span><span> my_application_activate</span><span>(</span><span>GApplication</span><span>*</span><span> application</span><span>)</span><span> </span><span>{</span><span>
  </span><span>// ...</span><span>
  fl_register_plugins</span><span>(</span><span>FL_PLUGIN_REGISTRY</span><span>(</span><span>self</span><span>-&gt;</span><span>view</span><span>));</span><span>

  g_autoptr</span><span>(</span><span>FlStandardMethodCodec</span><span>)</span><span> codec </span><span>=</span><span> fl_standard_method_codec_new</span><span>();</span><span>
  self</span><span>-&gt;</span><span>battery_channel </span><span>=</span><span> fl_method_channel_new</span><span>(</span><span>
      fl_engine_get_binary_messenger</span><span>(</span><span>fl_view_get_engine</span><span>(</span><span>view</span><span>)),</span><span>
      </span><span>"samples.flutter.dev/battery"</span><span>,</span><span> FL_METHOD_CODEC</span><span>(</span><span>codec</span><span>));</span><span>
  fl_method_channel_set_method_call_handler</span><span>(</span><span>
      self</span><span>-&gt;</span><span>battery_channel</span><span>,</span><span> battery_method_call_handler</span><span>,</span><span> self</span><span>,</span><span> </span><span>nullptr</span><span>);</span><span>

  gtk_widget_grab_focus</span><span>(</span><span>GTK_WIDGET</span><span>(</span><span>self</span><span>-&gt;</span><span>view</span><span>));</span><span>
</span><span>}</span>
```

Next, add the C code that uses the Linux battery APIs to retrieve the battery level. This code is exactly the same as you would write in a native Linux application.

Add the following as a new function at the top of `my_application.cc` just after the `G_DEFINE_TYPE` line:

```
<span>static</span><span> </span><span>FlMethodResponse</span><span>*</span><span> get_battery_level</span><span>()</span><span> </span><span>{</span><span>
  </span><span>// Find the first available battery and report that.</span><span>
  g_autoptr</span><span>(</span><span>UpClient</span><span>)</span><span> up_client </span><span>=</span><span> up_client_new</span><span>();</span><span>
  g_autoptr</span><span>(</span><span>GPtrArray</span><span>)</span><span> devices </span><span>=</span><span> up_client_get_devices2</span><span>(</span><span>up_client</span><span>);</span><span>
  </span><span>if</span><span> </span><span>(</span><span>devices</span><span>-&gt;</span><span>len </span><span>==</span><span> </span><span>0</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> FL_METHOD_RESPONSE</span><span>(</span><span>fl_method_error_response_new</span><span>(</span><span>
        </span><span>"UNAVAILABLE"</span><span>,</span><span> </span><span>"Device does not have a battery."</span><span>,</span><span> </span><span>nullptr</span><span>));</span><span>
  </span><span>}</span><span>

  </span><span>UpDevice</span><span>*</span><span> device </span><span>=</span><span> </span><span>(</span><span>UpDevice</span><span>*)(</span><span>g_ptr_array_index</span><span>(</span><span>devices</span><span>,</span><span> </span><span>0</span><span>));</span><span>
  </span><span>double</span><span> percentage </span><span>=</span><span> </span><span>0</span><span>;</span><span>
  g_object_get</span><span>(</span><span>device</span><span>,</span><span> </span><span>"percentage"</span><span>,</span><span> </span><span>&amp;</span><span>percentage</span><span>,</span><span> </span><span>nullptr</span><span>);</span><span>

  g_autoptr</span><span>(</span><span>FlValue</span><span>)</span><span> result </span><span>=</span><span>
      fl_value_new_int</span><span>(</span><span>static_cast</span><span>&lt;int64_t&gt;</span><span>(</span><span>round</span><span>(</span><span>percentage</span><span>)));</span><span>
  </span><span>return</span><span> FL_METHOD_RESPONSE</span><span>(</span><span>fl_method_success_response_new</span><span>(</span><span>result</span><span>));</span><span>
</span><span>}</span>
```

Finally, add the `battery_method_call_handler` function referenced in the earlier call to `fl_method_channel_set_method_call_handler`. You need to handle a single platform method, `getBatteryLevel`, so test for that in the `method_call` argument. The implementation of this function calls the Linux code written in the previous step. If an unknown method is called, report that instead.

Add the following code after the `get_battery_level` function:

```
<span>static</span><span> </span><span>void</span><span> battery_method_call_handler</span><span>(</span><span>FlMethodChannel</span><span>*</span><span> channel</span><span>,</span><span>
                                        </span><span>FlMethodCall</span><span>*</span><span> method_call</span><span>,</span><span>
                                        gpointer user_data</span><span>)</span><span> </span><span>{</span><span>
  g_autoptr</span><span>(</span><span>FlMethodResponse</span><span>)</span><span> response </span><span>=</span><span> </span><span>nullptr</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>strcmp</span><span>(</span><span>fl_method_call_get_name</span><span>(</span><span>method_call</span><span>),</span><span> </span><span>"getBatteryLevel"</span><span>)</span><span> </span><span>==</span><span> </span><span>0</span><span>)</span><span> </span><span>{</span><span>
    response </span><span>=</span><span> get_battery_level</span><span>();</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    response </span><span>=</span><span> FL_METHOD_RESPONSE</span><span>(</span><span>fl_method_not_implemented_response_new</span><span>());</span><span>
  </span><span>}</span><span>

  g_autoptr</span><span>(</span><span>GError</span><span>)</span><span> error </span><span>=</span><span> </span><span>nullptr</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(!</span><span>fl_method_call_respond</span><span>(</span><span>method_call</span><span>,</span><span> response</span><span>,</span><span> </span><span>&amp;</span><span>error</span><span>))</span><span> </span><span>{</span><span>
    g_warning</span><span>(</span><span>"Failed to send response: %s"</span><span>,</span><span> error</span><span>-&gt;</span><span>message</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

You should now be able to run the application on Linux. If your device doesn’t have a battery, it displays ‘Battery level not available’.

## Typesafe platform channels using Pigeon

The previous example uses `MethodChannel` to communicate between the host and client, which isn’t typesafe. Calling and receiving messages depends on the host and client declaring the same arguments and datatypes in order for messages to work. You can use the [Pigeon](https://pub.dev/packages/pigeon) package as an alternative to `MethodChannel` to generate code that sends messages in a structured, typesafe manner.

With [Pigeon](https://pub.dev/packages/pigeon), the messaging protocol is defined in a subset of Dart that then generates messaging code for Android, iOS, macOS, or Windows. You can find a more complete example and more information on the [`pigeon`](https://pub.dev/packages/pigeon) page on pub.dev.

Using [Pigeon](https://pub.dev/packages/pigeon) eliminates the need to match strings between host and client for the names and datatypes of messages. It supports: nested classes, grouping messages into APIs, generation of asynchronous wrapper code and sending messages in either direction. The generated code is readable and guarantees there are no conflicts between multiple clients of different versions. Supported languages are Objective-C, Java, Kotlin, C++, and Swift (with Objective-C interop).

### Pigeon example

**Pigeon file:**

```
<span>import</span><span> </span><span>'package:pigeon/pigeon.dart'</span><span>;</span><span>

</span><span>class</span><span> </span><span>SearchRequest</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>String</span><span> query</span><span>;</span><span>

  </span><span>SearchRequest</span><span>({</span><span>required</span><span> </span><span>this</span><span>.</span><span>query</span><span>});</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SearchReply</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>String</span><span> result</span><span>;</span><span>

  </span><span>SearchReply</span><span>({</span><span>required</span><span> </span><span>this</span><span>.</span><span>result</span><span>});</span><span>
</span><span>}</span><span>

@</span><span>HostApi</span><span>()</span><span>
</span><span>abstract</span><span> </span><span>class</span><span> </span><span>Api</span><span> </span><span>{</span><span>
  @</span><span>async</span><span>
  </span><span>SearchReply</span><span> search</span><span>(</span><span>SearchRequest</span><span> request</span><span>);</span><span>
</span><span>}</span>
```

**Dart usage:**

```
<span>import</span><span> </span><span>'generated_pigeon.dart'</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> onClick</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>SearchRequest</span><span> request </span><span>=</span><span> </span><span>SearchRequest</span><span>(</span><span>query</span><span>:</span><span> </span><span>'test'</span><span>);</span><span>
  </span><span>Api</span><span> api </span><span>=</span><span> </span><span>SomeApi</span><span>();</span><span>
  </span><span>SearchReply</span><span> reply </span><span>=</span><span> </span><span>await</span><span> api</span><span>.</span><span>search</span><span>(</span><span>request</span><span>);</span><span>
  print</span><span>(</span><span>'reply: ${reply.result}'</span><span>);</span><span>
</span><span>}</span>
```

## Separate platform-specific code from UI code

If you expect to use your platform-specific code in multiple Flutter apps, you might consider separating the code into a platform plugin located in a directory outside your main application. See [developing packages](https://docs.flutter.dev/packages-and-plugins/developing-packages) for details.

## Publish platform-specific code as a package

To share your platform-specific code with other developers in the Flutter ecosystem, see [publishing packages](https://docs.flutter.dev/packages-and-plugins/developing-packages#publish).

## Custom channels and codecs

Besides the above mentioned `MethodChannel`, you can also use the more basic [`BasicMessageChannel`](https://api.flutter.dev/flutter/services/BasicMessageChannel-class.html), which supports basic, asynchronous message passing using a custom message codec. You can also use the specialized [`BinaryCodec`](https://api.flutter.dev/flutter/services/BinaryCodec-class.html), [`StringCodec`](https://api.flutter.dev/flutter/services/StringCodec-class.html), and [`JSONMessageCodec`](https://api.flutter.dev/flutter/services/JSONMessageCodec-class.html) classes, or create your own codec.

You might also check out an example of a custom codec in the [`cloud_firestore`](https://github.com/firebase/flutterfire/blob/master/packages/cloud_firestore/cloud_firestore_platform_interface/lib/src/method_channel/utils/firestore_message_codec.dart) plugin, which is able to serialize and deserialize many more types than the default types.

## Channels and platform threading

When invoking channels on the platform side destined for Flutter, invoke them on the platform’s main thread. When invoking channels in Flutter destined for the platform side, either invoke them from any `Isolate` that is the root `Isolate`, _or_ that is registered as a background `Isolate`. The handlers for the platform side can execute on the platform’s main thread or they can execute on a background thread if using a Task Queue. You can invoke the platform side handlers asynchronously and on any thread.

### Using plugins and channels from background isolates

Plugins and channels can be used by any `Isolate`, but that `Isolate` has to be a root `Isolate` (the one created by Flutter) or registered as a background `Isolate` for a root `Isolate`.

The following example shows how to register a background `Isolate` in order to use a plugin from a background `Isolate`.

```
<span>import</span> <span>'package:flutter/services.dart'</span><span>;</span>
<span>import</span> <span>'package:shared_preferences/shared_preferences.dart'</span><span>;</span>

<span>void</span> <span>_isolateMain</span><span>(</span><span>RootIsolateToken</span> <span>rootIsolateToken</span><span>)</span> <span>async</span> <span>{</span>
  <span>BackgroundIsolateBinaryMessenger</span><span>.</span><span>ensureInitialized</span><span>(</span><span>rootIsolateToken</span><span>);</span>
  <span>SharedPreferences</span> <span>sharedPreferences</span> <span>=</span> <span>await</span> <span>SharedPreferences</span><span>.</span><span>getInstance</span><span>();</span>
  <span>print</span><span>(</span><span>sharedPreferences</span><span>.</span><span>getBool</span><span>(</span><span>'isDebug'</span><span>));</span>
<span>}</span>

<span>void</span> <span>main</span><span>()</span> <span>{</span>
  <span>RootIsolateToken</span> <span>rootIsolateToken</span> <span>=</span> <span>RootIsolateToken</span><span>.</span><span>instance</span><span>!</span><span>;</span>
  <span>Isolate</span><span>.</span><span>spawn</span><span>(</span><span>_isolateMain</span><span>,</span> <span>rootIsolateToken</span><span>);</span>
<span>}</span>
```

### Executing channel handlers on background threads

In order for a channel’s platform side handler to execute on a background thread, you must use the Task Queue API. Currently this feature is only supported on iOS and Android.

In Java:

```
<span>@Override</span>
<span>public</span> <span>void</span> <span>onAttachedToEngine</span><span>(</span><span>@NonNull</span> <span>FlutterPluginBinding</span> <span>binding</span><span>)</span> <span>{</span>
  <span>BinaryMessenger</span> <span>messenger</span> <span>=</span> <span>binding</span><span>.</span><span>getBinaryMessenger</span><span>();</span>
  <span>BinaryMessenger</span><span>.</span><span>TaskQueue</span> <span>taskQueue</span> <span>=</span>
      <span>messenger</span><span>.</span><span>makeBackgroundTaskQueue</span><span>();</span>
  <span>channel</span> <span>=</span>
      <span>new</span> <span>MethodChannel</span><span>(</span>
          <span>messenger</span><span>,</span>
          <span>"com.example.foo"</span><span>,</span>
          <span>StandardMethodCodec</span><span>.</span><span>INSTANCE</span><span>,</span>
          <span>taskQueue</span><span>);</span>
  <span>channel</span><span>.</span><span>setMethodCallHandler</span><span>(</span><span>this</span><span>);</span>
<span>}</span>
```

In Kotlin:

```
<span>override</span> <span>fun</span> <span>onAttachedToEngine</span><span>(</span><span>@NonNull</span> <span>flutterPluginBinding</span><span>:</span> <span>FlutterPlugin</span><span>.</span><span>FlutterPluginBinding</span><span>)</span> <span>{</span>
  <span>val</span> <span>taskQueue</span> <span>=</span>
      <span>flutterPluginBinding</span><span>.</span><span>binaryMessenger</span><span>.</span><span>makeBackgroundTaskQueue</span><span>()</span>
  <span>channel</span> <span>=</span> <span>MethodChannel</span><span>(</span><span>flutterPluginBinding</span><span>.</span><span>binaryMessenger</span><span>,</span>
                          <span>"com.example.foo"</span><span>,</span>
                          <span>StandardMethodCodec</span><span>.</span><span>INSTANCE</span><span>,</span>
                          <span>taskQueue</span><span>)</span>
  <span>channel</span><span>.</span><span>setMethodCallHandler</span><span>(</span><span>this</span><span>)</span>
<span>}</span>
```

In Swift:

```
<span>public</span> <span>static</span> <span>func</span> <span>register</span><span>(</span><span>with</span> <span>registrar</span><span>:</span> <span>FlutterPluginRegistrar</span><span>)</span> <span>{</span>
  <span>let</span> <span>taskQueue</span> <span>=</span> <span>registrar</span><span>.</span><span>messenger</span><span>.</span><span>makeBackgroundTaskQueue</span><span>()</span>
  <span>let</span> <span>channel</span> <span>=</span> <span>FlutterMethodChannel</span><span>(</span><span>name</span><span>:</span> <span>"com.example.foo"</span><span>,</span>
                                     <span>binaryMessenger</span><span>:</span> <span>registrar</span><span>.</span><span>messenger</span><span>(),</span>
                                     <span>codec</span><span>:</span> <span>FlutterStandardMethodCodec</span><span>.</span><span>sharedInstance</span><span>,</span>
                                     <span>taskQueue</span><span>:</span> <span>taskQueue</span><span>)</span>
  <span>let</span> <span>instance</span> <span>=</span> <span>MyPlugin</span><span>()</span>
  <span>registrar</span><span>.</span><span>addMethodCallDelegate</span><span>(</span><span>instance</span><span>,</span> <span>channel</span><span>:</span> <span>channel</span><span>)</span>
<span>}</span>
```

In Objective-C:

```
<span>+</span> <span>(</span><span>void</span><span>)</span><span>registerWithRegistrar</span><span>:(</span><span>NSObject</span><span>&lt;</span><span>FlutterPluginRegistrar</span><span>&gt;*</span><span>)</span><span>registrar</span> <span>{</span>
  <span>NSObject</span><span>&lt;</span><span>FlutterTaskQueue</span><span>&gt;*</span> <span>taskQueue</span> <span>=</span>
      <span>[[</span><span>registrar</span> <span>messenger</span><span>]</span> <span>makeBackgroundTaskQueue</span><span>];</span>
  <span>FlutterMethodChannel</span><span>*</span> <span>channel</span> <span>=</span>
      <span>[</span><span>FlutterMethodChannel</span> <span>methodChannelWithName</span><span>:</span><span>@"com.example.foo"</span>
                                  <span>binaryMessenger:</span><span>[</span><span>registrar</span> <span>messenger</span><span>]</span>
                                            <span>codec:</span><span>[</span><span>FlutterStandardMethodCodec</span> <span>sharedInstance</span><span>]</span>
                                        <span>taskQueue:</span><span>taskQueue</span><span>];</span>
  <span>MyPlugin</span><span>*</span> <span>instance</span> <span>=</span> <span>[[</span><span>MyPlugin</span> <span>alloc</span><span>]</span> <span>init</span><span>];</span>
  <span>[</span><span>registrar</span> <span>addMethodCallDelegate</span><span>:</span><span>instance</span> <span>channel</span><span>:</span><span>channel</span><span>];</span>
<span>}</span>
```

### Jumping to the UI thread in Android

To comply with channels’ UI thread requirement, you might need to jump from a background thread to Android’s UI thread to execute a channel method. In Android, you can accomplish this by `post()`ing a `Runnable` to Android’s UI thread `Looper`, which causes the `Runnable` to execute on the main thread at the next opportunity.

In Java:

```
<span>new</span> <span>Handler</span><span>(</span><span>Looper</span><span>.</span><span>getMainLooper</span><span>()).</span><span>post</span><span>(</span><span>new</span> <span>Runnable</span><span>()</span> <span>{</span>
  <span>@Override</span>
  <span>public</span> <span>void</span> <span>run</span><span>()</span> <span>{</span>
    <span>// Call the desired channel message here.</span>
  <span>}</span>
<span>});</span>
```

In Kotlin:

```
<span>Handler</span><span>(</span><span>Looper</span><span>.</span><span>getMainLooper</span><span>()).</span><span>post</span> <span>{</span>
  <span>// Call the desired channel message here.</span>
<span>}</span>
```

### Jumping to the main thread in iOS

To comply with channel’s main thread requirement, you might need to jump from a background thread to iOS’s main thread to execute a channel method. You can accomplish this in iOS by executing a [block](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html) on the main [dispatch queue](https://developer.apple.com/documentation/dispatch/dispatchqueue):

In Objective-C:

```
<span>dispatch_async</span><span>(</span><span>dispatch_get_main_queue</span><span>(),</span> <span>^</span><span>{</span>
  <span>// Call the desired channel message here.</span>
<span>});</span>
```

In Swift:

```
<span>DispatchQueue</span><span>.</span><span>main</span><span>.</span><span>async</span> <span>{</span>
  <span>// Call the desired channel message here.</span>
<span>}</span>
```