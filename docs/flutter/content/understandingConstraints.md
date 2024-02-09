1.  [UI](https://docs.flutter.dev/ui)
2.  [Layout](https://docs.flutter.dev/ui/layout)
3.  [Understanding constraints](https://docs.flutter.dev/ui/layout/constraints)

![Hero image from the article](https://docs.flutter.dev/assets/images/docs/ui/layout/article-hero-image.png)

When someone learning Flutter asks you why some widget with `width: 100` isn’t 100 pixels wide, the default answer is to tell them to put that widget inside of a `Center`, right?

**Don’t do that.**

If you do, they’ll come back again and again, asking why some `FittedBox` isn’t working, why that `Column` is overflowing, or what `IntrinsicWidth` is supposed to be doing.

Instead, first tell them that Flutter layout is very different from HTML layout (which is probably where they’re coming from), and then make them memorize the following rule:

**Constraints go down. Sizes go up. Parent sets position.**

Flutter layout can’t really be understood without knowing this rule, so Flutter developers should learn it early on.

In more detail:

-   A widget gets its own **constraints** from its **parent**. A _constraint_ is just a set of 4 doubles: a minimum and maximum width, and a minimum and maximum height.
-   Then the widget goes through its own list of **children**. One by one, the widget tells its children what their **constraints** are (which can be different for each child), and then asks each child what size it wants to be.
-   Then, the widget positions its **children** (horizontally in the `x` axis, and vertically in the `y` axis), one by one.
-   And, finally, the widget tells its parent about its own **size** (within the original constraints, of course).

For example, if a composed widget contains a column with some padding, and wants to lay out its two children as follows:

![Visual layout](https://docs.flutter.dev/assets/images/docs/ui/layout/children.png)

The negotiation goes something like this:

**Widget**: “Hey parent, what are my constraints?”

**Parent**: “You must be from `0` to `300` pixels wide, and `0` to `85` tall.”

**Widget**: “Hmmm, since I want to have `5` pixels of padding, then my children can have at most `290` pixels of width and `75` pixels of height.”

**Widget**: “Hey first child, You must be from `0` to `290` pixels wide, and `0` to `75` tall.”

**First child**: “OK, then I wish to be `290` pixels wide, and `20` pixels tall.”

**Widget**: “Hmmm, since I want to put my second child below the first one, this leaves only `55` pixels of height for my second child.”

**Widget**: “Hey second child, You must be from `0` to `290` wide, and `0` to `55` tall.”

**Second child**: “OK, I wish to be `140` pixels wide, and `30` pixels tall.”

**Widget**: “Very well. My first child has position `x: 5` and `y: 5`, and my second child has `x: 80` and `y: 25`.”

**Widget**: “Hey parent, I’ve decided that my size is going to be `300` pixels wide, and `60` pixels tall.”

## Limitations

Flutter’s layout engine is designed to be a one-pass process. This means that Flutter lays out its widgets very efficiently, but does result in a few limitations:

-   A widget can decide its own size only within the constraints given to it by its parent. This means a widget usually **can’t have any size it wants**.
    
-   A widget **can’t know and doesn’t decide its own position in the screen**, since it’s the widget’s parent who decides the position of the widget.
    
-   Since the parent’s size and position, in its turn, also depends on its own parent, it’s impossible to precisely define the size and position of any widget without taking into consideration the tree as a whole.
    
-   If a child wants a different size from its parent and the parent doesn’t have enough information to align it, then the child’s size might be ignored. **Be specific when defining alignment.**
    

In Flutter, widgets are rendered by their underlying [`RenderBox`](https://api.flutter.dev/flutter/rendering/RenderBox-class.html) objects. Many boxes in Flutter, especially those that just take a single child, pass their constraint on to their children.

Generally, there are three kinds of boxes, in terms of how they handle their constraints:

-   Those that try to be as big as possible. For example, the boxes used by [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html) and [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html).
-   Those that try to be the same size as their children. For example, the boxes used by [`Transform`](https://api.flutter.dev/flutter/widgets/Transform-class.html) and [`Opacity`](https://api.flutter.dev/flutter/widgets/Opacity-class.html).
-   Those that try to be a particular size. For example, the boxes used by [`Image`](https://api.flutter.dev/flutter/dart-ui/Image-class.html) and [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html).

Some widgets, for example [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html), vary from type to type based on their constructor arguments. The [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) constructor defaults to trying to be as big as possible, but if you give it a `width`, for instance, it tries to honor that and be that particular size.

Others, for example [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) and [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) (flex boxes) vary based on the constraints they are given, as described in the [Flex](https://docs.flutter.dev/ui/layout/constraints#flex) section.

## Examples

For an interactive experience, use the following DartPad. Use the numbered horizontal scrolling bar to switch between 29 different examples.

If you prefer, you can grab the code from [this GitHub repo](https://github.com/marcglasberg/flutter_layout_article).

The examples are explained in the following sections.

### Example 1

![Example 1 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-1.png)

The screen is the parent of the `Container`, and it forces the `Container` to be exactly the same size as the screen.

So the `Container` fills the screen and paints it red.

### Example 2

![Example 2 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-2.png)

```
<span>Container</span><span>(</span><span>width</span><span>:</span><span> </span><span>100</span><span>,</span><span> height</span><span>:</span><span> </span><span>100</span><span>,</span><span> color</span><span>:</span><span> red</span><span>)</span>
```

The red `Container` wants to be 100 × 100, but it can’t, because the screen forces it to be exactly the same size as the screen.

So the `Container` fills the screen.

### Example 3

![Example 3 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-3.png)

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>width</span><span>:</span><span> </span><span>100</span><span>,</span><span> height</span><span>:</span><span> </span><span>100</span><span>,</span><span> color</span><span>:</span><span> red</span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `Center` to be exactly the same size as the screen, so the `Center` fills the screen.

The `Center` tells the `Container` that it can be any size it wants, but not bigger than the screen. Now the `Container` can indeed be 100 × 100.

### Example 4

![Example 4 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-4.png)

```
<span>Align</span><span>(</span><span>
  alignment</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>bottomRight</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>width</span><span>:</span><span> </span><span>100</span><span>,</span><span> height</span><span>:</span><span> </span><span>100</span><span>,</span><span> color</span><span>:</span><span> red</span><span>),</span><span>
</span><span>)</span>
```

This is different from the previous example in that it uses `Align` instead of `Center`.

`Align` also tells the `Container` that it can be any size it wants, but if there is empty space it won’t center the `Container`. Instead, it aligns the container to the bottom-right of the available space.

### Example 5

![Example 5 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-5.png)

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      width</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span> height</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span> color</span><span>:</span><span> red</span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `Center` to be exactly the same size as the screen, so the `Center` fills the screen.

The `Center` tells the `Container` that it can be any size it wants, but not bigger than the screen. The `Container` wants to be of infinite size, but since it can’t be bigger than the screen, it just fills the screen.

### Example 6

![Example 6 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-6.png)

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `Center` to be exactly the same size as the screen, so the `Center` fills the screen.

The `Center` tells the `Container` that it can be any size it wants, but not bigger than the screen. Since the `Container` has no child and no fixed size, it decides it wants to be as big as possible, so it fills the whole screen.

But why does the `Container` decide that? Simply because that’s a design decision by those who created the `Container` widget. It could have been created differently, and you have to read the [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) API documentation to understand how it behaves, depending on the circumstances.

### Example 7

![Example 7 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-7.png)

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    color</span><span>:</span><span> red</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> green</span><span>,</span><span> width</span><span>:</span><span> </span><span>30</span><span>,</span><span> height</span><span>:</span><span> </span><span>30</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `Center` to be exactly the same size as the screen, so the `Center` fills the screen.

The `Center` tells the red `Container` that it can be any size it wants, but not bigger than the screen. Since the red `Container` has no size but has a child, it decides it wants to be the same size as its child.

The red `Container` tells its child that it can be any size it wants, but not bigger than the screen.

The child is a green `Container` that wants to be 30 × 30. Given that the red `Container` sizes itself to the size of its child, it is also 30 × 30. The red color isn’t visible because the green `Container` entirely covers the red `Container`.

### Example 8

![Example 8 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-8.png)

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>20</span><span>),</span><span>
    color</span><span>:</span><span> red</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> green</span><span>,</span><span> width</span><span>:</span><span> </span><span>30</span><span>,</span><span> height</span><span>:</span><span> </span><span>30</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

The red `Container` sizes itself to its children’s size, but it takes its own padding into consideration. So it is also 30 × 30 plus padding. The red color is visible because of the padding, and the green `Container` has the same size as in the previous example.

### Example 9

![Example 9 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-9.png)

```
<span>ConstrainedBox</span><span>(</span><span>
  constraints</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxConstraints</span><span>(</span><span>
    minWidth</span><span>:</span><span> </span><span>70</span><span>,</span><span>
    minHeight</span><span>:</span><span> </span><span>70</span><span>,</span><span>
    maxWidth</span><span>:</span><span> </span><span>150</span><span>,</span><span>
    maxHeight</span><span>:</span><span> </span><span>150</span><span>,</span><span>
  </span><span>),</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>,</span><span> width</span><span>:</span><span> </span><span>10</span><span>,</span><span> height</span><span>:</span><span> </span><span>10</span><span>),</span><span>
</span><span>)</span>
```

You might guess that the `Container` has to be between 70 and 150 pixels, but you would be wrong. The `ConstrainedBox` only imposes **additional** constraints from those it receives from its parent.

Here, the screen forces the `ConstrainedBox` to be exactly the same size as the screen, so it tells its child `Container` to also assume the size of the screen, thus ignoring its `constraints` parameter.

### Example 10

![Example 10 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-10.png)

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>ConstrainedBox</span><span>(</span><span>
    constraints</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxConstraints</span><span>(</span><span>
      minWidth</span><span>:</span><span> </span><span>70</span><span>,</span><span>
      minHeight</span><span>:</span><span> </span><span>70</span><span>,</span><span>
      maxWidth</span><span>:</span><span> </span><span>150</span><span>,</span><span>
      maxHeight</span><span>:</span><span> </span><span>150</span><span>,</span><span>
    </span><span>),</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>,</span><span> width</span><span>:</span><span> </span><span>10</span><span>,</span><span> height</span><span>:</span><span> </span><span>10</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

Now, `Center` allows `ConstrainedBox` to be any size up to the screen size. The `ConstrainedBox` imposes **additional** constraints from its `constraints` parameter onto its child.

The Container must be between 70 and 150 pixels. It wants to have 10 pixels, so it ends up having 70 (the minimum).

### Example 11

![Example 11 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-11.png)

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>ConstrainedBox</span><span>(</span><span>
    constraints</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxConstraints</span><span>(</span><span>
      minWidth</span><span>:</span><span> </span><span>70</span><span>,</span><span>
      minHeight</span><span>:</span><span> </span><span>70</span><span>,</span><span>
      maxWidth</span><span>:</span><span> </span><span>150</span><span>,</span><span>
      maxHeight</span><span>:</span><span> </span><span>150</span><span>,</span><span>
    </span><span>),</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>,</span><span> width</span><span>:</span><span> </span><span>1000</span><span>,</span><span> height</span><span>:</span><span> </span><span>1000</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

`Center` allows `ConstrainedBox` to be any size up to the screen size. The `ConstrainedBox` imposes **additional** constraints from its `constraints` parameter onto its child.

The `Container` must be between 70 and 150 pixels. It wants to have 1000 pixels, so it ends up having 150 (the maximum).

### Example 12

![Example 12 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-12.png)

```
<span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>ConstrainedBox</span><span>(</span><span>
    constraints</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxConstraints</span><span>(</span><span>
      minWidth</span><span>:</span><span> </span><span>70</span><span>,</span><span>
      minHeight</span><span>:</span><span> </span><span>70</span><span>,</span><span>
      maxWidth</span><span>:</span><span> </span><span>150</span><span>,</span><span>
      maxHeight</span><span>:</span><span> </span><span>150</span><span>,</span><span>
    </span><span>),</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>,</span><span> width</span><span>:</span><span> </span><span>100</span><span>,</span><span> height</span><span>:</span><span> </span><span>100</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

`Center` allows `ConstrainedBox` to be any size up to the screen size. The `ConstrainedBox` imposes **additional** constraints from its `constraints` parameter onto its child.

The `Container` must be between 70 and 150 pixels. It wants to have 100 pixels, and that’s the size it has, since that’s between 70 and 150.

### Example 13

![Example 13 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-13.png)

```
<span>UnconstrainedBox</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>,</span><span> width</span><span>:</span><span> </span><span>20</span><span>,</span><span> height</span><span>:</span><span> </span><span>50</span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `UnconstrainedBox` to be exactly the same size as the screen. However, the `UnconstrainedBox` lets its child `Container` be any size it wants.

### Example 14

![Example 14 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-14.png)

```
<span>UnconstrainedBox</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>,</span><span> width</span><span>:</span><span> </span><span>4000</span><span>,</span><span> height</span><span>:</span><span> </span><span>50</span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `UnconstrainedBox` to be exactly the same size as the screen, and `UnconstrainedBox` lets its child `Container` be any size it wants.

Unfortunately, in this case the `Container` is 4000 pixels wide and is too big to fit in the `UnconstrainedBox`, so the `UnconstrainedBox` displays the much dreaded “overflow warning”.

### Example 15

![Example 15 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-15.png)

```
<span>OverflowBox</span><span>(</span><span>
  minWidth</span><span>:</span><span> </span><span>0</span><span>,</span><span>
  minHeight</span><span>:</span><span> </span><span>0</span><span>,</span><span>
  maxWidth</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span>
  maxHeight</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>,</span><span> width</span><span>:</span><span> </span><span>4000</span><span>,</span><span> height</span><span>:</span><span> </span><span>50</span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `OverflowBox` to be exactly the same size as the screen, and `OverflowBox` lets its child `Container` be any size it wants.

`OverflowBox` is similar to `UnconstrainedBox`; the difference is that it won’t display any warnings if the child doesn’t fit the space.

In this case, the `Container` has 4000 pixels of width, and is too big to fit in the `OverflowBox`, but the `OverflowBox` simply shows as much as it can, with no warnings given.

### Example 16

![Example 16 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-16.png)

```
<span>UnconstrainedBox</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>,</span><span> width</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span> height</span><span>:</span><span> </span><span>100</span><span>),</span><span>
</span><span>)</span>
```

This won’t render anything, and you’ll see an error in the console.

The `UnconstrainedBox` lets its child be any size it wants, however its child is a `Container` with infinite size.

Flutter can’t render infinite sizes, so it throws an error with the following message: `BoxConstraints forces an infinite width.`

### Example 17

![Example 17 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-17.png)

```
<span>UnconstrainedBox</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>LimitedBox</span><span>(</span><span>
    maxWidth</span><span>:</span><span> </span><span>100</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>,</span><span>
      width</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span>
      height</span><span>:</span><span> </span><span>100</span><span>,</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

Here you won’t get an error anymore, because when the `LimitedBox` is given an infinite size by the `UnconstrainedBox`; it passes a maximum width of 100 down to its child.

If you swap the `UnconstrainedBox` for a `Center` widget, the `LimitedBox` won’t apply its limit anymore (since its limit is only applied when it gets infinite constraints), and the width of the `Container` is allowed to grow past 100.

This explains the difference between a `LimitedBox` and a `ConstrainedBox`.

### Example 18

![Example 18 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-18.png)

```
<span>const</span><span> </span><span>FittedBox</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Some Example Text.'</span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `FittedBox` to be exactly the same size as the screen. The `Text` has some natural width (also called its intrinsic width) that depends on the amount of text, its font size, and so on.

The `FittedBox` lets the `Text` be any size it wants, but after the `Text` tells its size to the `FittedBox`, the `FittedBox` scales the Text until it fills all of the available width.

### Example 19

![Example 19 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-19.png)

```
<span>const</span><span> </span><span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>FittedBox</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Some Example Text.'</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

But what happens if you put the `FittedBox` inside of a `Center` widget? The `Center` lets the `FittedBox` be any size it wants, up to the screen size.

The `FittedBox` then sizes itself to the `Text`, and lets the `Text` be any size it wants. Since both `FittedBox` and the `Text` have the same size, no scaling happens.

### Example 20

![Example 20 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-20.png)

```
<span>const</span><span> </span><span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>FittedBox</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'This is some very very very large text that is too big to fit a regular screen in a single line.'</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

However, what happens if `FittedBox` is inside of a `Center` widget, but the `Text` is too large to fit the screen?

`FittedBox` tries to size itself to the `Text`, but it can’t be bigger than the screen. It then assumes the screen size, and resizes `Text` so that it fits the screen, too.

### Example 21

![Example 21 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-21.png)

```
<span>const</span><span> </span><span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
      </span><span>'This is some very very very large text that is too big to fit a regular screen in a single line.'</span><span>),</span><span>
</span><span>)</span>
```

If, however, you remove the `FittedBox`, the `Text` gets its maximum width from the screen, and breaks the line so that it fits the screen.

### Example 22

![Example 22 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-22.png)

```
<span>FittedBox</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    height</span><span>:</span><span> </span><span>20</span><span>,</span><span>
    width</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span>
    color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

`FittedBox` can only scale a widget that is bounded (has non-infinite width and height). Otherwise, it won’t render anything, and you’ll see an error in the console.

### Example 23

![Example 23 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-23.png)

```
<span>Row</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> red</span><span>,</span><span> child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Hello!'</span><span>,</span><span> style</span><span>:</span><span> big</span><span>)),</span><span>
    </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> green</span><span>,</span><span> child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Goodbye!'</span><span>,</span><span> style</span><span>:</span><span> big</span><span>)),</span><span>
  </span><span>],</span><span>
</span><span>)</span>
```

The screen forces the `Row` to be exactly the same size as the screen.

Just like an `UnconstrainedBox`, the `Row` won’t impose any constraints onto its children, and instead lets them be any size they want. The `Row` then puts them side-by-side, and any extra space remains empty.

### Example 24

![Example 24 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-24.png)

```
<span>Row</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Container</span><span>(</span><span>
      color</span><span>:</span><span> red</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'This is a very long text that '</span><span>
        </span><span>'won\'t fit the line.'</span><span>,</span><span>
        style</span><span>:</span><span> big</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
    </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> green</span><span>,</span><span> child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Goodbye!'</span><span>,</span><span> style</span><span>:</span><span> big</span><span>)),</span><span>
  </span><span>],</span><span>
</span><span>)</span>
```

Since `Row` won’t impose any constraints onto its children, it’s quite possible that the children might be too big to fit the available width of the `Row`. In this case, just like an `UnconstrainedBox`, the `Row` displays the “overflow warning”.

### Example 25

![Example 25 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-25.png)

```
<span>Row</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Expanded</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
          color</span><span>:</span><span> red</span><span>,</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
            </span><span>'This is a very long text that won\'t fit the line.'</span><span>,</span><span>
            style</span><span>:</span><span> big</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
    </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> green</span><span>,</span><span> child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Goodbye!'</span><span>,</span><span> style</span><span>:</span><span> big</span><span>)),</span><span>
  </span><span>],</span><span>
</span><span>)</span>
```

When a `Row`’s child is wrapped in an `Expanded` widget, the `Row` won’t let this child define its own width anymore.

Instead, it defines the `Expanded` width according to the other children, and only then the `Expanded` widget forces the original child to have the `Expanded`’s width.

In other words, once you use `Expanded`, the original child’s width becomes irrelevant, and is ignored.

### Example 26

![Example 26 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-26.png)

```
<span>Row</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Expanded</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        color</span><span>:</span><span> red</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'This is a very long text that won\'t fit the line.'</span><span>,</span><span>
          style</span><span>:</span><span> big</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
    </span><span>Expanded</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        color</span><span>:</span><span> green</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'Goodbye!'</span><span>,</span><span>
          style</span><span>:</span><span> big</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>],</span><span>
</span><span>)</span>
```

If all of `Row`’s children are wrapped in `Expanded` widgets, each `Expanded` has a size proportional to its flex parameter, and only then each `Expanded` widget forces its child to have the `Expanded`’s width.

In other words, `Expanded` ignores the preferred width of its children.

### Example 27

![Example 27 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-27.png)

```
<span>Row</span><span>(</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Flexible</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        color</span><span>:</span><span> red</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'This is a very long text that won\'t fit the line.'</span><span>,</span><span>
          style</span><span>:</span><span> big</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
    </span><span>Flexible</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        color</span><span>:</span><span> green</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'Goodbye!'</span><span>,</span><span>
          style</span><span>:</span><span> big</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>],</span><span>
</span><span>)</span>
```

The only difference if you use `Flexible` instead of `Expanded`, is that `Flexible` lets its child have the same or smaller width than the `Flexible` itself, while `Expanded` forces its child to have the exact same width of the `Expanded`. But both `Expanded` and `Flexible` ignore their children’s width when sizing themselves.

### Example 28

![Example 28 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-28.png)

```
<span>Scaffold</span><span>(</span><span>
  body</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    color</span><span>:</span><span> blue</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>const</span><span> </span><span>Column</span><span>(</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        </span><span>Text</span><span>(</span><span>'Hello!'</span><span>),</span><span>
        </span><span>Text</span><span>(</span><span>'Goodbye!'</span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

The screen forces the `Scaffold` to be exactly the same size as the screen, so the `Scaffold` fills the screen. The `Scaffold` tells the `Container` that it can be any size it wants, but not bigger than the screen.

### Example 29

![Example 29 layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-29.png)

```
<span>Scaffold</span><span>(</span><span>
  body</span><span>:</span><span> </span><span>SizedBox</span><span>.</span><span>expand</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      color</span><span>:</span><span> blue</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Column</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>Text</span><span>(</span><span>'Hello!'</span><span>),</span><span>
          </span><span>Text</span><span>(</span><span>'Goodbye!'</span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

If you want the `Scaffold`’s child to be exactly the same size as the `Scaffold` itself, you can wrap its child with `SizedBox.expand`.

## Tight vs loose constraints

It’s very common to hear that some constraint is “tight” or “loose”, so what does that mean?

### Tight constraints

A _tight_ constraint offers a single possibility, an exact size. In other words, a tight constraint has its maximum width equal to its minimum width; and has its maximum height equal to its minimum height.

An example of this is the `App` widget, which is contained by the [`RenderView`](https://api.flutter.dev/flutter/rendering/RenderView-class.html) class: the box used by the child returned by the application’s [`build`](https://api.flutter.dev/flutter/widgets/State/build.html) function is given a constraint that forces it to exactly fill the application’s content area (typically, the entire screen).

Another example: if you nest a bunch of boxes inside each other at the root of your application’s render tree, they’ll all exactly fit in each other, forced by the box’s tight constraints.

If you go to Flutter’s `box.dart` file and search for the `BoxConstraints` constructors, you’ll find the following:

```
<span>BoxConstraints</span><span>.</span><span>tight</span><span>(</span><span>Size</span> <span>size</span><span>)</span>
   <span>:</span> <span>minWidth</span> <span>=</span> <span>size</span><span>.</span><span>width</span><span>,</span>
     <span>maxWidth</span> <span>=</span> <span>size</span><span>.</span><span>width</span><span>,</span>
     <span>minHeight</span> <span>=</span> <span>size</span><span>.</span><span>height</span><span>,</span>
     <span>maxHeight</span> <span>=</span> <span>size</span><span>.</span><span>height</span><span>;</span>
```

If you revisit [Example 2](https://docs.flutter.dev/ui/layout/constraints#example-2), the screen forces the red `Container` to be exactly the same size as the screen. The screen achieves that, of course, by passing tight constraints to the `Container`.

### Loose constraints

A _loose_ constraint is one that has a minimum of zero and a maximum non-zero.

Some boxes _loosen_ the incoming constraints, meaning the maximum is maintained but the minimum is removed, so the widget can have a **minimum** width and height both equal to **zero**.

Ultimately, `Center`’s purpose is to transform the tight constraints it received from its parent (the screen) to loose constraints for its child (the `Container`).

If you revisit [Example 3](https://docs.flutter.dev/ui/layout/constraints#example-3), the `Center` allows the red `Container` to be smaller, but not bigger than the screen.

## Unbounded constraints

In certain situations, a box’s constraint is _unbounded_, or infinite. This means that either the maximum width or the maximum height is set to [`double.infinity`](https://api.flutter.dev/flutter/dart-core/double/infinity-constant.html).

A box that tries to be as big as possible won’t function usefully when given an unbounded constraint and, in debug mode, throws an exception.

The most common case where a render box ends up with an unbounded constraint is within a flex box ([`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) or [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)), and **within a scrollable region** (such as [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) and other [`ScrollView`](https://api.flutter.dev/flutter/widgets/ScrollView-class.html) subclasses).

[`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html), for example, tries to expand to fit the space available in its cross-direction (perhaps it’s a vertically-scrolling block and tries to be as wide as its parent). If you nest a vertically scrolling [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) inside a horizontally scrolling `ListView`, the inner list tries to be as wide as possible, which is infinitely wide, since the outer one is scrollable in that direction.

The next section describes the error you might encounter with unbounded constraints in a `Flex` widget.

## Flex

A flex box ([`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) and [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html)) behaves differently depending on whether its constraint is bounded or unbounded in its primary direction.

A flex box with a bounded constraint in its primary direction tries to be as big as possible.

A flex box with an unbounded constraint in its primary direction tries to fit its children in that space. Each child’s `flex` value must be set to zero, meaning that you can’t use [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html) when the flex box is inside another flex box or a scrollable; otherwise it throws an exception.

The _cross_ direction (width for [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) or height for [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html)), must _never_ be unbounded, or it can’t reasonably align its children.

Knowing the general layout rule is necessary, but it’s not enough.

Each widget has a lot of freedom when applying the general rule, so there is no way of knowing how it behaves by just reading the widget’s name.

If you try to guess, you’ll probably guess wrong. You can’t know exactly how a widget behaves unless you’ve read its documentation, or studied its source-code.

The layout source-code is usually complex, so it’s probably better to just read the documentation. However, if you decide to study the layout source-code, you can easily find it by using the navigating capabilities of your IDE.

Here’s an example:

-   Find a `Column` in your code and navigate to its source code. To do this, use `command+B` (macOS) or `control+B` (Windows/Linux) in Android Studio or IntelliJ. You’ll be taken to the `basic.dart` file. Since `Column` extends `Flex`, navigate to the `Flex` source code (also in `basic.dart`).
    
-   Scroll down until you find a method called `createRenderObject()`. As you can see, this method returns a `RenderFlex`. This is the render-object for the `Column`. Now navigate to the source-code of `RenderFlex`, which takes you to the `flex.dart` file.
    
-   Scroll down until you find a method called `performLayout()`. This is the method that does the layout for the `Column`.
    

![A goodbye layout](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-final.png)

___

Original article by Marcelo Glasberg

Marcelo originally published this content as [Flutter: The Advanced Layout Rule Even Beginners Must Know](https://medium.com/flutter-community/flutter-the-advanced-layout-rule-even-beginners-must-know-edc9516d1a2) on Medium. We loved it and asked that he allow us to publish in on docs.flutter.dev, to which he graciously agreed. Thanks, Marcelo! You can find Marcelo on [GitHub](https://github.com/marcglasberg) and [pub.dev](https://pub.dev/publishers/glasberg.dev/packages).

Also, thanks to [Simon Lightfoot](https://github.com/slightfoot) for creating the header image at the top of the article.