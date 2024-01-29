iOS developers with experience using UIKit who want to write mobile apps using Flutter should review this guide. It explains how to apply existing UIKit knowledge to Flutter.

Flutter is a framework for building cross-platform applications that uses the Dart programming language. To understand some differences between programming with Dart and programming with Swift, see [Learning Dart as a Swift Developer](https://dart.dev/guides/language/coming-from/swift-to-dart) and [Flutter concurrency for Swift developers](https://docs.flutter.dev/get-started/flutter-for/dart-swift-concurrency).

Your iOS and UIKit knowledge and experience are highly valuable when building with Flutter. Flutter also makes a number of adaptations to app behavior when running on iOS. To learn how, see [Platform adaptations](https://docs.flutter.dev/platform-integration/platform-adaptations).

Use this guide as a cookbook. Jump around and find questions that address your most relevant needs.

## Overview

As an introduction, watch the following video. It outlines how Flutter works on iOS and how to use Flutter to build iOS apps.

<iframe src="https://www.youtube.com/embed/ceMsPBbcEGg?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to develop with Flutter as an iOS developer" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="35597014" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

### Views vs. Widgets

In UIKit, most of what you create in the UI is done using view objects, which are instances of the `UIView` class. These can act as containers for other `UIView` classes, which form your layout.

In Flutter, the rough equivalent to a `UIView` is a `Widget`. Widgets don’t map exactly to iOS views, but while you’re getting acquainted with how Flutter works you can think of them as “the way you declare and construct UI”.

However, these have a few differences to a `UIView`. To start, widgets have a different lifespan: they are immutable and only exist until they need to be changed. Whenever widgets or their state change, Flutter’s framework creates a new tree of widget instances. In comparison, a UIKit view is not recreated when it changes, but rather it’s a mutable entity that is drawn once and doesn’t redraw until it is invalidated using `setNeedsDisplay()`.

Furthermore, unlike `UIView`, Flutter’s widgets are lightweight, in part due to their immutability. Because they aren’t views themselves, and aren’t directly drawing anything, but rather are a description of the UI and its semantics that get “inflated” into actual view objects under the hood.

Flutter includes the [Material Components](https://m3.material.io/develop/flutter/) library. These are widgets that implement the [Material Design guidelines](https://m3.material.io/styles/). Material Design is a flexible design system [optimized for all platforms](https://m2.material.io/design/platform-guidance/cross-platform-adaptation.html#cross-platform-guidelines), including iOS.

But Flutter is flexible and expressive enough to implement any design language. On iOS, you can use the [Cupertino widgets](https://docs.flutter.dev/ui/widgets/cupertino) to produce an interface that looks like [Apple’s iOS design language](https://developer.apple.com/design/resources).

### Updating Widgets

To update your views in UIKit, you directly mutate them. In Flutter, widgets are immutable and not updated directly. Instead, you have to manipulate the widget’s state.

This is where the concept of Stateful vs Stateless widgets comes in. A `StatelessWidget` is just what it sounds like—a widget with no state attached.

`StatelessWidgets` are useful when the part of the user interface you are describing does not depend on anything other than the initial configuration information in the widget.

For example, with UIKit, this is similar to placing a `UIImageView` with your logo as the `image`. If the logo is not changing during runtime, use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received after making an HTTP call, use a `StatefulWidget`. After the HTTP call has completed, tell the Flutter framework that the widget’s `State` is updated, so it can update the UI.

The important difference between stateless and stateful widgets is that `StatefulWidget`s have a `State` object that stores state data and carries it over across tree rebuilds, so it’s not lost.

If you are in doubt, remember this rule: if a widget changes outside of the `build` method (because of runtime user interactions, for example), it’s stateful. If the widget never changes, once built, it’s stateless. However, even if a widget is stateful, the containing parent widget can still be stateless if it isn’t itself reacting to those changes (or other inputs).

The following example shows how to use a `StatelessWidget`. A common`StatelessWidget` is the `Text` widget. If you look at the implementation of the `Text` widget, you’ll find it subclasses `StatelessWidget`.

```
<span>Text</span><span>(</span><span>
  </span><span>'I like Flutter!'</span><span>,</span><span>
  style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>),</span><span>
</span><span>);</span>
```

If you look at the code above, you might notice that the `Text` widget carries no explicit state with it. It renders what is passed in its constructors and nothing more.

But, what if you want to make “I Like Flutter” change dynamically, for example when clicking a `FloatingActionButton`?

To achieve this, wrap the `Text` widget in a `StatefulWidget` and update it when the user clicks the button.

For example:

```
<span>
</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Default placeholder text</span><span>
  </span><span>String</span><span> textToShow </span><span>=</span><span> </span><span>'I Like Flutter'</span><span>;</span><span>

  </span><span>void</span><span> _updateText</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      </span><span>// Update the text</span><span>
      textToShow </span><span>=</span><span> </span><span>'Flutter is Awesome!'</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
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

### Widget layout

In UIKit, you might use a Storyboard file to organize your views and set constraints, or you might set your constraints programmatically in your view controllers. In Flutter, declare your layout in code by composing a widget tree.

The following example shows how to display a simple widget with padding:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
    appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
    body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>CupertinoButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>only</span><span>(</span><span>left</span><span>:</span><span> </span><span>10</span><span>,</span><span> right</span><span>:</span><span> </span><span>10</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Hello'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

You can add padding to any widget, which mimics the functionality of constraints in iOS.

You can view the layouts that Flutter has to offer in the [widget catalog](https://docs.flutter.dev/ui/widgets/layout).

### Removing Widgets

In UIKit, you call `addSubview()` on the parent, or `removeFromSuperview()` on a child view to dynamically add or remove child views. In Flutter, because widgets are immutable, there is no direct equivalent to `addSubview()`. Instead, you can pass a function to the parent that returns a widget, and control that child’s creation with a boolean flag.

The following example shows how to toggle between two widgets when the user clicks the `FloatingActionButton`:

```
<span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
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
    </span><span>}</span><span>

    </span><span>return</span><span> </span><span>CupertinoButton</span><span>(</span><span>
      onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Toggle Two'</span><span>),</span><span>
    </span><span>);</span><span>
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

### Animations

In UIKit, you create an animation by calling the `animate(withDuration:animations:)` method on a view. In Flutter, use the animation library to wrap widgets inside an animated widget.

In Flutter, use an `AnimationController`, which is an `Animation<double>` that can pause, seek, stop, and reverse the animation. It requires a `Ticker` that signals when vsync happens and produces a linear interpolation between 0 and 1 on each frame while it’s running. You then create one or more `Animation`s and attach them to the controller.

For example, you might use `CurvedAnimation` to implement an animation along an interpolated curve. In this sense, the controller is the “master” source of the animation progress and the `CurvedAnimation` computes the curve that replaces the controller’s default linear motion. Like widgets, animations in Flutter work with composition.

When building the widget tree you assign the `Animation` to an animated property of a widget, such as the opacity of a `FadeTransition`, and tell the controller to start the animation.

The following example shows how to write a `FadeTransition` that fades the widget into a logo when you press the `FloatingActionButton`:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Fade Demo'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>MyFadeTest</span><span>(</span><span>title</span><span>:</span><span> </span><span>'Fade Demo'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyFadeTest</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyFadeTest</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyFadeTest</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyFadeTest</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyFadeTest </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyFadeTest</span><span>&gt;</span><span>
    </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
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
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    controller</span><span>.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>widget</span><span>.</span><span>title</span><span>)),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>FadeTransition</span><span>(</span><span>
          opacity</span><span>:</span><span> curve</span><span>,</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(</span><span>size</span><span>:</span><span> </span><span>100</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          controller</span><span>.</span><span>forward</span><span>();</span><span>
        </span><span>},</span><span>
        tooltip</span><span>:</span><span> </span><span>'Fade'</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>brush</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

For more information, see [Animation & Motion widgets](https://docs.flutter.dev/ui/widgets/animation), the [Animations tutorial](https://docs.flutter.dev/ui/animations/tutorial), and the [Animations overview](https://docs.flutter.dev/ui/animations).

### Drawing on the screen

In UIKit, you use `CoreGraphics` to draw lines and shapes to the screen. Flutter has a different API based on the `Canvas` class, with two other classes that help you draw: `CustomPaint` and `CustomPainter`, the latter of which implements your algorithm to draw to the canvas.

To learn how to implement a signature painter in Flutter, see Collin’s answer on [StackOverflow](https://stackoverflow.com/questions/46241071/create-signature-area-for-mobile-app-in-dart-flutter).

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
  </span><span>State</span><span>&lt;</span><span>Signature</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> </span><span>SignatureState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SignatureState</span><span> </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>Signature</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Offset</span><span>?&gt;</span><span> _points </span><span>=</span><span> </span><span>&lt;</span><span>Offset</span><span>?&gt;[];</span><span>
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
      child</span><span>:</span><span>
          </span><span>CustomPaint</span><span>(</span><span>
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
    </span><span>final</span><span> </span><span>Paint</span><span> paint </span><span>=</span><span> </span><span>Paint</span><span>()</span><span>
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

### Widget opacity

In UIKit, everything has `.opacity` or `.alpha`. In Flutter, most of the time you need to wrap a widget in an `Opacity` widget to accomplish this.

### Custom Widgets

In UIKit, you typically subclass `UIView`, or use a pre-existing view, to override and implement methods that achieve the desired behavior. In Flutter, build a custom widget by [composing](https://docs.flutter.dev/resources/architectural-overview#composition) smaller widgets (instead of extending them).

For example, how do you build a `CustomButton` that takes a label in the constructor? Create a CustomButton that composes a `ElevatedButton` with a label, rather than by extending `ElevatedButton`:

```
<span>class</span><span> </span><span>CustomButton</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>CustomButton</span><span>(</span><span>this</span><span>.</span><span>label</span><span>,</span><span> </span><span>{</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> label</span><span>;</span><span>

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

## Navigation

This section of the document discusses navigation between pages of an app, the push and pop mechanism, and more.

### Navigating between pages

In UIKit, to travel between view controllers, you can use a `UINavigationController` that manages the stack of view controllers to display.

Flutter has a similar implementation, using a `Navigator` and `Routes`. A `Route` is an abstraction for a “screen” or “page” of an app, and a `Navigator` is a [widget](https://docs.flutter.dev/resources/architectural-overview#widgets) that manages routes. A route roughly maps to a `UIViewController`. The navigator works in a similar way to the iOS `UINavigationController`, in that it can `push()` and `pop()` routes depending on whether you want to navigate to, or back from, a view.

To navigate between pages, you have a couple options:

-   Specify a `Map` of route names.
-   Directly navigate to a route.

The following example builds a `Map.`

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span>CupertinoApp</span><span>(</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>MyAppHome</span><span>(),</span><span> </span><span>// becomes the route named '/'</span><span>
      routes</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>WidgetBuilder</span><span>&gt;{</span><span>
        </span><span>'/a'</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>MyPage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'page A'</span><span>),</span><span>
        </span><span>'/b'</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>MyPage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'page B'</span><span>),</span><span>
        </span><span>'/c'</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>MyPage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'page C'</span><span>),</span><span>
      </span><span>},</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

Navigate to a route by `push`ing its name to the `Navigator`.

```
<span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/b'</span><span>);</span>
```

The `Navigator` class handles routing in Flutter and is used to get a result back from a route that you have pushed on the stack. This is done by `await`ing on the `Future` returned by `push()`.

For example, to start a `location` route that lets the user select their location, you might do the following:

```
<span>Object</span><span>?</span><span> coordinates </span><span>=</span><span> </span><span>await</span><span> </span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/location'</span><span>);</span>
```

And then, inside your `location` route, once the user has selected their location, `pop()` the stack with the result:

```
<span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pop</span><span>({</span><span>'lat'</span><span>:</span><span> </span><span>43.821757</span><span>,</span><span> </span><span>'long'</span><span>:</span><span> </span><span>-</span><span>79.226392</span><span>});</span>
```

### Navigating to another app

In UIKit, to send the user to another application, you use a specific URL scheme. For the system level apps, the scheme depends on the app. To implement this functionality in Flutter, create a native platform integration, or use an [existing plugin](https://pub.dev/flutter), such as [`url_launcher`](https://pub.dev/packages/url_launcher).

### Manually pop back

Calling `SystemNavigator.pop()` from your Dart code invokes the following iOS code:

```
<span>UIViewController</span><span>*</span> <span>viewController</span> <span>=</span> <span>[</span><span>UIApplication</span> <span>sharedApplication</span><span>].</span><span>keyWindow</span><span>.</span><span>rootViewController</span><span>;</span>
<span>if</span> <span>([</span><span>viewController</span> <span>isKindOfClass</span><span>:[</span><span>UINavigationController</span> <span>class</span><span>]])</span> <span>{</span>
  <span>[((</span><span>UINavigationController</span><span>*</span><span>)</span><span>viewController</span><span>)</span> <span>popViewControllerAnimated</span><span>:</span><span>NO</span><span>];</span>
<span>}</span>
```

If that doesn’t do what you want, you can create your own [platform channel](https://docs.flutter.dev/platform-integration/platform-channels) to invoke arbitrary iOS code.

### Handling localization

Unlike iOS, which has the `Localizable.strings` file, Flutter doesn’t currently have a dedicated system for handling strings. At the moment, the best practice is to declare your copy text in a class as static fields and access them from there. For example:

```
<span>class</span><span> </span><span>Strings</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> </span><span>String</span><span> welcomeMessage </span><span>=</span><span> </span><span>'Welcome To Flutter'</span><span>;</span><span>
</span><span>}</span>
```

You can access your strings as such:

```
<span>Text</span><span>(</span><span>Strings</span><span>.</span><span>welcomeMessage</span><span>);</span>
```

By default, Flutter only supports US English for its strings. If you need to add support for other languages, include the `flutter_localizations` package. You might also need to add Dart’s [`intl`](https://pub.dev/packages/intl) package to use i10n machinery, such as date/time formatting.

```
<span>dependencies</span><span>:</span>
  <span>flutter_localizations</span><span>:</span>
    <span>sdk</span><span>:</span> <span>flutter</span>
  <span>intl</span><span>:</span> <span>any</span> <span># Use version of intl from flutter_localizations.</span>
```

To use the `flutter_localizations` package, specify the `localizationsDelegates` and `supportedLocales` on the app widget:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_localizations/flutter_localizations.dart'</span><span>;</span><span>

</span><span>class</span><span> </span><span>MyWidget</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyWidget</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      localizationsDelegates</span><span>:</span><span> </span><span>&lt;</span><span>LocalizationsDelegate</span><span>&lt;</span><span>dynamic</span><span>&gt;&gt;[</span><span>
        </span><span>// Add app-specific localization delegate[s] here</span><span>
        </span><span>GlobalMaterialLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
        </span><span>GlobalWidgetsLocalizations</span><span>.</span><span>delegate</span><span>,</span><span>
      </span><span>],</span><span>
      supportedLocales</span><span>:</span><span> </span><span>&lt;</span><span>Locale</span><span>&gt;[</span><span>
        </span><span>Locale</span><span>(</span><span>'en'</span><span>,</span><span> </span><span>'US'</span><span>),</span><span> </span><span>// English</span><span>
        </span><span>Locale</span><span>(</span><span>'he'</span><span>,</span><span> </span><span>'IL'</span><span>),</span><span> </span><span>// Hebrew</span><span>
        </span><span>// ... other locales the app supports</span><span>
      </span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The delegates contain the actual localized values, while the `supportedLocales` defines which locales the app supports. The above example uses a `MaterialApp`, so it has both a `GlobalWidgetsLocalizations` for the base widgets localized values, and a `MaterialWidgetsLocalizations` for the Material widgets localizations. If you use `WidgetsApp` for your app, you don’t need the latter. Note that these two delegates contain “default” values, but you’ll need to provide one or more delegates for your own app’s localizable copy, if you want those to be localized too.

When initialized, the `WidgetsApp` (or `MaterialApp`) creates a [`Localizations`](https://api.flutter.dev/flutter/widgets/Localizations-class.html) widget for you, with the delegates you specify. The current locale for the device is always accessible from the `Localizations` widget from the current context (in the form of a `Locale` object), or using the [`Window.locale`](https://api.flutter.dev/flutter/dart-ui/Window/locale.html).

To access localized resources, use the `Localizations.of()` method to access a specific localizations class that is provided by a given delegate. Use the [`intl_translation`](https://pub.dev/packages/intl_translation) package to extract translatable copy to [arb](https://github.com/googlei18n/app-resource-bundle) files for translating, and importing them back into the app for using them with `intl`.

For further details on internationalization and localization in Flutter, see the [internationalization guide](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization), which has sample code with and without the `intl` package.

### Managing dependencies

In iOS, you add dependencies with CocoaPods by adding to your `Podfile`. Flutter uses Dart’s build system and the Pub package manager to handle dependencies. The tools delegate the building of the native Android and iOS wrapper apps to the respective build systems.

While there is a Podfile in the iOS folder in your Flutter project, only use this if you are adding native dependencies needed for per-platform integration. In general, use `pubspec.yaml` to declare external dependencies in Flutter. A good place to find great packages for Flutter is on [pub.dev](https://pub.dev/flutter/packages).

## ViewControllers

This section of the document discusses the equivalent of ViewController in Flutter and how to listen to lifecycle events.

### Equivalent of ViewController in Flutter

In UIKit, a `ViewController` represents a portion of user interface, most commonly used for a screen or section. These are composed together to build complex user interfaces, and help scale your application’s UI. In Flutter, this job falls to Widgets. As mentioned in the Navigation section, screens in Flutter are represented by Widgets since “everything is a widget!” Use a `Navigator` to move between different `Route`s that represent different screens or pages, or maybe different states or renderings of the same data.

### Listening to lifecycle events

In UIKit, you can override methods to the `ViewController` to capture lifecycle methods for the view itself, or register lifecycle callbacks in the `AppDelegate`. In Flutter, you have neither concept, but you can instead listen to lifecycle events by hooking into the `WidgetsBinding` observer and listening to the `didChangeAppLifecycleState()` change event.

The observable lifecycle events are:

**`inactive`**

The application is in an inactive state and is not receiving user input. This event only works on iOS, as there is no equivalent event on Android.

**`paused`**

The application is not currently visible to the user, is not responding to user input, but is running in the background.

**`resumed`**

The application is visible and responding to user input.

**`suspending`**

The application is suspended momentarily. The iOS platform has no equivalent event.

For more details on the meaning of these states, see [`AppLifecycleState` documentation](https://api.flutter.dev/flutter/dart-ui/AppLifecycleState.html).

## Layouts

This section discusses different layouts in Flutter and how they compare with UIKit.

### Displaying a list view

In UIKit, you might show a list in either a `UITableView` or a `UICollectionView`. In Flutter, you have a similar implementation using a `ListView`. In UIKit, these views have delegate methods for deciding the number of rows, the cell for each index path, and the size of the cells.

Due to Flutter’s immutable widget pattern, you pass a list of widgets to your `ListView`, and Flutter takes care of making sure that scrolling is fast and smooth.

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
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> _getListData</span><span>()</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> </span><span>100</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      widgets</span><span>.</span><span>add</span><span>(</span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $i'</span><span>),</span><span>
      </span><span>));</span><span>
    </span><span>}</span><span>
    </span><span>return</span><span> widgets</span><span>;</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> _getListData</span><span>()),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Detecting what was clicked

In UIKit, you implement the delegate method, `tableView:didSelectRowAtIndexPath:`. In Flutter, use the touch handling provided by the passed-in widgets.

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
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
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

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> _getListData</span><span>()),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Dynamically updating ListView

In UIKit, you update the data for the list view, and notify the table or collection view using the `reloadData` method.

In Flutter, if you update the list of widgets inside a `setState()`, you quickly see that your data doesn’t change visually. This is because when `setState()` is called, the Flutter rendering engine looks at the widget tree to see if anything has changed. When it gets to your `ListView`, it performs an `==` check, and determines that the two `ListView`s are the same. Nothing has changed, so no update is required.

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
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> widgets </span><span>=</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> </span><span>100</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>i</span><span>));</span><span>
    </span><span>}</span><span>
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

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> widgets</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The recommended, efficient, and effective way to build a list uses a `ListView.Builder`. This method is great when you have a dynamic list or a list with very large amounts of data.

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
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
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
</span><span>}</span>
```

Instead of creating a `ListView`, create a `ListView.builder` that takes two key parameters: the initial length of the list, and an `ItemBuilder` function.

The `ItemBuilder` function is similar to the `cellForItemAt` delegate method in an iOS table or collection view, as it takes a position, and returns the cell you want rendered at that position.

Finally, but most importantly, notice that the `onTap()` function doesn’t recreate the list anymore, but instead `.add`s to it.

### Creating a scroll view

In UIKit, you wrap your views in a `ScrollView` that allows a user to scroll your content if needed.

In Flutter the easiest way to do this is using the `ListView` widget. This acts as both a `ScrollView` and an iOS `TableView`, as you can layout widgets in a vertical format.

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

For more detailed docs on how to lay out widgets in Flutter, see the [layout tutorial](https://docs.flutter.dev/ui/widgets/layout).

## Gesture detection and touch event handling

This section discusses how to detect gestures and handle different events in Flutter, and how they compare with UIKit.

### Adding a click listener

In UIKit, you attach a `GestureRecognizer` to a view to handle click events. In Flutter, there are two ways of adding touch listeners:

1.  If the widget supports event detection, pass a function to it, and handle the event in the function. For example, the `ElevatedButton` widget has an `onPressed` parameter:
    
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
    
2.  If the Widget doesn’t support event detection, wrap the widget in a GestureDetector and pass a function to the `onTap` parameter.
    
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
    

### Handling other gestures

Using `GestureDetector` you can listen to a wide range of gestures such as:

-   **Tapping**
    
    **`onTapDown`**
    
    A pointer that might cause a tap has contacted the screen at a particular location.
    
    **`onTapUp`**
    
    A pointer that triggers a tap has stopped contacting the screen at a particular location.
    
    **`onTap`**
    
    A tap has occurred.
    
    **`onTapCancel`**
    
    The pointer that previously triggered the `onTapDown` won’t cause a tap.
    
-   **Double tapping**
    
    **`onDoubleTap`**
    
    The user tapped the screen at the same location twice in quick succession.
    
-   **Long pressing**
    
    **`onLongPress`**
    
    A pointer has remained in contact with the screen at the same location for a long period of time.
    
-   **Vertical dragging**
    
    **`onVerticalDragStart`**
    
    A pointer has contacted the screen and might begin to move vertically.
    
    **`onVerticalDragUpdate`**
    
    A pointer in contact with the screen has moved further in the vertical direction.
    
    **`onVerticalDragEnd`**
    
    A pointer that was previously in contact with the screen and moving vertically is no longer in contact with the screen and was moving at a specific velocity when it stopped contacting the screen.
    
-   **Horizontal dragging**
    
    **`onHorizontalDragStart`**
    
    A pointer has contacted the screen and might begin to move horizontally.
    
    **`onHorizontalDragUpdate`**
    
    A pointer in contact with the screen has moved further in the horizontal direction.
    
    **`onHorizontalDragEnd`**
    
    A pointer that was previously in contact with the screen and moving horizontally is no longer in contact with the screen.
    

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

Flutter applications are easy to style; you can switch between light and dark themes, change the style of your text and UI components, and more. This section covers aspects of styling your Flutter apps and compares how you might do the same in UIKit.

### Using a theme

Out of the box, Flutter comes with a beautiful implementation of Material Design, which takes care of a lot of styling and theming needs that you would typically do.

To take full advantage of Material Components in your app, declare a top-level widget, `MaterialApp`, as the entry point to your application. `MaterialApp` is a convenience widget that wraps a number of widgets that are commonly required for applications implementing Material Design. It builds upon a `WidgetsApp` by adding Material specific functionality.

But Flutter is flexible and expressive enough to implement any design language. On iOS, you can use the [Cupertino library](https://api.flutter.dev/flutter/cupertino/cupertino-library.html) to produce an interface that adheres to the [Human Interface Guidelines](https://developer.apple.com/ios/human-interface-guidelines/overview/themes/). For the full set of these widgets, see the [Cupertino widgets](https://docs.flutter.dev/ui/widgets/cupertino) gallery.

You can also use a `WidgetsApp` as your app widget, which provides some of the same functionality, but is not as rich as `MaterialApp`.

To customize the colors and styles of any child components, pass a `ThemeData` object to the `MaterialApp` widget. For example, in the code below, the color scheme from seed is set to deepPurple and divider color is grey.

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
        dividerColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>,</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Using custom fonts

In UIKit, you import any `ttf` font files into your project and create a reference in the `info.plist` file. In Flutter, place the font file in a folder and reference it in the `pubspec.yaml` file, similar to how you import images.

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

### Styling text

Along with fonts, you can customize other styling elements on a `Text` widget. The style parameter of a `Text` widget takes a `TextStyle` object, where you can customize many parameters, such as:

-   `color`
-   `decoration`
-   `decorationColor`
-   `decorationStyle`
-   `fontFamily`
-   `fontSize`
-   `fontStyle`
-   `fontWeight`
-   `hashCode`
-   `height`
-   `inherit`
-   `letterSpacing`
-   `textBaseline`
-   `wordSpacing`

### Bundling images in apps

While iOS treats images and assets as distinct items, Flutter apps have only assets. Resources that are placed in the `Images.xcasset` folder on iOS, are placed in an assets’ folder for Flutter. As with iOS, assets are any type of file, not just images. For example, you might have a JSON file located in the `my-assets` folder:

Declare the asset in the `pubspec.yaml` file:

```
<span>assets</span><span>:</span>
 <span>-</span> <span>my-assets/data.json</span>
```

And then access it from code using an [`AssetBundle`](https://api.flutter.dev/flutter/services/AssetBundle-class.html):

```
<span>import</span><span> </span><span>'dart:async'</span><span> </span><span>show</span><span> </span><span>Future</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/services.dart'</span><span> </span><span>show</span><span> rootBundle</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>String</span><span>&gt;</span><span> loadAsset</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>await</span><span> rootBundle</span><span>.</span><span>loadString</span><span>(</span><span>'my-assets/data.json'</span><span>);</span><span>
</span><span>}</span>
```

For images, Flutter follows a simple density-based format like iOS. Image assets might be `1.0x`, `2.0x`, `3.0x`, or any other multiplier. Flutter’s [`devicePixelRatio`](https://api.flutter.dev/flutter/dart-ui/FlutterView/devicePixelRatio.html) expresses the ratio of physical pixels in a single logical pixel.

Assets are located in any arbitrary folder— Flutter has no predefined folder structure. You declare the assets (with location) in the `pubspec.yaml` file, and Flutter picks them up.

For example, to add an image called `my_icon.png` to your Flutter project, you might decide to store it in a folder arbitrarily called `images`. Place the base image (1.0x) in the `images` folder, and the other variants in sub-folders named after the appropriate ratio multiplier:

```
images/my_icon.png       // Base: 1.0x image
images/2.0x/my_icon.png  // 2.0x image
images/3.0x/my_icon.png  // 3.0x image
```

Next, declare these images in the `pubspec.yaml` file:

```
<span>assets</span><span>:</span>
 <span>-</span> <span>images/my_icon.png</span>
```

You can now access your images using `AssetImage`:

```
<span>AssetImage</span><span>(</span><span>'images/a_dot_burr.jpeg'</span><span>)</span>
```

or directly in an `Image` widget:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/my_image.png'</span><span>);</span><span>
</span><span>}</span>
```

For more details, see [Adding Assets and Images in Flutter](https://docs.flutter.dev/ui/assets/assets-and-images).

## Form input

This section discusses how to use forms in Flutter and how they compare with UIKit.

### Retrieving user input

Given how Flutter uses immutable widgets with a separate state, you might be wondering how user input fits into the picture. In UIKit, you usually query the widgets for their current values when it’s time to submit the user input, or action on it. How does that work in Flutter?

In practice forms are handled, like everything in Flutter, by specialized widgets. If you have a `TextField` or a `TextFormField`, you can supply a [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) to retrieve user input:

```
<span>class</span><span> _MyFormState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyForm</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Create a text controller and use it to retrieve the current value.</span><span>
  </span><span>// of the TextField!</span><span>
  </span><span>final</span><span> myController </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Clean up the controller when disposing of the Widget.</span><span>
    myController</span><span>.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Retrieve Text Input'</span><span>)),</span><span>
      body</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>TextField</span><span>(</span><span>controller</span><span>:</span><span> myController</span><span>),</span><span>
      </span><span>),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        </span><span>// When the user presses the button, show an alert dialog with the</span><span>
        </span><span>// text the user has typed into our text field.</span><span>
        onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          showDialog</span><span>(</span><span>
            context</span><span>:</span><span> context</span><span>,</span><span>
            builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>{</span><span>
              </span><span>return</span><span> </span><span>AlertDialog</span><span>(</span><span>
                </span><span>// Retrieve the text the user has typed in using our</span><span>
                </span><span>// TextEditingController.</span><span>
                content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>myController</span><span>.</span><span>text</span><span>),</span><span>
              </span><span>);</span><span>
            </span><span>},</span><span>
          </span><span>);</span><span>
        </span><span>},</span><span>
        tooltip</span><span>:</span><span> </span><span>'Show me the value!'</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>text_fields</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

You can find more information and the full code listing in [Retrieve the value of a text field](https://docs.flutter.dev/cookbook/forms/retrieve-input), from the [Flutter cookbook](https://docs.flutter.dev/cookbook).

### Placeholder in a text field

In Flutter, you can easily show a “hint” or a placeholder text for your field by adding an `InputDecoration` object to the decoration constructor parameter for the `Text` widget:

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>TextField</span><span>(</span><span>
    decoration</span><span>:</span><span> </span><span>InputDecoration</span><span>(</span><span>hintText</span><span>:</span><span> </span><span>'This is a hint'</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

### Showing validation errors

Just as you would with a “hint”, pass an `InputDecoration` object to the decoration constructor for the `Text` widget.

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
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
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

  </span><span>bool</span><span> isEmail</span><span>(</span><span>String</span><span> em</span><span>)</span><span> </span><span>{</span><span>
    </span><span>String</span><span> emailRegexp </span><span>=</span><span>
        </span><span>r'^(([^&lt;&gt;()[\]\\.,;:\s@\"]+(\.[^&lt;&gt;()[\]\\.,;:\s@\"]+)*)|'</span><span>
        </span><span>r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'</span><span>
        </span><span>r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'</span><span>;</span><span>

    </span><span>RegExp</span><span> regExp </span><span>=</span><span> </span><span>RegExp</span><span>(</span><span>emailRegexp</span><span>);</span><span>

    </span><span>return</span><span> regExp</span><span>.</span><span>hasMatch</span><span>(</span><span>em</span><span>);</span><span>
  </span><span>}</span><span>

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
            errorText</span><span>:</span><span> _errorText</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Threading & asynchronicity

This section discusses concurrency in Flutter and how it compares with UIKit.

### Writing asynchronous code

Dart has a single-threaded execution model, with support for `Isolate`s (a way to run Dart code on another thread), an event loop, and asynchronous programming. Unless you spawn an `Isolate`, your Dart code runs in the main UI thread and is driven by an event loop. Flutter’s event loop is equivalent to the iOS main loop—that is, the `Looper` that is attached to the main thread.

Dart’s single-threaded model doesn’t mean you are required to run everything as a blocking operation that causes the UI to freeze. Instead, use the asynchronous facilities that the Dart language provides, such as `async`/`await`, to perform asynchronous work.

For example, you can run network code without causing the UI to hang by using `async`/`await` and letting Dart do the heavy lifting:

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    data </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
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
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> data </span><span>=</span><span> </span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    loadData</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
    </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      data </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row ${data[index]['</span><span>title</span><span>']}'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
        itemCount</span><span>:</span><span> data</span><span>.</span><span>length</span><span>,</span><span>
        itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> getRow</span><span>(</span><span>index</span><span>);</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Refer to the next section for more information on doing work in the background, and how Flutter differs from iOS.

### Moving to the background thread

Since Flutter is single threaded and runs an event loop (like Node.js), you don’t have to worry about thread management or spawning background threads. If you’re doing I/O-bound work, such as disk access or a network call, then you can safely use `async`/`await` and you’re done. If, on the other hand, you need to do computationally intensive work that keeps the CPU busy, you want to move it to an `Isolate` to avoid blocking the event loop.

For I/O-bound work, declare the function as an `async` function, and `await` on long-running tasks inside the function:

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    data </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

This is how you typically do network or database calls, which are both I/O operations.

However, there are times when you might be processing a large amount of data and your UI hangs. In Flutter, use `Isolate`s to take advantage of multiple CPU cores to do long-running or computationally intensive tasks.

Isolates are separate execution threads that do not share any memory with the main execution memory heap. This means you can’t access variables from the main thread, or update your UI by calling `setState()`. Isolates are true to their name, and cannot share memory (in the form of static fields, for example).

The following example shows, in a simple isolate, how to share data back to the main thread to update the UI.

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>ReceivePort</span><span> receivePort </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
  </span><span>await</span><span> </span><span>Isolate</span><span>.</span><span>spawn</span><span>(</span><span>dataLoader</span><span>,</span><span> receivePort</span><span>.</span><span>sendPort</span><span>);</span><span>

  </span><span>// The 'echo' isolate sends its SendPort as the first message.</span><span>
  </span><span>final</span><span> </span><span>SendPort</span><span> sendPort </span><span>=</span><span> </span><span>await</span><span> receivePort</span><span>.</span><span>first </span><span>as</span><span> </span><span>SendPort</span><span>;</span><span>

  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> msg </span><span>=</span><span> </span><span>await</span><span> sendReceive</span><span>(</span><span>
    sendPort</span><span>,</span><span>
    </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
  </span><span>);</span><span>

  setState</span><span>(()</span><span> </span><span>{</span><span>
    data </span><span>=</span><span> msg</span><span>;</span><span>
  </span><span>});</span><span>
</span><span>}</span><span>

</span><span>// The entry point for the isolate.</span><span>
</span><span>static</span><span> </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> dataLoader</span><span>(</span><span>SendPort</span><span> sendPort</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Open the ReceivePort for incoming messages.</span><span>
  </span><span>final</span><span> </span><span>ReceivePort</span><span> port </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>

  </span><span>// Notify any other isolates what port this isolate listens to.</span><span>
  sendPort</span><span>.</span><span>send</span><span>(</span><span>port</span><span>.</span><span>sendPort</span><span>);</span><span>

  </span><span>await</span><span> </span><span>for</span><span> </span><span>(</span><span>final</span><span> </span><span>dynamic</span><span> msg </span><span>in</span><span> port</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>String</span><span> url </span><span>=</span><span> msg</span><span>[</span><span>0</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>;</span><span>
    </span><span>final</span><span> </span><span>SendPort</span><span> replyTo </span><span>=</span><span> msg</span><span>[</span><span>1</span><span>]</span><span> </span><span>as</span><span> </span><span>SendPort</span><span>;</span><span>

    </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>url</span><span>);</span><span>
    </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
    </span><span>// Lots of JSON to parse</span><span>
    replyTo</span><span>.</span><span>send</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;&gt;</span><span> sendReceive</span><span>(</span><span>SendPort</span><span> port</span><span>,</span><span> </span><span>String</span><span> msg</span><span>)</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>ReceivePort</span><span> response </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
  port</span><span>.</span><span>send</span><span>(&lt;</span><span>dynamic</span><span>&gt;[</span><span>msg</span><span>,</span><span> response</span><span>.</span><span>sendPort</span><span>]);</span><span>
  </span><span>return</span><span> response</span><span>.</span><span>first </span><span>as</span><span> </span><span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;&gt;;</span><span>
</span><span>}</span>
```

Here, `dataLoader()` is the `Isolate` that runs in its own separate execution thread. In the isolate, you can perform more CPU intensive processing (parsing a big JSON, for example), or perform computationally intensive math, such as encryption or signal processing.

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
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> data </span><span>=</span><span> </span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    loadData</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>bool</span><span> </span><span>get</span><span> showLoadingDialog </span><span>=&gt;</span><span> data</span><span>.</span><span>isEmpty</span><span>;</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>ReceivePort</span><span> receivePort </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
    </span><span>await</span><span> </span><span>Isolate</span><span>.</span><span>spawn</span><span>(</span><span>dataLoader</span><span>,</span><span> receivePort</span><span>.</span><span>sendPort</span><span>);</span><span>

    </span><span>// The 'echo' isolate sends its SendPort as the first message.</span><span>
    </span><span>final</span><span> </span><span>SendPort</span><span> sendPort </span><span>=</span><span> </span><span>await</span><span> receivePort</span><span>.</span><span>first </span><span>as</span><span> </span><span>SendPort</span><span>;</span><span>

    </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> msg </span><span>=</span><span> </span><span>await</span><span> sendReceive</span><span>(</span><span>
      sendPort</span><span>,</span><span>
      </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
    </span><span>);</span><span>

    setState</span><span>(()</span><span> </span><span>{</span><span>
      data </span><span>=</span><span> msg</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>// The entry point for the isolate.</span><span>
  </span><span>static</span><span> </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> dataLoader</span><span>(</span><span>SendPort</span><span> sendPort</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Open the ReceivePort for incoming messages.</span><span>
    </span><span>final</span><span> </span><span>ReceivePort</span><span> port </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>

    </span><span>// Notify any other isolates what port this isolate listens to.</span><span>
    sendPort</span><span>.</span><span>send</span><span>(</span><span>port</span><span>.</span><span>sendPort</span><span>);</span><span>

    </span><span>await</span><span> </span><span>for</span><span> </span><span>(</span><span>final</span><span> </span><span>dynamic</span><span> msg </span><span>in</span><span> port</span><span>)</span><span> </span><span>{</span><span>
      </span><span>final</span><span> </span><span>String</span><span> url </span><span>=</span><span> msg</span><span>[</span><span>0</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>;</span><span>
      </span><span>final</span><span> </span><span>SendPort</span><span> replyTo </span><span>=</span><span> msg</span><span>[</span><span>1</span><span>]</span><span> </span><span>as</span><span> </span><span>SendPort</span><span>;</span><span>

      </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>url</span><span>);</span><span>
      </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
      </span><span>// Lots of JSON to parse</span><span>
      replyTo</span><span>.</span><span>send</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;);</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;&gt;</span><span> sendReceive</span><span>(</span><span>SendPort</span><span> port</span><span>,</span><span> </span><span>String</span><span> msg</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>ReceivePort</span><span> response </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
    port</span><span>.</span><span>send</span><span>(&lt;</span><span>dynamic</span><span>&gt;[</span><span>msg</span><span>,</span><span> response</span><span>.</span><span>sendPort</span><span>]);</span><span>
    </span><span>return</span><span> response</span><span>.</span><span>first </span><span>as</span><span> </span><span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;&gt;;</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getBody</span><span>()</span><span> </span><span>{</span><span>
    </span><span>bool</span><span> showLoadingDialog </span><span>=</span><span> data</span><span>.</span><span>isEmpty</span><span>;</span><span>

    </span><span>if</span><span> </span><span>(</span><span>showLoadingDialog</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> getProgressDialog</span><span>();</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
      </span><span>return</span><span> getListView</span><span>();</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getProgressDialog</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>CircularProgressIndicator</span><span>());</span><span>
  </span><span>}</span><span>

  </span><span>ListView</span><span> getListView</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
      itemCount</span><span>:</span><span> data</span><span>.</span><span>length</span><span>,</span><span>
      itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> position</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> getRow</span><span>(</span><span>position</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> i</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>"Row ${data[i]["</span><span>title</span><span>"]}"</span><span>),</span><span>
    </span><span>);</span><span>
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
</span><span>}</span>
```

### Making network requests

Making a network call in Flutter is easy when you use the popular [`http` package](https://pub.dev/packages/http). This abstracts away a lot of the networking that you might normally implement yourself, making it simple to make network calls.

To add the `http` package as a dependency, run `flutter pub add`:

To make a network call, call `await` on the `async` function `http.get()`:

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    data </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

### Showing the progress on long running tasks

In UIKit, you typically use a `UIProgressView` while executing a long-running task in the background.

In Flutter, use a `ProgressIndicator` widget. Show the progress programmatically by controlling when it’s rendered through a boolean flag. Tell Flutter to update its state before your long-running task starts, and hide it after it ends.

In the example below, the build function is separated into three different functions. If `showLoadingDialog` is `true` (when `widgets.length == 0`), then render the `ProgressIndicator`. Otherwise, render the `ListView` with the data returned from a network call.

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
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SampleAppPageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SampleAppPageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SampleAppPage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> data </span><span>=</span><span> </span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    loadData</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>bool</span><span> </span><span>get</span><span> showLoadingDialog </span><span>=&gt;</span><span> data</span><span>.</span><span>isEmpty</span><span>;</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>);</span><span>
    </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      data </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getBody</span><span>()</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>showLoadingDialog</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> getProgressDialog</span><span>();</span><span>
    </span><span>}</span><span>

    </span><span>return</span><span> getListView</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getProgressDialog</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>CircularProgressIndicator</span><span>());</span><span>
  </span><span>}</span><span>

  </span><span>ListView</span><span> getListView</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
      itemCount</span><span>:</span><span> data</span><span>.</span><span>length</span><span>,</span><span>
      itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> getRow</span><span>(</span><span>index</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> i</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>"Row ${data[i]["</span><span>title</span><span>"]}"</span><span>),</span><span>
    </span><span>);</span><span>
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
</span><span>}</span>
```