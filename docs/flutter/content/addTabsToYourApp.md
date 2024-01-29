1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Design](https://docs.flutter.dev/cookbook/design)
3.  [Work with tabs](https://docs.flutter.dev/cookbook/design/tabs)

Working with tabs is a common pattern in apps that follow the Material Design guidelines. Flutter includes a convenient way to create tab layouts as part of the [material library](https://api.flutter.dev/flutter/material/material-library.html).

This recipe creates a tabbed example using the following steps;

1.  Create a `TabController`.
2.  Create the tabs.
3.  Create content for each tab.

## 1\. Create a `TabController`

For tabs to work, you need to keep the selected tab and content sections in sync. This is the job of the [`TabController`](https://api.flutter.dev/flutter/material/TabController-class.html).

Either create a `TabController` manually, or automatically by using a [`DefaultTabController`](https://api.flutter.dev/flutter/material/DefaultTabController-class.html) widget.

Using `DefaultTabController` is the simplest option, since it creates a `TabController` and makes it available to all descendant widgets.

```
<span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
  home</span><span>:</span><span> </span><span>DefaultTabController</span><span>(</span><span>
    length</span><span>:</span><span> </span><span>3</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Scaffold</span><span>(),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## 2\. Create the tabs

When a tab is selected, it needs to display content. You can create tabs using the [`TabBar`](https://api.flutter.dev/flutter/material/TabBar-class.html) widget. In this example, create a `TabBar` with three [`Tab`](https://api.flutter.dev/flutter/material/Tab-class.html) widgets and place it within an [`AppBar`](https://api.flutter.dev/flutter/material/AppBar-class.html).

```
<span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
  home</span><span>:</span><span> </span><span>DefaultTabController</span><span>(</span><span>
    length</span><span>:</span><span> </span><span>3</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        bottom</span><span>:</span><span> </span><span>const</span><span> </span><span>TabBar</span><span>(</span><span>
          tabs</span><span>:</span><span> </span><span>[</span><span>
            </span><span>Tab</span><span>(</span><span>icon</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>directions_car</span><span>)),</span><span>
            </span><span>Tab</span><span>(</span><span>icon</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>directions_transit</span><span>)),</span><span>
            </span><span>Tab</span><span>(</span><span>icon</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>directions_bike</span><span>)),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

By default, the `TabBar` looks up the widget tree for the nearest `DefaultTabController`. If you’re manually creating a `TabController`, pass it to the `TabBar`.

## 3\. Create content for each tab

Now that you have tabs, display content when a tab is selected. For this purpose, use the [`TabBarView`](https://api.flutter.dev/flutter/material/TabBarView-class.html) widget.

```
<span>body</span><span>:</span><span> </span><span>const</span><span> </span><span>TabBarView</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>directions_car</span><span>),</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>directions_transit</span><span>),</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>directions_bike</span><span>),</span><span>
  </span><span>],</span><span>
</span><span>),</span>
```

## Interactive example