1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Animation](https://docs.flutter.dev/cookbook/animation)
3.  [Fade a widget in and out](https://docs.flutter.dev/cookbook/animation/opacity-animation)

UI developers often need to show and hide elements on screen. However, quickly popping elements on and off the screen can feel jarring to end users. Instead, fade elements in and out with an opacity animation to create a smooth experience.

The [`AnimatedOpacity`](https://api.flutter.dev/flutter/widgets/AnimatedOpacity-class.html) widget makes it easy to perform opacity animations. This recipe uses the following steps:

1.  Create a box to fade in and out.
2.  Define a `StatefulWidget`.
3.  Display a button that toggles the visibility.
4.  Fade the box in and out.

## 1\. Create a box to fade in and out

First, create something to fade in and out. For this example, draw a green box on screen.

```
<span>Container</span><span>(</span><span>
  width</span><span>:</span><span> </span><span>200</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>200</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>,</span><span>
</span><span>)</span>
```

Now that you have a green box to animate, you need a way to know whether the box should be visible. To accomplish this, use a [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).

A `StatefulWidget` is a class that creates a `State` object. The `State` object holds some data about the app and provides a way to update that data. When updating the data, you can also ask Flutter to rebuild the UI with those changes.

In this case, you have one piece of data: a boolean representing whether the button is visible.

To construct a `StatefulWidget`, create two classes: A `StatefulWidget` and a corresponding `State` class. Pro tip: The Flutter plugins for Android Studio and VSCode include the `stful` snippet to quickly generate this code.

```
<span>// The StatefulWidget's job is to take data and create a State class.</span><span>
</span><span>// In this case, the widget takes a title, and creates a _MyHomePageState.</span><span>
</span><span>class</span><span> </span><span>MyHomePage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  </span><span>const</span><span> </span><span>MyHomePage</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
  </span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyHomePageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>// The State class is responsible for two things: holding some data you can</span><span>
</span><span>// update and building the UI using that data.</span><span>
</span><span>class</span><span> _MyHomePageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Whether the green box should be visible.</span><span>
  </span><span>bool</span><span> _visible </span><span>=</span><span> </span><span>true</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// The green box goes here with some other Widgets.</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 3\. Display a button that toggles the visibility

Now that you have some data to determine whether the green box should be visible, you need a way to update that data. In this example, if the box is visible, hide it. If the box is hidden, show it.

To handle this, display a button. When a user presses the button, flip the boolean from true to false, or false to true. Make this change using [`setState()`](https://api.flutter.dev/flutter/widgets/State/setState.html), which is a method on the `State` class. This tells Flutter to rebuild the widget.

For more information on working with user input, see the [Gestures](https://docs.flutter.dev/cookbook#gestures) section of the cookbook.

```
<span>FloatingActionButton</span><span>(</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Call setState. This tells Flutter to rebuild the</span><span>
    </span><span>// UI with the changes.</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _visible </span><span>=</span><span> </span><span>!</span><span>_visible</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>},</span><span>
  tooltip</span><span>:</span><span> </span><span>'Toggle Opacity'</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>flip</span><span>),</span><span>
</span><span>)</span>
```

## 4\. Fade the box in and out

You have a green box on screen and a button to toggle the visibility to `true` or `false`. How to fade the box in and out? With an [`AnimatedOpacity`](https://api.flutter.dev/flutter/widgets/AnimatedOpacity-class.html) widget.

The `AnimatedOpacity` widget requires three arguments:

-   `opacity`: A value from 0.0 (invisible) to 1.0 (fully visible).
-   `duration`: How long the animation should take to complete.
-   `child`: The widget to animate. In this case, the green box.

```
<span>AnimatedOpacity</span><span>(</span><span>
  </span><span>// If the widget is visible, animate to 0.0 (invisible).</span><span>
  </span><span>// If the widget is hidden, animate to 1.0 (fully visible).</span><span>
  opacity</span><span>:</span><span> _visible </span><span>?</span><span> </span><span>1.0</span><span> </span><span>:</span><span> </span><span>0.0</span><span>,</span><span>
  duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>500</span><span>),</span><span>
  </span><span>// The green box must be a child of the AnimatedOpacity widget.</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    width</span><span>:</span><span> </span><span>200</span><span>,</span><span>
    height</span><span>:</span><span> </span><span>200</span><span>,</span><span>
    color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

## Interactive example