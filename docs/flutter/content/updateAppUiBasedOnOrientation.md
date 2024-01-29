1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Design](https://docs.flutter.dev/cookbook/design)
3.  [Update the UI based on orientation](https://docs.flutter.dev/cookbook/design/orientation)

In some situations, you want to update the display of an app when the user rotates the screen from portrait mode to landscape mode. For example, the app might show one item after the next in portrait mode, yet put those same items side-by-side in landscape mode.

In Flutter, you can build different layouts depending on a given [`Orientation`](https://api.flutter.dev/flutter/widgets/Orientation.html). In this example, build a list that displays two columns in portrait mode and three columns in landscape mode using the following steps:

1.  Build a `GridView` with two columns.
2.  Use an `OrientationBuilder` to change the number of columns.

## 1\. Build a `GridView` with two columns

First, create a list of items to work with. Rather than using a normal list, create a list that displays items in a grid. For now, create a grid with two columns.

```
<span>return</span><span> </span><span>GridView</span><span>.</span><span>count</span><span>(</span><span>
  </span><span>// A list with 2 columns</span><span>
  crossAxisCount</span><span>:</span><span> </span><span>2</span><span>,</span><span>
  </span><span>// ...</span><span>
</span><span>);</span>
```

To learn more about working with `GridViews`, see the [Creating a grid list](https://docs.flutter.dev/cookbook/lists/grid-lists) recipe.

## 2\. Use an `OrientationBuilder` to change the number of columns

To determine the app’s current `Orientation`, use the [`OrientationBuilder`](https://api.flutter.dev/flutter/widgets/OrientationBuilder-class.html) widget. The `OrientationBuilder` calculates the current `Orientation` by comparing the width and height available to the parent widget, and rebuilds when the size of the parent changes.

Using the `Orientation`, build a list that displays two columns in portrait mode, or three columns in landscape mode.

```
<span>body</span><span>:</span><span> </span><span>OrientationBuilder</span><span>(</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> orientation</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GridView</span><span>.</span><span>count</span><span>(</span><span>
      </span><span>// Create a grid with 2 columns in portrait mode,</span><span>
      </span><span>// or 3 columns in landscape mode.</span><span>
      crossAxisCount</span><span>:</span><span> orientation </span><span>==</span><span> </span><span>Orientation</span><span>.</span><span>portrait </span><span>?</span><span> </span><span>2</span><span> </span><span>:</span><span> </span><span>3</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
</span><span>),</span>
```

## Interactive example

## Locking device orientation

In the previous section, you learned how to adapt the app UI to device orientation changes.

Flutter also allows you to specify the orientations your app supports using the values of [`DeviceOrientation`](https://api.flutter.dev/flutter/services/DeviceOrientation.html). You can either:

-   Lock the app to a single orientation, like only the `portraitUp` position, or…
-   Allow multiple orientations, like both `portraitUp` and `portraitDown`, but not landscape.

In the application `main()` method, call [`SystemChrome.setPreferredOrientations()`](https://api.flutter.dev/flutter/services/SystemChrome/setPreferredOrientations.html) with the list of preferred orientations that your app supports.

To lock the device to a single orientation, you can pass a list with a single item.

For a list of all the possible values, check out [`DeviceOrientation`](https://api.flutter.dev/flutter/services/DeviceOrientation.html).

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>WidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span>
  </span><span>SystemChrome</span><span>.</span><span>setPreferredOrientations</span><span>([</span><span>
    </span><span>DeviceOrientation</span><span>.</span><span>portraitUp</span><span>,</span><span>
  </span><span>]);</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
</span><span>}</span>
```