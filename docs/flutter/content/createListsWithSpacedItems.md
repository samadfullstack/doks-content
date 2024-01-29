1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Lists](https://docs.flutter.dev/cookbook/lists)
3.  [List with spaced items](https://docs.flutter.dev/cookbook/lists/spaced-items)

Perhaps you want to create a list where all list items are spaced evenly, so that the items take up the visible space. For example, the four items in the following image are spaced evenly, with “Item 0” at the top, and “Item 3” at the bottom.

![Spaced items](https://docs.flutter.dev/assets/images/docs/cookbook/spaced-items-1.png)

At the same time, you might want to allow users to scroll through the list when the list of items won’t fit, maybe because a device is too small, a user resized a window, or the number of items exceeds the screen size.

![Scrollable items](https://docs.flutter.dev/assets/images/docs/cookbook/spaced-items-2.png)

Typically, you use [`Spacer`](https://api.flutter.dev/flutter/widgets/Spacer-class.html) to tune the spacing between widgets, or [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html) to expand a widget to fill the available space. However, these solutions are not possible inside scrollable widgets, because they need a finite height constraint.

This recipe demonstrates how to use [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) and [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html) to space out list items evenly when there is enough space, and to allow users to scroll when there is not enough space, using the following steps:

1.  Add a [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) with a [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html).
2.  Add a [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html) inside the [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html).
3.  Create a [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) with spaced items.

Start by creating a [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html). You need to provide a `builder` callback function with two parameters:

1.  The [`BuildContext`](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) provided by the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html).
2.  The [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html) of the parent widget.

In this recipe, you won’t be using the [`BuildContext`](https://api.flutter.dev/flutter/widgets/BuildContext-class.html), but you will need the [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html) in the next step.

Inside the `builder` function, return a [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html). This widget ensures that the child widget can be scrolled, even when the parent container is too small.

```
<span>LayoutBuilder</span><span>(</span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> constraints</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>SingleChildScrollView</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Placeholder</span><span>(),</span><span>
  </span><span>);</span><span>
</span><span>});</span>
```

In this step, add a [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html) as the child of the [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html).

The [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html) widget imposes aditional constraints to its child.

Configure the constraint by setting the `minHeight` parameter to be the `maxHeight` of the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) constraints.

This ensures that the child widget is constrained to have a minimum height equal to the available space provided by the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) constraints, namely the maximum height of the [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html).

```
<span>LayoutBuilder</span><span>(</span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> constraints</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>SingleChildScrollView</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>ConstrainedBox</span><span>(</span><span>
      constraints</span><span>:</span><span> </span><span>BoxConstraints</span><span>(</span><span>minHeight</span><span>:</span><span> constraints</span><span>.</span><span>maxHeight</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Placeholder</span><span>(),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>});</span>
```

However, you don’t set the `maxHeight` parameter, because you need to allow the child to be larger than the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) size, in case the items don’t fit the screen.

## 3\. Create a `Column` with spaced items

Finally, add a [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) as the child of the [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html).

To space the items evenly, set the `mainAxisAlignment` to `MainAxisAlignment.spaceBetween`.

```
<span>LayoutBuilder</span><span>(</span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> constraints</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>SingleChildScrollView</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>ConstrainedBox</span><span>(</span><span>
      constraints</span><span>:</span><span> </span><span>BoxConstraints</span><span>(</span><span>minHeight</span><span>:</span><span> constraints</span><span>.</span><span>maxHeight</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>spaceBetween</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>ItemWidget</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Item 1'</span><span>),</span><span>
          </span><span>ItemWidget</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Item 2'</span><span>),</span><span>
          </span><span>ItemWidget</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Item 3'</span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>});</span>
```

Alternatively, you can use the [`Spacer`](https://api.flutter.dev/flutter/widgets/Spacer-class.html) widget to tune the spacing between the items, or the [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html) widget, if you want one widget to take more space than others.

For that, you have to wrap the [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) with an [`IntrinsicHeight`](https://api.flutter.dev/flutter/widgets/IntrinsicHeight-class.html) widget, which forces the [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) widget to size itself to a minimum height, instead of expanding infinitely.

```
<span>LayoutBuilder</span><span>(</span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> constraints</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>SingleChildScrollView</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>ConstrainedBox</span><span>(</span><span>
      constraints</span><span>:</span><span> </span><span>BoxConstraints</span><span>(</span><span>minHeight</span><span>:</span><span> constraints</span><span>.</span><span>maxHeight</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>IntrinsicHeight</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>ItemWidget</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Item 1'</span><span>),</span><span>
            </span><span>Spacer</span><span>(),</span><span>
            </span><span>ItemWidget</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Item 2'</span><span>),</span><span>
            </span><span>Expanded</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>ItemWidget</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Item 3'</span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>});</span>
```

## Interactive example

This example shows a list of items that are spaced evenly within a column. The list can be scrolled up and down when the items don’t fit the screen. The number of items is defined by the variable `items`, change this value to see what happens when the items won’t fit the screen.