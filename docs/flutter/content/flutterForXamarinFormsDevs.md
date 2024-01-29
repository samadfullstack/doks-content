This document is meant for Xamarin.Forms developers looking to apply their existing knowledge to build mobile apps with Flutter. If you understand the fundamentals of the Xamarin.Forms framework, then you can use this document as a jump start to Flutter development.

Your Android and iOS knowledge and skill set are valuable when building with Flutter, because Flutter relies on the native operating system configurations, similar to how you would configure your native Xamarin.Forms projects. The Flutter Frameworks is also similar to how you create a single UI, that is used on multiple platforms.

This document can be used as a cookbook by jumping around and finding questions that are most relevant to your needs.

## Project setup

### How does the app start?

For each platform in Xamarin.Forms, you call the `LoadApplication` method, which creates a new application and starts your app.

```
<span>LoadApplication</span><span>(</span><span>new</span> <span>App</span><span>());</span>
```

In Flutter, the default main entry point is `main` where you load your Flutter app.

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
</span><span>}</span>
```

In Xamarin.Forms, you assign a `Page` to the `MainPage` property in the `Application` class.

```
<span>public</span> <span>class</span> <span>App</span> <span>:</span> <span>Application</span>
<span>{</span>
    <span>public</span> <span>App</span><span>()</span>
    <span>{</span>
        <span>MainPage</span> <span>=</span> <span>new</span> <span>ContentPage</span>
        <span>{</span>
            <span>Content</span> <span>=</span> <span>new</span> <span>Label</span>
            <span>{</span>
                <span>Text</span> <span>=</span> <span>"Hello World"</span><span>,</span>
                <span>HorizontalOptions</span> <span>=</span> <span>LayoutOptions</span><span>.</span><span>Center</span><span>,</span>
                <span>VerticalOptions</span> <span>=</span> <span>LayoutOptions</span><span>.</span><span>Center</span>
            <span>}</span>
        <span>};</span>
    <span>}</span>
<span>}</span>
```

In Flutter, “everything is a widget”, even the application itself. The following example shows `MyApp`, a simple application `Widget`.

```
<span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Hello World!'</span><span>,</span><span>
        textDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do you create a page?

Xamarin.Forms has many types of pages; `ContentPage` is the most common. In Flutter, you specify an application widget that holds your root page. You can use a [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html) widget, which supports [Material Design](https://m3.material.io/styles), or you can use a [`CupertinoApp`](https://api.flutter.dev/flutter/cupertino/CupertinoApp-class.html) widget, which supports an iOS-style app, or you can use the lower level [`WidgetsApp`](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html), which you can customize in any way you want.

The following code defines the home page, a stateful widget. In Flutter, all widgets are immutable, but two types of widgets are supported: _Stateful_ and _Stateless_. Examples of a stateless widget are titles, icons, or images.

The following example uses `MaterialApp`, which holds its root page in the `home` property.

```
<span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Flutter Demo'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>MyHomePage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'Flutter Demo Home Page'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

From here, your actual first page is another `Widget`, in which you create your state.

A _Stateful_ widget, such as `MyHomePage` below, consists of two parts. The first part, which is itself immutable, creates a `State` object that holds the state of the object. The `State` object persists over the life of the widget.

```
<span>class</span><span> </span><span>MyHomePage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyHomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyHomePageState</span><span>();</span><span>
</span><span>}</span>
```

The `State` object implements the `build()` method for the stateful widget.

When the state of the widget tree changes, call `setState()`, which triggers a build of that portion of the UI. Make sure to call `setState()` only when necessary, and only on the part of the widget tree that has changed, or it can result in poor UI performance.

```
<span>class</span><span> _MyHomePageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>int</span><span> _counter </span><span>=</span><span> </span><span>0</span><span>;</span><span>

  </span><span>void</span><span> _incrementCounter</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _counter</span><span>++;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        </span><span>// Take the value from the MyHomePage object that was created by</span><span>
        </span><span>// the App.build method, and use it to set the appbar title.</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>widget</span><span>.</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        </span><span>// Center is a layout widget. It takes a single child and positions it</span><span>
        </span><span>// in the middle of the parent.</span><span>
        child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
          children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
              </span><span>'You have pushed the button this many times:'</span><span>,</span><span>
            </span><span>),</span><span>
            </span><span>Text</span><span>(</span><span>
              </span><span>'$_counter'</span><span>,</span><span>
              style</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>textTheme</span><span>.</span><span>headlineMedium</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> _incrementCounter</span><span>,</span><span>
        tooltip</span><span>:</span><span> </span><span>'Increment'</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>add</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

In Flutter, the UI (also known as widget tree), is immutable, meaning you can’t change its state once it’s built. You change fields in your `State` class, then call `setState()` to rebuild the entire widget tree again.

This way of generating UI is different from Xamarin.Forms, but there are many benefits to this approach.

## Views

### What is the equivalent of a Page or Element in Flutter?

`ContentPage`, `TabbedPage`, `FlyoutPage` are all types of pages you might use in a Xamarin.Forms application. These pages would then hold `Element`s to display the various controls. In Xamarin.Forms an `Entry` or `Button` are examples of an `Element`.

In Flutter, almost everything is a widget. A `Page`, called a `Route` in Flutter, is a widget. Buttons, progress bars, and animation controllers are all widgets. When building a route, you create a widget tree.

Flutter includes the [Material Components](https://docs.flutter.dev/ui/widgets/material) library. These are widgets that implement the [Material Design guidelines](https://m3.material.io/styles). Material Design is a flexible design system [optimized for all platforms](https://m2.material.io/design/platform-guidance/cross-platform-adaptation.html#cross-platform-guidelines), including iOS.

But Flutter is flexible and expressive enough to implement any design language. For example, on iOS, you can use the [Cupertino widgets](https://docs.flutter.dev/ui/widgets/cupertino) to produce an interface that looks like [Apple’s iOS design language](https://developer.apple.com/design/resources/).

### How do I update widgets?

In Xamarin.Forms, each `Page` or `Element` is a stateful class, that has properties and methods. You update your `Element` by updating a property, and this is propagated down to the native control.

In Flutter, `Widget`s are immutable and you can’t directly update them by changing a property, instead you have to work with the widget’s state.

This is where the concept of Stateful vs Stateless widgets comes from. A `StatelessWidget` is just what it sounds like— a widget with no state information.

`StatelessWidgets` are useful when the part of the user interface you are describing doesn’t depend on anything other than the configuration information in the object.

For example, in Xamarin.Forms, this is similar to placing an `Image` with your logo. The logo is not going to change during runtime, so use a `StatelessWidget` in Flutter.

If you want to dynamically change the UI based on data received after making an HTTP call or a user interaction, then you have to work with `StatefulWidget` and tell the Flutter framework that the widget’s `State` has been updated, so it can update that widget.

The important thing to note here is at the core both stateless and stateful widgets behave the same. They rebuild every frame, the difference is the `StatefulWidget` has a `State` object that stores state data across frames and restores it.

If you are in doubt, then always remember this rule: if a widget changes (because of user interactions, for example) it’s stateful. However, if a widget reacts to change, the containing parent widget can still be stateless if it doesn’t itself react to change.

The following example shows how to use a `StatelessWidget`. A common `StatelessWidget` is the `Text` widget. If you look at the implementation of the `Text` widget you’ll find it subclasses `StatelessWidget`.

```
<span>const</span><span> </span><span>Text</span><span>(</span><span>
  </span><span>'I like Flutter!'</span><span>,</span><span>
  style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>),</span><span>
</span><span>);</span>
```

As you can see, the `Text` widget has no state information associated with it, it renders what is passed in its constructors and nothing more.

But, what if you want to make “I Like Flutter” change dynamically, for example, when clicking a `FloatingActionButton`?

To achieve this, wrap the `Text` widget in a `StatefulWidget` and update it when the user clicks the button, as shown in the following example:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
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
  </span><span>/// Default placeholder text</span><span>
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

### How do I lay out my widgets? What is the equivalent of an XAML file?

In Xamarin.Forms, most developers write layouts in XAML, though sometimes in C#. In Flutter, you write your layouts with a widget tree in code.

The following example shows how to display a simple widget with padding:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
    appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
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

You can view the layouts that Flutter has to offer in the [widget catalog](https://docs.flutter.dev/ui/widgets/layout).

### How do I add or remove an Element from my layout?

In Xamarin.Forms, you had to remove or add an `Element` in code. This involved either setting the `Content` property or calling `Add()` or `Remove()` if it was a list.

In Flutter, because widgets are immutable there is no direct equivalent. Instead, you can pass a function to the parent that returns a widget, and control that child’s creation with a boolean flag.

The following example shows how to toggle between two widgets when the user clicks the `FloatingActionButton`:

```
<span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
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
  </span><span>/// Default value for toggle</span><span>
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
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> _getToggleChild</span><span>()),</span><span>
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

In Xamarin.Forms, you create simple animations using ViewExtensions that include methods such as `FadeTo` and `TranslateTo`. You would use these methods on a view to perform the required animations.

```
<span>&lt;Image</span> <span>Source=</span><span>"{Binding MyImage}"</span> <span>x:Name=</span><span>"myImage"</span> <span>/&gt;</span>
```

Then in code behind, or a behavior, this would fade in the image, over a 1-second period.

In Flutter, you animate widgets using the animation library by wrapping widgets inside an animated widget. Use an `AnimationController`, which is an `Animation<double>` that can pause, seek, stop and reverse the animation. It requires a `Ticker` that signals when vsync happens, and produces a linear interpolation between 0 and 1 on each frame while it’s running. You then create one or more`Animation`s and attach them to the controller.

For example, you might use `CurvedAnimation` to implement an animation along an interpolated curve. In this sense, the controller is the “master” source of the animation progress and the `CurvedAnimation` computes the curve that replaces the controller’s default linear motion. Like widgets, animations in Flutter work with composition.

When building the widget tree, you assign the `Animation` to an animated property of a widget, such as the opacity of a `FadeTransition`, and tell the controller to start the animation.

The following example shows how to write a `FadeTransition` that fades the widget into a logo when you press the `FloatingActionButton`:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>FadeAppTest</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>FadeAppTest</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>FadeAppTest</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

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

</span><span>class</span><span> _MyFadeTest </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyFadeTest</span><span>&gt;</span><span> </span><span>with</span><span> </span><span>TickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>final</span><span> </span><span>AnimationController</span><span> controller</span><span>;</span><span>
  </span><span>late</span><span> </span><span>final</span><span> </span><span>CurvedAnimation</span><span> curve</span><span>;</span><span>

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

### How do I draw/paint on the screen?

Xamarin.Forms never had a built-in way to draw directly on the screen. Many would use SkiaSharp, if they needed a custom image drawn. In Flutter, you have direct access to the Skia Canvas and can easily draw on screen.

Flutter has two classes that help you draw to the canvas: `CustomPaint` and `CustomPainter`, the latter of which implements your algorithm to draw to the canvas.

To learn how to implement a signature painter in Flutter, see Collin’s answer on [Custom Paint](https://stackoverflow.com/questions/46241071/create-signature-area-for-mobile-app-in-dart-flutter).

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>home</span><span>:</span><span> </span><span>DemoApp</span><span>()));</span><span>
</span><span>}</span><span>

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
  </span><span>List</span><span>&lt;</span><span>Offset</span><span>?&gt;</span><span> _points </span><span>=</span><span> </span><span>&lt;</span><span>Offset</span><span>?&gt;[];</span><span>

  </span><span>void</span><span> _onPanUpdate</span><span>(</span><span>DragUpdateDetails</span><span> details</span><span>)</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      </span><span>final</span><span> </span><span>RenderBox</span><span> referenceBox </span><span>=</span><span> context</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
      </span><span>final</span><span> </span><span>Offset</span><span> localPosition </span><span>=</span><span> referenceBox</span><span>.</span><span>globalToLocal</span><span>(</span><span>
        details</span><span>.</span><span>globalPosition</span><span>,</span><span>
      </span><span>);</span><span>
      _points </span><span>=</span><span> </span><span>List</span><span>.</span><span>from</span><span>(</span><span>_points</span><span>)..</span><span>add</span><span>(</span><span>localPosition</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onPanUpdate</span><span>:</span><span> _onPanUpdate</span><span>,</span><span>
      onPanEnd</span><span>:</span><span> </span><span>(</span><span>details</span><span>)</span><span> </span><span>=&gt;</span><span> _points</span><span>.</span><span>add</span><span>(</span><span>null</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>CustomPaint</span><span>(</span><span>
        painter</span><span>:</span><span> </span><span>SignaturePainter</span><span>(</span><span>_points</span><span>),</span><span>
        size</span><span>:</span><span> </span><span>Size</span><span>.</span><span>infinite</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SignaturePainter</span><span> </span><span>extends</span><span> </span><span>CustomPainter</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SignaturePainter</span><span>(</span><span>this</span><span>.</span><span>points</span><span>);</span><span>

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

### Where is the widget’s opacity?

On Xamarin.Forms, all `VisualElement`s have an Opacity. In Flutter, you need to wrap a widget in an [`Opacity` widget](https://api.flutter.dev/flutter/widgets/Opacity-class.html) to accomplish this.

### How do I build custom widgets?

In Xamarin.Forms, you typically subclass `VisualElement`, or use a pre-existing `VisualElement`, to override and implement methods that achieve the desired behavior.

In Flutter, build a custom widget by [composing](https://docs.flutter.dev/resources/architectural-overview#composition) smaller widgets (instead of extending them). It is somewhat similar to implementing a custom control based off a `Grid` with numerous `VisualElement`s added in, while extending with custom logic.

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

### How do I navigate between pages?

In Xamarin.Forms, the `NavigationPage` class provides a hierarchical navigation experience where the user is able to navigate through pages, forwards and backwards.

Flutter has a similar implementation, using a `Navigator` and `Routes`. A `Route` is an abstraction for a `Page` of an app, and a `Navigator` is a [widget](https://docs.flutter.dev/resources/architectural-overview#widgets) that manages routes.

A route roughly maps to a `Page`. The navigator works in a similar way to the Xamarin.Forms `NavigationPage`, in that it can `push()` and `pop()` routes depending on whether you want to navigate to, or back from, a view.

To navigate between pages, you have a couple options:

-   Specify a `Map` of route names. (`MaterialApp`)
-   Directly navigate to a route. (`WidgetsApp`)

The following example builds a `Map`.

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span>MaterialApp</span><span>(</span><span>
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

Navigate to a route by pushing its name to the `Navigator`.

```
<span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/b'</span><span>);</span>
```

The `Navigator` is a stack that manages your app’s routes. Pushing a route to the stack moves to that route. Popping a route from the stack, returns to the previous route. This is done by awaiting on the `Future` returned by `push()`.

`async`/`await` is very similar to the .NET implementation and is explained in more detail in [Async UI](https://docs.flutter.dev/get-started/flutter-for/xamarin-forms-devs#async-ui).

For example, to start a `location` route that lets the user select their location, you might do the following:

```
<span>Object</span><span>?</span><span> coordinates </span><span>=</span><span> </span><span>await</span><span> </span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/location'</span><span>);</span>
```

And then, inside your ‘location’ route, once the user has selected their location, pop the stack with the result:

```
<span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pop</span><span>({</span><span>'lat'</span><span>:</span><span> </span><span>43.821757</span><span>,</span><span> </span><span>'long'</span><span>:</span><span> </span><span>-</span><span>79.226392</span><span>});</span>
```

### How do I navigate to another app?

In Xamarin.Forms, to send the user to another application, you use a specific URI scheme, using `Device.OpenUrl("mailto://")`.

To implement this functionality in Flutter, create a native platform integration, or use an [existing plugin](https://pub.dev/flutter), such as[`url_launcher`](https://pub.dev/packages/url_launcher), available with many other packages on [pub.dev](https://pub.dev/).

## Async UI

### What is the equivalent of Device.BeginOnMainThread() in Flutter?

Dart has a single-threaded execution model, with support for `Isolate`s (a way to run Dart codes on another thread), an event loop, and asynchronous programming. Unless you spawn an `Isolate`, your Dart code runs in the main UI thread and is driven by an event loop.

Dart’s single-threaded model doesn’t mean you need to run everything as a blocking operation that causes the UI to freeze. Much like Xamarin.Forms, you need to keep the UI thread free. You would use `async`/`await` to perform tasks, where you must wait for the response.

In Flutter, use the asynchronous facilities that the Dart language provides, also named `async`/`await`, to perform asynchronous work. This is very similar to C# and should be very easy to use for any Xamarin.Forms developer.

For example, you can run network code without causing the UI to hang by using `async`/`await` and letting Dart do the heavy lifting:

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>
    </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
  </span><span>);</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    data </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

Once the awaited network call is done, update the UI by calling `setState()`, which triggers a rebuild of the widget subtree and updates the data.

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
    </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>
      </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
    </span><span>);</span><span>
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
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
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

Refer to the next section for more information on doing work in the background, and how Flutter differs from Android.

### How do you move work to a background thread?

Since Flutter is single threaded and runs an event loop, you don’t have to worry about thread management or spawning background threads. This is very similar to Xamarin.Forms. If you’re doing I/O-bound work, such as disk access or a network call, then you can safely use `async`/`await` and you’re all set.

If, on the other hand, you need to do computationally intensive work that keeps the CPU busy, you want to move it to an `Isolate` to avoid blocking the event loop, like you would keep _any_ sort of work out of the main thread. This is similar to when you move things to a different thread via `Task.Run()` in Xamarin.Forms.

For I/O-bound work, declare the function as an `async` function, and `await` on long-running tasks inside the function:

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>
    </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
  </span><span>);</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    data </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

This is how you would typically do network or database calls, which are both I/O operations.

However, there are times when you might be processing a large amount of data and your UI hangs. In Flutter, use `Isolate`s to take advantage of multiple CPU cores to do long-running or computationally intensive tasks.

Isolates are separate execution threads that do not share any memory with the main execution memory heap. This is a difference between `Task.Run()`. This means you can’t access variables from the main thread, or update your UI by calling `setState()`.

The following example shows, in a simple isolate, how to share data back to the main thread to update the UI.

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>ReceivePort</span><span> receivePort </span><span>=</span><span> </span><span>ReceivePort</span><span>();</span><span>
  </span><span>await</span><span> </span><span>Isolate</span><span>.</span><span>spawn</span><span>(</span><span>dataLoader</span><span>,</span><span> receivePort</span><span>.</span><span>sendPort</span><span>);</span><span>

  </span><span>// The 'echo' isolate sends its SendPort as the first message</span><span>
  </span><span>final</span><span> </span><span>SendPort</span><span> sendPort </span><span>=</span><span> </span><span>await</span><span> receivePort</span><span>.</span><span>first </span><span>as</span><span> </span><span>SendPort</span><span>;</span><span>
  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> msg </span><span>=</span><span> </span><span>await</span><span> sendReceive</span><span>(</span><span>
    sendPort</span><span>,</span><span>
    </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
  </span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    data </span><span>=</span><span> msg</span><span>;</span><span>
  </span><span>});</span><span>
</span><span>}</span><span>

</span><span>// The entry point for the isolate</span><span>
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

    </span><span>// The 'echo' isolate sends its SendPort as the first message</span><span>
    </span><span>final</span><span> </span><span>SendPort</span><span> sendPort </span><span>=</span><span> </span><span>await</span><span> receivePort</span><span>.</span><span>first </span><span>as</span><span> </span><span>SendPort</span><span>;</span><span>
    </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;</span><span> msg </span><span>=</span><span> </span><span>await</span><span> sendReceive</span><span>(</span><span>
      sendPort</span><span>,</span><span>
      </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
    </span><span>);</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      data </span><span>=</span><span> msg</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>// The entry point for the isolate</span><span>
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

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row ${data[index]['</span><span>title</span><span>']}'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
      body</span><span>:</span><span> getBody</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do I make network requests?

In Xamarin.Forms you would use `HttpClient`. Making a network call in Flutter is easy when you use the popular [`http` package](https://pub.dev/packages/http). This abstracts away a lot of the networking that you might normally implement yourself, making it simple to make network calls.

To use the `http` package, add it to your dependencies in `pubspec.yaml`:

```
<span>dependencies</span><span>:</span>
  <span>http</span><span>:</span> <span>^1.1.0</span>
```

To make a network request, call `await` on the `async` function `http.get()`:

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> loadData</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>
    </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
  </span><span>);</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>dataURL</span><span>);</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    data </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

### How do I show the progress for a long-running task?

In Xamarin.Forms you would typically create a loading indicator, either directly in XAML or through a 3rd party plugin such as AcrDialogs.

In Flutter, use a `ProgressIndicator` widget. Show the progress programmatically by controlling when it’s rendered through a boolean flag. Tell Flutter to update its state before your long-running task starts, and hide it after it ends.

In the example below, the build function is separated into three different functions. If `showLoadingDialog` is `true` (when `widgets.length == 0`), then render the `ProgressIndicator`. Otherwise, render the `ListView` with the data returned from a network call.

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

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
    </span><span>final</span><span> </span><span>Uri</span><span> dataURL </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>
      </span><span>'https://jsonplaceholder.typicode.com/posts'</span><span>,</span><span>
    </span><span>);</span><span>
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

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row ${data[index]['</span><span>title</span><span>']}'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
      body</span><span>:</span><span> getBody</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Project structure & resources

### Where do I store my image files?

Xamarin.Forms has no platform independent way of storing images, you had to place images in the iOS `xcasset` folder, or on Android in the various `drawable` folders.

While Android and iOS treat resources and assets as distinct items, Flutter apps have only assets. All resources that would live in the `Resources/drawable-*` folders on Android, are placed in an assets’ folder for Flutter.

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

Assets are located in any arbitrary folder— Flutter has no predefined folder structure. You declare the assets (with location) in the `pubspec.yaml` file, and Flutter picks them up.

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

You can directly access your images in an `Image.asset` widget:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/my_icon.png'</span><span>);</span><span>
</span><span>}</span>
```

or using `AssetImage`:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>const</span><span> </span><span>Image</span><span>(</span><span>
    image</span><span>:</span><span> </span><span>AssetImage</span><span>(</span><span>'images/my_image.png'</span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

More detailed information can be found in [Adding assets and images](https://docs.flutter.dev/ui/assets/assets-and-images).

### Where do I store strings? How do I handle localization?

Unlike .NET which has `resx` files, Flutter doesn’t currently have a dedicated system for handling strings. At the moment, the best practice is to declare your copy text in a class as static fields and access them from there. For example:

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
<span>import</span><span> </span><span>'package:flutter_localizations/flutter_localizations.dart'</span><span>;</span><span>

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

To access localized resources, use the `Localizations.of()` method to access a specific localizations class that is provided by a given delegate. Use the [`intl_translation`](https://pub.dev/packages/intl_translation) package to extract translatable copy to [arb](https://github.com/google/app-resource-bundle) files for translating, and importing them back into the app for using them with `intl`.

For further details on internationalization and localization in Flutter, see the [internationalization guide](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization), which has sample code with and without the `intl` package.

### Where is my project file?

In Xamarin.Forms you will have a `csproj` file. The closest equivalent in Flutter is pubspec.yaml, which contains package dependencies and various project details. Similar to .NET Standard, files within the same directory are considered part of the project.

### What is the equivalent of Nuget? How do I add dependencies?

In the .NET ecosystem, native Xamarin projects and Xamarin.Forms projects had access to Nuget and the built-in package management system. Flutter apps contain a native Android app, native iOS app and Flutter app.

In Android, you add dependencies by adding to your Gradle build script. In iOS, you add dependencies by adding to your `Podfile`.

Flutter uses Dart’s own build system, and the Pub package manager. The tools delegate the building of the native Android and iOS wrapper apps to the respective build systems.

In general, use `pubspec.yaml` to declare external dependencies to use in Flutter. A good place to find Flutter packages is on [pub.dev](https://pub.dev/).

## Application lifecycle

### How do I listen to application lifecycle events?

In Xamarin.Forms, you have an `Application` that contains `OnStart`, `OnResume` and `OnSleep`. In Flutter, you can instead listen to similar lifecycle events by hooking into the `WidgetsBinding` observer and listening to the `didChangeAppLifecycleState()` change event.

The observable lifecycle events are:

`inactive`

The application is in an inactive state and is not receiving user input. This event is iOS only.

`paused`

The application is not currently visible to the user, is not responding to user input, but is running in the background.

`resumed`

The application is visible and responding to user input.

`suspending`

The application is suspended momentarily. This event is Android only.

For more details on the meaning of these states, see the [`AppLifecycleStatus` documentation](https://api.flutter.dev/flutter/dart-ui/AppLifecycleState.html).

## Layouts

### What is the equivalent of a StackLayout?

In Xamarin.Forms you can create a `StackLayout` with an `Orientation` of horizontal or vertical. Flutter has a similar approach, however you would use the `Row` or `Column` widgets.

If you notice the two code samples are identical except the `Row` and `Column` widget. The children are the same and this feature can be exploited to develop rich layouts that can change overtime with the same children.

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
  </span><span>);</span>
```

### What is the equivalent of a Grid?

The closest equivalent of a `Grid` would be a `GridView`. This is much more powerful than what you are used to in Xamarin.Forms. A `GridView` provides automatic scrolling when the content exceeds its viewable space.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>GridView</span><span>.</span><span>count</span><span>(</span><span>
    </span><span>// Create a grid with 2 columns. If you change the scrollDirection to</span><span>
    </span><span>// horizontal, this would produce 2 rows.</span><span>
    crossAxisCount</span><span>:</span><span> </span><span>2</span><span>,</span><span>
    </span><span>// Generate 100 widgets that display their index in the list.</span><span>
    children</span><span>:</span><span> </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;.</span><span>generate</span><span>(</span><span>
      </span><span>100</span><span>,</span><span>
      </span><span>(</span><span>index</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
            </span><span>'Item $index'</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>textTheme</span><span>.</span><span>headlineMedium</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

You might have used a `Grid` in Xamarin.Forms to implement widgets that overlay other widgets. In Flutter, you accomplish this with the `Stack` widget.

This sample creates two icons that overlap each other.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>const</span><span> </span><span>Stack</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
      </span><span>Icon</span><span>(</span><span>
        </span><span>Icons</span><span>.</span><span>add_box</span><span>,</span><span>
        size</span><span>:</span><span> </span><span>24</span><span>,</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>,</span><span>
      </span><span>),</span><span>
      </span><span>Positioned</span><span>(</span><span>
        left</span><span>:</span><span> </span><span>10</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>
          </span><span>Icons</span><span>.</span><span>add_circle</span><span>,</span><span>
          size</span><span>:</span><span> </span><span>24</span><span>,</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

### What is the equivalent of a ScrollView?

In Xamarin.Forms, a `ScrollView` wraps around a `VisualElement`, and if the content is larger than the device screen, it scrolls.

In Flutter, the closest match is the `SingleChildScrollView` widget. You simply fill the Widget with the content that you want to be scrollable.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>const</span><span> </span><span>SingleChildScrollView</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Long Content'</span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

If you have many items you want to wrap in a scroll, even of different `Widget` types, you might want to use a `ListView`. This might seem like overkill, but in Flutter this is far more optimized and less intensive than a Xamarin.Forms `ListView`, which is backing on to platform specific controls.

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

Landscape transitions can be handled automatically by setting the `configChanges` property in the AndroidManifest.xml:

```
<span>&lt;activity</span> <span>android:configChanges=</span><span>"orientation|screenSize"</span> <span>/&gt;</span>
```

## Gesture detection and touch event handling

### How do I add GestureRecognizers to a widget in Flutter?

In Xamarin.Forms, `Element`s might contain a click event you can attach to. Many elements also contain a `Command` that is tied to this event. Alternatively you would use the `TapGestureRecognizer`. In Flutter there are two very similar ways:

1.  If the widget supports event detection, pass a function to it and handle it in the function. For example, the ElevatedButton has an `onPressed` parameter:
    
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
    
2.  If the widget doesn’t support event detection, wrap the widget in a `GestureDetector` and pass a function to the `onTap` parameter.
    
    ```
    <span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
      </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
      @override
      </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
          body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
            child</span><span>:</span><span> </span><span>GestureDetector</span><span>(</span><span>
              onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
                developer</span><span>.</span><span>log</span><span>(</span><span>'tap'</span><span>);</span><span>
              </span><span>},</span><span>
              child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(</span><span>size</span><span>:</span><span> </span><span>200</span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>);</span><span>
      </span><span>}</span><span>
    </span><span>}</span>
    ```
    

### How do I handle other gestures on widgets?

In Xamarin.Forms you would add a `GestureRecognizer` to the `View`. You would normally be limited to `TapGestureRecognizer`, `PinchGestureRecognizer`, `PanGestureRecognizer`, `SwipeGestureRecognizer`, `DragGestureRecognizer` and `DropGestureRecognizer` unless you built your own.

In Flutter, using the GestureDetector, you can listen to a wide range of Gestures such as:

-   Tap

`onTapDown`

A pointer that might cause a tap has contacted the screen at a particular location.

`onTapUp`

A pointer that triggers a tap has stopped contacting the screen at a particular location.

`onTap`

A tap has occurred.

`onTapCancel`

The pointer that previously triggered the `onTapDown` won’t cause a tap.

-   Double tap

`onDoubleTap`

The user tapped the screen at the same location twice in quick succession.

-   Long press

`onLongPress`

A pointer has remained in contact with the screen at the same location for a long period of time.

-   Vertical drag

`onVerticalDragStart`

A pointer has contacted the screen and might begin to move vertically.

`onVerticalDragUpdate`

A pointer in contact with the screen has moved further in the vertical direction.

`onVerticalDragEnd`

A pointer that was previously in contact with the screen and moving vertically is no longer in contact with the screen and was moving at a specific velocity when it stopped contacting the screen.

-   Horizontal drag

`onHorizontalDragStart`

A pointer has contacted the screen and might begin to move horizontally.

`onHorizontalDragUpdate`

A pointer in contact with the screen has moved further in the horizontal direction.

`onHorizontalDragEnd`

A pointer that was previously in contact with the screen and moving horizontally is no longer in contact with the screen and was moving at a specific velocity when it stopped contacting the screen.

The following example shows a `GestureDetector` that rotates the Flutter logo on a double tap:

```
<span>class</span><span> </span><span>RotatingFlutterDetector</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>RotatingFlutterDetector</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>RotatingFlutterDetector</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span>
      _RotatingFlutterDetectorState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _RotatingFlutterDetectorState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>RotatingFlutterDetector</span><span>&gt;</span><span>
    </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>final</span><span> </span><span>AnimationController</span><span> controller</span><span>;</span><span>
  </span><span>late</span><span> </span><span>final</span><span> </span><span>CurvedAnimation</span><span> curve</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    controller </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
      duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>2000</span><span>),</span><span>
      vsync</span><span>:</span><span> </span><span>this</span><span>,</span><span>
    </span><span>);</span><span>
    curve </span><span>=</span><span> </span><span>CurvedAnimation</span><span>(</span><span>parent</span><span>:</span><span> controller</span><span>,</span><span> curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>easeIn</span><span>);</span><span>
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
            child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(</span><span>size</span><span>:</span><span> </span><span>200</span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Listviews and adapters

### What is the equivalent to a ListView in Flutter?

The equivalent to a `ListView` in Flutter is … a `ListView`!

In a Xamarin.Forms `ListView`, you create a `ViewCell` and possibly a `DataTemplateSelector`and pass it into the `ListView`, which renders each row with what your `DataTemplateSelector` or `ViewCell` returns. However, you often have to make sure you turn on Cell Recycling otherwise you will run into memory issues and slow scrolling speeds.

Due to Flutter’s immutable widget pattern, you pass a list of widgets to your `ListView`, and Flutter takes care of making sure that scrolling is fast and smooth.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleAppPage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleAppPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> _getListData</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;.</span><span>generate</span><span>(</span><span>
      </span><span>100</span><span>,</span><span>
      </span><span>(</span><span>index</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $index'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> _getListData</span><span>()),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do I know which list item has been clicked?

In Xamarin.Forms, the ListView has an `ItemTapped` method to find out which item was clicked. There are many other techniques you might have used such as checking when `SelectedItem` or `EventToCommand` behaviors change.

In Flutter, use the touch handling provided by the passed-in widgets.

```
<span>import</span><span> </span><span>'dart:developer'</span><span> </span><span>as</span><span> developer</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

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
  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> _getListData</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;.</span><span>generate</span><span>(</span><span>
      </span><span>100</span><span>,</span><span>
      </span><span>(</span><span>index</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>GestureDetector</span><span>(</span><span>
        onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          developer</span><span>.</span><span>log</span><span>(</span><span>'Row $index tapped'</span><span>);</span><span>
        </span><span>},</span><span>
        child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
          padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $index'</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> _getListData</span><span>()),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do I update a ListView dynamically?

In Xamarin.Forms, if you bound the `ItemsSource` property to an `ObservableCollection`, you would just update the list in your ViewModel. Alternatively, you could assign a new `List` to the `ItemSource` property.

In Flutter, things work a little differently. If you update the list of widgets inside a `setState()` method, you would quickly see that your data did not change visually. This is because when `setState()` is called, the Flutter rendering engine looks at the widget tree to see if anything has changed. When it gets to your `ListView`, it performs a `==` check, and determines that the two `ListView`s are the same. Nothing has changed, so no update is required.

For a simple way to update your `ListView`, create a new `List` inside of `setState()`, and copy the data from the old list to the new list. While this approach is simple, it is not recommended for large data sets, as shown in the next example.

```
<span>import</span><span> </span><span>'dart:developer'</span><span> </span><span>as</span><span> developer</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
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
  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> widgets </span><span>=</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> </span><span>100</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>i</span><span>));</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          widgets </span><span>=</span><span> </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;.</span><span>from</span><span>(</span><span>widgets</span><span>);</span><span>
          widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>widgets</span><span>.</span><span>length</span><span>));</span><span>
          developer</span><span>.</span><span>log</span><span>(</span><span>'Row $index'</span><span>);</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $index'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>children</span><span>:</span><span> widgets</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The recommended, efficient, and effective way to build a list uses a `ListView.Builder`. This method is great when you have a dynamic list or a list with very large amounts of data. This is essentially the equivalent of RecyclerView on Android, which automatically recycles list elements for you:

```
<span>import</span><span> </span><span>'dart:developer'</span><span> </span><span>as</span><span> developer</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
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
  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> widgets </span><span>=</span><span> </span><span>[];</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    </span><span>for</span><span> </span><span>(</span><span>int</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> </span><span>100</span><span>;</span><span> i</span><span>++)</span><span> </span><span>{</span><span>
      widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>i</span><span>));</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> getRow</span><span>(</span><span>int</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          widgets</span><span>.</span><span>add</span><span>(</span><span>getRow</span><span>(</span><span>widgets</span><span>.</span><span>length</span><span>));</span><span>
          developer</span><span>.</span><span>log</span><span>(</span><span>'Row $index'</span><span>);</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Row $index'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
        itemCount</span><span>:</span><span> widgets</span><span>.</span><span>length</span><span>,</span><span>
        itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> getRow</span><span>(</span><span>index</span><span>);</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Instead of creating a `ListView`, create a `ListView.builder` that takes two key parameters: the initial length of the list, and an item builder function.

The item builder function is similar to the `getView` function in an Android adapter; it takes a position, and returns the row you want rendered at that position.

Finally, but most importantly, notice that the `onTap()` function doesn’t recreate the list anymore, but instead adds to it.

For more information, see [Your first Flutter app](https://codelabs.developers.google.com/codelabs/flutter-codelab-first) codelab.

## Working with text

### How do I set custom fonts on my text widgets?

In Xamarin.Forms, you would have to add a custom font in each native project. Then, in your `Element` you would assign this font name to the `FontFamily` attribute using `filename#fontname` and just `fontname` for iOS.

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
    appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
    body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'This is a custom font text'</span><span>,</span><span>
        style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontFamily</span><span>:</span><span> </span><span>'MyCustomFont'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

### How do I style my text widgets?

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

## Form input

### How do I retrieve user input?

Xamarin.Forms `element`s allow you to directly query the `element` to determine the state of its properties, or whether it’s bound to a property in a `ViewModel`.

Retrieving information in Flutter is handled by specialized widgets and is different from how you are used to. If you have a `TextField`or a `TextFormField`, you can supply a [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) to retrieve user input:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>class</span><span> </span><span>MyForm</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyForm</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyForm</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyFormState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyFormState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyForm</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>/// Create a text controller and use it to retrieve the current value</span><span>
  </span><span>/// of the TextField.</span><span>
  </span><span>final</span><span> </span><span>TextEditingController</span><span> myController </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Clean up the controller when disposing of the widget.</span><span>
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
        </span><span>// text that the user has typed into our text field.</span><span>
        onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          showDialog</span><span>(</span><span>
            context</span><span>:</span><span> context</span><span>,</span><span>
            builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>{</span><span>
              </span><span>return</span><span> </span><span>AlertDialog</span><span>(</span><span>
                </span><span>// Retrieve the text that the user has entered using the</span><span>
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

### What is the equivalent of a Placeholder on an Entry?

In Xamarin.Forms, some `Elements` support a `Placeholder` property that you can assign a value to. For example:

```
<span>&lt;Entry</span> <span>Placeholder=</span><span>"This is a hint"</span><span>&gt;</span>
```

In Flutter, you can easily show a “hint” or a placeholder text for your input by adding an `InputDecoration` object to the `decoration` constructor parameter for the text widget.

```
<span>TextField</span><span>(</span><span>
  decoration</span><span>:</span><span> </span><span>InputDecoration</span><span>(</span><span>hintText</span><span>:</span><span> </span><span>'This is a hint'</span><span>),</span><span>
</span><span>),</span>
```

### How do I show validation errors?

With Xamarin.Forms, if you wished to provide a visual hint of a validation error, you would need to create new properties and `VisualElement`s surrounding the `Element`s that had validation errors.

In Flutter, you pass through an InputDecoration object to the decoration constructor for the text widget.

However, you don’t want to start off by showing an error. Instead, when the user has entered invalid data, update the state, and pass a new `InputDecoration` object.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>SampleApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
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
  </span><span>String</span><span>?</span><span> _errorText</span><span>;</span><span>

  </span><span>String</span><span>?</span><span> _getErrorText</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> _errorText</span><span>;</span><span>
  </span><span>}</span><span>

  </span><span>bool</span><span> isEmail</span><span>(</span><span>String</span><span> em</span><span>)</span><span> </span><span>{</span><span>
    </span><span>const</span><span> </span><span>String</span><span> emailRegexp </span><span>=</span><span>
        </span><span>r'^(([^&lt;&gt;()[\]\\.,;:\s@\"]+(\.[^&lt;&gt;()[\]\\.,;:\s@\"]+)*)|'</span><span>
        </span><span>r'(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'</span><span>
        </span><span>r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'</span><span>;</span><span>
    </span><span>final</span><span> </span><span>RegExp</span><span> regExp </span><span>=</span><span> </span><span>RegExp</span><span>(</span><span>emailRegexp</span><span>);</span><span>
    </span><span>return</span><span> regExp</span><span>.</span><span>hasMatch</span><span>(</span><span>em</span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Sample App'</span><span>)),</span><span>
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
</span><span>}</span>
```

## Flutter plugins

## Interacting with hardware, third party services, and the platform

### How do I interact with the platform, and with platform native code?

Flutter doesn’t run code directly on the underlying platform; rather, the Dart code that makes up a Flutter app is run natively on the device, “sidestepping” the SDK provided by the platform. That means, for example, when you perform a network request in Dart, it runs directly in the Dart context. You don’t use the Android or iOS APIs you normally take advantage of when writing native apps. Your Flutter app is still hosted in a native app’s `ViewController` or `Activity` as a view, but you don’t have direct access to this, or the native framework.

This doesn’t mean Flutter apps can’t interact with those native APIs, or with any native code you have. Flutter provides [platform channels](https://docs.flutter.dev/platform-integration/platform-channels) that communicate and exchange data with the `ViewController` or `Activity` that hosts your Flutter view. Platform channels are essentially an asynchronous messaging mechanism that bridges the Dart code with the host `ViewController` or `Activity` and the iOS or Android framework it runs on. You can use platform channels to execute a method on the native side, or to retrieve some data from the device’s sensors, for example.

In addition to directly using platform channels, you can use a variety of pre-made [plugins](https://docs.flutter.dev/packages-and-plugins/using-packages) that encapsulate the native and Dart code for a specific goal. For example, you can use a plugin to access the camera roll and the device camera directly from Flutter, without having to write your own integration. Plugins are found on [pub.dev](https://pub.dev/), Dart and Flutter’s open source package repository. Some packages might support native integrations on iOS, or Android, or both.

If you can’t find a plugin on pub.dev that fits your needs, you can [write your own](https://docs.flutter.dev/packages-and-plugins/developing-packages), and [publish it on pub.dev](https://docs.flutter.dev/packages-and-plugins/developing-packages#publish).

### How do I access the GPS sensor?

Use the [`geolocator`](https://pub.dev/packages/geolocator) community plugin.

### How do I access the camera?

The [`camera`](https://pub.dev/packages/camera) plugin is popular for accessing the camera.

### How do I log in with Facebook?

To log in with Facebook, use the [`flutter_facebook_login`](https://pub.dev/packages/flutter_facebook_login) community plugin.

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

If there is platform-specific functionality that Flutter or its community plugins are missing, you can build your own following the [developing packages and plugins](https://docs.flutter.dev/packages-and-plugins/developing-packages) page.

Flutter’s plugin architecture, in a nutshell, is much like using an Event bus in Android: you fire off a message and let the receiver process and emit a result back to you. In this case, the receiver is code running on the native side on Android or iOS.

## Themes (Styles)

### How do I theme my app?

Flutter comes with a beautiful, built-in implementation of Material Design, which handles much of the styling and theming needs that you would typically do.

Xamarin.Forms does have a global `ResourceDictionary` where you can share styles across your app. Alternatively, there is Theme support currently in preview.

In Flutter, you declare themes in the top level widget.

To take full advantage of Material Components in your app, you can declare a top level widget `MaterialApp` as the entry point to your application. `MaterialApp` is a convenience widget that wraps a number of widgets that are commonly required for applications implementing Material Design. It builds upon a `WidgetsApp` by adding Material-specific functionality.

You can also use a `WidgetsApp` as your app widget, which provides some of the same functionality, but is not as rich as `MaterialApp`.

To customize the colors and styles of any child components, pass a `ThemeData` object to the `MaterialApp` widget. For example, in the following code, the color scheme from seed is set to deepPurple and text selection color is red.

```
<span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>/// This widget is the root of your application.</span><span>
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

### How do I access shared preferences or UserDefaults?

Xamarin.Forms developers will likely be familiar with the `Xam.Plugins.Settings` plugin.

In Flutter, access equivalent functionality using the [`shared_preferences`](https://pub.dev/packages/shared_preferences) plugin. This plugin wraps the functionality of both `UserDefaults` and the Android equivalent, `SharedPreferences`.

### How do I access SQLite in Flutter?

In Xamarin.Forms most applications would use the `sqlite-net-pcl` plugin to access SQLite databases.

In Flutter, on macOS, Android, and iOS, access this functionality using the [`sqflite`](https://pub.dev/packages/sqflite) plugin.

## Debugging

### What tools can I use to debug my app in Flutter?

Use the [DevTools](https://docs.flutter.dev/tools/devtools/overview) suite for debugging Flutter or Dart apps.

DevTools includes support for profiling, examining the heap, inspecting the widget tree, logging diagnostics, debugging, observing executed lines of code, debugging memory leaks and memory fragmentation. For more information, see the [DevTools](https://docs.flutter.dev/tools/devtools/overview) documentation.

## Notifications

### How do I set up push notifications?

In Android, you use Firebase Cloud Messaging to setup push notifications for your app.

In Flutter, access this functionality using the [`firebase_messaging`](https://pub.dev/packages/firebase_messaging) plugin. For more information on using the Firebase Cloud Messaging API, see the [`firebase_messaging`](https://pub.dev/packages/firebase_messaging) plugin documentation.