1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Animation](https://docs.flutter.dev/cookbook/animation)
3.  [Animate the properties of a container](https://docs.flutter.dev/cookbook/animation/animated-container)

The [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) class provides a convenient way to create a widget with specific properties: width, height, background color, padding, borders, and more.

Simple animations often involve changing these properties over time. For example, you might want to animate the background color from grey to green to indicate that an item has been selected by the user.

To animate these properties, Flutter provides the [`AnimatedContainer`](https://api.flutter.dev/flutter/widgets/AnimatedContainer-class.html) widget. Like the `Container` widget, `AnimatedContainer` allows you to define the width, height, background colors, and more. However, when the `AnimatedContainer` is rebuilt with new properties, it automatically animates between the old and new values. In Flutter, these types of animations are known as “implicit animations.”

This recipe describes how to use an `AnimatedContainer` to animate the size, background color, and border radius when the user taps a button using the following steps:

1.  Create a StatefulWidget with default properties.
2.  Build an `AnimatedContainer` using the properties.
3.  Start the animation by rebuilding with new properties.

To start, create [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) and [`State`](https://api.flutter.dev/flutter/widgets/State-class.html) classes. Use the custom State class to define the properties that change over time. In this example, that includes the width, height, color, and border radius. You can also define the default value of each property.

These properties belong to a custom `State` class so they can be updated when the user taps a button.

```
<span>class</span><span> </span><span>AnimatedContainerApp</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>AnimatedContainerApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>AnimatedContainerApp</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _AnimatedContainerAppState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _AnimatedContainerAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>AnimatedContainerApp</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Define the various properties with default values. Update these properties</span><span>
  </span><span>// when the user taps a FloatingActionButton.</span><span>
  </span><span>double</span><span> _width </span><span>=</span><span> </span><span>50</span><span>;</span><span>
  </span><span>double</span><span> _height </span><span>=</span><span> </span><span>50</span><span>;</span><span>
  </span><span>Color</span><span> _color </span><span>=</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>;</span><span>
  </span><span>BorderRadiusGeometry</span><span> _borderRadius </span><span>=</span><span> </span><span>BorderRadius</span><span>.</span><span>circular</span><span>(</span><span>8</span><span>);</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Fill this out in the next steps.</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 2\. Build an `AnimatedContainer` using the properties

Next, build the `AnimatedContainer` using the properties defined in the previous step. Furthermore, provide a `duration` that defines how long the animation should run.

```
<span>AnimatedContainer</span><span>(</span><span>
  </span><span>// Use the properties stored in the State class.</span><span>
  width</span><span>:</span><span> _width</span><span>,</span><span>
  height</span><span>:</span><span> _height</span><span>,</span><span>
  decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
    color</span><span>:</span><span> _color</span><span>,</span><span>
    borderRadius</span><span>:</span><span> _borderRadius</span><span>,</span><span>
  </span><span>),</span><span>
  </span><span>// Define how long the animation should take.</span><span>
  duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>seconds</span><span>:</span><span> </span><span>1</span><span>),</span><span>
  </span><span>// Provide an optional curve to make the animation feel smoother.</span><span>
  curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>fastOutSlowIn</span><span>,</span><span>
</span><span>)</span>
```

## 3\. Start the animation by rebuilding with new properties

Finally, start the animation by rebuilding the `AnimatedContainer` with the new properties. How to trigger a rebuild? Use the [`setState()`](https://api.flutter.dev/flutter/widgets/State/setState.html) method.

Add a button to the app. When the user taps the button, update the properties with a new width, height, background color and border radius inside a call to `setState()`.

A real app typically transitions between fixed values (for example, from a grey to a green background). For this app, generate new values each time the user taps the button.

```
<span>FloatingActionButton</span><span>(</span><span>
  </span><span>// When the user taps the button</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Use setState to rebuild the widget with new values.</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      </span><span>// Create a random number generator.</span><span>
      </span><span>final</span><span> random </span><span>=</span><span> </span><span>Random</span><span>();</span><span>

      </span><span>// Generate a random width and height.</span><span>
      _width </span><span>=</span><span> random</span><span>.</span><span>nextInt</span><span>(</span><span>300</span><span>).</span><span>toDouble</span><span>();</span><span>
      _height </span><span>=</span><span> random</span><span>.</span><span>nextInt</span><span>(</span><span>300</span><span>).</span><span>toDouble</span><span>();</span><span>

      </span><span>// Generate a random color.</span><span>
      _color </span><span>=</span><span> </span><span>Color</span><span>.</span><span>fromRGBO</span><span>(</span><span>
        random</span><span>.</span><span>nextInt</span><span>(</span><span>256</span><span>),</span><span>
        random</span><span>.</span><span>nextInt</span><span>(</span><span>256</span><span>),</span><span>
        random</span><span>.</span><span>nextInt</span><span>(</span><span>256</span><span>),</span><span>
        </span><span>1</span><span>,</span><span>
      </span><span>);</span><span>

      </span><span>// Generate a random border radius.</span><span>
      _borderRadius </span><span>=</span><span>
          </span><span>BorderRadius</span><span>.</span><span>circular</span><span>(</span><span>random</span><span>.</span><span>nextInt</span><span>(</span><span>100</span><span>).</span><span>toDouble</span><span>());</span><span>
    </span><span>});</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>play_arrow</span><span>),</span><span>
</span><span>)</span>
```

## Interactive example