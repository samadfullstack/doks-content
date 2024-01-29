1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Lists](https://docs.flutter.dev/cookbook/lists)
3.  [Place a floating app bar above a list](https://docs.flutter.dev/cookbook/lists/floating-app-bar)

To make it easier for users to view a list of items, you might want to hide the app bar as the user scrolls down the list. This is especially true if your app displays a “tall” app bar that occupies a lot of vertical space.

Typically, you create an app bar by providing an `appBar` property to the `Scaffold` widget. This creates a fixed app bar that always remains above the `body` of the `Scaffold`.

Moving the app bar from a `Scaffold` widget into a [`CustomScrollView`](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html) allows you to create an app bar that scrolls offscreen as you scroll through a list of items contained inside the `CustomScrollView`.

This recipe demonstrates how to use a `CustomScrollView` to display a list of items with an app bar on top that scrolls offscreen as the user scrolls down the list using the following steps:

1.  Create a `CustomScrollView`.
2.  Use `SliverAppBar` to add a floating app bar.
3.  Add a list of items using a `SliverList`.

To create a floating app bar, place the app bar inside a `CustomScrollView` that also contains the list of items. This synchronizes the scroll position of the app bar and the list of items. You might think of the `CustomScrollView` widget as a `ListView` that allows you to mix and match different types of scrollable lists and widgets together.

The scrollable lists and widgets provided to the `CustomScrollView` are known as _slivers_. There are several types of slivers, such as `SliverList`, `SliverGridList`, and `SliverAppBar`. In fact, the `ListView` and `GridView` widgets use the `SliverList` and `SliverGrid` widgets to implement scrolling.

For this example, create a `CustomScrollView` that contains a `SliverAppBar` and a `SliverList`. In addition, remove any app bars that you provide to the `Scaffold` widget.

```
<span>Scaffold</span><span>(</span><span>
  </span><span>// No appBar property provided, only the body.</span><span>
  body</span><span>:</span><span> </span><span>CustomScrollView</span><span>(</span><span>
      </span><span>// Add the app bar and list of items as slivers in the next steps.</span><span>
      slivers</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[]),</span><span>
</span><span>);</span>
```

### 2\. Use `SliverAppBar` to add a floating app bar

Next, add an app bar to the [`CustomScrollView`](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html). Flutter provides the [`SliverAppBar`](https://api.flutter.dev/flutter/material/SliverAppBar-class.html) widget which, much like the normal `AppBar` widget, uses the `SliverAppBar` to display a title, tabs, images and more.

However, the `SliverAppBar` also gives you the ability to create a “floating” app bar that scrolls offscreen as the user scrolls down the list. Furthermore, you can configure the `SliverAppBar` to shrink and expand as the user scrolls.

To create this effect:

1.  Start with an app bar that displays only a title.
2.  Set the `floating` property to `true`. This allows users to quickly reveal the app bar when they scroll up the list.
3.  Add a `flexibleSpace` widget that fills the available `expandedHeight`.

```
<span>CustomScrollView</span><span>(</span><span>
  slivers</span><span>:</span><span> </span><span>[</span><span>
    </span><span>// Add the app bar to the CustomScrollView.</span><span>
    </span><span>const</span><span> </span><span>SliverAppBar</span><span>(</span><span>
      </span><span>// Provide a standard title.</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>title</span><span>),</span><span>
      </span><span>// Allows the user to reveal the app bar if they begin scrolling</span><span>
      </span><span>// back up the list of items.</span><span>
      floating</span><span>:</span><span> </span><span>true</span><span>,</span><span>
      </span><span>// Display a placeholder widget to visualize the shrinking size.</span><span>
      flexibleSpace</span><span>:</span><span> </span><span>Placeholder</span><span>(),</span><span>
      </span><span>// Make the initial height of the SliverAppBar larger than normal.</span><span>
      expandedHeight</span><span>:</span><span> </span><span>200</span><span>,</span><span>
    </span><span>),</span><span>
  </span><span>],</span><span>
</span><span>)</span>
```

### 3\. Add a list of items using a `SliverList`

Now that you have the app bar in place, add a list of items to the `CustomScrollView`. You have two options: a [`SliverList`](https://api.flutter.dev/flutter/widgets/SliverList-class.html) or a [`SliverGrid`](https://api.flutter.dev/flutter/widgets/SliverGrid-class.html). If you need to display a list of items one after the other, use the `SliverList` widget. If you need to display a grid list, use the `SliverGrid` widget.

The `SliverList` and `SliverGrid` widgets take one required parameter: a [`SliverChildDelegate`](https://api.flutter.dev/flutter/widgets/SliverChildDelegate-class.html), which provides a list of widgets to `SliverList` or `SliverGrid`. For example, the [`SliverChildBuilderDelegate`](https://api.flutter.dev/flutter/widgets/SliverChildBuilderDelegate-class.html) allows you to create a list of items that are built lazily as you scroll, just like the `ListView.builder` widget.

```
<span>// Next, create a SliverList</span><span>
</span><span>SliverList</span><span>(</span><span>
  </span><span>// Use a delegate to build items as they're scrolled on screen.</span><span>
  delegate</span><span>:</span><span> </span><span>SliverChildBuilderDelegate</span><span>(</span><span>
    </span><span>// The builder function returns a ListTile with a title that</span><span>
    </span><span>// displays the index of the current item.</span><span>
    </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>ListTile</span><span>(</span><span>title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Item #$index'</span><span>)),</span><span>
    </span><span>// Builds 1000 ListTiles</span><span>
    childCount</span><span>:</span><span> </span><span>1000</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

## Interactive example