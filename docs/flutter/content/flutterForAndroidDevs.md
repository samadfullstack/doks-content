This document is meant for Android developers looking to apply their existing Android knowledge to build mobile apps with Flutter. If you understand the fundamentals of the Android framework then you can use this document as a jump start to Flutter development.

Your Android knowledge and skill set are highly valuable when building with Flutter, because Flutter relies on the mobile operating system for numerous capabilities and configurations. Flutter is a new way to build UIs for mobile, but it has a plugin system to communicate with Android (and iOS) for non-UI tasks. If you’re an expert with Android, you don’t have to relearn everything to use Flutter.

This document can be used as a cookbook by jumping around and finding questions that are most relevant to your needs.

## Views

### What is the equivalent of a View in Flutter?

In Android, the `View` is the foundation of everything that shows up on the screen. Buttons, toolbars, and inputs, everything is a View. In Flutter, the rough equivalent to a `View` is a `Widget`. Widgets don’t map exactly to Android views, but while you’re getting acquainted with how Flutter works you can think of them as “the way you declare and construct UI”.

However, these have a few differences to a `View`. To start, widgets have a different lifespan: they are immutable and only exist until they need to be changed. Whenever widgets or their state change, Flutter’s framework creates a new tree of widget instances. In comparison, an Android view is drawn once and does not redraw until `invalidate` is called.

Flutter’s widgets are lightweight, in part due to their immutability. Because they aren’t views themselves, and aren’t directly drawing anything, but rather are a description of the UI and its semantics that get “inflated” into actual view objects under the hood.

Flutter includes the [Material Components](https://m3.material.io/develop/flutter) library. These are widgets that implement the [Material Design guidelines](https://m3.material.io/styles). Material Design is a flexible design system [optimized for all platforms](https://m3.material.io/develop), including iOS.

But Flutter is flexible and expressive enough to implement any design language. For example, on iOS, you can use the [Cupertino widgets](https://docs.flutter.dev/ui/widgets/cupertino) to produce an interface that looks like [Apple’s iOS design language](https://developer.apple.com/design/resources/).

### How do I update widgets?

In Android, you update your views by directly mutating them. However, in Flutter, `Widget`s are immutable and are not updated directly, instead you have to work with the widget’s state.

This is where the concept of `Stateful` and `Stateless` widgets comes from. A `StatelessWidget` is just what it sounds like—a widget with no state information.

`StatelessWidgets` are useful when the part of the user interface you are describing does not depend on anything other than the configuration information in the object.

For example, in Android, this is similar to placing an `ImageView` with your logo. The logo is not going to change during runtime, so use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received after making an HTTP call or user interaction then you have to work with `StatefulWidget` and tell the Flutter framework that the widget’s `State` has been updated so it can update that widget.

The important thing to note here is at the core both stateless and stateful widgets behave the same. They rebuild every frame, the difference is the `StatefulWidget` has a `State` object that stores state data across frames and restores it.

If you are in doubt, then always remember this rule: if a widget changes (because of user interactions, for example) it’s stateful. However, if a widget reacts to change, the containing parent widget can still be stateless if it doesn’t itself react to change.

The following example shows how to use a `StatelessWidget`. A common `StatelessWidget` is the `Text` widget. If you look at the implementation of the `Text` widget you’ll find that it subclasses `StatelessWidget`.

```
<span>Text</span><span>(</span><span>
  </span><span>'I like Flutter!'</span><span>,</span><span>
  style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>),</span><span>
</span><span>);</span>
```

As you can see, the `Text` Widget has no state information associated with it, it renders what is passed in its constructors and nothing more.

But, what if you want to make “I Like Flutter” change dynamically, for example when clicking a `FloatingActionButton`?

To achieve this, wrap the `Text` widget in a `StatefulWidget` and update it when the user clicks the button.

For example:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Default placeholder text.</span><span>
  </span><span>String</span><span> textToShow </span><span>=</span><span> </span><span>'I Like Flutter'</span><span>;</span><span>

  </span><span>void</span><span> _updateText</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      </span><span>// Update the text.</span><span>
      textToShow </span><span>=</span><span> </span><span>'Flutter is Awesome!'</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>textToShow</span><span>)),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> _updateText</span><span>,</span><span>
        tooltip</span><span>:</span><span> </span><span>'Update Text'</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>update</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do I lay out my widgets? Where is my XML layout file?

In Android, you write layouts in XML, but in Flutter you write your layouts with a widget tree.

The following example shows how to display a simple widget with padding:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
    appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
    </span><span>),</span><span>
    body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
        style</span><span>:</span><span> </span><span>ElevatedButton</span><span>.</span><span>styleFrom</span><span>(</span><span>
          padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>only</span><span>(</span><span>left</span><span>:</span><span> </span><span>20</span><span>,</span><span> right</span><span>:</span><span> </span><span>30</span><span>),</span><span>
        </span><span>),</span><span>
        onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Hello'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

You can view some of the layouts that Flutter has to offer in the [widget catalog](https://docs.flutter.dev/ui/widgets/layout).

### How do I add or remove a component from my layout?

In Android, you call `addChild()` or `removeChild()` on a parent to dynamically add or remove child views. In Flutter, because widgets are immutable there is no direct equivalent to `addChild()`. Instead, you can pass a function to the parent that returns a widget, and control that child’s creation with a boolean flag.

For example, here is how you can toggle between two widgets when you click on a `FloatingActionButton`:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Default value for toggle.</span><span>
  </span><span>bool</span><span> toggle </span><span>=</span><span> </span><span>true</span><span>;</span><span>
  </span><span>void</span><span> _toggle</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      toggle </span><span>=</span><span> </span><span>!</span><span>toggle</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> _getToggleChild</span><span>()</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>toggle</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Toggle One'</span><span>);</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>ElevatedButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Toggle Two'</span><span>),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> _getToggleChild</span><span>(),</span><span>
      </span><span>),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> _toggle</span><span>,</span><span>
        tooltip</span><span>:</span><span> </span><span>'Update Text'</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>update</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do I animate a widget?

In Android, you either create animations using XML, or call the `animate()` method on a view. In Flutter, animate widgets using the animation library by wrapping widgets inside an animated widget.

In Flutter, use an `AnimationController` which is an `Animation<double>` that can pause, seek, stop and reverse the animation. It requires a `Ticker` that signals when vsync happens, and produces a linear interpolation between 0 and 1 on each frame while it’s running. You then create one or more `Animation`s and attach them to the controller.

For example, you might use `CurvedAnimation` to implement an animation along an interpolated curve. In this sense, the controller is the “master” source of the animation progress and the `CurvedAnimation` computes the curve that replaces the controller’s default linear motion. Like widgets, animations in Flutter work with composition.

When building the widget tree you assign the `Animation` to an animated property of a widget, such as the opacity of a `FadeTransition`, and tell the controller to start the animation.

The following example shows how to write a `FadeTransition` that fades the widget into a logo when you press the `FloatingActionButton`:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>FadeAppTest</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>FadeAppTest</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>FadeAppTest</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Fade Demo'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>MyFadeTest</span><span>(</span><span>title</span><span>:</span><span> </span><span>'Fade Demo'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyFadeTest</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyFadeTest</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>
  @override
  </span><span>State</span><span>&lt;</span><span>MyFadeTest</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyFadeTest</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyFadeTest </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyFadeTest</span><span>&gt;</span><span> </span><span>with</span><span> </span><span>TickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>AnimationController</span><span> controller</span><span>;</span><span>
  </span><span>late</span><span> </span><span>CurvedAnimation</span><span> curve</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    controller </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
      duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>2000</span><span>),</span><span>
      vsync</span><span>:</span><span> </span><span>this</span><span>,</span><span>
    </span><span>);</span><span>
    curve </span><span>=</span><span> </span><span>CurvedAnimation</span><span>(</span><span>
      parent</span><span>:</span><span> controller</span><span>,</span><span>
      curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>easeIn</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>widget</span><span>.</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>FadeTransition</span><span>(</span><span>
          opacity</span><span>:</span><span> curve</span><span>,</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(</span><span>
            size</span><span>:</span><span> </span><span>100</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        tooltip</span><span>:</span><span> </span><span>'Fade'</span><span>,</span><span>
        onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          controller</span><span>.</span><span>forward</span><span>();</span><span>
        </span><span>},</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>brush</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

For more information, see [Animation & Motion widgets](https://docs.flutter.dev/ui/widgets/animation), the [Animations tutorial](https://docs.flutter.dev/ui/animations/tutorial), and the [Animations overview](https://docs.flutter.dev/ui/animations).

### How do I use a Canvas to draw/paint?

In Android, you would use the `Canvas` and `Drawable` to draw images and shapes to the screen. Flutter has a similar `Canvas` API as well, since it’s based on the same low-level rendering engine, Skia. As a result, painting to a canvas in Flutter is a very familiar task for Android developers.

Flutter has two classes that help you draw to the canvas: `CustomPaint` and `CustomPainter`, the latter of which implements your algorithm to draw to the canvas.

To learn how to implement a signature painter in Flutter, see Collin’s answer on [Custom Paint](https://stackoverflow.com/questions/46241071/create-signature-area-for-mobile-app-in-dart-flutter).

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>home</span><span>:</span><span> </span><span>DemoApp</span><span>()));</span><span>

</span><span>class</span><span> </span><span>DemoApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>DemoApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>Scaffold</span><span>(</span><span>body</span><span>:</span><span> </span><span>Signature</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>Signature</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>Signature</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>SignatureState</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> </span><span>SignatureState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SignatureState</span><span> </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>Signature</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Offset</span><span>?&gt;</span><span> _points </span><span>=</span><span> </span><span>&lt;</span><span>Offset</span><span>&gt;[];</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onPanUpdate</span><span>:</span><span> </span><span>(</span><span>details</span><span>)</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          </span><span>RenderBox</span><span>?</span><span> referenceBox </span><span>=</span><span> context</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
          </span><span>Offset</span><span> localPosition </span><span>=</span><span>
              referenceBox</span><span>.</span><span>globalToLocal</span><span>(</span><span>details</span><span>.</span><span>globalPosition</span><span>);</span><span>
          _points </span><span>=</span><span> </span><span>List</span><span>.</span><span>from</span><span>(</span><span>_points</span><span>)..</span><span>add</span><span>(</span><span>localPosition</span><span>);</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
      onPanEnd</span><span>:</span><span> </span><span>(</span><span>details</span><span>)</span><span> </span><span>=&gt;</span><span> _points</span><span>.</span><span>add</span><span>(</span><span>null</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>CustomPaint</span><span>(</span><span>
        painter</span><span>:</span><span> </span><span>SignaturePainter</span><span>(</span><span>_points</span><span>),</span><span>
        size</span><span>:</span><span> </span><span>Size</span><span>.</span><span>infinite</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SignaturePainter</span><span> </span><span>extends</span><span> </span><span>CustomPainter</span><span> </span><span>{</span><span>
  </span><span>SignaturePainter</span><span>(</span><span>this</span><span>.</span><span>points</span><span>);</span><span>
  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Offset</span><span>?&gt;</span><span> points</span><span>;</span><span>
  @override
  </span><span>void</span><span> paint</span><span>(</span><span>Canvas</span><span> canvas</span><span>,</span><span> </span><span>Size</span><span> size</span><span>)</span><span> </span><span>{</span><span>
    </span><span>var</span><span> paint </span><span>=</span><span> </span><span>Paint</span><span>()</span><span>
      </span><span>..</span><span>color </span><span>=</span><span> </span><span>Colors</span><span>.</span><span>black
      </span><span>..</span><span>strokeCap </span><span>=</span><span> </span><span>StrokeCap</span><span>.</span><span>round
      </span><span>..</span><span>strokeWidth </span><span>=</span><span> </span><span>5</span><span>;</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> points</span><span>.</span><span>length </span><span>-</span><span> </span><span>1</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      </span><span>if</span><span> </span><span>(</span><span>points</span><span>[</span><span>i</span><span>]</span><span> </span><span>!=</span><span> </span><span>null</span><span> </span><span>&amp;&amp;</span><span> points</span><span>[</span><span>i </span><span>+</span><span> </span><span>1</span><span>]</span><span> </span><span>!=</span><span> </span><span>null</span><span>)</span><span> </span><span>{</span><span>
        canvas</span><span>.</span><span>drawLine</span><span>(</span><span>points</span><span>[</span><span>i</span><span>]!,</span><span> points</span><span>[</span><span>i </span><span>+</span><span> </span><span>1</span><span>]!,</span><span> paint</span><span>);</span><span>
      </span><span>}</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  @override
  </span><span>bool</span><span> shouldRepaint</span><span>(</span><span>SignaturePainter</span><span> oldDelegate</span><span>)</span><span> </span><span>=&gt;</span><span>
      oldDelegate</span><span>.</span><span>points </span><span>!=</span><span> points</span><span>;</span><span>
</span><span>}</span>
```

### How do I build custom widgets?

In Android, you typically subclass `View`, or use a pre-existing view, to override and implement methods that achieve the desired behavior.

In Flutter, build a custom widget by [composing](https://docs.flutter.dev/resources/architectural-overview#composition) smaller widgets (instead of extending them). It is somewhat similar to implementing a custom `ViewGroup` in Android, where all the building blocks are already existing, but you provide a different behavior—for example, custom layout logic.

For example, how do you build a `CustomButton` that takes a label in the constructor? Create a CustomButton that composes a `ElevatedButton` with a label, rather than by extending `ElevatedButton`:

```
<span>class</span><span> </span><span>CustomButton</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>String</span><span> label</span><span>;</span><span>

  </span><span>const</span><span> </span><span>CustomButton</span><span>(</span><span>this</span><span>.</span><span>label</span><span>,</span><span> </span><span>{</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ElevatedButton</span><span>(</span><span>
      onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>label</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Then use `CustomButton`, just as you’d use any other Flutter widget:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>CustomButton</span><span>(</span><span>'Hello'</span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

## Intents

### What is the equivalent of an Intent in Flutter?

In Android, there are two main use cases for `Intent`s: navigating between Activities, and communicating with components. Flutter, on the other hand, does not have the concept of intents, although you can still start intents through native integrations (using [a plugin](https://pub.dev/packages/android_intent)).

Flutter doesn’t really have a direct equivalent to activities and fragments; rather, in Flutter you navigate between screens, using a `Navigator` and `Route`s, all within the same `Activity`.

A `Route` is an abstraction for a “screen” or “page” of an app, and a `Navigator` is a widget that manages routes. A route roughly maps to an `Activity`, but it does not carry the same meaning. A navigator can push and pop routes to move from screen to screen. Navigators work like a stack on which you can `push()` new routes you want to navigate to, and from which you can `pop()` routes when you want to “go back”.

In Android, you declare your activities inside the app’s `AndroidManifest.xml`.

In Flutter, you have a couple options to navigate between pages:

-   Specify a `Map` of route names. (using `MaterialApp`)
-   Directly navigate to a route. (using `WidgetsApp`)

The following example builds a Map.

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>MaterialApp</span><span>(</span><span>
    home</span><span>:</span><span> </span><span>const</span><span> </span><span>MyAppHome</span><span>(),</span><span> </span><span>// Becomes the route named '/'.</span><span>
    routes</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>WidgetBuilder</span><span>&gt;{</span><span>
      </span><span>'/a'</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>MyPage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'page A'</span><span>),</span><span>
      </span><span>'/b'</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>MyPage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'page B'</span><span>),</span><span>
      </span><span>'/c'</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>MyPage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'page C'</span><span>),</span><span>
    </span><span>},</span><span>
  </span><span>));</span><span>
</span><span>}</span>
```

Navigate to a route by `push`ing its name to the `Navigator`.

```
<span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/b'</span><span>);</span>
```

The other popular use-case for `Intent`s is to call external components such as a Camera or File picker. For this, you would need to create a native platform integration (or use an [existing plugin](https://pub.dev/flutter/)).

To learn how to build a native platform integration, see [developing packages and plugins](https://docs.flutter.dev/packages-and-plugins/developing-packages).

### How do I handle incoming intents from external applications in Flutter?

Flutter can handle incoming intents from Android by directly talking to the Android layer and requesting the data that was shared.

The following example registers a text share intent filter on the native activity that runs our Flutter code, so other apps can share text with our Flutter app.

The basic flow implies that we first handle the shared text data on the Android native side (in our `Activity`), and then wait until Flutter requests for the data to provide it using a `MethodChannel`.

First, register the intent filter for all intents in `AndroidManifest.xml`:

```
<span>&lt;activity</span>
  <span>android:name=</span><span>".MainActivity"</span>
  <span>android:launchMode=</span><span>"singleTop"</span>
  <span>android:theme=</span><span>"@style/LaunchTheme"</span>
  <span>android:configChanges=</span><span>"orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection"</span>
  <span>android:hardwareAccelerated=</span><span>"true"</span>
  <span>android:windowSoftInputMode=</span><span>"adjustResize"</span><span>&gt;</span>
  <span>&lt;!-- ... --&gt;</span>
  <span>&lt;intent-filter&gt;</span>
    <span>&lt;action</span> <span>android:name=</span><span>"android.intent.action.SEND"</span> <span>/&gt;</span>
    <span>&lt;category</span> <span>android:name=</span><span>"android.intent.category.DEFAULT"</span> <span>/&gt;</span>
    <span>&lt;data</span> <span>android:mimeType=</span><span>"text/plain"</span> <span>/&gt;</span>
  <span>&lt;/intent-filter&gt;</span>
<span>&lt;/activity&gt;</span>
```

Then in `MainActivity`, handle the intent, extract the text that was shared from the intent, and hold onto it. When Flutter is ready to process, it requests the data using a platform channel, and it’s sent across from the native side:

```
<span>package</span> <span>com.example.shared</span><span>;</span>

<span>import</span> <span>android.content.Intent</span><span>;</span>
<span>import</span> <span>android.os.Bundle</span><span>;</span>

<span>import</span> <span>androidx.annotation.NonNull</span><span>;</span>

<span>import</span> <span>io.flutter.plugin.common.MethodChannel</span><span>;</span>
<span>import</span> <span>io.flutter.embedding.android.FlutterActivity</span><span>;</span>
<span>import</span> <span>io.flutter.embedding.engine.FlutterEngine</span><span>;</span>
<span>import</span> <span>io.flutter.plugins.GeneratedPluginRegistrant</span><span>;</span>

<span>public</span> <span>class</span> <span>MainActivity</span> <span>extends</span> <span>FlutterActivity</span> <span>{</span>

  <span>private</span> <span>String</span> <span>sharedText</span><span>;</span>
  <span>private</span> <span>static</span> <span>final</span> <span>String</span> <span>CHANNEL</span> <span>=</span> <span>"app.channel.shared.data"</span><span>;</span>

  <span>@Override</span>
  <span>protected</span> <span>void</span> <span>onCreate</span><span>(</span><span>Bundle</span> <span>savedInstanceState</span><span>)</span> <span>{</span>
    <span>super</span><span>.</span><span>onCreate</span><span>(</span><span>savedInstanceState</span><span>);</span>
    <span>Intent</span> <span>intent</span> <span>=</span> <span>getIntent</span><span>();</span>
    <span>String</span> <span>action</span> <span>=</span> <span>intent</span><span>.</span><span>getAction</span><span>();</span>
    <span>String</span> <span>type</span> <span>=</span> <span>intent</span><span>.</span><span>getType</span><span>();</span>

    <span>if</span> <span>(</span><span>Intent</span><span>.</span><span>ACTION_SEND</span><span>.</span><span>equals</span><span>(</span><span>action</span><span>)</span> <span>&amp;&amp;</span> <span>type</span> <span>!=</span> <span>null</span><span>)</span> <span>{</span>
      <span>if</span> <span>(</span><span>"text/plain"</span><span>.</span><span>equals</span><span>(</span><span>type</span><span>))</span> <span>{</span>
        <span>handleSendText</span><span>(</span><span>intent</span><span>);</span> <span>// Handle text being sent</span>
      <span>}</span>
    <span>}</span>
  <span>}</span>

  <span>@Override</span>
  <span>public</span> <span>void</span> <span>configureFlutterEngine</span><span>(</span><span>@NonNull</span> <span>FlutterEngine</span> <span>flutterEngine</span><span>)</span> <span>{</span>
      <span>GeneratedPluginRegistrant</span><span>.</span><span>registerWith</span><span>(</span><span>flutterEngine</span><span>);</span>

      <span>new</span> <span>MethodChannel</span><span>(</span><span>flutterEngine</span><span>.</span><span>getDartExecutor</span><span>().</span><span>getBinaryMessenger</span><span>(),</span> <span>CHANNEL</span><span>)</span>
              <span>.</span><span>setMethodCallHandler</span><span>(</span>
                      <span>(</span><span>call</span><span>,</span> <span>result</span><span>)</span> <span>-&gt;</span> <span>{</span>
                          <span>if</span> <span>(</span><span>call</span><span>.</span><span>method</span><span>.</span><span>contentEquals</span><span>(</span><span>"getSharedText"</span><span>))</span> <span>{</span>
                              <span>result</span><span>.</span><span>success</span><span>(</span><span>sharedText</span><span>);</span>
                              <span>sharedText</span> <span>=</span> <span>null</span><span>;</span>
                          <span>}</span>
                      <span>}</span>
              <span>);</span>
  <span>}</span>

  <span>void</span> <span>handleSendText</span><span>(</span><span>Intent</span> <span>intent</span><span>)</span> <span>{</span>
    <span>sharedText</span> <span>=</span> <span>intent</span><span>.</span><span>getStringExtra</span><span>(</span><span>Intent</span><span>.</span><span>EXTRA_TEXT</span><span>);</span>
  <span>}</span>
<span>}</span>
```

Finally, request the data from the Flutter side when the widget is rendered:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/services.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample Shared App Handler'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> platform </span><span>=</span><span> </span><span>MethodChannel</span><span>(</span><span>'app.channel.shared.data'</span><span>);</span><span>
  </span><span>String</span><span> dataShared </span><span>=</span><span> </span><span>'No data'</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    getSharedText</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>dataShared</span><span>)));</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> getSharedText</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>var</span><span> sharedData </span><span>=</span><span> </span><span>await</span><span> platform</span><span>.</span><span>invokeMethod</span><span>(</span><span>'getSharedText'</span><span>);</span><span>
    </span><span>if</span><span> </span><span>(</span><span>sharedData </span><span>!=</span><span> </span><span>null</span><span>)</span><span> </span><span>{</span><span>
      setState</span><span>(()</span><span> </span><span>{</span><span>
        dataShared </span><span>=</span><span> sharedData</span><span>;</span><span>
      </span><span>});</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### What is the equivalent of startActivityForResult()?

The `Navigator` class handles routing in Flutter and is used to get a result back from a route that you have pushed on the stack. This is done by `await`ing on the `Future` returned by `push()`.

For example, to start a location route that lets the user select their location, you could do the following:

```
<span>Object</span><span>?</span><span> coordinates </span><span>=</span><span> </span><span>await</span><span> </span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/location'</span><span>);</span>
```

And then, inside your location route, once the user has selected their location you can `pop` the stack with the result:

```
<span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pop</span><span>({</span><span>'lat'</span><span>:</span><span> </span><span>43.821757</span><span>,</span><span> </span><span>'long'</span><span>:</span><span> </span><span>-</span><span>79.226392</span><span>});</span>
```

## Async UI

### What is the equivalent of runOnUiThread() in Flutter?

Dart has a single-threaded execution model, with support for `Isolate`s (a way to run Dart code on another thread), an event loop, and asynchronous programming. Unless you spawn an `Isolate`, your Dart code runs in the main UI thread and is driven by an event loop. Flutter’s event loop is equivalent to Android’s main `Looper`—that is, the `Looper` that is attached to the main thread.

Dart’s single-threaded model doesn’t mean you need to run everything as a blocking operation that causes the UI to freeze. Unlike Android, which requires you to keep the main thread free at all times, in Flutter, use the asynchronous facilities that the Dart language provides, such as `async`/`await`, to perform asynchronous work. You might be familiar with the `async`/`await` paradigm if you’ve used it in C#, Javascript, or if you have used Kotlin’s coroutines.

For example, you can run network code without causing the UI to hang by using `async`/`await` and letting Dart do the heavy lifting:

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>var</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
  http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    widgets </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

Once the `await`ed network call is done, update the UI by calling `setState()`, which triggers a rebuild of the widget sub-tree and updates the data.

The following example loads data asynchronously and displays it in a `ListView`:

```
<span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    loadData</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
        itemCount</span><span>:</span><span> widgets</span><span>.</span><span>length</span><span>,</span><span>
        itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> position</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> getRow</span><span>(</span><span>position</span><span>);</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> i</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>"Row ${widgets[i]["</span><span>title</span><span>"]}"</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>var</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
    http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      widgets </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Refer to the next section for more information on doing work in the background, and how Flutter differs from Android.

### How do you move work to a background thread?

In Android, when you want to access a network resource you would typically move to a background thread and do the work, as to not block the main thread, and avoid ANRs. For example, you might be using an `AsyncTask`, a `LiveData`, an `IntentService`, a `JobScheduler` job, or an RxJava pipeline with a scheduler that works on background threads.

Since Flutter is single threaded and runs an event loop (like Node.js), you don’t have to worry about thread management or spawning background threads. If you’re doing I/O-bound work, such as disk access or a network call, then you can safely use `async`/`await` and you’re all set. If, on the other hand, you need to do computationally intensive work that keeps the CPU busy, you want to move it to an `Isolate` to avoid blocking the event loop, like you would keep _any_ sort of work out of the main thread in Android.

For I/O-bound work, declare the function as an `async` function, and `await` on long-running tasks inside the function:

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>var</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
  http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    widgets </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

This is how you would typically do network or database calls, which are both I/O operations.

On Android, when you extend `AsyncTask`, you typically override 3 methods, `onPreExecute()`, `doInBackground()` and `onPostExecute()`. There is no equivalent in Flutter, since you `await` on a long running function, and Dart’s event loop takes care of the rest.

However, there are times when you might be processing a large amount of data and your UI hangs. In Flutter, use `Isolate`s to take advantage of multiple CPU cores to do long-running or computationally intensive tasks.

Isolates are separate execution threads that do not share any memory with the main execution memory heap. This means you can’t access variables from the main thread, or update your UI by calling `setState()`. Unlike Android threads, Isolates are true to their name, and cannot share memory (in the form of static fields, for example).

The following example shows, in a simple isolate, how to share data back to the main thread to update the UI.

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>ReceivePort</span><span> receivePort </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
  </span><span>await</span><span> </span><span>Isolate</span><span>.</span><span>spawn</span><span>(</span><span>dataLoader</span><span>,</span><span> receivePort</span><span>.</span><span>sendPort</span><span>);</span><span>

  </span><span>// The 'echo' isolate sends its SendPort as the first message.</span><span>
  </span><span>SendPort</span><span> sendPort </span><span>=</span><span> </span><span>await</span><span> receivePort</span><span>.</span><span>first</span><span>;</span><span>

  </span><span>List</span><span> msg </span><span>=</span><span> </span><span>await</span><span> sendReceive</span><span>(</span><span>
    sendPort</span><span>,</span><span>
    </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
  </span><span>);</span><span>

  setState</span><span>(()</span><span> </span><span>{</span><span>
    widgets </span><span>=</span><span> msg</span><span>;</span><span>
  </span><span>});</span><span>
</span><span>}</span><span>

</span><span>// The entry point for the isolate.</span><span>
</span><span>static</span><span> </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> dataLoader</span><span>(</span><span>SendPort</span><span> sendPort</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Open the ReceivePort for incoming messages.</span><span>
  </span><span>ReceivePort</span><span> port </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>

  </span><span>// Notify any other isolates what port this isolate listens to.</span><span>
  sendPort</span><span>.</span><span>send</span><span>(</span><span>port</span><span>.</span><span>sendPort</span><span>);</span><span>

  </span><span>await</span><span> </span><span>for</span><span> </span><span>(</span><span>var</span><span> msg </span><span>in</span><span> port</span><span>)</span><span> </span><span>{</span><span>
    </span><span>String</span><span> data </span><span>=</span><span> msg</span><span>[</span><span>0</span><span>];</span><span>
    </span><span>SendPort</span><span> replyTo </span><span>=</span><span> msg</span><span>[</span><span>1</span><span>];</span><span>

    </span><span>String</span><span> dataURL </span><span>=</span><span> data</span><span>;</span><span>
    http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>dataURL</span><span>));</span><span>
    </span><span>// Lots of JSON to parse</span><span>
    replyTo</span><span>.</span><span>send</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>));</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>Future</span><span> sendReceive</span><span>(</span><span>SendPort</span><span> port</span><span>,</span><span> msg</span><span>)</span><span> </span><span>{</span><span>
  </span><span>ReceivePort</span><span> response </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
  port</span><span>.</span><span>send</span><span>([</span><span>msg</span><span>,</span><span> response</span><span>.</span><span>sendPort</span><span>]);</span><span>
  </span><span>return</span><span> response</span><span>.</span><span>first</span><span>;</span><span>
</span><span>}</span>
```

Here, `dataLoader()` is the `Isolate` that runs in its own separate execution thread. In the isolate you can perform more CPU intensive processing (parsing a big JSON, for example), or perform computationally intensive math, such as encryption or signal processing.

You can run the full example below:

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:isolate'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    loadData</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getBody</span><span>()</span><span> </span><span>{</span><span>
    </span><span>bool</span><span> showLoadingDialog </span><span>=</span><span> widgets</span><span>.</span><span>isEmpty</span><span>;</span><span>
    </span><span>if</span><span> </span><span>(</span><span>showLoadingDialog</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> getProgressDialog</span><span>();</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
      </span><span>return</span><span> getListView</span><span>();</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getProgressDialog</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>CircularProgressIndicator</span><span>());</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> getBody</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>ListView</span><span> getListView</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
      itemCount</span><span>:</span><span> widgets</span><span>.</span><span>length</span><span>,</span><span>
      itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> position</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> getRow</span><span>(</span><span>position</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> i</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>"Row ${widgets[i]["</span><span>title</span><span>"]}"</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>ReceivePort</span><span> receivePort </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
    </span><span>await</span><span> </span><span>Isolate</span><span>.</span><span>spawn</span><span>(</span><span>dataLoader</span><span>,</span><span> receivePort</span><span>.</span><span>sendPort</span><span>);</span><span>

    </span><span>// The 'echo' isolate sends its SendPort as the first message.</span><span>
    </span><span>SendPort</span><span> sendPort </span><span>=</span><span> </span><span>await</span><span> receivePort</span><span>.</span><span>first</span><span>;</span><span>

    </span><span>List</span><span> msg </span><span>=</span><span> </span><span>await</span><span> sendReceive</span><span>(</span><span>
      sendPort</span><span>,</span><span>
      </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
    </span><span>);</span><span>

    setState</span><span>(()</span><span> </span><span>{</span><span>
      widgets </span><span>=</span><span> msg</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>// The entry point for the isolate.</span><span>
  </span><span>static</span><span> </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> dataLoader</span><span>(</span><span>SendPort</span><span> sendPort</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Open the ReceivePort for incoming messages.</span><span>
    </span><span>ReceivePort</span><span> port </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>

    </span><span>// Notify any other isolates what port this isolate listens to.</span><span>
    sendPort</span><span>.</span><span>send</span><span>(</span><span>port</span><span>.</span><span>sendPort</span><span>);</span><span>

    </span><span>await</span><span> </span><span>for</span><span> </span><span>(</span><span>var</span><span> msg </span><span>in</span><span> port</span><span>)</span><span> </span><span>{</span><span>
      </span><span>String</span><span> data </span><span>=</span><span> msg</span><span>[</span><span>0</span><span>];</span><span>
      </span><span>SendPort</span><span> replyTo </span><span>=</span><span> msg</span><span>[</span><span>1</span><span>];</span><span>

      </span><span>String</span><span> dataURL </span><span>=</span><span> data</span><span>;</span><span>
      http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>dataURL</span><span>));</span><span>
      </span><span>// Lots of JSON to parse</span><span>
      replyTo</span><span>.</span><span>send</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>));</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span> sendReceive</span><span>(</span><span>SendPort</span><span> port</span><span>,</span><span> msg</span><span>)</span><span> </span><span>{</span><span>
    </span><span>ReceivePort</span><span> response </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
    port</span><span>.</span><span>send</span><span>([</span><span>msg</span><span>,</span><span> response</span><span>.</span><span>sendPort</span><span>]);</span><span>
    </span><span>return</span><span> response</span><span>.</span><span>first</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### What is the equivalent of OkHttp on Flutter?

Making a network call in Flutter is easy when you use the popular [`http` package](https://pub.dev/packages/http).

While the http package doesn’t have every feature found in OkHttp, it abstracts away much of the networking that you would normally implement yourself, making it a simple way to make network calls.

To add the `http` package as a dependency, run `flutter pub add`:

To make a network call, call `await` on the `async` function `http.get()`:

```
<span>import</span><span> </span><span>'dart:developer'</span><span> </span><span>as</span><span> developer</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>var</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
  http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  developer</span><span>.</span><span>log</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
</span><span>}</span>
```

### How do I show the progress for a long-running task?

In Android you would typically show a `ProgressBar` view in your UI while executing a long running task on a background thread.

In Flutter, use a `ProgressIndicator` widget. Show the progress programmatically by controlling when it’s rendered through a boolean flag. Tell Flutter to update its state before your long-running task starts, and hide it after it ends.

In the following example, the build function is separated into three different functions. If `showLoadingDialog` is `true` (when `widgets.isEmpty`), then render the `ProgressIndicator`. Otherwise, render the `ListView` with the data returned from a network call.

```
<span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    loadData</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getBody</span><span>()</span><span> </span><span>{</span><span>
    </span><span>bool</span><span> showLoadingDialog </span><span>=</span><span> widgets</span><span>.</span><span>isEmpty</span><span>;</span><span>
    </span><span>if</span><span> </span><span>(</span><span>showLoadingDialog</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> getProgressDialog</span><span>();</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
      </span><span>return</span><span> getListView</span><span>();</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getProgressDialog</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>CircularProgressIndicator</span><span>());</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> getBody</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>ListView</span><span> getListView</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
      itemCount</span><span>:</span><span> widgets</span><span>.</span><span>length</span><span>,</span><span>
      itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> position</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> getRow</span><span>(</span><span>position</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> i</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>"Row ${widgets[i]["</span><span>title</span><span>"]}"</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>var</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
    http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      widgets </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Project structure & resources

### Where do I store my resolution-dependent image files?

While Android treats resources and assets as distinct items, Flutter apps have only assets. All resources that would live in the `res/drawable-*` folders on Android, are placed in an assets folder for Flutter.

Flutter follows a simple density-based format like iOS. Assets might be `1.0x`, `2.0x`, `3.0x`, or any other multiplier. Flutter doesn’t have `dp`s but there are logical pixels, which are basically the same as device-independent pixels. Flutter’s [`devicePixelRatio`](https://api.flutter.dev/flutter/dart-ui/FlutterView/devicePixelRatio.html) expresses the ratio of physical pixels in a single logical pixel.

The equivalent to Android’s density buckets are:

| Android density qualifier | Flutter pixel ratio |
| --- | --- |
| `ldpi` | `0.75x` |
| `mdpi` | `1.0x` |
| `hdpi` | `1.5x` |
| `xhdpi` | `2.0x` |
| `xxhdpi` | `3.0x` |
| `xxxhdpi` | `4.0x` |

Assets are located in any arbitrary folder—Flutter has no predefined folder structure. You declare the assets (with location) in the `pubspec.yaml` file, and Flutter picks them up.

Assets stored in the native asset folder are accessed on the native side using Android’s `AssetManager`:

```
<span>val</span> <span>flutterAssetStream</span> <span>=</span> <span>assetManager</span><span>.</span><span>open</span><span>(</span><span>"flutter_assets/assets/my_flutter_asset.png"</span><span>)</span>
```

Flutter can’t access native resources or assets.

To add a new image asset called `my_icon.png` to our Flutter project, for example, and deciding that it should live in a folder we arbitrarily called `images`, you would put the base image (1.0x) in the `images` folder, and all the other variants in sub-folders called with the appropriate ratio multiplier:

```
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image
```

Next, you’ll need to declare these images in your `pubspec.yaml` file:

```
<span>assets</span><span>:</span>
 <span>-</span> <span>images/my_icon.jpeg</span>
```

You can then access your images using `AssetImage`:

```
<span>AssetImage</span><span>(</span><span>'images/my_icon.jpeg'</span><span>)</span>
```

or directly in an `Image` widget:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/my_image.png'</span><span>);</span><span>
</span><span>}</span>
```

### Where do I store strings? How do I handle localization?

Flutter currently doesn’t have a dedicated resources-like system for strings. At the moment, the best practice is to hold your copy text in a class as static fields and accessing them from there. For example:

```
<span>class</span><span> </span><span>Strings</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>String</span><span> welcomeMessage </span><span>=</span><span> </span><span>'Welcome To Flutter'</span><span>;</span><span>
</span><span>}</span>
```

Then in your code, you can access your strings as such:

```
<span>Text</span><span>(</span><span>Strings</span><span>.</span><span>welcomeMessage</span><span>);</span>
```

Flutter has basic support for accessibility on Android, though this feature is a work in progress.

Flutter developers are encouraged to use the [intl package](https://pub.dev/packages/intl) for internationalization and localization.

### What is the equivalent of a Gradle file? How do I add dependencies?

In Android, you add dependencies by adding to your Gradle build script. Flutter uses Dart’s own build system, and the Pub package manager. The tools delegate the building of the native Android and iOS wrapper apps to the respective build systems.

While there are Gradle files under the `android` folder in your Flutter project, only use these if you are adding native dependencies needed for per-platform integration. In general, use `pubspec.yaml` to declare external dependencies to use in Flutter. A good place to find Flutter packages is [pub.dev](https://pub.dev/flutter/packages/).

## Activities and fragments

### What are the equivalent of activities and fragments in Flutter?

In Android, an `Activity` represents a single focused thing the user can do. A `Fragment` represents a behavior or a portion of user interface. Fragments are a way to modularize your code, compose sophisticated user interfaces for larger screens, and help scale your application UI. In Flutter, both of these concepts fall under the umbrella of `Widget`s.

To learn more about the UI for building Activities and Fragements, see the community-contributed Medium article, [Flutter for Android Developers: How to design Activity UI in Flutter](https://blog.usejournal.com/flutter-for-android-developers-how-to-design-activity-ui-in-flutter-4bf7b0de1e48).

As mentioned in the [Intents](https://docs.flutter.dev/get-started/flutter-for/android-devs#what-is-the-equivalent-of-an-intent-in-flutter) section, screens in Flutter are represented by `Widget`s since everything is a widget in Flutter. Use a `Navigator` to move between different `Route`s that represent different screens or pages, or perhaps different states or renderings of the same data.

### How do I listen to Android activity lifecycle events?

In Android, you can override methods from the `Activity` to capture lifecycle methods for the activity itself, or register `ActivityLifecycleCallbacks` on the `Application`. In Flutter, you have neither concept, but you can instead listen to lifecycle events by hooking into the `WidgetsBinding` observer and listening to the `didChangeAppLifecycleState()` change event.

The observable lifecycle events are:

-   `detached` — The application is still hosted on a flutter engine but is detached from any host views.
-   `inactive` — The application is in an inactive state and is not receiving user input.
-   `paused` — The application is not currently visible to the user, not responding to user input, and running in the background. This is equivalent to `onPause()` in Android.
-   `resumed` — The application is visible and responding to user input. This is equivalent to `onPostResume()` in Android.

For more details on the meaning of these states, see the [`AppLifecycleStatus` documentation](https://api.flutter.dev/flutter/dart-ui/AppLifecycleState.html).

As you might have noticed, only a small minority of the Activity lifecycle events are available; while `FlutterActivity` does capture almost all the activity lifecycle events internally and send them over to the Flutter engine, they’re mostly shielded away from you. Flutter takes care of starting and stopping the engine for you, and there is little reason for needing to observe the activity lifecycle on the Flutter side in most cases. If you need to observe the lifecycle to acquire or release any native resources, you should likely be doing it from the native side, at any rate.

Here’s an example of how to observe the lifecycle status of the containing activity:

```
<span>import</span><span> </span><span>'package:flutter/widgets.dart'</span><span>;</span><span>

</span><span>class</span><span> </span><span>LifecycleWatcher</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>LifecycleWatcher</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>LifecycleWatcher</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _LifecycleWatcherState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _LifecycleWatcherState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>LifecycleWatcher</span><span>&gt;</span><span>
    </span><span>with</span><span> </span><span>WidgetsBindingObserver</span><span> </span><span>{</span><span>
  </span><span>AppLifecycleState</span><span>?</span><span> _lastLifecycleState</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    </span><span>WidgetsBinding</span><span>.</span><span>instance</span><span>.</span><span>addObserver</span><span>(</span><span>this</span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    </span><span>WidgetsBinding</span><span>.</span><span>instance</span><span>.</span><span>removeObserver</span><span>(</span><span>this</span><span>);</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> didChangeAppLifecycleState</span><span>(</span><span>AppLifecycleState</span><span> state</span><span>)</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _lastLifecycleState </span><span>=</span><span> state</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>_lastLifecycleState </span><span>==</span><span> </span><span>null</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'This widget has not observed any lifecycle changes.'</span><span>,</span><span>
        textDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span>

    </span><span>return</span><span> </span><span>Text</span><span>(</span><span>
      </span><span>'The most recent lifecycle state this widget observed was: $_lastLifecycleState.'</span><span>,</span><span>
      textDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>LifecycleWatcher</span><span>()));</span><span>
</span><span>}</span>
```

## Layouts

### What is the equivalent of a LinearLayout?

In Android, a LinearLayout is used to lay your widgets out linearly—either horizontally or vertically. In Flutter, use the Row or Column widgets to achieve the same result.

If you notice the two code samples are identical with the exception of the “Row” and “Column” widget. The children are the same and this feature can be exploited to develop rich layouts that can change overtime with the same children.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>const</span><span> </span><span>Row</span><span>(</span><span>
    mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
    children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
      </span><span>Text</span><span>(</span><span>'Row One'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Row Two'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Row Three'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Row Four'</span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>const</span><span> </span><span>Column</span><span>(</span><span>
    mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
    children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
      </span><span>Text</span><span>(</span><span>'Column One'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Column Two'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Column Three'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Column Four'</span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

To learn more about building linear layouts, see the community-contributed Medium article [Flutter for Android Developers: How to design LinearLayout in Flutter](https://proandroiddev.com/flutter-for-android-developers-how-to-design-linearlayout-in-flutter-5d819c0ddf1a).

### What is the equivalent of a RelativeLayout?

A RelativeLayout lays your widgets out relative to each other. In Flutter, there are a few ways to achieve the same result.

You can achieve the result of a RelativeLayout by using a combination of Column, Row, and Stack widgets. You can specify rules for the widgets constructors on how the children are laid out relative to the parent.

For a good example of building a RelativeLayout in Flutter, see Collin’s answer on [StackOverflow](https://stackoverflow.com/questions/44396075/equivalent-of-relativelayout-in-flutter).

### What is the equivalent of a ScrollView?

In Android, use a ScrollView to lay out your widgets—if the user’s device has a smaller screen than your content, it scrolls.

In Flutter, the easiest way to do this is using the ListView widget. This might seem like overkill coming from Android, but in Flutter a ListView widget is both a ScrollView and an Android ListView.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>ListView</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
      </span><span>Text</span><span>(</span><span>'Row One'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Row Two'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Row Three'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'Row Four'</span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

### How do I handle landscape transitions in Flutter?

FlutterView handles the config change if AndroidManifest.xml contains:

```
<span>android:configChanges="orientation|screenSize"</span>
```

## Gesture detection and touch event handling

### How do I add an onClick listener to a widget in Flutter?

In Android, you can attach onClick to views such as button by calling the method ‘setOnClickListener’.

In Flutter there are two ways of adding touch listeners:

1.  If the Widget supports event detection, pass a function to it and handle it in the function. For example, the ElevatedButton has an `onPressed` parameter:

```
<span>@override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ElevatedButton</span><span>(</span><span>
      onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        developer</span><span>.</span><span>log</span><span>(</span><span>'click'</span><span>);</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Button'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span>
```

1.  If the Widget doesn’t support event detection, wrap the widget in a GestureDetector and pass a function to the `onTap` parameter.

```
<span>class</span><span> </span><span>SampleTapApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
    </span><span>const</span><span> </span><span>SampleTapApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

    @override
    </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
        body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>GestureDetector</span><span>(</span><span>
            onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
              developer</span><span>.</span><span>log</span><span>(</span><span>'tap'</span><span>);</span><span>
            </span><span>},</span><span>
            child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(</span><span>
              size</span><span>:</span><span> </span><span>200</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>}</span>
```

### How do I handle other gestures on widgets?

Using the GestureDetector, you can listen to a wide range of Gestures such as:

-   Tap
    
    -   `onTapDown` - A pointer that might cause a tap has contacted the screen at a particular location.
    -   `onTapUp` - A pointer that triggers a tap has stopped contacting the screen at a particular location.
    -   `onTap` - A tap has occurred.
    -   `onTapCancel` - The pointer that previously triggered the `onTapDown` won’t cause a tap.
-   Double tap
    
    -   `onDoubleTap` - The user tapped the screen at the same location twice in quick succession.
-   Long press
    
    -   `onLongPress` - A pointer has remained in contact with the screen at the same location for a long period of time.
-   Vertical drag
    
    -   `onVerticalDragStart` - A pointer has contacted the screen and might begin to move vertically.
    -   `onVerticalDragUpdate` - A pointer in contact with the screen has moved further in the vertical direction.
    -   `onVerticalDragEnd` - A pointer that was previously in contact with the screen and moving vertically is no longer in contact with the screen and was moving at a specific velocity when it stopped contacting the screen.
-   Horizontal drag
    
    -   `onHorizontalDragStart` - A pointer has contacted the screen and might begin to move horizontally.
    -   `onHorizontalDragUpdate` - A pointer in contact with the screen has moved further in the horizontal direction.
    -   `onHorizontalDragEnd` - A pointer that was previously in contact with the screen and moving horizontally is no longer in contact with the screen and was moving at a specific velocity when it stopped contacting the screen.

The following example shows a `GestureDetector` that rotates the Flutter logo on a double tap:

```
<span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleApp</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleApp</span><span>&gt;</span><span>
    </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>AnimationController</span><span> controller</span><span>;</span><span>
  </span><span>late</span><span> </span><span>CurvedAnimation</span><span> curve</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    controller </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
      vsync</span><span>:</span><span> </span><span>this</span><span>,</span><span>
      duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>2000</span><span>),</span><span>
    </span><span>);</span><span>
    curve </span><span>=</span><span> </span><span>CurvedAnimation</span><span>(</span><span>
      parent</span><span>:</span><span> controller</span><span>,</span><span>
      curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>easeIn</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>GestureDetector</span><span>(</span><span>
          onDoubleTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
            </span><span>if</span><span> </span><span>(</span><span>controller</span><span>.</span><span>isCompleted</span><span>)</span><span> </span><span>{</span><span>
              controller</span><span>.</span><span>reverse</span><span>();</span><span>
            </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
              controller</span><span>.</span><span>forward</span><span>();</span><span>
            </span><span>}</span><span>
          </span><span>},</span><span>
          child</span><span>:</span><span> </span><span>RotationTransition</span><span>(</span><span>
            turns</span><span>:</span><span> curve</span><span>,</span><span>
            child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(</span><span>
              size</span><span>:</span><span> </span><span>200</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Listviews & adapters

### What is the alternative to a ListView in Flutter?

The equivalent to a ListView in Flutter is … a ListView!

In an Android ListView, you create an adapter and pass it into the ListView, which renders each row with what your adapter returns. However, you have to make sure you recycle your rows, otherwise, you get all sorts of crazy visual glitches and memory issues.

Due to Flutter’s immutable widget pattern, you pass a list of widgets to your ListView, and Flutter takes care of making sure that scrolling is fast and smooth.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> _getListData</span><span>()),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> _getListData</span><span>()</span><span> </span><span>{</span><span>
    </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> </span><span>100</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      widgets</span><span>.</span><span>add</span><span>(</span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $i'</span><span>),</span><span>
      </span><span>));</span><span>
    </span><span>}</span><span>
    </span><span>return</span><span> widgets</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do I know which list item is clicked on?

In Android, the ListView has a method to find out which item was clicked, ‘onItemClickListener’. In Flutter, use the touch handling provided by the passed-in widgets.

```
<span>import</span><span> </span><span>'dart:developer'</span><span> </span><span>as</span><span> developer</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> _getListData</span><span>()),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> _getListData</span><span>()</span><span> </span><span>{</span><span>
    </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> </span><span>100</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      widgets</span><span>.</span><span>add</span><span>(</span><span>
        </span><span>GestureDetector</span><span>(</span><span>
          onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
            developer</span><span>.</span><span>log</span><span>(</span><span>'row tapped'</span><span>);</span><span>
          </span><span>},</span><span>
          child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
            padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
            child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $i'</span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span>
    </span><span>return</span><span> widgets</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do I update ListView’s dynamically?

On Android, you update the adapter and call `notifyDataSetChanged`.

In Flutter, if you were to update the list of widgets inside a `setState()`, you would quickly see that your data did not change visually. This is because when `setState()` is called, the Flutter rendering engine looks at the widget tree to see if anything has changed. When it gets to your `ListView`, it performs a `==` check, and determines that the two `ListView`s are the same. Nothing has changed, so no update is required.

For a simple way to update your `ListView`, create a new `List` inside of `setState()`, and copy the data from the old list to the new list. While this approach is simple, it is not recommended for large data sets, as shown in the next example.

```
<span>import</span><span> </span><span>'dart:developer'</span><span> </span><span>as</span><span> developer</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> </span><span>100</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>i</span><span>));</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> widgets</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> i</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          widgets </span><span>=</span><span> </span><span>List</span><span>.</span><span>from</span><span>(</span><span>widgets</span><span>);</span><span>
          widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>widgets</span><span>.</span><span>length</span><span>));</span><span>
          developer</span><span>.</span><span>log</span><span>(</span><span>'row $i'</span><span>);</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $i'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The recommended, efficient, and effective way to build a list uses a `ListView.Builder`. This method is great when you have a dynamic `List` or a `List` with very large amounts of data. This is essentially the equivalent of RecyclerView on Android, which automatically recycles list elements for you:

```
<span>import</span><span> </span><span>'dart:developer'</span><span> </span><span>as</span><span> developer</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> </span><span>100</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>i</span><span>));</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
        itemCount</span><span>:</span><span> widgets</span><span>.</span><span>length</span><span>,</span><span>
        itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> position</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> getRow</span><span>(</span><span>position</span><span>);</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> i</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>widgets</span><span>.</span><span>length</span><span>));</span><span>
          developer</span><span>.</span><span>log</span><span>(</span><span>'row $i'</span><span>);</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $i'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Instead of creating a “ListView”, create a `ListView.builder` that takes two key parameters: the initial length of the list, and an `ItemBuilder` function.

The `ItemBuilder` function is similar to the `getView` function in an Android adapter; it takes a position, and returns the row you want rendered at that position.

Finally, but most importantly, notice that the `onTap()` function doesn’t recreate the list anymore, but instead `.add`s to it.

## Working with text

### How do I set custom fonts on my Text widgets?

In Android SDK (as of Android O), you create a Font resource file and pass it into the FontFamily param for your TextView.

In Flutter, place the font file in a folder and reference it in the `pubspec.yaml` file, similar to how you import images.

```
<span>fonts</span><span>:</span>
   <span>-</span> <span>family</span><span>:</span> <span>MyCustomFont</span>
     <span>fonts</span><span>:</span>
       <span>-</span> <span>asset</span><span>:</span> <span>fonts/MyCustomFont.ttf</span>
       <span>-</span> <span>style</span><span>:</span> <span>italic</span>
```

Then assign the font to your `Text` widget:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
    appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
    </span><span>),</span><span>
    body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'This is a custom font text'</span><span>,</span><span>
        style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontFamily</span><span>:</span><span> </span><span>'MyCustomFont'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

### How do I style my Text widgets?

Along with fonts, you can customize other styling elements on a `Text` widget. The style parameter of a `Text` widget takes a `TextStyle` object, where you can customize many parameters, such as:

-   color
-   decoration
-   decorationColor
-   decorationStyle
-   fontFamily
-   fontSize
-   fontStyle
-   fontWeight
-   hashCode
-   height
-   inherit
-   letterSpacing
-   textBaseline
-   wordSpacing

## Form input

For more information on using Forms, see [Retrieve the value of a text field](https://docs.flutter.dev/cookbook/forms/retrieve-input), from the [Flutter cookbook](https://docs.flutter.dev/cookbook).

### What is the equivalent of a “hint” on an Input?

In Flutter, you can easily show a “hint” or a placeholder text for your input by adding an InputDecoration object to the decoration constructor parameter for the Text Widget.

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>TextField</span><span>(</span><span>
    decoration</span><span>:</span><span> </span><span>InputDecoration</span><span>(</span><span>hintText</span><span>:</span><span> </span><span>'This is a hint'</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

### How do I show validation errors?

Just as you would with a “hint”, pass an InputDecoration object to the decoration constructor for the Text widget.

However, you don’t want to start off by showing an error. Instead, when the user has entered invalid data, update the state, and pass a new `InputDecoration` object.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>String</span><span>?</span><span> _errorText</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>TextField</span><span>(</span><span>
          onSubmitted</span><span>:</span><span> </span><span>(</span><span>text</span><span>)</span><span> </span><span>{</span><span>
            setState</span><span>(()</span><span> </span><span>{</span><span>
              </span><span>if</span><span> </span><span>(!</span><span>isEmail</span><span>(</span><span>text</span><span>))</span><span> </span><span>{</span><span>
                _errorText </span><span>=</span><span> </span><span>'Error: This is not an email'</span><span>;</span><span>
              </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
                _errorText </span><span>=</span><span> </span><span>null</span><span>;</span><span>
              </span><span>}</span><span>
            </span><span>});</span><span>
          </span><span>},</span><span>
          decoration</span><span>:</span><span> </span><span>InputDecoration</span><span>(</span><span>
            hintText</span><span>:</span><span> </span><span>'This is a hint'</span><span>,</span><span>
            errorText</span><span>:</span><span> _getErrorText</span><span>(),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>String</span><span>?</span><span> _getErrorText</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> _errorText</span><span>;</span><span>
  </span><span>}</span><span>

  </span><span>bool</span><span> isEmail</span><span>(</span><span>String</span><span> em</span><span>)</span><span> </span><span>{</span><span>
    </span><span>String</span><span> emailRegexp </span><span>=</span><span>
        </span><span>r'^(([^&lt;&gt;()[\]\\.,;:\s@\"]+(\.[^&lt;&gt;()[\]\\.,;:\s@\"]+)*)|'</span><span>
        </span><span>r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'</span><span>
        </span><span>r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'</span><span>;</span><span>

    </span><span>RegExp</span><span> regExp </span><span>=</span><span> </span><span>RegExp</span><span>(</span><span>emailRegexp</span><span>);</span><span>

    </span><span>return</span><span> regExp</span><span>.</span><span>hasMatch</span><span>(</span><span>em</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Flutter plugins

### How do I access the GPS sensor?

Use the [`geolocator`](https://pub.dev/packages/geolocator) community plugin.

### How do I access the camera?

The [`image_picker`](https://pub.dev/packages/image_picker) plugin is popular for accessing the camera.

### How do I log in with Facebook?

To Log in with Facebook, use the [`flutter_facebook_login`](https://pub.dev/packages/flutter_facebook_login) community plugin.

### How do I use Firebase features?

Most Firebase functions are covered by [first party plugins](https://pub.dev/flutter/packages?q=firebase). These plugins are first-party integrations, maintained by the Flutter team:

-   [`google_mobile_ads`](https://pub.dev/packages/google_mobile_ads) for Google Mobile Ads for Flutter
-   [`firebase_analytics`](https://pub.dev/packages/firebase_analytics) for Firebase Analytics
-   [`firebase_auth`](https://pub.dev/packages/firebase_auth) for Firebase Auth
-   [`firebase_database`](https://pub.dev/packages/firebase_database) for Firebase RTDB
-   [`firebase_storage`](https://pub.dev/packages/firebase_storage) for Firebase Cloud Storage
-   [`firebase_messaging`](https://pub.dev/packages/firebase_messaging) for Firebase Messaging (FCM)
-   [`flutter_firebase_ui`](https://pub.dev/packages/flutter_firebase_ui) for quick Firebase Auth integrations (Facebook, Google, Twitter and email)
-   [`cloud_firestore`](https://pub.dev/packages/cloud_firestore) for Firebase Cloud Firestore

You can also find some third-party Firebase plugins on pub.dev that cover areas not directly covered by the first-party plugins.

### How do I build my own custom native integrations?

If there is platform-specific functionality that Flutter or its community Plugins are missing, you can build your own following the [developing packages and plugins](https://docs.flutter.dev/packages-and-plugins/developing-packages) page.

Flutter’s plugin architecture, in a nutshell, is much like using an Event bus in Android: you fire off a message and let the receiver process and emit a result back to you. In this case, the receiver is code running on the native side on Android or iOS.

### How do I use the NDK in my Flutter application?

If you use the NDK in your current Android application and want your Flutter application to take advantage of your native libraries then it’s possible by building a custom plugin.

Your custom plugin first talks to your Android app, where you call your `native` functions over JNI. Once a response is ready, send a message back to Flutter and render the result.

Calling native code directly from Flutter is currently not supported.

## Themes

### How do I theme my app?

Out of the box, Flutter comes with a beautiful implementation of Material Design, which takes care of a lot of styling and theming needs that you would typically do. Unlike Android where you declare themes in XML and then assign it to your application using AndroidManifest.xml, in Flutter you declare themes in the top level widget.

To take full advantage of Material Components in your app, you can declare a top level widget `MaterialApp` as the entry point to your application. MaterialApp is a convenience widget that wraps a number of widgets that are commonly required for applications implementing Material Design. It builds upon a WidgetsApp by adding Material specific functionality.

You can also use a `WidgetsApp` as your app widget, which provides some of the same functionality, but is not as rich as `MaterialApp`.

To customize the colors and styles of any child components, pass a `ThemeData` object to the `MaterialApp` widget. For example, in the code below, the color scheme from seed is set to deepPurple and text selection color is red.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
        textSelectionTheme</span><span>:</span><span>
            </span><span>const</span><span> </span><span>TextSelectionThemeData</span><span>(</span><span>selectionColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Databases and local storage

### How do I access Shared Preferences?

In Android, you can store a small collection of key-value pairs using the SharedPreferences API.

In Flutter, access this functionality using the [Shared\_Preferences plugin](https://pub.dev/packages/shared_preferences). This plugin wraps the functionality of both Shared Preferences and NSUserDefaults (the iOS equivalent).

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:shared_preferences/shared_preferences.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
            onPressed</span><span>:</span><span> _incrementCounter</span><span>,</span><span>
            child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Increment Counter'</span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _incrementCounter</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>SharedPreferences</span><span> prefs </span><span>=</span><span> </span><span>await</span><span> </span><span>SharedPreferences</span><span>.</span><span>getInstance</span><span>();</span><span>
  </span><span>int</span><span> counter </span><span>=</span><span> </span><span>(</span><span>prefs</span><span>.</span><span>getInt</span><span>(</span><span>'counter'</span><span>)</span><span> </span><span>??</span><span> </span><span>0</span><span>)</span><span> </span><span>+</span><span> </span><span>1</span><span>;</span><span>
  </span><span>await</span><span> prefs</span><span>.</span><span>setInt</span><span>(</span><span>'counter'</span><span>,</span><span> counter</span><span>);</span><span>
</span><span>}</span>
```

### How do I access SQLite in Flutter?

In Android, you use SQLite to store structured data that you can query using SQL.

In Flutter, for macOS, Android, or iOS, access this functionality using the [SQFlite](https://pub.dev/packages/sqflite) plugin.

## Debugging

### What tools can I use to debug my app in Flutter?

Use the [DevTools](https://docs.flutter.dev/tools/devtools) suite for debugging Flutter or Dart apps.

DevTools includes support for profiling, examining the heap, inspecting the widget tree, logging diagnostics, debugging, observing executed lines of code, debugging memory leaks and memory fragmentation. For more information, see the [DevTools](https://docs.flutter.dev/tools/devtools) documentation.

## Notifications

### How do I set up push notifications?

In Android, you use Firebase Cloud Messaging to setup push notifications for your app.

In Flutter, access this functionality using the [Firebase Messaging](https://github.com/firebase/flutterfire/tree/master/packages/firebase_messaging) plugin. For more information on using the Firebase Cloud Messaging API, see the [`firebase_messaging`](https://pub.dev/packages/firebase_messaging) plugin documentation.