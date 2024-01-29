SwiftUI developers who want to write mobile apps using Flutter should review this guide. It explains how to apply existing SwiftUI knowledge to Flutter.

Flutter is a framework for building cross-platform applications that uses the Dart programming language. To understand some differences between programming with Dart and programming with Swift, see [Learning Dart as a Swift Developer](https://dart.dev/guides/language/coming-from/swift-to-dart) and [Flutter concurrency for Swift developers](https://docs.flutter.dev/get-started/flutter-for/dart-swift-concurrency).

Your SwiftUI knowledge and experience are highly valuable when building with Flutter.

Flutter also makes a number of adaptations to app behavior when running on iOS and macOS. To learn how, see [Platform adaptations](https://docs.flutter.dev/platform-integration/platform-adaptations).

This document can be used as a cookbook by jumping around and finding questions that are most relevant to your needs. This guide embeds sample code. You can test full working examples on DartPad or view them on GitHub.

## Overview

As an introduction, watch the following video. It outlines how Flutter works on iOS and how to use Flutter to build iOS apps.

<iframe src="https://www.youtube.com/embed/ceMsPBbcEGg?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Flutter for iOS developers" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" id="153859485" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

Flutter and SwiftUI code describes how the UI looks and works. Developers call this type of code a _declarative framework_.

### Views vs. Widgets

**SwiftUI** represents UI components as _views_. You configure views using _modifiers_.

```
<span>Text</span><span>(</span><span>"Hello, World!"</span><span>)</span> <span>// &lt;-- This is a View</span>
  <span>.</span><span>padding</span><span>(</span><span>10</span><span>)</span>        <span>// &lt;-- This is a modifier of that View</span>
```

**Flutter** represents UI components as _widgets_.

Both views and widgets only exist until they need to be changed. These languages call this property _immutability_. SwiftUI represents a UI component property as a View modifier. By contrast, Flutter uses widgets for both UI components and their properties.

```
<span>Padding</span><span>(</span>                         <span>// &lt;-- This is a Widget</span>
  <span>padding:</span> <span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>10.0</span><span>),</span> <span>// &lt;-- So is this</span>
  <span>child:</span> <span>Text</span><span>(</span><span>"Hello, World!"</span><span>),</span>  <span>// &lt;-- This, too</span>
<span>)));</span>
```

To compose layouts, both SwiftUI and Flutter nest UI components within one another. SwiftUI nests Views while Flutter nests Widgets.

### Layout process

**SwiftUI** lays out views using the following process:

1.  The parent view proposes a size to its child view.
2.  All subsequent child views:
    -   propose a size to _their_ child’s view
    -   ask that child what size it wants
3.  Each parent view renders its child view at the returned size.

**Flutter** differs somewhat with its process:

1.  The parent widget passes constraints down to its children. Constraints include minimum and maximum values for height and width.
2.  The child tries to decide its size. It repeats the same process with its own list of children:
    -   It informs its child of the child’s constraints.
    -   It asks its child what size it wishes to be.
3.  The parent lays out the child.
    -   If the requested size fits in the constraints, the parent uses that size.
    -   If the requested size doesn’t fit in the constraints, the parent limits the height, width, or both to fit in its constraints.

Flutter differs from SwiftUI because the parent component can override the child’s desired size. The widget cannot have any size it wants. It also cannot know or decide its position on screen as its parent makes that decision.

To force a child widget to render at a specific size, the parent must set tight constraints. A constraint becomes tight when its constraint’s minimum size value equals its maximum size value.

In **SwiftUI**, views might expand to the available space or limit their size to that of its content. **Flutter** widgets behave in similar manner.

However, in Flutter parent widgets can offer unbounded constraints. Unbounded constraints set their maximum values to infinity.

```
<span>UnboundedBox</span><span>(</span>
  <span>child:</span> <span>Container</span><span>(</span>
      <span>width:</span> <span>double</span><span>.</span><span>infinity</span><span>,</span> <span>height:</span> <span>double</span><span>.</span><span>infinity</span><span>,</span> <span>color:</span> <span>red</span><span>),</span>
<span>)</span>
```

If the child expands and it has unbounded constraints, Flutter returns an overflow warning:

```
<span>UnconstrainedBox</span><span>(</span>
  <span>child:</span> <span>Container</span><span>(</span><span>color:</span> <span>red</span><span>,</span> <span>width:</span> <span>4000</span><span>,</span> <span>height:</span> <span>50</span><span>),</span>
<span>)</span>
```

![When parents pass unbounded constraints to children, and the children are expanding, then there is an overflow warning](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-14.png)

To learn how constraints work in Flutter, see [Understanding constraints](https://docs.flutter.dev/ui/layout/constraints).

### Design system

Because Flutter targets multiple platforms, your app doesn’t need to conform to any design system. Though this guide features [Material](https://m3.material.io/develop/flutter/) widgets, your Flutter app can use many different design systems:

-   Custom Material widgets
-   Community built widgets
-   Your own custom widgets
-   [Cupertino widgets](https://docs.flutter.dev/ui/widgets/cupertino) that follow Apple’s Human Interface Guidelines

<iframe width="560" height="315" src="https://www.youtube.com/embed/3PdUaidHc-E?rel=0&amp;enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Flutter’s Cupertino Package for iOS devs - Flutter In Focus" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="78701675" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

If you’re looking for a great reference app that features a custom design system, check out [Wonderous](https://flutter.gskinner.com/wonderous/?utm_source=flutterdocs&utm_medium=docs&utm_campaign=iosdevs).

## UI Basics

This section covers the basics of UI development in Flutter and how it compares to SwiftUI. This includes how to start developing your app, display static text, create buttons, react to on-press events, display lists, grids, and more.

### Getting started

In **SwiftUI**, you use `App` to start your app.

```
<span>@main</span>
<span>struct</span> <span>MyApp</span><span>:</span> <span>App</span> <span>{</span>
    <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>Scene</span> <span>{</span>
        <span>WindowGroup</span> <span>{</span>
            <span>HomePage</span><span>()</span>
        <span>}</span>
    <span>}</span>
<span>}</span>
```

Another common SwiftUI practice places the app body within a `struct` that conforms to the `View` protocol as follows:

```
<span>struct</span> <span>HomePage</span><span>:</span> <span>View</span> <span>{</span>
  <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>View</span> <span>{</span>
    <span>Text</span><span>(</span><span>"Hello, World!"</span><span>)</span>
  <span>}</span>
<span>}</span>
```

To start your **Flutter** app, pass in an instance of your app to the `runApp` function.

-   [Test in DartPad](https://dartpad.dev/?id=d3d38ae68f7d6444421d0485a1fd02db)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/get_started.dart)

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
</span><span>}</span>
```

`App` is a widget. The build method describes the part of the user interface it represents. It’s common to begin your app with a [`WidgetApp`](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html) class, like [`CupertinoApp`](https://api.flutter.dev/flutter/cupertino/CupertinoApp-class.html).

-   [Test in DartPad](https://dartpad.dev/?id=d3d38ae68f7d6444421d0485a1fd02db)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/get_started.dart)

```
<span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Returns a CupertinoApp that, by default,</span><span>
    </span><span>// has the look and feel of an iOS app.</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>CupertinoApp</span><span>(</span><span>
      home</span><span>:</span><span> </span><span>HomePage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The widget used in `HomePage` might begin with the `Scaffold` class. `Scaffold` implements a basic layout structure for an app.

-   [Test in DartPad](https://dartpad.dev/?id=d3d38ae68f7d6444421d0485a1fd02db)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/get_started.dart)

```
<span>class</span><span> </span><span>HomePage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>HomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>Scaffold</span><span>(</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'Hello, World!'</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Note how Flutter uses the [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html) widget. SwiftUI renders a view’s contents in its center by default. That’s not always the case with Flutter. `Scaffold` doesn’t render its `body` widget at the center of the screen. To center the text, wrap it in a `Center` widget. To learn about different widgets and their default behaviors, check out the [Widget catalog](https://docs.flutter.dev/ui/widgets/layout).

### Adding Buttons

In **SwiftUI**, you use the `Button` struct to create a button.

```
<span>Button</span><span>(</span><span>"Do something"</span><span>)</span> <span>{</span>
  <span>// this closure gets called when your</span>
  <span>// button is tapped</span>
<span>}</span>
```

To achieve the same result in **Flutter**, use the `CupertinoButton` class:

-   [Test in DartPad](https://dartpad.dev/?id=b776dfe43c91e580c66b2b93368745eb)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/text_button.dart)

```
<span>        </span><span>CupertinoButton</span><span>(</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// This closure is called when your button is tapped.</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Do something'</span><span>),</span><span>
</span><span>)</span>
```

**Flutter** gives you access to a variety of buttons with predefined styles. The [`CupertinoButton`](https://api.flutter.dev/flutter/cupertino/CupertinoButton-class.html) class comes from the Cupertino library. Widgets in the Cupertino library use Apple’s design system.

### Aligning components horizontally

In **SwiftUI**, stack views play a big part in designing your layouts. Two separate structures allow you to create stacks:

1.  `HStack` for horizontal stack views
    
2.  `VStack` for vertical stack views
    

The following SwiftUI view adds a globe image and text to a horizontal stack view:

```
<span>HStack</span> <span>{</span>
  <span>Image</span><span>(</span><span>systemName</span><span>:</span> <span>"globe"</span><span>)</span>
  <span>Text</span><span>(</span><span>"Hello, world!"</span><span>)</span>
<span>}</span>
```

**Flutter** uses [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) rather than `HStack`:

-   [Test in DartPad](https://dartpad.dev/?id=5715d4f269f629d274ef1b0e9546853b)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/row.dart)

```
<span>    </span><span>Row</span><span>(</span><span>
  mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Icon</span><span>(</span><span>CupertinoIcons</span><span>.</span><span>globe</span><span>),</span><span>
    </span><span>Text</span><span>(</span><span>'Hello, world!'</span><span>),</span><span>
  </span><span>],</span><span>
</span><span>),</span>
```

The `Row` widget requires a `List<Widget>` in the `children` parameter. The `mainAxisAlignment` property tells Flutter how to position children with extra space. `MainAxisAlignment.center` positions children in the center of the main axis. For `Row`, the main axis is the horizontal axis.

### Aligning components vertically

The following examples build on those in the previous section.

In **SwiftUI**, you use `VStack` to arrange the components into a vertical pillar.

```
<span>VStack</span> <span>{</span>
  <span>Image</span><span>(</span><span>systemName</span><span>:</span> <span>"globe"</span><span>)</span>
  <span>Text</span><span>(</span><span>"Hello, world!"</span><span>)</span>
<span>}</span>
```

**Flutter** uses the same Dart code from the previous example, except it swaps [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) for `Row`:

-   [Test in DartPad](https://dartpad.dev/?id=5e85473354959c0712f05e86d111c584)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/column.dart)

```
<span>    </span><span>Column</span><span>(</span><span>
  mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Icon</span><span>(</span><span>CupertinoIcons</span><span>.</span><span>globe</span><span>),</span><span>
    </span><span>Text</span><span>(</span><span>'Hello, world!'</span><span>),</span><span>
  </span><span>],</span><span>
</span><span>),</span>
```

### Displaying a list view

In **SwiftUI**, you use the `List` base component to display sequences of items. To display a sequence of model objects, make sure that the user can identify your model objects. To make an object identifiable, use the `Identifiable` protocol.

```
<span>struct</span> <span>Person</span><span>:</span> <span>Identifiable</span> <span>{</span>
  <span>var</span> <span>name</span><span>:</span> <span>String</span>
<span>}</span>

<span>var</span> <span>persons</span> <span>=</span> <span>[</span>
  <span>Person</span><span>(</span><span>name</span><span>:</span> <span>"Person 1"</span><span>),</span>
  <span>Person</span><span>(</span><span>name</span><span>:</span> <span>"Person 2"</span><span>),</span>
  <span>Person</span><span>(</span><span>name</span><span>:</span> <span>"Person 3"</span><span>),</span>
<span>]</span>

<span>struct</span> <span>ListWithPersons</span><span>:</span> <span>View</span> <span>{</span>
  <span>let</span> <span>persons</span><span>:</span> <span>[</span><span>Person</span><span>]</span>
  <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>View</span> <span>{</span>
    <span>List</span> <span>{</span>
      <span>ForEach</span><span>(</span><span>persons</span><span>)</span> <span>{</span> <span>person</span> <span>in</span>
        <span>Text</span><span>(</span><span>person</span><span>.</span><span>name</span><span>)</span>
      <span>}</span>
    <span>}</span>
  <span>}</span>
<span>}</span>
```

This resembles how **Flutter** prefers to build its list widgets. Flutter doesn’t need the list items to be identifiable. You set the number of items to display then build a widget for each item.

-   [Test in DartPad](https://dartpad.dev/?id=66e6728e204021e3b9e0190be50d014b)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/list.dart)

```
<span>class</span><span> </span><span>Person</span><span> </span><span>{</span><span>
  </span><span>String</span><span> name</span><span>;</span><span>
  </span><span>Person</span><span>(</span><span>this</span><span>.</span><span>name</span><span>);</span><span>
</span><span>}</span><span>

</span><span>var</span><span> items </span><span>=</span><span> </span><span>[</span><span>
  </span><span>Person</span><span>(</span><span>'Person 1'</span><span>),</span><span>
  </span><span>Person</span><span>(</span><span>'Person 2'</span><span>),</span><span>
  </span><span>Person</span><span>(</span><span>'Person 3'</span><span>),</span><span>
</span><span>];</span><span>

</span><span>class</span><span> </span><span>HomePage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>HomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
        itemCount</span><span>:</span><span> items</span><span>.</span><span>length</span><span>,</span><span>
        itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
            title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>items</span><span>[</span><span>index</span><span>].</span><span>name</span><span>),</span><span>
          </span><span>);</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Flutter has some caveats for lists:

-   The [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) widget has a builder method. This works like the `ForEach` within SwiftUI’s `List` struct.
    
-   The `itemCount` parameter of the `ListView` sets how many items the `ListView` displays.
    
-   The `itemBuilder` has an index parameter that will be between zero and one less than itemCount.
    

The previous example returned a [`ListTile`](https://api.flutter.dev/flutter/widgets/ListTitle-class.html) widget for each item. The `ListTile` widget includes properties like `height` and `font-size`. These properties help build a list. However, Flutter allows you to return almost any widget that represents your data.

### Displaying a grid

When constructing non-conditional grids in **SwiftUI**, you use `Grid` with `GridRow`.

```
<span>Grid</span> <span>{</span>
  <span>GridRow</span> <span>{</span>
    <span>Text</span><span>(</span><span>"Row 1"</span><span>)</span>
    <span>Image</span><span>(</span><span>systemName</span><span>:</span> <span>"square.and.arrow.down"</span><span>)</span>
    <span>Image</span><span>(</span><span>systemName</span><span>:</span> <span>"square.and.arrow.up"</span><span>)</span>
  <span>}</span>
  <span>GridRow</span> <span>{</span>
    <span>Text</span><span>(</span><span>"Row 2"</span><span>)</span>
    <span>Image</span><span>(</span><span>systemName</span><span>:</span> <span>"square.and.arrow.down"</span><span>)</span>
    <span>Image</span><span>(</span><span>systemName</span><span>:</span> <span>"square.and.arrow.up"</span><span>)</span>
  <span>}</span>
<span>}</span>
```

To display grids in **Flutter**, use the [`GridView`](https://api.flutter.dev/flutter/widgets/GridView-class.html) widget. This widget has various constructors. Each constructor has a similar goal, but uses different input parameters. The following example uses the `.builder()` initializer:

-   [Test in DartPad](https://dartpad.dev/?id=4ac2d2433390042d25c97f1e819ec337)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/grid.dart)

```
<span>const</span><span> widgets </span><span>=</span><span> </span><span>[</span><span>
  </span><span>Text</span><span>(</span><span>'Row 1'</span><span>),</span><span>
  </span><span>Icon</span><span>(</span><span>CupertinoIcons</span><span>.</span><span>arrow_down_square</span><span>),</span><span>
  </span><span>Icon</span><span>(</span><span>CupertinoIcons</span><span>.</span><span>arrow_up_square</span><span>),</span><span>
  </span><span>Text</span><span>(</span><span>'Row 2'</span><span>),</span><span>
  </span><span>Icon</span><span>(</span><span>CupertinoIcons</span><span>.</span><span>arrow_down_square</span><span>),</span><span>
  </span><span>Icon</span><span>(</span><span>CupertinoIcons</span><span>.</span><span>arrow_up_square</span><span>),</span><span>
</span><span>];</span><span>

</span><span>class</span><span> </span><span>HomePage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>HomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      body</span><span>:</span><span> </span><span>GridView</span><span>.</span><span>builder</span><span>(</span><span>
        gridDelegate</span><span>:</span><span> </span><span>const</span><span> </span><span>SliverGridDelegateWithFixedCrossAxisCount</span><span>(</span><span>
          crossAxisCount</span><span>:</span><span> </span><span>3</span><span>,</span><span>
          mainAxisExtent</span><span>:</span><span> </span><span>40</span><span>,</span><span>
        </span><span>),</span><span>
        itemCount</span><span>:</span><span> widgets</span><span>.</span><span>length</span><span>,</span><span>
        itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>=&gt;</span><span> widgets</span><span>[</span><span>index</span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The `SliverGridDelegateWithFixedCrossAxisCount` delegate determines various parameters that the grid uses to lay out its components. This includes `crossAxisCount` that dictates the number of items displayed on each row.

How SwiftUI’s `Grid` and Flutter’s `GridView` differ in that `Grid` requires `GridRow`. `GridView` uses the delegate to decide how the grid should lay out its components.

### Creating a scroll view

In **SwiftUI**, you use `ScrollView` to create custom scrolling components. The following example displays a series of `PersonView` instances in a scrollable fashion.

```
<span>ScrollView</span> <span>{</span>
  <span>VStack</span><span>(</span><span>alignment</span><span>:</span> <span>.</span><span>leading</span><span>)</span> <span>{</span>
    <span>ForEach</span><span>(</span><span>persons</span><span>)</span> <span>{</span> <span>person</span> <span>in</span>
      <span>PersonView</span><span>(</span><span>person</span><span>:</span> <span>person</span><span>)</span>
    <span>}</span>
  <span>}</span>
<span>}</span>
```

To create a scrolling view, **Flutter** uses [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html). In the following example, the function `mockPerson` mocks instances of the `Person` class to create the custom `PersonView` widget.

-   [Test in DartPad](https://dartpad.dev/?id=63039c5371995ae53d971d613a936f7b)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/scroll.dart)

```
<span>    </span><span>SingleChildScrollView</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
    children</span><span>:</span><span> mockPersons
        </span><span>.</span><span>map</span><span>(</span><span>
          </span><span>(</span><span>person</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>PersonView</span><span>(</span><span>
            person</span><span>:</span><span> person</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>)</span><span>
        </span><span>.</span><span>toList</span><span>(),</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

### Responsive and adaptive design

In **SwiftUI**, you use `GeometryReader` to create relative view sizes.

For example, you could:

-   Multiply `geometry.size.width` by some factor to set the _width_.
-   Use `GeometryReader` as a breakpoint to change the design of your app.

You can also see if the size class has `.regular` or `.compact` using `horizontalSizeClass`.

To create relative views in **Flutter**, you can use one of two options:

-   Get the `BoxConstraints` object in the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) class.
-   Use the [`MediaQuery.of()`](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html) in your build functions to get the size and orientation of your current app.

To learn more, check out [Creating responsive and adaptive apps](https://docs.flutter.dev/ui/layout/responsive/adaptive-responsive).

### Managing state

In **SwiftUI**, you use the `@State` property wrapper to represent the internal state of a SwiftUI view.

```
<span>struct</span> <span>ContentView</span><span>:</span> <span>View</span> <span>{</span>
  <span>@State</span> <span>private</span> <span>var</span> <span>counter</span> <span>=</span> <span>0</span><span>;</span>
  <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>View</span> <span>{</span>
    <span>VStack</span><span>{</span>
      <span>Button</span><span>(</span><span>"+"</span><span>)</span> <span>{</span> <span>counter</span><span>+=</span><span>1</span> <span>}</span>
      <span>Text</span><span>(</span><span>String</span><span>(</span><span>counter</span><span>))</span>
    <span>}</span>
  <span>}}</span>
```

**SwiftUI** also includes several options for more complex state management such as the `ObservableObject` protocol.

**Flutter** manages local state using a [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html). Implement a stateful widget with the following two classes:

-   a subclass of `StatefulWidget`
-   a subclass of `State`

The `State` object stores the widget’s state. To change a widget’s state, call `setState()` from the `State` subclass to tell the framework to redraw the widget.

The following example shows a part of a counter app:

-   [Test in DartPad](https://dartpad.dev/?id=c5fcf5897c21456c518ea954c2587ada)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/state.dart)

```
<span>class</span><span> </span><span>MyHomePage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyHomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
  @override
  </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyHomePageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyHomePageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>int</span><span> _counter </span><span>=</span><span> </span><span>0</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>Text</span><span>(</span><span>'$_counter'</span><span>),</span><span>
            </span><span>TextButton</span><span>(</span><span>
              onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> setState</span><span>(()</span><span> </span><span>{</span><span>
                _counter</span><span>++;</span><span>
              </span><span>}),</span><span>
              child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'+'</span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

To learn more ways to manage state, check out [State management](https://docs.flutter.dev/data-and-backend/state-mgmt).

### Animations

Two main types of UI animations exist.

-   Implicit that animated from a current value to a new target.
-   Explicit that animates when asked.

#### Implicit Animation

SwiftUI and Flutter take a similar approach to animation. In both frameworks, you specify parameters like `duration`, and `curve`.

In **SwiftUI**, you use the `animate()` modifier to handle implicit animation.

```
<span>Button</span><span>(</span><span>"Tap me!"</span><span>){</span>
   <span>angle</span> <span>+=</span> <span>45</span>
<span>}</span>
<span>.</span><span>rotationEffect</span><span>(</span><span>.</span><span>degrees</span><span>(</span><span>angle</span><span>))</span>
<span>.</span><span>animation</span><span>(</span><span>.</span><span>easeIn</span><span>(</span><span>duration</span><span>:</span> <span>1</span><span>))</span>
```

**Flutter** includes widgets for implicit animation. This simplifies animating common widgets. Flutter names these widgets with the following format: `AnimatedFoo`.

For example: To rotate a button, use the [`AnimatedRotation`](https://api.flutter.dev/flutter/widgets/AnimatedRotation-class.html) class. This animates the `Transform.rotate` widget.

-   [Test in DartPad](https://dartpad.dev/?id=4b9cfedfe9ca09baeb83456fdf7cbe32)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/simple_animation.dart)

```
<span>    </span><span>AnimatedRotation</span><span>(</span><span>
  duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>seconds</span><span>:</span><span> </span><span>1</span><span>),</span><span>
  turns</span><span>:</span><span> turns</span><span>,</span><span>
  curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>easeIn</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>TextButton</span><span>(</span><span>
      onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          turns </span><span>+=</span><span> </span><span>.</span><span>125</span><span>;</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Tap me!'</span><span>)),</span><span>
</span><span>),</span>
```

Flutter allows you to create custom implicit animations. To compose a new animated widget, use the [`TweenAnimationBuilder`](https://api.flutter.dev/flutter/widgets/TweenAnimationBuilder-class.html).

#### Explicit Animation

For explicit animations, **SwiftUI** uses the `withAnimation()` function.

**Flutter** includes explicitly animated widgets with names formatted like `FooTransition`. One example would be the [`RotationTransition`](https://api.flutter.dev/flutter/widgets/RotationTransition-class.html) class.

Flutter also allows you to create a custom explicit animation using `AnimatedWidget` or `AnimatedBuilder`.

To learn more about animations in Flutter, see [Animations overview](https://docs.flutter.dev/ui/animations).

### Drawing on the Screen

In **SwiftUI**, you use `CoreGraphics` to draw lines and shapes to the screen.

**Flutter** has an API based on the `Canvas` class, with two classes that help you draw:

1.  [`CustomPaint`](https://api.flutter.dev/flutter/widgets/CustomPaint-class.html) that requires a painter:
    
    -   [Test in DartPad](https://dartpad.dev/?id=fccb26fc4bca4c08ca37931089a837e7)
    -   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/canvas.dart)
    
    ```
    <span>    </span><span>CustomPaint</span><span>(</span><span>
       painter</span><span>:</span><span> </span><span>SignaturePainter</span><span>(</span><span>_points</span><span>),</span><span>
       size</span><span>:</span><span> </span><span>Size</span><span>.</span><span>infinite</span><span>,</span><span>
     </span><span>),</span>
    ```
    
2.  [`CustomPainter`](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html) that implements your algorithm to draw to the canvas.
    
    -   [Test in DartPad](https://dartpad.dev/?id=fccb26fc4bca4c08ca37931089a837e7)
    -   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/canvas.dart)
    
    ```
    <span>class</span><span> </span><span>SignaturePainter</span><span> </span><span>extends</span><span> </span><span>CustomPainter</span><span> </span><span>{</span><span>
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
    

## Navigation

This section explains how to navigate between pages of an app, the push and pop mechanism, and more.

### Navigating between pages

Developers build iOS and macOS apps with different pages called _navigation routes_.

In **SwiftUI**, the `NavigationStack` represents this stack of pages.

The following example creates an app that displays a list of persons. To display a person’s details in a new navigation link, tap on that person.

```
<span>NavigationStack</span><span>(</span><span>path</span><span>:</span> <span>$path</span><span>)</span> <span>{</span>
      <span>List</span> <span>{</span>
        <span>ForEach</span><span>(</span><span>persons</span><span>)</span> <span>{</span> <span>person</span> <span>in</span>
          <span>NavigationLink</span><span>(</span>
            <span>person</span><span>.</span><span>name</span><span>,</span>
            <span>value</span><span>:</span> <span>person</span>
          <span>)</span>
        <span>}</span>
      <span>}</span>
      <span>.</span><span>navigationDestination</span><span>(</span><span>for</span><span>:</span> <span>Person</span><span>.</span><span>self</span><span>)</span> <span>{</span> <span>person</span> <span>in</span>
        <span>PersonView</span><span>(</span><span>person</span><span>:</span> <span>person</span><span>)</span>
      <span>}</span>
    <span>}</span>
```

If you have a small **Flutter** app without complex linking, use [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html) with named routes. After defining your navigation routes, call your navigation routes using their names.

1.  Name each route in the class passed to the `runApp()` function. The following example uses `App`:
    
    -   [Test in DartPad](https://dartpad.dev/?id=5ae0624689958c4775b064d39d108d9e)
    -   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/navigation.dart)
    
    ```
    <span>// Defines the route name as a constant</span><span>
     </span><span>// so that it's reusable.</span><span>
     </span><span>const</span><span> detailsPageRouteName </span><span>=</span><span> </span><span>'/details'</span><span>;</span><span>
    
     </span><span>class</span><span> </span><span>App</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
       </span><span>const</span><span> </span><span>App</span><span>({</span><span>
         </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
       </span><span>});</span><span>
    
       @override
       </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
         </span><span>return</span><span> </span><span>CupertinoApp</span><span>(</span><span>
           home</span><span>:</span><span> </span><span>const</span><span> </span><span>HomePage</span><span>(),</span><span>
           </span><span>// The [routes] property defines the available named routes</span><span>
           </span><span>// and the widgets to build when navigating to those routes.</span><span>
           routes</span><span>:</span><span> </span><span>{</span><span>
             detailsPageRouteName</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>DetailsPage</span><span>(),</span><span>
           </span><span>},</span><span>
         </span><span>);</span><span>
       </span><span>}</span><span>
     </span><span>}</span>
    ```
    
    The following sample generates a list of persons using `mockPersons()`. Tapping a person pushes the person’s detail page to the `Navigator` using `pushNamed()`.
    
    -   [Test in DartPad](https://dartpad.dev/?id=5ae0624689958c4775b064d39d108d9e)
    -   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/navigation.dart)
    
    ```
    <span>    </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
       itemCount</span><span>:</span><span> mockPersons</span><span>.</span><span>length</span><span>,</span><span>
       itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
         </span><span>final</span><span> person </span><span>=</span><span> mockPersons</span><span>.</span><span>elementAt</span><span>(</span><span>index</span><span>);</span><span>
         </span><span>final</span><span> age </span><span>=</span><span> </span><span>'${person.age} years old'</span><span>;</span><span>
         </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
           title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>person</span><span>.</span><span>name</span><span>),</span><span>
           subtitle</span><span>:</span><span> </span><span>Text</span><span>(</span><span>age</span><span>),</span><span>
           trailing</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>
             </span><span>Icons</span><span>.</span><span>arrow_forward_ios</span><span>,</span><span>
           </span><span>),</span><span>
           onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
             </span><span>// When a [ListTile] that represents a person is</span><span>
             </span><span>// tapped, push the detailsPageRouteName route</span><span>
             </span><span>// to the Navigator and pass the person's instance</span><span>
             </span><span>// to the route.</span><span>
             </span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>
               detailsPageRouteName</span><span>,</span><span>
               arguments</span><span>:</span><span> person</span><span>,</span><span>
             </span><span>);</span><span>
           </span><span>},</span><span>
         </span><span>);</span><span>
       </span><span>},</span><span>
     </span><span>),</span>
    ```
    
2.  Define the `DetailsPage` widget that displays the details of each person. In Flutter, you can pass arguments into the widget when navigating to the new route. Extract the arguments using `ModalRoute.of()`:
    
    -   [Test in DartPad](https://dartpad.dev/?id=5ae0624689958c4775b064d39d108d9e)
    -   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/navigation.dart)
    
    ```
    <span>class</span><span> </span><span>DetailsPage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
       </span><span>const</span><span> </span><span>DetailsPage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
       @override
       </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
         </span><span>// Read the person instance from the arguments.</span><span>
         </span><span>final</span><span> </span><span>Person</span><span> person </span><span>=</span><span> </span><span>ModalRoute</span><span>.</span><span>of</span><span>(</span><span>
           context</span><span>,</span><span>
         </span><span>)?.</span><span>settings</span><span>.</span><span>arguments </span><span>as</span><span> </span><span>Person</span><span>;</span><span>
         </span><span>// Extract the age.</span><span>
         </span><span>final</span><span> age </span><span>=</span><span> </span><span>'${person.age} years old'</span><span>;</span><span>
         </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
           </span><span>// Display name and age.</span><span>
           body</span><span>:</span><span> </span><span>Column</span><span>(</span><span>children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>person</span><span>.</span><span>name</span><span>),</span><span> </span><span>Text</span><span>(</span><span>age</span><span>)]),</span><span>
         </span><span>);</span><span>
       </span><span>}</span><span>
     </span><span>}</span>
    ```
    

To create more advanced navigation and routing requirements, use a routing package such as [go\_router](https://pub.dev/packages/go_router).

To learn more, check out [Navigation and routing](https://docs.flutter.dev/ui/navigation).

### Manually pop back

In **SwiftUI**, you use the `dismiss` environment value to pop-back to the previous screen.

```
<span>Button</span><span>(</span><span>"Pop back"</span><span>)</span> <span>{</span>
        <span>dismiss</span><span>()</span>
      <span>}</span>
```

In **Flutter**, use the `pop()` function of the `Navigator` class:

-   [Test in DartPad](https://dartpad.dev/?id=0cf352feaeaea2eb107f784d879e480d)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/popback.dart)

```
<span>TextButton</span><span>(</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// This code allows the</span><span>
    </span><span>// view to pop back to its presenter.</span><span>
    </span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pop</span><span>();</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Pop back'</span><span>),</span><span>
</span><span>),</span>
```

### Navigating to another app

In **SwiftUI**, you use the `openURL` environment variable to open a URL to another application.

```
<span>@Environment</span><span>(\</span><span>.</span><span>openURL</span><span>)</span> <span>private</span> <span>var</span> <span>openUrl</span>

<span>// View code goes here</span>

 <span>Button</span><span>(</span><span>"Open website"</span><span>)</span> <span>{</span>
      <span>openUrl</span><span>(</span>
        <span>URL</span><span>(</span>
          <span>string</span><span>:</span> <span>"https://google.com"</span>
        <span>)</span><span>!</span>
      <span>)</span>
    <span>}</span>
```

In **Flutter**, use the [`url_launcher`](https://pub.dev/packages/url_launcher) plugin.

-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/openapp.dart)

```
<span>    </span><span>CupertinoButton</span><span>(</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>await</span><span> launchUrl</span><span>(</span><span>
      </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://google.com'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
    </span><span>'Open website'</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

You can style Flutter apps with little effort. Styling includes switching between light and dark themes, changing the design of your text and UI components, and more. This section covers how to style your apps.

### Using dark mode

In **SwiftUI**, you call the `preferredColorScheme()` function on a `View` to use dark mode.

In **Flutter**, you can control light and dark mode at the app-level. To control the brightness mode, use the `theme` property of the `App` class:

-   [Test in DartPad](https://dartpad.dev/?id=c446775c3224787e51fb18b054a08a1c)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/cupertino_themes.dart)

```
<span>    </span><span>CupertinoApp</span><span>(</span><span>
  theme</span><span>:</span><span> </span><span>CupertinoThemeData</span><span>(</span><span>
    brightness</span><span>:</span><span> </span><span>Brightness</span><span>.</span><span>dark</span><span>,</span><span>
  </span><span>),</span><span>
  home</span><span>:</span><span> </span><span>HomePage</span><span>(),</span><span>
</span><span>);</span>
```

### Styling text

In **SwiftUI**, you use modifier functions to style text. For example, to change the font of a `Text` string, use the `font()` modifier:

```
<span>Text</span><span>(</span><span>"Hello, world!"</span><span>)</span>
  <span>.</span><span>font</span><span>(</span><span>.</span><span>system</span><span>(</span><span>size</span><span>:</span> <span>30</span><span>,</span> <span>weight</span><span>:</span> <span>.</span><span>heavy</span><span>))</span>
  <span>.</span><span>foregroundColor</span><span>(</span><span>.</span><span>yellow</span><span>)</span>
```

To style text in **Flutter**, add a `TextStyle` widget as the value of the `style` parameter of the `Text` widget.

-   [Test in DartPad](https://dartpad.dev/?id=c446775c3224787e51fb18b054a08a1c)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/cupertino_themes.dart)

```
<span>    </span><span>Text</span><span>(</span><span>
  </span><span>'Hello, world!'</span><span>,</span><span>
  style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
    fontSize</span><span>:</span><span> </span><span>30</span><span>,</span><span>
    fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span>
    color</span><span>:</span><span> </span><span>CupertinoColors</span><span>.</span><span>systemYellow</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

### Styling buttons

In **SwiftUI**, you use modifier functions to style buttons.

```
<span>Button</span><span>(</span><span>"Do something"</span><span>)</span> <span>{</span>
    <span>// do something when button is tapped</span>
  <span>}</span>
  <span>.</span><span>font</span><span>(</span><span>.</span><span>system</span><span>(</span><span>size</span><span>:</span> <span>30</span><span>,</span> <span>weight</span><span>:</span> <span>.</span><span>bold</span><span>))</span>
  <span>.</span><span>background</span><span>(</span><span>Color</span><span>.</span><span>yellow</span><span>)</span>
  <span>.</span><span>foregroundColor</span><span>(</span><span>Color</span><span>.</span><span>blue</span><span>)</span>
<span>}</span>
```

To style button widgets in **Flutter**, set the style of its child, or modify properties on the button itself.

In the following example:

-   The `color` property of `CupertinoButton` sets its `color`.
-   The `color` property of the child `Text` widget sets the button text color.

-   [Test in DartPad](https://dartpad.dev/?id=8ffd244574c98f510c29712f6e6c2204)
-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/stylingbutton.dart)

```
<span>child</span><span>:</span><span> </span><span>CupertinoButton</span><span>(</span><span>
  color</span><span>:</span><span> </span><span>CupertinoColors</span><span>.</span><span>systemYellow</span><span>,</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
  padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
    </span><span>'Do something'</span><span>,</span><span>
    style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
      color</span><span>:</span><span> </span><span>CupertinoColors</span><span>.</span><span>systemBlue</span><span>,</span><span>
      fontSize</span><span>:</span><span> </span><span>30</span><span>,</span><span>
      fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

### Using custom fonts

In **SwiftUI**, you can use a custom font in your app in two steps. First, add the font file to your SwiftUI project. After adding the file, use the `.font()` modifier to apply it to your UI components.

```
<span>Text</span><span>(</span><span>"Hello"</span><span>)</span>
  <span>.</span><span>font</span><span>(</span>
    <span>Font</span><span>.</span><span>custom</span><span>(</span>
      <span>"BungeeSpice-Regular"</span><span>,</span>
      <span>size</span><span>:</span> <span>40</span>
    <span>)</span>
  <span>)</span>
```

In **Flutter**, you control your resources with a file named `pubspec.yaml`. This file is platform agnostic. To add a custom font to your project, follow these steps:

1.  Create a folder called `fonts` in the project’s root directory. This optional step helps to organize your fonts.
2.  Add your `.ttf`, `.otf`, or `.ttc` font file into the `fonts` folder.
3.  Open the `pubspec.yaml` file within the project.
4.  Find the `flutter` section.
5.  Add your custom font(s) under the `fonts` section.
    
    ```
     flutter:
       fonts:
         - family: BungeeSpice
           fonts:
             - asset: fonts/BungeeSpice-Regular.ttf
    ```
    

After you add the font to your project, you can use it as in the following example:

-   [View on GitHub](https://github.com/flutter/website/blob/main/examples/get-started/flutter-for/ios_devs/lib/stylingbutton.dart)

```
<span>        </span><span>Text</span><span>(</span><span>
  </span><span>'Cupertino'</span><span>,</span><span>
  style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
    fontSize</span><span>:</span><span> </span><span>40</span><span>,</span><span>
    fontFamily</span><span>:</span><span> </span><span>'BungeeSpice'</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

### Bundling images in apps

In **SwiftUI**, you first add the image files to `Assets.xcassets`, then use the `Image` view to display the images.

To add images in **Flutter**, follow a method similar to how you added custom fonts.

1.  Add an `images` folder to the root directory.
2.  Add this asset to the `pubspec.yaml` file.
    
    ```
     flutter:
       assets:
         - images/Blueberries.jpg
    ```
    

After adding your image, display it using the `Image` widget’s `.asset()` constructor. This constructor:

1.  Instantiates the given image using the provided path.
2.  Reads the image from the assets bundled with your app.
3.  Displays the image on the screen.

To review a complete example, check out the [`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html) docs.

### Bundling videos in apps

In **SwiftUI**, you bundle a local video file with your app in two steps. First, you import the `AVKit` framework, then you instantiate a `VideoPlayer` view.

In **Flutter**, add the [video\_player](https://pub.dev/packages/video_player) plugin to your project. This plugin allows you to create a video player that works on Android, iOS, and on the web from the same codebase.

1.  Add the plugin to your app and add the video file to your project.
2.  Add the asset to your `pubspec.yaml` file.
3.  Use the `VideoPlayerController` class to load and play your video file.

To review a complete walkthrough, check out the [video\_player example](https://pub.dev/packages/video_player/example).