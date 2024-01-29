1.  [UI](https://docs.flutter.dev/ui)
2.  [Layout](https://docs.flutter.dev/ui/layout)

The core of Flutter’s layout mechanism is widgets. In Flutter, almost everything is a widget—even layout models are widgets. The images, icons, and text that you see in a Flutter app are all widgets. But things you don’t see are also widgets, such as the rows, columns, and grids that arrange, constrain, and align the visible widgets.

You create a layout by composing widgets to build more complex widgets. For example, the first screenshot below shows 3 icons with a label under each one:

![Sample layout](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes-icons.png) ![Sample layout with visual debugging](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes-icons-visual.png)

The second screenshot displays the visual layout, showing a row of 3 columns where each column contains an icon and a label.

Here’s a diagram of the widget tree for this UI:

![Node tree](https://docs.flutter.dev/assets/images/docs/ui/layout/sample-flutter-layout.png)

Most of this should look as you might expect, but you might be wondering about the containers (shown in pink). [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) is a widget class that allows you to customize its child widget. Use a `Container` when you want to add padding, margins, borders, or background color, to name some of its capabilities.

In this example, each [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget is placed in a `Container` to add margins. The entire [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) is also placed in a `Container` to add padding around the row.

The rest of the UI in this example is controlled by properties. Set an [`Icon`](https://api.flutter.dev/flutter/material/Icons-class.html)’s color using its `color` property. Use the `Text.style` property to set the font, its color, weight, and so on. Columns and rows have properties that allow you to specify how their children are aligned vertically or horizontally, and how much space the children should occupy.

How do you lay out a single widget in Flutter? This section shows you how to create and display a simple widget. It also shows the entire code for a simple Hello World app.

In Flutter, it takes only a few steps to put text, an icon, or an image on the screen.

### 1\. Select a layout widget

Choose from a variety of [layout widgets](https://docs.flutter.dev/ui/widgets/layout) based on how you want to align or constrain the visible widget, as these characteristics are typically passed on to the contained widget.

This example uses [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html) which centers its content horizontally and vertically.

### 2\. Create a visible widget

For example, create a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget:

Create an [`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html) widget:

```
<span>return</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>
  image</span><span>,</span><span>
  fit</span><span>:</span><span> </span><span>BoxFit</span><span>.</span><span>cover</span><span>,</span><span>
</span><span>);</span>
```

Create an [`Icon`](https://api.flutter.dev/flutter/material/Icons-class.html) widget:

```
<span>Icon</span><span>(</span><span>
  </span><span>Icons</span><span>.</span><span>star</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>500</span><span>],</span><span>
</span><span>),</span>
```

### 3\. Add the visible widget to the layout widget

All layout widgets have either of the following:

-   A `child` property if they take a single child—for example, `Center` or `Container`
-   A `children` property if they take a list of widgets—for example, `Row`, `Column`, `ListView`, or `Stack`.

Add the `Text` widget to the `Center` widget:

```
<span>const</span><span> </span><span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Hello World'</span><span>),</span><span>
</span><span>),</span>
```

### 4\. Add the layout widget to the page

A Flutter app is itself a widget, and most widgets have a [`build()`](https://api.flutter.dev/flutter/widgets/StatelessWidget/build.html) method. Instantiating and returning a widget in the app’s `build()` method displays the widget.

#### Material apps

For a `Material` app, you can use a [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) widget; it provides a default banner, background color, and has API for adding drawers, snack bars, and bottom sheets. Then you can add the `Center` widget directly to the `body` property for the home page.

```
<span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>const</span><span> </span><span>String</span><span> appTitle </span><span>=</span><span> </span><span>'Flutter layout demo'</span><span>;</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> appTitle</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>appTitle</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Hello World'</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

#### Cupertino apps

To create a `Cupertino` app, use `CupertinoApp` and [`CupertinoPageScaffold`](https://api.flutter.dev/flutter/cupertino/CupertinoPageScaffold-class.html) widgets.

Unlike `Material`, it doesn’t provide a default banner or background color. You need to set these yourself.

-   To set default colors, pass in a configured [`CupertinoThemeData`](https://api.flutter.dev/flutter/cupertino/CupertinoThemeData-class.html) to your app’s `theme` property.
-   To add an iOS-styled navigation bar to the top of your app, add a [`CupertinoNavigationBar`](https://api.flutter.dev/flutter/cupertino/CupertinoNavigationBar-class.html) widget to the `navigationBar` property of your scaffold. You can use the colors that [`CupertinoColors`](https://api.flutter.dev/flutter/cupertino/CupertinoColors-class.html) provides to configure your widgets to match iOS design.
    
-   To layout the body of your app, set the `child` property of your scaffold with the desired widget as its value, like `Center` or `Column`.

To learn what other UI components you can add, check out the [Cupertino library](https://api.flutter.dev/flutter/cupertino/cupertino-library.html).

```
<span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>CupertinoApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Flutter layout demo'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>CupertinoThemeData</span><span>(</span><span>
        brightness</span><span>:</span><span> </span><span>Brightness</span><span>.</span><span>light</span><span>,</span><span>
        primaryColor</span><span>:</span><span> </span><span>CupertinoColors</span><span>.</span><span>systemBlue</span><span>,</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>CupertinoPageScaffold</span><span>(</span><span>
        navigationBar</span><span>:</span><span> </span><span>CupertinoNavigationBar</span><span>(</span><span>
          backgroundColor</span><span>:</span><span> </span><span>CupertinoColors</span><span>.</span><span>systemGrey</span><span>,</span><span>
          middle</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Flutter layout demo'</span><span>),</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
            mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
            children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
              </span><span>Text</span><span>(</span><span>'Hello World'</span><span>),</span><span>
            </span><span>],</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

#### Non-Material apps

For a non-Material app, you can add the `Center` widget to the app’s `build()` method:

```
<span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Container</span><span>(</span><span>
      decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxDecoration</span><span>(</span><span>color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'Hello World'</span><span>,</span><span>
          textDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
          style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
            fontSize</span><span>:</span><span> </span><span>32</span><span>,</span><span>
            color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black87</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

By default a non-Material app doesn’t include an `AppBar`, title, or background color. If you want these features in a non-Material app, you have to build them yourself. This app changes the background color to white and the text to dark grey to mimic a Material app.

![Hello World](https://docs.flutter.dev/assets/images/docs/ui/layout/hello-world.png)

___

One of the most common layout patterns is to arrange widgets vertically or horizontally. You can use a `Row` widget to arrange widgets horizontally, and a `Column` widget to arrange widgets vertically.

To create a row or column in Flutter, you add a list of children widgets to a [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) or [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) widget. In turn, each child can itself be a row or column, and so on. The following example shows how it is possible to nest rows or columns inside of rows or columns.

This layout is organized as a `Row`. The row contains two children: a column on the left, and an image on the right:

![Screenshot with callouts showing the row containing two children](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-diagram.png)

The left column’s widget tree nests rows and columns.

![Diagram showing a left column broken down to its sub-rows and sub-columns](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-left-column-diagram.png)

You’ll implement some of Pavlova’s layout code in [Nesting rows and columns](https://docs.flutter.dev/ui/layout#nesting-rows-and-columns).

### Aligning widgets

You control how a row or column aligns its children using the `mainAxisAlignment` and `crossAxisAlignment` properties. For a row, the main axis runs horizontally and the cross axis runs vertically. For a column, the main axis runs vertically and the cross axis runs horizontally.

![Diagram showing the main axis and cross axis for a row](https://docs.flutter.dev/assets/images/docs/ui/layout/row-diagram.png) ![Diagram showing the main axis and cross axis for a column](https://docs.flutter.dev/assets/images/docs/ui/layout/column-diagram.png)

The [`MainAxisAlignment`](https://api.flutter.dev/flutter/rendering/MainAxisAlignment.html) and [`CrossAxisAlignment`](https://api.flutter.dev/flutter/rendering/CrossAxisAlignment.html) enums offer a variety of constants for controlling alignment.

In the following example, each of the 3 images is 100 pixels wide. The render box (in this case, the entire screen) is more than 300 pixels wide, so setting the main axis alignment to `spaceEvenly` divides the free horizontal space evenly between, before, and after each image.

```
<span><span>Row</span></span><span>(</span><span>
  mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>spaceEvenly</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic1.jpg'</span><span>),</span><span>
    </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic2.jpg'</span><span>),</span><span>
    </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic3.jpg'</span><span>),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

Columns work the same way as rows. The following example shows a column of 3 images, each is 100 pixels high. The height of the render box (in this case, the entire screen) is more than 300 pixels, so setting the main axis alignment to `spaceEvenly` divides the free vertical space evenly between, above, and below each image.

```
<span><span>Column</span></span><span>(</span><span>
  mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>spaceEvenly</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic1.jpg'</span><span>),</span><span>
    </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic2.jpg'</span><span>),</span><span>
    </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic3.jpg'</span><span>),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

**App source:** [row\_column](https://github.com/flutter/website/tree/main/examples/layout/row_column)

![Column showing 3 images spaced evenly](https://docs.flutter.dev/assets/images/docs/ui/layout/column-visual.png)

### Sizing widgets

When a layout is too large to fit a device, a yellow and black striped pattern appears along the affected edge. Here is an [example](https://github.com/flutter/website/tree/main/examples/layout/sizing) of a row that is too wide:

![Overly-wide row](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-too-large.png)

Widgets can be sized to fit within a row or column by using the [`Expanded`](https://api.flutter.dev/flutter/widgets/Expanded-class.html) widget. To fix the previous example where the row of images is too wide for its render box, wrap each image with an `Expanded` widget.

```
<span>Row</span><span>(</span><span>
  crossAxisAlignment</span><span>:</span><span> </span><span>CrossAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span><span>Expanded</span></span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic1.jpg'</span><span>),</span><span>
    </span><span>),</span><span>
    </span><span><span>Expanded</span></span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic2.jpg'</span><span>),</span><span>
    </span><span>),</span><span>
    </span><span><span>Expanded</span></span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic3.jpg'</span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

Perhaps you want a widget to occupy twice as much space as its siblings. For this, use the `Expanded` widget `flex` property, an integer that determines the flex factor for a widget. The default flex factor is 1. The following code sets the flex factor of the middle image to 2:

```
<span>Row</span><span>(</span><span>
  crossAxisAlignment</span><span>:</span><span> </span><span>CrossAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Expanded</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic1.jpg'</span><span>),</span><span>
    </span><span>),</span><span>
    </span><span>Expanded</span><span>(</span><span>
      </span><span><span>flex</span><span>:</span><span> </span><span>2</span><span>,</span></span><span>
      child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic2.jpg'</span><span>),</span><span>
    </span><span>),</span><span>
    </span><span>Expanded</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic3.jpg'</span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

### Packing widgets

By default, a row or column occupies as much space along its main axis as possible, but if you want to pack the children closely together, set its `mainAxisSize` to `MainAxisSize.min`. The following example uses this property to pack the star icons together.

```
<span>Row</span><span>(</span><span>
  </span><span><span>mainAxisSize</span><span>:</span><span> </span><span>MainAxisSize</span><span>.</span><span>min</span><span>,</span></span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
    </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>),</span><span>
    </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>),</span><span>
  </span><span>],</span><span>
</span><span>)</span>
```

### Nesting rows and columns

The layout framework allows you to nest rows and columns inside of rows and columns as deeply as you need. Let’s look at the code for the outlined section of the following layout:

![Screenshot of the pavlova app, with the ratings and icon rows outlined in red](https://docs.flutter.dev/assets/images/docs/ui/layout/pavlova-large-annotated.png)

The outlined section is implemented as two rows. The ratings row contains five stars and the number of reviews. The icons row contains three columns of icons and text.

The widget tree for the ratings row:

![Ratings row widget tree](https://docs.flutter.dev/assets/images/docs/ui/layout/widget-tree-pavlova-rating-row.png)

The `ratings` variable creates a row containing a smaller row of 5 star icons, and text:

```
<span>final</span><span> stars </span><span>=</span><span> </span><span>Row</span><span>(</span><span>
  mainAxisSize</span><span>:</span><span> </span><span>MainAxisSize</span><span>.</span><span>min</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
    </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
    </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>),</span><span>
    </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>),</span><span>
  </span><span>],</span><span>
</span><span>);</span><span>

</span><span>final</span><span> </span><span><span>ratings</span></span><span> </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>20</span><span>),</span><span>
  child</span><span>:</span><span> </span><span>Row</span><span>(</span><span>
    mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>spaceEvenly</span><span>,</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      stars</span><span>,</span><span>
      </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'170 Reviews'</span><span>,</span><span>
        style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>,</span><span>
          fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w800</span><span>,</span><span>
          fontFamily</span><span>:</span><span> </span><span>'Roboto'</span><span>,</span><span>
          letterSpacing</span><span>:</span><span> </span><span>0.5</span><span>,</span><span>
          fontSize</span><span>:</span><span> </span><span>20</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

The icons row, below the ratings row, contains 3 columns; each column contains an icon and two lines of text, as you can see in its widget tree:

![Icon widget tree](https://docs.flutter.dev/assets/images/docs/ui/layout/widget-tree-pavlova-icon-row.png)

The `iconList` variable defines the icons row:

```
<span>const</span><span> descTextStyle </span><span>=</span><span> </span><span>TextStyle</span><span>(</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>,</span><span>
  fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w800</span><span>,</span><span>
  fontFamily</span><span>:</span><span> </span><span>'Roboto'</span><span>,</span><span>
  letterSpacing</span><span>:</span><span> </span><span>0.5</span><span>,</span><span>
  fontSize</span><span>:</span><span> </span><span>18</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>2</span><span>,</span><span>
</span><span>);</span><span>

</span><span>// DefaultTextStyle.merge() allows you to create a default text</span><span>
</span><span>// style that is inherited by its child and all subsequent children.</span><span>
</span><span>final</span><span> </span><span><span>iconList</span></span><span> </span><span>=</span><span> </span><span>DefaultTextStyle</span><span>.</span><span>merge</span><span>(</span><span>
  style</span><span>:</span><span> descTextStyle</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>20</span><span>),</span><span>
    child</span><span>:</span><span> </span><span>Row</span><span>(</span><span>
      mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>spaceEvenly</span><span>,</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        </span><span>Column</span><span>(</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>kitchen</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'PREP:'</span><span>),</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'25 min'</span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
        </span><span>Column</span><span>(</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>timer</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'COOK:'</span><span>),</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'1 hr'</span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
        </span><span>Column</span><span>(</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>restaurant</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>[</span><span>500</span><span>]),</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'FEEDS:'</span><span>),</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'4-6'</span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

The `leftColumn` variable contains the ratings and icons rows, as well as the title and text that describes the Pavlova:

```
<span>final</span><span> </span><span><span>leftColumn</span></span><span> </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>fromLTRB</span><span>(</span><span>20</span><span>,</span><span> </span><span>30</span><span>,</span><span> </span><span>20</span><span>,</span><span> </span><span>20</span><span>),</span><span>
  child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      titleText</span><span>,</span><span>
      subTitle</span><span>,</span><span>
      ratings</span><span>,</span><span>
      iconList</span><span>,</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

The left column is placed in a `SizedBox` to constrain its width. Finally, the UI is constructed with the entire row (containing the left column and the image) inside a `Card`.

The [Pavlova image](https://pixabay.com/en/photos/pavlova) is from [Pixabay](https://pixabay.com/en/photos/pavlova). You can embed an image from the net using `Image.network()` but, for this example, the image is saved to an images directory in the project, added to the [pubspec file](https://github.com/flutter/website/tree/main/examples/layout/pavlova/pubspec.yaml), and accessed using `Images.asset()`. For more information, see [Adding assets and images](https://docs.flutter.dev/ui/assets/assets-and-images).

```
<span>body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    margin</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>fromLTRB</span><span>(</span><span>0</span><span>,</span><span> </span><span>40</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>30</span><span>),</span><span>
    height</span><span>:</span><span> </span><span>600</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Card</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Row</span><span>(</span><span>
        crossAxisAlignment</span><span>:</span><span> </span><span>CrossAxisAlignment</span><span>.</span><span>start</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>SizedBox</span><span>(</span><span>
            width</span><span>:</span><span> </span><span>440</span><span>,</span><span>
            child</span><span>:</span><span> leftColumn</span><span>,</span><span>
          </span><span>),</span><span>
          mainImage</span><span>,</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

**App source:** [pavlova](https://github.com/flutter/website/tree/main/examples/layout/pavlova)

___

Flutter has a rich library of layout widgets. Here are a few of those most commonly used. The intent is to get you up and running as quickly as possible, rather than overwhelm you with a complete list. For information on other available widgets, refer to the [Widget catalog](https://docs.flutter.dev/ui/widgets), or use the Search box in the [API reference docs](https://api.flutter.dev/flutter). Also, the widget pages in the API docs often make suggestions about similar widgets that might better suit your needs.

The following widgets fall into two categories: standard widgets from the [widgets library](https://api.flutter.dev/flutter/widgets/widgets-library.html), and specialized widgets from the [Material library](https://api.flutter.dev/flutter/material/material-library.html). Any app can use the widgets library but only Material apps can use the Material Components library.

### Standard widgets

-   [`Container`](https://docs.flutter.dev/ui/layout#container): Adds padding, margins, borders, background color, or other decorations to a widget.
-   [`GridView`](https://docs.flutter.dev/ui/layout#gridview): Lays widgets out as a scrollable grid.
-   [`ListView`](https://docs.flutter.dev/ui/layout#listview): Lays widgets out as a scrollable list.
-   [`Stack`](https://docs.flutter.dev/ui/layout#stack): Overlaps a widget on top of another.

### Material widgets

-   [`Card`](https://docs.flutter.dev/ui/layout#card): Organizes related info into a box with rounded corners and a drop shadow.
-   [`ListTile`](https://docs.flutter.dev/ui/layout#listtile): Organizes up to 3 lines of text, and optional leading and trailing icons, into a row.

### Container

Many layouts make liberal use of [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html)s to separate widgets using padding, or to add borders or margins. You can change the device’s background by placing the entire layout into a `Container` and changing its background color or image.

#### Summary (Container)

-   Add padding, margins, borders
-   Change background color or image
-   Contains a single child widget, but that child can be a Row, Column, or even the root of a widget tree

![Diagram showing: margin, border, padding, and content](https://docs.flutter.dev/assets/images/docs/ui/layout/margin-padding-border.png)

#### Examples (Container)

This layout consists of a column with two rows, each containing 2 images. A [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) is used to change the background color of the column to a lighter grey.

```
<span>Widget</span><span> _buildImageColumn</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span><span>Container</span></span><span>(</span><span>
    decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxDecoration</span><span>(</span><span>
      color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black26</span><span>,</span><span>
    </span><span>),</span><span>
    child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        _buildImageRow</span><span>(</span><span>1</span><span>),</span><span>
        _buildImageRow</span><span>(</span><span>3</span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

![Screenshot showing 2 rows, each containing 2 images](https://docs.flutter.dev/assets/images/docs/ui/layout/container.png)

A `Container` is also used to add a rounded border and margins to each image:

```
<span>Widget</span><span> _buildDecoratedImage</span><span>(</span><span>int</span><span> imageIndex</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Expanded</span><span>(</span><span>
      child</span><span>:</span><span> </span><span><span>Container</span></span><span>(</span><span>
        decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          border</span><span>:</span><span> </span><span>Border</span><span>.</span><span>all</span><span>(</span><span>width</span><span>:</span><span> </span><span>10</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black38</span><span>),</span><span>
          borderRadius</span><span>:</span><span> </span><span>const</span><span> </span><span>BorderRadius</span><span>.</span><span>all</span><span>(</span><span>Radius</span><span>.</span><span>circular</span><span>(</span><span>8</span><span>)),</span><span>
        </span><span>),</span><span>
        margin</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>4</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic$imageIndex.jpg'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>

</span><span>Widget</span><span> _buildImageRow</span><span>(</span><span>int</span><span> imageIndex</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Row</span><span>(</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        _buildDecoratedImage</span><span>(</span><span>imageIndex</span><span>),</span><span>
        _buildDecoratedImage</span><span>(</span><span>imageIndex </span><span>+</span><span> </span><span>1</span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>);</span>
```

You can find more `Container` examples in the [tutorial](https://docs.flutter.dev/ui/layout/tutorial) and the Flutter Gallery ([running app](https://gallery.flutter.dev/), [repo](https://github.com/flutter/gallery/tree/main)).

**App source:** [container](https://github.com/flutter/website/tree/main/examples/layout/container)

___

### GridView

Use [`GridView`](https://api.flutter.dev/flutter/widgets/GridView-class.html) to lay widgets out as a two-dimensional list. `GridView` provides two pre-fabricated lists, or you can build your own custom grid. When a `GridView` detects that its contents are too long to fit the render box, it automatically scrolls.

#### Summary (GridView)

-   Lays widgets out in a grid
-   Detects when the column content exceeds the render box and automatically provides scrolling
-   Build your own custom grid, or use one of the provided grids:
    -   `GridView.count` allows you to specify the number of columns
    -   `GridView.extent` allows you to specify the maximum pixel width of a tile

#### Examples (GridView)

![A 3-column grid of photos](https://docs.flutter.dev/assets/images/docs/ui/layout/gridview-extent.png)

Uses `GridView.extent` to create a grid with tiles a maximum 150 pixels wide.

**App source:** [grid\_and\_list](https://github.com/flutter/website/tree/main/examples/layout/grid_and_list)

![A 2 column grid with footers](https://docs.flutter.dev/assets/images/docs/ui/layout/gridview-count-flutter-gallery.png)

Uses `GridView.count` to create a grid that’s 2 tiles wide in portrait mode, and 3 tiles wide in landscape mode. The titles are created by setting the `footer` property for each [`GridTile`](https://api.flutter.dev/flutter/material/GridTile-class.html).

**Dart code:** [grid\_list\_demo.dart](https://github.com/flutter/gallery/tree/main/lib/demos/material/grid_list_demo.dart) from the [Flutter Gallery](https://github.com/flutter/gallery/tree/main)

```
<span>Widget</span><span> _buildGrid</span><span>()</span><span> </span><span>=&gt;</span><span> </span><span><span>GridView</span></span><span>.</span><span>extent</span><span>(</span><span>
    maxCrossAxisExtent</span><span>:</span><span> </span><span>150</span><span>,</span><span>
    padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>4</span><span>),</span><span>
    mainAxisSpacing</span><span>:</span><span> </span><span>4</span><span>,</span><span>
    crossAxisSpacing</span><span>:</span><span> </span><span>4</span><span>,</span><span>
    children</span><span>:</span><span> _buildGridTileList</span><span>(</span><span>30</span><span>));</span><span>

</span><span>// The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.</span><span>
</span><span>// The List.generate() constructor allows an easy way to create</span><span>
</span><span>// a list when objects have a predictable naming pattern.</span><span>
</span><span>List</span><span>&lt;</span><span>Container</span><span>&gt;</span><span> _buildGridTileList</span><span>(</span><span>int</span><span> count</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>List</span><span>.</span><span>generate</span><span>(</span><span>
    count</span><span>,</span><span> </span><span>(</span><span>i</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Container</span><span>(</span><span>child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>'images/pic$i.jpg'</span><span>)));</span>
```

___

### ListView

[`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html), a column-like widget, automatically provides scrolling when its content is too long for its render box.

#### Summary (ListView)

-   A specialized [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) for organizing a list of boxes
-   Can be laid out horizontally or vertically
-   Detects when its content won’t fit and provides scrolling
-   Less configurable than `Column`, but easier to use and supports scrolling

#### Examples (ListView)

![ListView containing movie theaters and restaurants](https://docs.flutter.dev/assets/images/docs/ui/layout/listview.png)

Uses `ListView` to display a list of businesses using `ListTile`s. A `Divider` separates the theaters from the restaurants.

**App source:** [grid\_and\_list](https://github.com/flutter/website/tree/main/examples/layout/grid_and_list)

```
<span>Widget</span><span> _buildList</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span><span>ListView</span></span><span>(</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      _tile</span><span>(</span><span>'CineArts at the Empire'</span><span>,</span><span> </span><span>'85 W Portal Ave'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>theaters</span><span>),</span><span>
      _tile</span><span>(</span><span>'The Castro Theater'</span><span>,</span><span> </span><span>'429 Castro St'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>theaters</span><span>),</span><span>
      _tile</span><span>(</span><span>'Alamo Drafthouse Cinema'</span><span>,</span><span> </span><span>'2550 Mission St'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>theaters</span><span>),</span><span>
      _tile</span><span>(</span><span>'Roxie Theater'</span><span>,</span><span> </span><span>'3117 16th St'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>theaters</span><span>),</span><span>
      _tile</span><span>(</span><span>'United Artists Stonestown Twin'</span><span>,</span><span> </span><span>'501 Buckingham Way'</span><span>,</span><span>
          </span><span>Icons</span><span>.</span><span>theaters</span><span>),</span><span>
      _tile</span><span>(</span><span>'AMC Metreon 16'</span><span>,</span><span> </span><span>'135 4th St #3000'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>theaters</span><span>),</span><span>
      </span><span>const</span><span> </span><span>Divider</span><span>(),</span><span>
      _tile</span><span>(</span><span>'K\'s Kitchen'</span><span>,</span><span> </span><span>'757 Monterey Blvd'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>restaurant</span><span>),</span><span>
      _tile</span><span>(</span><span>'Emmy\'s Restaurant'</span><span>,</span><span> </span><span>'1923 Ocean Ave'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>restaurant</span><span>),</span><span>
      _tile</span><span>(</span><span>'Chaiya Thai Restaurant'</span><span>,</span><span> </span><span>'272 Claremont Blvd'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>restaurant</span><span>),</span><span>
      _tile</span><span>(</span><span>'La Ciccia'</span><span>,</span><span> </span><span>'291 30th St'</span><span>,</span><span> </span><span>Icons</span><span>.</span><span>restaurant</span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span><span>

</span><span>ListTile</span><span> _tile</span><span>(</span><span>String</span><span> title</span><span>,</span><span> </span><span>String</span><span> subtitle</span><span>,</span><span> </span><span>IconData</span><span> icon</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
    title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>title</span><span>,</span><span>
        style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>
          fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w500</span><span>,</span><span>
          fontSize</span><span>:</span><span> </span><span>20</span><span>,</span><span>
        </span><span>)),</span><span>
    subtitle</span><span>:</span><span> </span><span>Text</span><span>(</span><span>subtitle</span><span>),</span><span>
    leading</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>
      icon</span><span>,</span><span>
      color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>[</span><span>500</span><span>],</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

___

### Stack

Use [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html) to arrange widgets on top of a base widget—often an image. The widgets can completely or partially overlap the base widget.

#### Summary (Stack)

-   Use for widgets that overlap another widget
-   The first widget in the list of children is the base widget; subsequent children are overlaid on top of that base widget
-   A `Stack`’s content can’t scroll
-   You can choose to clip children that exceed the render box

#### Examples (Stack)

![Circular avatar image with a label](https://docs.flutter.dev/assets/images/docs/ui/layout/stack.png)

Uses `Stack` to overlay a `Container` (that displays its `Text` on a translucent black background) on top of a `CircleAvatar`. The `Stack` offsets the text using the `alignment` property and `Alignment`s.

**App source:** [card\_and\_stack](https://github.com/flutter/website/tree/main/examples/layout/card_and_stack)

```
<span>Widget</span><span> _buildStack</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span><span>Stack</span></span><span>(</span><span>
    alignment</span><span>:</span><span> </span><span>const</span><span> </span><span>Alignment</span><span>(</span><span>0.6</span><span>,</span><span> </span><span>0.6</span><span>),</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      </span><span>const</span><span> </span><span>CircleAvatar</span><span>(</span><span>
        backgroundImage</span><span>:</span><span> </span><span>AssetImage</span><span>(</span><span>'images/pic.jpg'</span><span>),</span><span>
        radius</span><span>:</span><span> </span><span>100</span><span>,</span><span>
      </span><span>),</span><span>
      </span><span>Container</span><span>(</span><span>
        decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black45</span><span>,</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'Mia B'</span><span>,</span><span>
          style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
            fontSize</span><span>:</span><span> </span><span>20</span><span>,</span><span>
            fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span>
            color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

___

### Card

A [`Card`](https://api.flutter.dev/flutter/material/Card-class.html), from the [Material library](https://api.flutter.dev/flutter/material/material-library.html), contains related nuggets of information and can be composed from almost any widget, but is often used with [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html). `Card` has a single child, but its child can be a column, row, list, grid, or other widget that supports multiple children. By default, a `Card` shrinks its size to 0 by 0 pixels. You can use [`SizedBox`](https://api.flutter.dev/flutter/widgets/SizedBox-class.html) to constrain the size of a card.

In Flutter, a `Card` features slightly rounded corners and a drop shadow, giving it a 3D effect. Changing a `Card`’s `elevation` property allows you to control the drop shadow effect. Setting the elevation to 24, for example, visually lifts the `Card` further from the surface and causes the shadow to become more dispersed. For a list of supported elevation values, see [Elevation](https://m3.material.io/styles/elevation) in the [Material guidelines](https://m3.material.io/styles). Specifying an unsupported value disables the drop shadow entirely.

#### Summary (Card)

-   Implements a [Material card](https://m3.material.io/components/cards)
-   Used for presenting related nuggets of information
-   Accepts a single child, but that child can be a `Row`, `Column`, or other widget that holds a list of children
-   Displayed with rounded corners and a drop shadow
-   A `Card`’s content can’t scroll
-   From the [Material library](https://api.flutter.dev/flutter/material/material-library.html)

#### Examples (Card)

![Card containing 3 ListTiles](https://docs.flutter.dev/assets/images/docs/ui/layout/card.png)

A `Card` containing 3 ListTiles and sized by wrapping it with a `SizedBox`. A `Divider` separates the first and second `ListTiles`.

**App source:** [card\_and\_stack](https://github.com/flutter/website/tree/main/examples/layout/card_and_stack)

```
<span>Widget</span><span> _buildCard</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>SizedBox</span><span>(</span><span>
    height</span><span>:</span><span> </span><span>210</span><span>,</span><span>
    child</span><span>:</span><span> </span><span><span>Card</span></span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>ListTile</span><span>(</span><span>
            title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
              </span><span>'1625 Main Street'</span><span>,</span><span>
              style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w500</span><span>),</span><span>
            </span><span>),</span><span>
            subtitle</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'My City, CA 99984'</span><span>),</span><span>
            leading</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>
              </span><span>Icons</span><span>.</span><span>restaurant_menu</span><span>,</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>[</span><span>500</span><span>],</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
          </span><span>const</span><span> </span><span>Divider</span><span>(),</span><span>
          </span><span>ListTile</span><span>(</span><span>
            title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
              </span><span>'(408) 555-1212'</span><span>,</span><span>
              style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w500</span><span>),</span><span>
            </span><span>),</span><span>
            leading</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>
              </span><span>Icons</span><span>.</span><span>contact_phone</span><span>,</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>[</span><span>500</span><span>],</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
          </span><span>ListTile</span><span>(</span><span>
            title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'costa@example.com'</span><span>),</span><span>
            leading</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>
              </span><span>Icons</span><span>.</span><span>contact_mail</span><span>,</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>[</span><span>500</span><span>],</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

___

### ListTile

Use [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html), a specialized row widget from the [Material library](https://api.flutter.dev/flutter/material/material-library.html), for an easy way to create a row containing up to 3 lines of text and optional leading and trailing icons. `ListTile` is most commonly used in [`Card`](https://api.flutter.dev/flutter/material/Card-class.html) or [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html), but can be used elsewhere.

#### Summary (ListTile)

-   A specialized row that contains up to 3 lines of text and optional icons
-   Less configurable than `Row`, but easier to use
-   From the [Material library](https://api.flutter.dev/flutter/material/material-library.html)

#### Examples (ListTile)

___

## Constraints

To fully understand Flutter’s layout system, you need to learn how Flutter positions and sizes the components in a layout. For more information, see [Understanding constraints](https://docs.flutter.dev/ui/layout/constraints).

## Videos

The following videos, part of the [Flutter in Focus](https://www.youtube.com/watch?v=wgTBLj7rMPM&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2) series, explain `Stateless` and `Stateful` widgets.

<iframe width="560" height="315" src="https://www.youtube.com/embed/wE7khGHVkYY?rel=0&amp;enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to create stateless widgets" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" id="187657252" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe><iframe width="560" height="315" src="https://www.youtube.com/embed/AqCMFXEmf3w?rel=0&amp;enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn the best times to use stateful widgets" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="682473288" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

[Flutter in Focus playlist](https://www.youtube.com/playlist?list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2)

___

Each episode of the [Widget of the Week series](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG) focuses on a widget. Several of them includes layout widgets.

<iframe width="560" height="315" src="https://www.youtube.com/embed/b_sQ9bMltGU?rel=0&amp;enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Watch the Widget of the Week playlist" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="949386648" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

[Flutter Widget of the Week playlist](https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG)

## Other resources

The following resources might help when writing layout code.

-   [Layout tutorial](https://docs.flutter.dev/ui/layout/tutorial)
    
    Learn how to build a layout.
    
-   [Widget catalog](https://docs.flutter.dev/ui/widgets)
    
    Describes many of the widgets available in Flutter.
    
-   [HTML/CSS Analogs in Flutter](https://docs.flutter.dev/get-started/flutter-for/web-devs)
    
    For those familiar with web programming, this page maps HTML/CSS functionality to Flutter features.
    
-   Flutter Gallery [running app](https://gallery.flutter.dev/), [repo](https://github.com/flutter/gallery/tree/main)
    
    Demo app showcasing many Material Design widgets and other Flutter features.
    
-   [API reference docs](https://api.flutter.dev/flutter)
    
    Reference documentation for all of the Flutter libraries.
    
-   [Adding assets and images](https://docs.flutter.dev/ui/assets/assets-and-images)
    
    Explains how to add images and other assets to your app’s package.
    
-   [Zero to One with Flutter](https://medium.com/@mravn/zero-to-one-with-flutter-43b13fd7b354)
    
    One person’s experience writing his first Flutter app.