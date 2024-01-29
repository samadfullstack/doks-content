1.  [UI](https://docs.flutter.dev/ui)
2.  [Layout](https://docs.flutter.dev/ui/layout)
3.  [Adaptive design](https://docs.flutter.dev/ui/layout/responsive)
4.  [Building adaptive apps](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps)

## Overview

Flutter provides new opportunities to build apps that can run on mobile, desktop, and the web from a single codebase. However, with these opportunities, come new challenges. You want your app to feel familiar to users, adapting to each platform by maximizing usability and ensuring a comfortable and seamless experience. That is, you need to build apps that are not just multiplatform, but are fully platform adaptive.

There are many considerations for developing platform-adaptive apps, but they fall into three major categories:

-   [Layout](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps#building-adaptive-layouts)
-   [Input](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps#input)
-   [Idioms and norms](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps#idioms-and-norms)

<iframe width="560" height="315" src="https://www.youtube.com/embed/RCdeSKVt7LI?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to build platform-adaptive Flutter apps" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy"></iframe>

This page covers all three categories in detail using code snippets to illustrate the concepts. If you’d like to see how these concepts come together, check out the [Flokk](https://github.com/gskinnerTeam/flokk) and [Folio](https://github.com/gskinnerTeam/flutter-folio) examples that were built using the concepts described here.

Original demo code for adaptive app development techniques from [flutter-adaptive-demo](https://github.com/gskinnerTeam/flutter-adaptive-demo).

## Building adaptive layouts

One of the first things you must consider when writing your app for multiple platforms is how to adapt it to the various sizes and shapes of the screens that it will run on.

### Layout widgets

If you’ve been building apps or websites, you’re probably familiar with creating responsive interfaces. Luckily for Flutter developers, there are a large set of widgets to make this easier.

Some of Flutter’s most useful layout widgets include:

**Single child**

-   [`Align`](https://api.flutter.dev/flutter/widgets/Align-class.html)—Aligns a child within itself. It takes a double value between -1 and 1, for both the vertical and horizontal alignment.
    
-   [`AspectRatio`](https://api.flutter.dev/flutter/widgets/AspectRatio-class.html)—Attempts to size the child to a specific aspect ratio.
    
-   [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html)—Imposes size constraints on its child, offering control over the minimum or maximum size.
    
-   [`CustomSingleChildLayout`](https://api.flutter.dev/flutter/widgets/CustomSingleChildLayout-class.html)—Uses a delegate function to position a single child. The delegate can determine the layout constraints and positioning for the child.
    
-   [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html) and [`Flexible`](https://api.flutter.dev/flutter/widgets/Flexible-class.html)—Allows a child of a `Row` or `Column` to shrink or grow to fill any available space.
    
-   [`FractionallySizedBox`](https://api.flutter.dev/flutter/widgets/FractionallySizedBox-class.html)—Sizes its child to a fraction of the available space.
    
-   [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)—Builds a widget that can reflow itself based on its parents size.
    
-   [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html)—Adds scrolling to a single child. Often used with a `Row` or `Column`.
    

**Multichild**

-   [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html), [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html), and [`Flex`](https://api.flutter.dev/flutter/widgets/Flex-class.html)—Lays out children in a single horizontal or vertical run. Both `Column` and `Row` extend the `Flex` widget.
    
-   [`CustomMultiChildLayout`](https://api.flutter.dev/flutter/widgets/CustomMultiChildLayout-class.html)—Uses a delegate function to position multiple children during the layout phase.
    
-   [`Flow`](https://api.flutter.dev/flutter/widgets/Flow-class.html)—Similar to `CustomMultiChildLayout`, but more efficient because it’s performed during the paint phase rather than the layout phase.
    
-   [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html), [`GridView`](https://api.flutter.dev/flutter/widgets/GridView-class.html), and [`CustomScrollView`](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html)—Provides scrollable lists of children.
    
-   [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html)—Layers and positions multiple children relative to the edges of the `Stack`. Functions similarly to position-fixed in CSS.
    
-   [`Table`](https://api.flutter.dev/flutter/widgets/Table-class.html)—Uses a classic table layout algorithm for its children, combining multiple rows and columns.
    
-   [`Wrap`](https://api.flutter.dev/flutter/widgets/Wrap-class.html)—Displays its children in multiple horizontal or vertical runs.
    

To see more available widgets and example code, see [Layout widgets](https://docs.flutter.dev/ui/widgets/layout).

### Visual density

Different input devices offer various levels of precision, which necessitate differently sized hit areas. Flutter’s `VisualDensity` class makes it easy to adjust the density of your views across the entire application, for example, by making a button larger (and therefore easier to tap) on a touch device.

When you change the `VisualDensity` for your `MaterialApp`, `MaterialComponents` that support it animate their densities to match. By default, both horizontal and vertical densities are set to 0.0, but you can set the densities to any negative or positive value that you want. By switching between different densities, you can easily adjust your UI:

![Adaptive scaffold](https://docs.flutter.dev/assets/images/docs/development/ui/layout/adaptive_scaffold.gif)

To set a custom visual density, inject the density into your `MaterialApp` theme:

```
<span>double</span><span> densityAmt </span><span>=</span><span> touchMode </span><span>?</span><span> </span><span>0.0</span><span> </span><span>:</span><span> </span><span>-</span><span>1.0</span><span>;</span><span>
</span><span>VisualDensity</span><span> density </span><span>=</span><span>
    </span><span>VisualDensity</span><span>(</span><span>horizontal</span><span>:</span><span> densityAmt</span><span>,</span><span> vertical</span><span>:</span><span> densityAmt</span><span>);</span><span>
</span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
  theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>visualDensity</span><span>:</span><span> density</span><span>),</span><span>
  home</span><span>:</span><span> </span><span>MainAppScaffold</span><span>(),</span><span>
  debugShowCheckedModeBanner</span><span>:</span><span> </span><span>false</span><span>,</span><span>
</span><span>);</span>
```

To use `VisualDensity` inside your own views, you can look it up:

```
<span>VisualDensity</span><span> density </span><span>=</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>visualDensity</span><span>;</span>
```

Not only does the container react automatically to changes in density, it also animates when it changes. This ties together your custom components, along with the built-in components, for a smooth transition effect across the app.

As shown, `VisualDensity` is unit-less, so it can mean different things to different views. In this example, 1 density unit equals 6 pixels, but this is totally up to your views to decide. The fact that it is unit-less makes it quite versatile, and it should work in most contexts.

It’s worth noting that the Material Components generally use a value of around 4 logical pixels for each visual density unit. For more information about the supported components, see [`VisualDensity`](https://api.flutter.dev/flutter/material/VisualDensity-class.html) API. For more information about density principles in general, see the [Material Design guide](https://m2.material.io/design/layout/applying-density.html#usage).

### Contextual layout

If you need more than density changes and can’t find a widget that does what you need, you can take a more procedural approach to adjust parameters, calculate sizes, swap widgets, or completely restructure your UI to suit a particular form factor.

#### Screen-based breakpoints

The simplest form of procedural layouts uses screen-based breakpoints. In Flutter, this can be done with the `MediaQuery` API. There are no hard and fast rules for the sizes to use here, but these are general values:

```
<span>class</span><span> </span><span>FormFactor</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>double</span><span> desktop </span><span>=</span><span> </span><span>900</span><span>;</span><span>
  </span><span>static</span><span> </span><span>double</span><span> tablet </span><span>=</span><span> </span><span>600</span><span>;</span><span>
  </span><span>static</span><span> </span><span>double</span><span> handset </span><span>=</span><span> </span><span>300</span><span>;</span><span>
</span><span>}</span>
```

Using breakpoints, you can set up a simple system to determine the device type:

```
<span>ScreenType</span><span> getFormFactor</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>// Use .shortestSide to detect device type regardless of orientation</span><span>
  </span><span>double</span><span> deviceWidth </span><span>=</span><span> </span><span>MediaQuery</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>size</span><span>.</span><span>shortestSide</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>deviceWidth </span><span>&gt;</span><span> </span><span>FormFactor</span><span>.</span><span>desktop</span><span>)</span><span> </span><span>return</span><span> </span><span>ScreenType</span><span>.</span><span>desktop</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>deviceWidth </span><span>&gt;</span><span> </span><span>FormFactor</span><span>.</span><span>tablet</span><span>)</span><span> </span><span>return</span><span> </span><span>ScreenType</span><span>.</span><span>tablet</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>deviceWidth </span><span>&gt;</span><span> </span><span>FormFactor</span><span>.</span><span>handset</span><span>)</span><span> </span><span>return</span><span> </span><span>ScreenType</span><span>.</span><span>handset</span><span>;</span><span>
  </span><span>return</span><span> </span><span>ScreenType</span><span>.</span><span>watch</span><span>;</span><span>
</span><span>}</span>
```

As an alternative, you could abstract it more and define it in terms of small to large:

```
<span>enum</span><span> </span><span>ScreenSize</span><span> </span><span>{</span><span> small</span><span>,</span><span> normal</span><span>,</span><span> large</span><span>,</span><span> extraLarge </span><span>}</span><span>

</span><span>ScreenSize</span><span> getSize</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>double</span><span> deviceWidth </span><span>=</span><span> </span><span>MediaQuery</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>size</span><span>.</span><span>shortestSide</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>deviceWidth </span><span>&gt;</span><span> </span><span>900</span><span>)</span><span> </span><span>return</span><span> </span><span>ScreenSize</span><span>.</span><span>extraLarge</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>deviceWidth </span><span>&gt;</span><span> </span><span>600</span><span>)</span><span> </span><span>return</span><span> </span><span>ScreenSize</span><span>.</span><span>large</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>deviceWidth </span><span>&gt;</span><span> </span><span>300</span><span>)</span><span> </span><span>return</span><span> </span><span>ScreenSize</span><span>.</span><span>normal</span><span>;</span><span>
  </span><span>return</span><span> </span><span>ScreenSize</span><span>.</span><span>small</span><span>;</span><span>
</span><span>}</span>
```

Screen-based breakpoints are best used for making top-level decisions in your app. Changing things like visual density, paddings, or font-sizes are best when defined on a global basis.

You can also use screen-based breakpoints to reflow your top-level widget trees. For example, you could switch from a vertical to a horizontal layout when the user isn’t on a handset:

```
<span>bool</span><span> isHandset </span><span>=</span><span> </span><span>MediaQuery</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>size</span><span>.</span><span>width </span><span>&lt;</span><span> </span><span>600</span><span>;</span><span>
</span><span>return</span><span> </span><span>Flex</span><span>(</span><span>
  direction</span><span>:</span><span> isHandset </span><span>?</span><span> </span><span>Axis</span><span>.</span><span>vertical </span><span>:</span><span> </span><span>Axis</span><span>.</span><span>horizontal</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'Foo'</span><span>),</span><span> </span><span>Text</span><span>(</span><span>'Bar'</span><span>),</span><span> </span><span>Text</span><span>(</span><span>'Baz'</span><span>)],</span><span>
</span><span>);</span>
```

In another widget, you might swap some of the children completely:

```
<span>Widget</span><span> foo </span><span>=</span><span> </span><span>Row</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>...</span><span>isHandset </span><span>?</span><span> _getHandsetChildren</span><span>()</span><span> </span><span>:</span><span> _getNormalChildren</span><span>(),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

Even though checking total screen size is great for full-screen pages or making global layout decisions, it’s often not ideal for nested subviews. Often, subviews have their own internal breakpoints and care only about the space that they have available to render.

The simplest way to handle this in Flutter is using the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) class. `LayoutBuilder` allows a widget to respond to incoming local size constraints, which can make the widget more versatile than if it depended on a global value.

The previous example could be rewritten using `LayoutBuilder`:

```
<span>Widget</span><span> foo </span><span>=</span><span> </span><span>LayoutBuilder</span><span>(</span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> constraints</span><span>)</span><span> </span><span>{</span><span>
  </span><span>bool</span><span> useVerticalLayout </span><span>=</span><span> constraints</span><span>.</span><span>maxWidth </span><span>&lt;</span><span> </span><span>400</span><span>;</span><span>
  </span><span>return</span><span> </span><span>Flex</span><span>(</span><span>
    direction</span><span>:</span><span> useVerticalLayout </span><span>?</span><span> </span><span>Axis</span><span>.</span><span>vertical </span><span>:</span><span> </span><span>Axis</span><span>.</span><span>horizontal</span><span>,</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>Text</span><span>(</span><span>'Hello'</span><span>),</span><span>
      </span><span>Text</span><span>(</span><span>'World'</span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>});</span>
```

This widget can now be composed within a side panel, dialog, or even a full-screen view, and adapt its layout to whatever space is provided.

#### Device segmentation

There are times when you want to make layout decisions based on the actual platform you’re running on, regardless of size. For example, when building a custom title bar, you might need to check the operating system type and tweak the layout of your title bar, so it doesn’t get covered by the native window buttons.

To determine which combination of platforms you’re on, you can use the [`Platform`](https://api.flutter.dev/flutter/package-platform_platform/Platform-class.html) API along with the `kIsWeb` value:

```
<span>bool</span><span> </span><span>get</span><span> isMobileDevice </span><span>=&gt;</span><span> </span><span>!</span><span>kIsWeb </span><span>&amp;&amp;</span><span> </span><span>(</span><span>Platform</span><span>.</span><span>isIOS </span><span>||</span><span> </span><span>Platform</span><span>.</span><span>isAndroid</span><span>);</span><span>
</span><span>bool</span><span> </span><span>get</span><span> isDesktopDevice </span><span>=&gt;</span><span>
    </span><span>!</span><span>kIsWeb </span><span>&amp;&amp;</span><span> </span><span>(</span><span>Platform</span><span>.</span><span>isMacOS </span><span>||</span><span> </span><span>Platform</span><span>.</span><span>isWindows </span><span>||</span><span> </span><span>Platform</span><span>.</span><span>isLinux</span><span>);</span><span>
</span><span>bool</span><span> </span><span>get</span><span> isMobileDeviceOrWeb </span><span>=&gt;</span><span> kIsWeb </span><span>||</span><span> isMobileDevice</span><span>;</span><span>
</span><span>bool</span><span> </span><span>get</span><span> isDesktopDeviceOrWeb </span><span>=&gt;</span><span> kIsWeb </span><span>||</span><span> isDesktopDevice</span><span>;</span>
```

The `Platform` API can’t be accessed from web builds without throwing an exception, because the `dart.io` package isn’t supported on the web target. As a result, the above code checks for web first, and because of short-circuiting, Dart never calls `Platform` on web targets.

Use `Platform`/`kIsWeb` when the logic absolutely _must_ run for a given platform. For example, talking to a plugin that only works on iOS, or displaying a widget that only conforms to Play Store policy and not the App Store’s.

### Single source of truth for styling

You’ll probably find it easier to maintain your views if you create a single source of truth for styling values like padding, spacing, corner shape, font sizes, and so on. This can be done easily with some helper classes:

```
<span>class</span><span> </span><span>Insets</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> </span><span>double</span><span> xsmall </span><span>=</span><span> </span><span>3</span><span>;</span><span>
  </span><span>static</span><span> </span><span>const</span><span> </span><span>double</span><span> small </span><span>=</span><span> </span><span>4</span><span>;</span><span>
  </span><span>static</span><span> </span><span>const</span><span> </span><span>double</span><span> medium </span><span>=</span><span> </span><span>5</span><span>;</span><span>
  </span><span>static</span><span> </span><span>const</span><span> </span><span>double</span><span> large </span><span>=</span><span> </span><span>10</span><span>;</span><span>
  </span><span>static</span><span> </span><span>const</span><span> </span><span>double</span><span> extraLarge </span><span>=</span><span> </span><span>20</span><span>;</span><span>
  </span><span>// etc</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>Fonts</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> </span><span>String</span><span> raleway </span><span>=</span><span> </span><span>'Raleway'</span><span>;</span><span>
  </span><span>// etc</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>TextStyles</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span> raleway </span><span>=</span><span> </span><span>TextStyle</span><span>(</span><span>
    fontFamily</span><span>:</span><span> </span><span>Fonts</span><span>.</span><span>raleway</span><span>,</span><span>
  </span><span>);</span><span>
  </span><span>static</span><span> </span><span>TextStyle</span><span> buttonText1 </span><span>=</span><span>
      </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span> fontSize</span><span>:</span><span> </span><span>14</span><span>);</span><span>
  </span><span>static</span><span> </span><span>TextStyle</span><span> buttonText2 </span><span>=</span><span>
      </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>normal</span><span>,</span><span> fontSize</span><span>:</span><span> </span><span>11</span><span>);</span><span>
  </span><span>static</span><span> </span><span>TextStyle</span><span> h1 </span><span>=</span><span>
      </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span> fontSize</span><span>:</span><span> </span><span>22</span><span>);</span><span>
  </span><span>static</span><span> </span><span>TextStyle</span><span> h2 </span><span>=</span><span>
      </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span> fontSize</span><span>:</span><span> </span><span>16</span><span>);</span><span>
  </span><span>static</span><span> </span><span>TextStyle</span><span> body1 </span><span>=</span><span> raleway</span><span>.</span><span>copyWith</span><span>(</span><span>color</span><span>:</span><span> </span><span>const</span><span> </span><span>Color</span><span>(</span><span>0xFF42A5F5</span><span>));</span><span>
  </span><span>// etc</span><span>
</span><span>}</span>
```

These constants can then be used in place of hard-coded numeric values:

```
<span>return</span><span> </span><span>Padding</span><span>(</span><span>
  padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>Insets</span><span>.</span><span>small</span><span>),</span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Hello!'</span><span>,</span><span> style</span><span>:</span><span> </span><span>TextStyles</span><span>.</span><span>body1</span><span>),</span><span>
</span><span>);</span>
```

Use `Theme.of(context).platform` for theming and design choices, like what kind of switches to show and general Cupertino/Material adaptions.

With all views referencing the same shared-design system rules, they tend to look better and more consistent. Making a change or adjusting a value for a specific platform can be done in a single place, instead of using an error-prone search and replace. Using shared rules has the added benefit of helping enforce consistency on the design side.

Some common design system categories that can be represented this way are:

-   Animation timings
-   Sizes and breakpoints
-   Insets and paddings
-   Corner radius
-   Shadows
-   Strokes
-   Font families, sizes, and styles

Like most rules, there are exceptions: one-off values that are used nowhere else in the app. There is little point in cluttering up the styling rules with these values, but it’s worth considering if they should be derived from an existing value (for example, `padding + 1.0`). You should also watch for reuse or duplication of the same semantic values. Those values should likely be added to the global styling ruleset.

### Design to the strengths of each form factor

Beyond screen size, you should also spend time considering the unique strengths and weaknesses of different form factors. It isn’t always ideal for your multiplatform app to offer identical functionality everywhere. Consider whether it makes sense to focus on specific capabilities, or even remove certain features, on some device categories.

For example, mobile devices are portable and have cameras, but they aren’t well suited for detailed creative work. With this in mind, you might focus more on capturing content and tagging it with location data for a mobile UI, but focus on organizing or manipulating that content for a tablet or desktop UI.

Another example is leveraging the web’s extremely low barrier for sharing. If you’re deploying a web app, decide which deep links to support, and design your navigation routes with those in mind.

The key takeaway here is to think about what each platform does best and see if there are unique capabilities you can leverage.

### Use desktop build targets for rapid testing

One of the most effective ways to test adaptive interfaces is to take advantage of the desktop build targets.

When running on a desktop, you can easily resize the window while the app is running to preview various screen sizes. This, combined with hot reload, can greatly accelerate the development of a responsive UI.

![Adaptive scaffold 2](https://docs.flutter.dev/assets/images/docs/development/ui/layout/adaptive_scaffold2.gif)

### Solve touch first

Building a great touch UI can often be more difficult than a traditional desktop UI due, in part, to the lack of input accelerators like right-click, scroll wheel, or keyboard shortcuts.

One way to approach this challenge is to focus initially on a great touch-oriented UI. You can still do most of your testing using the desktop target for its iteration speed. But, remember to switch frequently to a mobile device to verify that everything feels right.

After you have the touch interface polished, you can tweak the visual density for mouse users, and then layer on all the additional inputs. Approach these other inputs as accelerator—alternatives that make a task faster. The important thing to consider is what a user expects when using a particular input device, and work to reflect that in your app.

## Input

Of course, it isn’t enough to just adapt how your app looks, you also have to support varying user inputs. The mouse and keyboard introduce input types beyond those found on a touch device—like scroll wheel, right-click, hover interactions, tab traversal, and keyboard shortcuts.

### Scroll wheel

Scrolling widgets like `ScrollView` or `ListView` support the scroll wheel by default, and because almost every scrollable custom widget is built using one of these, it works with them as well.

If you need to implement custom scroll behavior, you can use the [`Listener`](https://api.flutter.dev/flutter/widgets/Listener-class.html) widget, which lets you customize how your UI reacts to the scroll wheel.

```
<span>return</span><span> </span><span>Listener</span><span>(</span><span>
  onPointerSignal</span><span>:</span><span> </span><span>(</span><span>event</span><span>)</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>event </span><span>is</span><span> </span><span>PointerScrollEvent</span><span>)</span><span> print</span><span>(</span><span>event</span><span>.</span><span>scrollDelta</span><span>.</span><span>dy</span><span>);</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>ListView</span><span>(),</span><span>
</span><span>);</span>
```

### Tab traversal and focus interactions

Users with physical keyboards expect that they can use the tab key to quickly navigate your application, and users with motor or vision differences often rely completely on keyboard navigation.

There are two considerations for tab interactions: how focus moves from widget to widget, known as traversal, and the visual highlight shown when a widget is focused.

Most built-in components, like buttons and text fields, support traversal and highlights by default. If you have your own widget that you want included in traversal, you can use the [`FocusableActionDetector`](https://api.flutter.dev/flutter/widgets/FocusableActionDetector-class.html) widget to create your own controls. It combines the functionality of [`Actions`](https://api.flutter.dev/flutter/widgets/Actions-class.html), [`Shortcuts`](https://api.flutter.dev/flutter/widgets/Shortcuts-class.html), [`MouseRegion`](https://api.flutter.dev/flutter/widgets/MouseRegion-class.html), and [`Focus`](https://api.flutter.dev/flutter/widgets/Focus-class.html) widgets to create a detector that defines actions and key bindings, and provides callbacks for handling focus and hover highlights.

```
<span>class</span><span> _BasicActionDetectorState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>BasicActionDetector</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>bool</span><span> _hasFocus </span><span>=</span><span> </span><span>false</span><span>;</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>FocusableActionDetector</span><span>(</span><span>
      onFocusChange</span><span>:</span><span> </span><span>(</span><span>value</span><span>)</span><span> </span><span>=&gt;</span><span> setState</span><span>(()</span><span> </span><span>=&gt;</span><span> _hasFocus </span><span>=</span><span> value</span><span>),</span><span>
      actions</span><span>:</span><span> </span><span>&lt;</span><span>Type</span><span>,</span><span> </span><span>Action</span><span>&lt;</span><span>Intent</span><span>&gt;&gt;{</span><span>
        </span><span>ActivateIntent</span><span>:</span><span> </span><span>CallbackAction</span><span>&lt;</span><span>Intent</span><span>&gt;(</span><span>onInvoke</span><span>:</span><span> </span><span>(</span><span>intent</span><span>)</span><span> </span><span>{</span><span>
          print</span><span>(</span><span>'Enter or Space was pressed!'</span><span>);</span><span>
          </span><span>return</span><span> </span><span>null</span><span>;</span><span>
        </span><span>}),</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>Stack</span><span>(</span><span>
        clipBehavior</span><span>:</span><span> </span><span>Clip</span><span>.</span><span>none</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>const</span><span> </span><span>FlutterLogo</span><span>(</span><span>size</span><span>:</span><span> </span><span>100</span><span>),</span><span>
          </span><span>// Position focus in the negative margin for a cool effect</span><span>
          </span><span>if</span><span> </span><span>(</span><span>_hasFocus</span><span>)</span><span>
            </span><span>Positioned</span><span>(</span><span>
              left</span><span>:</span><span> </span><span>-</span><span>4</span><span>,</span><span>
              top</span><span>:</span><span> </span><span>-</span><span>4</span><span>,</span><span>
              bottom</span><span>:</span><span> </span><span>-</span><span>4</span><span>,</span><span>
              right</span><span>:</span><span> </span><span>-</span><span>4</span><span>,</span><span>
              child</span><span>:</span><span> _roundedBorder</span><span>(),</span><span>
            </span><span>)</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

#### Controlling traversal order

To get more control over the order that widgets are focused on when the user presses tab, you can use [`FocusTraversalGroup`](https://api.flutter.dev/flutter/widgets/FocusTraversalGroup-class.html) to define sections of the tree that should be treated as a group when tabbing.

For example, you might to tab through all the fields in a form before tabbing to the submit button:

```
<span>return</span><span> </span><span>Column</span><span>(</span><span>children</span><span>:</span><span> </span><span>[</span><span>
  </span><span>FocusTraversalGroup</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>MyFormWithMultipleColumnsAndRows</span><span>(),</span><span>
  </span><span>),</span><span>
  </span><span>SubmitButton</span><span>(),</span><span>
</span><span>]);</span>
```

Flutter has several built-in ways to traverse widgets and groups, defaulting to the `ReadingOrderTraversalPolicy` class. This class usually works well, but it’s possible to modify this using another predefined `TraversalPolicy` class or by creating a custom policy.

### Keyboard accelerators

In addition to tab traversal, desktop and web users are accustomed to having various keyboard shortcuts bound to specific actions. Whether it’s the `Delete` key for quick deletions or `Control+N` for a new document, be sure to consider the different accelerators your users expect. The keyboard is a powerful input tool, so try to squeeze as much efficiency from it as you can. Your users will appreciate it!

Keyboard accelerators can be accomplished in a few ways in Flutter depending on your goals.

If you have a single widget like a `TextField` or a `Button` that already has a focus node, you can wrap it in a [`RawKeyboardListener`](https://api.flutter.dev/flutter/widgets/RawKeyboardListener-class.html) and listen for keyboard events:

```
<span>  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Focus</span><span>(</span><span>
      onKey</span><span>:</span><span> </span><span>(</span><span>node</span><span>,</span><span> event</span><span>)</span><span> </span><span>{</span><span>
        </span><span>if</span><span> </span><span>(</span><span>event </span><span>is</span><span> </span><span>RawKeyDownEvent</span><span>)</span><span> </span><span>{</span><span>
          print</span><span>(</span><span>event</span><span>.</span><span>logicalKey</span><span>);</span><span>
        </span><span>}</span><span>
        </span><span>return</span><span> </span><span>KeyEventResult</span><span>.</span><span>ignored</span><span>;</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>ConstrainedBox</span><span>(</span><span>
        constraints</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxConstraints</span><span>(</span><span>maxWidth</span><span>:</span><span> </span><span>400</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>TextField</span><span>(</span><span>
          decoration</span><span>:</span><span> </span><span>InputDecoration</span><span>(</span><span>
            border</span><span>:</span><span> </span><span>OutlineInputBorder</span><span>(),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

If you’d like to apply a set of keyboard shortcuts to a large section of the tree, you can use the [`Shortcuts`](https://api.flutter.dev/flutter/widgets/Shortcuts-class.html) widget:

```
<span>// Define a class for each type of shortcut action you want</span><span>
</span><span>class</span><span> </span><span>CreateNewItemIntent</span><span> </span><span>extends</span><span> </span><span>Intent</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>CreateNewItemIntent</span><span>();</span><span>
</span><span>}</span><span>

</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Shortcuts</span><span>(</span><span>
    </span><span>// Bind intents to key combinations</span><span>
    shortcuts</span><span>:</span><span> </span><span>const</span><span> </span><span>&lt;</span><span>ShortcutActivator</span><span>,</span><span> </span><span>Intent</span><span>&gt;{</span><span>
      </span><span>SingleActivator</span><span>(</span><span>LogicalKeyboardKey</span><span>.</span><span>keyN</span><span>,</span><span> control</span><span>:</span><span> </span><span>true</span><span>):</span><span>
          </span><span>CreateNewItemIntent</span><span>(),</span><span>
    </span><span>},</span><span>
    child</span><span>:</span><span> </span><span>Actions</span><span>(</span><span>
      </span><span>// Bind intents to an actual method in your code</span><span>
      actions</span><span>:</span><span> </span><span>&lt;</span><span>Type</span><span>,</span><span> </span><span>Action</span><span>&lt;</span><span>Intent</span><span>&gt;&gt;{</span><span>
        </span><span>CreateNewItemIntent</span><span>:</span><span> </span><span>CallbackAction</span><span>&lt;</span><span>CreateNewItemIntent</span><span>&gt;(</span><span>
          onInvoke</span><span>:</span><span> </span><span>(</span><span>intent</span><span>)</span><span> </span><span>=&gt;</span><span> _createNewItem</span><span>(),</span><span>
        </span><span>),</span><span>
      </span><span>},</span><span>
      </span><span>// Your sub-tree must be wrapped in a focusNode, so it can take focus.</span><span>
      child</span><span>:</span><span> </span><span>Focus</span><span>(</span><span>
        autofocus</span><span>:</span><span> </span><span>true</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>Container</span><span>(),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The [`Shortcuts`](https://api.flutter.dev/flutter/widgets/Shortcuts-class.html) widget is useful because it only allows shortcuts to be fired when this widget tree or one of its children has focus and is visible.

The final option is a global listener. This listener can be used for always-on, app-wide shortcuts or for panels that can accept shortcuts whenever they’re visible (regardless of their focus state). Adding global listeners is easy with [`RawKeyboard`](https://api.flutter.dev/flutter/services/RawKeyboard-class.html):

```
<span>@override
</span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
  </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
  </span><span>RawKeyboard</span><span>.</span><span>instance</span><span>.</span><span>addListener</span><span>(</span><span>_handleKey</span><span>);</span><span>
</span><span>}</span><span>

@override
</span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
  </span><span>RawKeyboard</span><span>.</span><span>instance</span><span>.</span><span>removeListener</span><span>(</span><span>_handleKey</span><span>);</span><span>
  </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
</span><span>}</span>
```

To check key combinations with the global listener, you can use the `RawKeyboard.instance.keysPressed` map. For example, a method like the following can check whether any of the provided keys are being held down:

```
<span>static</span><span> </span><span>bool</span><span> isKeyDown</span><span>(</span><span>Set</span><span>&lt;</span><span>LogicalKeyboardKey</span><span>&gt;</span><span> keys</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> keys</span><span>.</span><span>intersection</span><span>(</span><span>RawKeyboard</span><span>.</span><span>instance</span><span>.</span><span>keysPressed</span><span>).</span><span>isNotEmpty</span><span>;</span><span>
</span><span>}</span>
```

Putting these two things together, you can fire an action when `Shift+N` is pressed:

```
<span>void</span><span> _handleKey</span><span>(</span><span>event</span><span>)</span><span> </span><span>{</span><span>
  </span><span>if</span><span> </span><span>(</span><span>event </span><span>is</span><span> </span><span>RawKeyDownEvent</span><span>)</span><span> </span><span>{</span><span>
    </span><span>bool</span><span> isShiftDown </span><span>=</span><span> isKeyDown</span><span>({</span><span>
      </span><span>LogicalKeyboardKey</span><span>.</span><span>shiftLeft</span><span>,</span><span>
      </span><span>LogicalKeyboardKey</span><span>.</span><span>shiftRight</span><span>,</span><span>
    </span><span>});</span><span>
    </span><span>if</span><span> </span><span>(</span><span>isShiftDown </span><span>&amp;&amp;</span><span> event</span><span>.</span><span>logicalKey </span><span>==</span><span> </span><span>LogicalKeyboardKey</span><span>.</span><span>keyN</span><span>)</span><span> </span><span>{</span><span>
      _createNewItem</span><span>();</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

One note of caution when using the static listener, is that you often need to disable it when the user is typing in a field or when the widget it’s associated with is hidden from view. Unlike with `Shortcuts` or `RawKeyboardListener`, this is your responsibility to manage. This can be especially important when you’re binding a Delete/Backspace accelerator for `Delete`, but then have child `TextFields` that the user might be typing in.

### Mouse enter, exit, and hover

On desktop, it’s common to change the mouse cursor to indicate the functionality about the content the mouse is hovering over. For example, you usually see a hand cursor when you hover over a button, or an `I` cursor when you hover over text.

The Material Component set has built-in support for your standard button and text cursors. To change the cursor from within your own widgets, use [`MouseRegion`](https://api.flutter.dev/flutter/widgets/MouseRegion-class.html):

```
<span>// Show hand cursor</span><span>
</span><span>return</span><span> </span><span>MouseRegion</span><span>(</span><span>
  cursor</span><span>:</span><span> </span><span>SystemMouseCursors</span><span>.</span><span>click</span><span>,</span><span>
  </span><span>// Request focus when clicked</span><span>
  child</span><span>:</span><span> </span><span>GestureDetector</span><span>(</span><span>
    onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
      </span><span>Focus</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>requestFocus</span><span>();</span><span>
      _submit</span><span>();</span><span>
    </span><span>},</span><span>
    child</span><span>:</span><span> </span><span>Logo</span><span>(</span><span>showBorder</span><span>:</span><span> hasFocus</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

`MouseRegion` is also useful for creating custom rollover and hover effects:

```
<span>return</span><span> </span><span>MouseRegion</span><span>(</span><span>
  onEnter</span><span>:</span><span> </span><span>(</span><span>_</span><span>)</span><span> </span><span>=&gt;</span><span> setState</span><span>(()</span><span> </span><span>=&gt;</span><span> _isMouseOver </span><span>=</span><span> </span><span>true</span><span>),</span><span>
  onExit</span><span>:</span><span> </span><span>(</span><span>_</span><span>)</span><span> </span><span>=&gt;</span><span> setState</span><span>(()</span><span> </span><span>=&gt;</span><span> _isMouseOver </span><span>=</span><span> </span><span>false</span><span>),</span><span>
  onHover</span><span>:</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>=&gt;</span><span> print</span><span>(</span><span>e</span><span>.</span><span>localPosition</span><span>),</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    height</span><span>:</span><span> </span><span>500</span><span>,</span><span>
    color</span><span>:</span><span> _isMouseOver </span><span>?</span><span> </span><span>Colors</span><span>.</span><span>blue </span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## Idioms and norms

The final area to consider for adaptive apps is platform standards. Each platform has its own idioms and norms; these nominal or de facto standards inform user expectations of how an application should behave. Thanks, in part to the web, users are accustomed to more customized experiences, but reflecting these platform standards can still provide significant benefits:

-   **Reduce cognitive load**—By matching the user’s existing mental model, accomplishing tasks becomes intuitive, which requires less thinking, boosts productivity, and reduces frustrations.
    
-   **Build trust**—Users can become wary or suspicious when applications don’t adhere to their expectations. Conversely, a UI that feels familiar can build user trust and can help improve the perception of quality. This often has the added benefit of better app store ratings—something we can all appreciate!
    

### Consider expected behavior on each platform

The first step is to spend some time considering what the expected appearance, presentation, or behavior is on this platform. Try to forget any limitations of your current implementation, and just envision the ideal user experience. Work backwards from there.

Another way to think about this is to ask, “How would a user of this platform expect to achieve this goal?” Then, try to envision how that would work in your app without any compromises.

This can be difficult if you aren’t a regular user of the platform. You might be unaware of the specific idioms and can easily miss them completely. For example, a lifetime Android user is likely unaware of platform conventions on iOS, and the same holds true for macOS, Linux, and Windows. These differences might be subtle to you, but be painfully obvious to an experienced user.

#### Find a platform advocate

If possible, assign someone as an advocate for each platform. Ideally, your advocate uses the platform as their primary device, and can offer the perspective of a highly opinionated user. To reduce the number of people, combine roles. Have one advocate for Windows and Android, one for Linux and the web, and one for Mac and iOS.

The goal is to have constant, informed feedback so the app feels great on each platform. Advocates should be encouraged to be quite picky, calling out anything they feel differs from typical applications on their device. A simple example is how the default button in a dialog is typically on the left on Mac and Linux, but is on the right on Windows. Details like that are easy to miss if you aren’t using a platform on a regular basis.

#### Stay unique

Conforming to expected behaviors doesn’t mean that your app needs to use default components or styling. Many of the most popular multiplatform apps have very distinct and opinionated UIs including custom buttons, context menus, and title bars.

The more you can consolidate styling and behavior across platforms, the easier development and testing will be. The trick is to balance creating a unique experience with a strong identity, while respecting the norms of each platform.

### Common idioms and norms to consider

Take a quick look at a few specific norms and idioms you might want to consider, and how you could approach them in Flutter.

#### Scrollbar appearance and behavior

Desktop and mobile users expect scrollbars, but they expect them to behave differently on different platforms. Mobile users expect smaller scrollbars that only appear while scrolling, whereas desktop users generally expect omnipresent, larger scrollbars that they can click or drag.

Flutter comes with a built-in `Scrollbar` widget that already has support for adaptive colors and sizes according to the current platform. The one tweak you might want to make is to toggle `alwaysShown` when on a desktop platform:

```
<span>return</span><span> </span><span>Scrollbar</span><span>(</span><span>
  thumbVisibility</span><span>:</span><span> </span><span>DeviceType</span><span>.</span><span>isDesktop</span><span>,</span><span>
  controller</span><span>:</span><span> _scrollController</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>GridView</span><span>.</span><span>count</span><span>(</span><span>
    controller</span><span>:</span><span> _scrollController</span><span>,</span><span>
    padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>Insets</span><span>.</span><span>extraLarge</span><span>),</span><span>
    childAspectRatio</span><span>:</span><span> </span><span>1</span><span>,</span><span>
    crossAxisCount</span><span>:</span><span> colCount</span><span>,</span><span>
    children</span><span>:</span><span> listChildren</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

This subtle attention to detail can make your app feel more comfortable on a given platform.

#### Multi-select

Dealing with multi-select within a list is another area with subtle differences across platforms:

```
<span>static</span><span> </span><span>bool</span><span> </span><span>get</span><span> isSpanSelectModifierDown </span><span>=&gt;</span><span>
    isKeyDown</span><span>({</span><span>LogicalKeyboardKey</span><span>.</span><span>shiftLeft</span><span>,</span><span> </span><span>LogicalKeyboardKey</span><span>.</span><span>shiftRight</span><span>});</span>
```

To perform a platform-aware check for control or command, you can write something like this:

```
<span>static</span><span> </span><span>bool</span><span> </span><span>get</span><span> isMultiSelectModifierDown </span><span>{</span><span>
  </span><span>bool</span><span> isDown </span><span>=</span><span> </span><span>false</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>Platform</span><span>.</span><span>isMacOS</span><span>)</span><span> </span><span>{</span><span>
    isDown </span><span>=</span><span> isKeyDown</span><span>(</span><span>
      </span><span>{</span><span>LogicalKeyboardKey</span><span>.</span><span>metaLeft</span><span>,</span><span> </span><span>LogicalKeyboardKey</span><span>.</span><span>metaRight</span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    isDown </span><span>=</span><span> isKeyDown</span><span>(</span><span>
      </span><span>{</span><span>LogicalKeyboardKey</span><span>.</span><span>controlLeft</span><span>,</span><span> </span><span>LogicalKeyboardKey</span><span>.</span><span>controlRight</span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
  </span><span>return</span><span> isDown</span><span>;</span><span>
</span><span>}</span>
```

A final consideration for keyboard users is the **Select All** action. If you have a large list of items of selectable items, many of your keyboard users will expect that they can use `Control+A` to select all the items.

##### Touch devices

On touch devices, multi-selection is typically simplified, with the expected behavior being similar to having the `isMultiSelectModifier` down on the desktop. You can select or deselect items using a single tap, and will usually have a button to **Select All** or **Clear** the current selection.

How you handle multi-selection on different devices depends on your specific use cases, but the important thing is to make sure that you’re offering each platform the best interaction model possible.

#### Selectable text

A common expectation on the web (and to a lesser extent desktop) is that most visible text can be selected with the mouse cursor. When text is not selectable, users on the web tend to have an adverse reaction.

Luckily, this is easy to support with the [`SelectableText`](https://api.flutter.dev/flutter/material/SelectableText-class.html) widget:

```
<span>return</span><span> </span><span>const</span><span> </span><span>SelectableText</span><span>(</span><span>'Select me!'</span><span>);</span>
```

To support rich text, then use `TextSpan`:

```
<span>return</span><span> </span><span>const</span><span> </span><span>SelectableText</span><span>.</span><span>rich</span><span>(</span><span>
  </span><span>TextSpan</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      </span><span>TextSpan</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Hello'</span><span>),</span><span>
      </span><span>TextSpan</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Bold'</span><span>,</span><span> style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>)),</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

#### Title bars

On modern desktop applications, it’s common to customize the title bar of your app window, adding a logo for stronger branding or contextual controls to help save vertical space in your main UI.

![Samples of title bars](https://docs.flutter.dev/assets/images/docs/development/ui/layout/titlebar.png)

This isn’t supported directly in Flutter, but you can use the [`bits_dojo`](https://github.com/bitsdojo/bitsdojo_window) package to disable the native title bars, and replace them with your own.

This package lets you add whatever widgets you want to the `TitleBar` because it uses pure Flutter widgets under the hood. This makes it easy to adapt the title bar as you navigate to different sections of the app.

#### Context menus and tooltips

On desktop, there are several interactions that manifest as a widget shown in an overlay, but with differences in how they’re triggered, dismissed, and positioned:

-   **Context menu**—Typically triggered by a right-click, a context menu is positioned close to the mouse, and is dismissed by clicking anywhere, selecting an option from the menu, or clicking outside it.
    
-   **Tooltip**—Typically triggered by hovering for 200-400ms over an interactive element, a tooltip is usually anchored to a widget (as opposed to the mouse position) and is dismissed when the mouse cursor leaves that widget.
    
-   **Popup panel (also known as flyout)**—Similar to a tooltip, a popup panel is usually anchored to a widget. The main difference is that panels are most often shown on a tap event, and they usually don’t hide themselves when the cursor leaves. Instead, panels are typically dismissed by clicking outside the panel or by pressing a **Close** or **Submit** button.
    

To show basic tooltips in Flutter, use the built-in [`Tooltip`](https://api.flutter.dev/flutter/material/Tooltip-class.html) widget:

```
<span>return</span><span> </span><span>const</span><span> </span><span>Tooltip</span><span>(</span><span>
  message</span><span>:</span><span> </span><span>'I am a Tooltip'</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Hover over the text to show a tooltip.'</span><span>),</span><span>
</span><span>);</span>
```

Flutter also provides built-in context menus when editing or selecting text.

To show more advanced tooltips, popup panels, or create custom context menus, you either use one of the available packages, or build it yourself using a `Stack` or `Overlay`.

Some available packages include:

-   [`context_menus`](https://pub.dev/packages/context_menus)
-   [`anchored_popups`](https://pub.dev/packages/anchored_popups)
-   [`flutter_portal`](https://pub.dev/packages/flutter_portal)
-   [`super_tooltip`](https://pub.dev/packages/super_tooltip)
-   [`custom_pop_up_menu`](https://pub.dev/packages/custom_pop_up_menu)

While these controls can be valuable for touch users as accelerators, they are essential for mouse users. These users expect to right-click things, edit content in place, and hover for more information. Failing to meet those expectations can lead to disappointed users, or at least, a feeling that something isn’t quite right.

#### Horizontal button order

On Windows, when presenting a row of buttons, the confirmation button is placed at the start of the row (left side). On all other platforms, it’s the opposite. The confirmation button is placed at the end of the row (right side).

This can be easily handled in Flutter using the `TextDirection` property on `Row`:

```
<span>TextDirection</span><span> btnDirection </span><span>=</span><span>
    </span><span>DeviceType</span><span>.</span><span>isWindows </span><span>?</span><span> </span><span>TextDirection</span><span>.</span><span>rtl </span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>;</span><span>
</span><span>return</span><span> </span><span>Row</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>const</span><span> </span><span>Spacer</span><span>(),</span><span>
    </span><span>Row</span><span>(</span><span>
      textDirection</span><span>:</span><span> btnDirection</span><span>,</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        </span><span>DialogButton</span><span>(</span><span>
          label</span><span>:</span><span> </span><span>'Cancel'</span><span>,</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> </span><span>Navigator</span><span>.</span><span>pop</span><span>(</span><span>context</span><span>,</span><span> </span><span>false</span><span>),</span><span>
        </span><span>),</span><span>
        </span><span>DialogButton</span><span>(</span><span>
          label</span><span>:</span><span> </span><span>'Ok'</span><span>,</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> </span><span>Navigator</span><span>.</span><span>pop</span><span>(</span><span>context</span><span>,</span><span> </span><span>true</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

![Sample of embedded image](https://docs.flutter.dev/assets/images/docs/development/ui/layout/embed_image1.png)

![Sample of embedded image](https://docs.flutter.dev/assets/images/docs/development/ui/layout/embed_image2.png)

Another common pattern on desktop apps is the menu bar. On Windows and Linux, this menu lives as part of the Chrome title bar, whereas on macOS, it’s located along the top of the primary screen.

Currently, you can specify custom menu bar entries using a prototype plugin, but it’s expected that this functionality will eventually be integrated into the main SDK.

It’s worth mentioning that on Windows and Linux, you can’t combine a custom title bar with a menu bar. When you create a custom title bar, you’re replacing the native one completely, which means you also lose the integrated native menu bar.

If you need both a custom title bar and a menu bar, you can achieve that by implementing it in Flutter, similar to a custom context menu.

#### Drag and drop

One of the core interactions for both touch-based and pointer-based inputs is drag and drop. Although this interaction is expected for both types of input, there are important differences to think about when it comes to scrolling lists of draggable items.

Generally speaking, touch users expect to see drag handles to differentiate draggable areas from scrollable ones, or alternatively, to initiate a drag by using a long press gesture. This is because scrolling and dragging are both sharing a single finger for input.

Mouse users have more input options. They can use a wheel or scrollbar to scroll, which generally eliminates the need for dedicated drag handles. If you look at the macOS Finder or Windows Explorer, you’ll see that they work this way: you just select an item and start dragging.

In Flutter, you can implement drag and drop in many ways. Discussing specific implementations is outside the scope of this article, but some high level options are:

-   Use the [`Draggable`](https://api.flutter.dev/flutter/widgets/Draggable-class.html) and [`DragTarget`](https://api.flutter.dev/flutter/widgets/DragTarget-class.html) APIs directly for a custom look and feel.
    
-   Hook into `onPan` gesture events, and move an object yourself within a parent `Stack`.
    
-   Use one of the [pre-made list packages](https://pub.dev/packages?q=reorderable+list) on pub.dev.
    

### Educate yourself on basic usability principles

Of course, this page doesn’t constitute an exhaustive list of the things you might consider. The more operating systems, form factors, and input devices you support, the more difficult it becomes to spec out every permutation in design.

Taking time to learn basic usability principles as a developer empowers you to make better decisions, reduces back-and-forth iterations with design during production, and results in improved productivity with better outcomes.

Here are some resources to get you started:

-   [Material guidelines on applying layout](https://m3.material.io/foundations/layout/applying-layout/window-size-classes)
-   [Material design for large screens](https://m2.material.io/blog/material-design-for-large-screens)
-   [Material guidelines on canonical layouts](https://m3.material.io/foundations/layout/canonical-layouts/overview)
-   [Build high quality apps (Android)](https://developer.android.com/quality)
-   [UI design do’s and don’ts (Apple)](https://developer.apple.com/design/tips/)
-   [Human interface guidelines (Apple)](https://developer.apple.com/design/human-interface-guidelines/)
-   [Responsive design techniques (Microsoft)](https://docs.microsoft.com/en-us/windows/uwp/design/layout/responsive-design)
-   [Machine sizes and breakpoints (Microsoft)](https://docs.microsoft.com/en-us/windows/uwp/design/layout/screen-sizes-and-breakpoints-for-responsive-desig)