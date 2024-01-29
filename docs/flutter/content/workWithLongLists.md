1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Lists](https://docs.flutter.dev/cookbook/lists)
3.  [Work with long lists](https://docs.flutter.dev/cookbook/lists/long-lists)

The standard [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) constructor works well for small lists. To work with lists that contain a large number of items, it’s best to use the [`ListView.builder`](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html) constructor.

In contrast to the default `ListView` constructor, which requires creating all items at once, the `ListView.builder()` constructor creates items as they’re scrolled onto the screen.

## 1\. Create a data source

First, you need a data source. For example, your data source might be a list of messages, search results, or products in a store. Most of the time, this data comes from the internet or a database.

For this example, generate a list of 10,000 Strings using the [`List.generate`](https://api.flutter.dev/flutter/dart-core/List/List.generate.html) constructor.

```
<span>List</span><span>&lt;</span><span>String</span><span>&gt;.</span><span>generate</span><span>(</span><span>10000</span><span>,</span><span> </span><span>(</span><span>i</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>'Item $i'</span><span>),</span>
```

To display the list of strings, render each String as a widget using `ListView.builder()`. In this example, display each String on its own line.

```
<span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
  itemCount</span><span>:</span><span> items</span><span>.</span><span>length</span><span>,</span><span>
  prototypeItem</span><span>:</span><span> </span><span>ListTile</span><span>(</span><span>
    title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>items</span><span>.</span><span>first</span><span>),</span><span>
  </span><span>),</span><span>
  itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>items</span><span>[</span><span>index</span><span>]),</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
</span><span>)</span>
```

## Interactive example

## Children’s extent

To specify each item’s extent, you can use either `itemExtent` or `prototypeItem`. Specifying either is more efficient than letting the children determine their own extent because the scrolling machinery can make use of the foreknowledge of the children’s extent to save work, for example when the scroll position changes drastically.