1.  [UI](https://docs.flutter.dev/ui)
2.  [Layout](https://docs.flutter.dev/ui/layout)
3.  [Layout tutorial](https://docs.flutter.dev/ui/layout/tutorial)

This tutorial explains how to design and build layouts in Flutter.

If you use the example code provided, you can build the following app.

![The finished app.](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-demo-app.png)

The finished app.

Photo by [Dino Reichmuth](https://unsplash.com/photos/red-and-gray-tents-in-grass-covered-mountain-5Rhl-kSRydQ) on [Unsplash](https://unsplash.com/). Text by [Switzerland Tourism](https://www.myswitzerland.com/en-us/destinations/lake-oeschinen).

To get a better overview of the layout mechanism, start with [Flutter’s approach to layout](https://docs.flutter.dev/ui/layout).

## Diagram the layout

In this section, consider what type of user experience you want for your app users.

Consider how to position the components of your user interface. A layout consists of the total end result of these positionings. Consider planning your layout to speed up your coding. Using visual cues to know where something goes on screen can be a great help.

Use whichever method you prefer, like an interface design tool or a pencil and a sheet of paper. Figure out where you want to place elements on your screen before writing code. It’s the programming version of the adage: “Measure twice, cut once.”

1.  Ask these questions to break the layout down to its basic elements.
    
    -   Can you identify the rows and columns?
    -   Does the layout include a grid?
    -   Are there overlapping elements?
    -   Does the UI need tabs?
    -   What do you need to align, pad, or border?
2.  Identify the larger elements. In this example, you arrange the image, title, buttons, and description into a column.
    
    ![Major elements in the layout: image, row, row, and text block](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-sketch-intro.svg)
    
    Major elements in the layout: image, row, row, and text block
    
3.  Diagram each row.
    
    1.  Row 1, the **Title** section, has three children: a column of text, a star icon, and a number. Its first child, the column, contains two lines of text. That first column might need more space.
        
        ![Title section with text blocks and an icon](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-sketch-title-block.svg)
        
        Title section with text blocks and an icon
        
    2.  Row 2, the **Button** section, has three children: each child contains a column which then contains an icon and text.
        
        ![The Button section with three labeled buttons](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-sketch-button-block.svg)
        
        The Button section with three labeled buttons
        

After diagramming the layout, consider how you would code it.

Would you write all the code in one class? Or, would you create one class for each part of the layout?

To follow Flutter best practices, create one class, or Widget, to contain each part of your layout. When Flutter needs to re-render part of a UI, it updates the smallest part that changes. This is why Flutter makes “everything a widget”. If the only the text changes in a `Text` widget, Flutter redraws only that text. Flutter changes the least amount of the UI possible in response to user input.

For this tutorial, write each element you have identified as its own widget.

## Create the app base code

In this section, shell out the basic Flutter app code to start your app.

1.  [Set up your Flutter environment](https://docs.flutter.dev/get-started/install).
    
2.  [Create a new Flutter app](https://docs.flutter.dev/get-started/test-drive).
    
3.  Replace the contents of `lib/main.dart` with the following code. This app uses a parameter for the app title and the title shown on the app’s `appBar`. This decision simplifies the code.
    
    ```
    <span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
    
    </span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
    
    </span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
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
    

## Add the Title section

In this section, create a `TitleSection` widget that resembles the following layout.

![The Title section as sketch and prototype UI](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-sketch-title-block-unlabeled.svg)

The Title section as sketch and prototype UI

### Add the `TitleSection` Widget

Add the following code after the `MyApp` class.

```
<span>class</span><span> </span><span>TitleSection</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>TitleSection</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>name</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>location</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> name</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> location</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>32</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Row</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>Expanded</span><span>(</span><span>
            </span><span>/*1*/</span><span>
            child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
              crossAxisAlignment</span><span>:</span><span> </span><span>CrossAxisAlignment</span><span>.</span><span>start</span><span>,</span><span>
              children</span><span>:</span><span> </span><span>[</span><span>
                </span><span>/*2*/</span><span>
                </span><span>Padding</span><span>(</span><span>
                  padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>only</span><span>(</span><span>bottom</span><span>:</span><span> </span><span>8</span><span>),</span><span>
                  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
                    name</span><span>,</span><span>
                    style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>
                      fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span>
                    </span><span>),</span><span>
                  </span><span>),</span><span>
                </span><span>),</span><span>
                </span><span>Text</span><span>(</span><span>
                  location</span><span>,</span><span>
                  style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
                    color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>500</span><span>],</span><span>
                  </span><span>),</span><span>
                </span><span>),</span><span>
              </span><span>],</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
          </span><span>/*3*/</span><span>
          </span><span>Icon</span><span>(</span><span>
            </span><span>Icons</span><span>.</span><span>star</span><span>,</span><span>
            color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>500</span><span>],</span><span>
          </span><span>),</span><span>
          </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'41'</span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

1.  To use all remaining free space in the row, use the `Expanded` widget to stretch the `Column` widget. To place the column at the start of the row, set the `crossAxisAlignment` property to `CrossAxisAlignment.start`.
2.  To add space between the rows of text, put those rows in a `Padding` widget.
3.  The title row ends with a red star icon and the text `41`. The entire row falls inside a `Padding` widget and pads each edge by 32 pixels.

### Change the app body to a scrolling view

In the `body` property, replace the `Center` widget with a `SingleChildScrollView` widget. Within the [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html) widget, replace the `Text` widget with a `Column` widget.

<table><tbody><tr><td></td><td><p>@@ -21,2 +17,3 @@</p></td></tr><tr><td><p>21</p></td><td><p><span>-</span> <span>body: <span>const</span> <del>Center</del>(</span></p></td></tr><tr><td><p>22</p></td><td><p><span>-</span> <span>child: <del>Text</del>(<del><span>'Hello World'</span>),</del></span></p></td></tr><tr><td><p>17</p></td><td><p><span>+</span> <span>body: <span>const</span> <ins>SingleChildScrollView</ins>(</span></p></td></tr><tr><td><p>18</p></td><td><p><span>+</span> <span>child: <ins>Column</ins>(</span></p></td></tr><tr><td><p>19</p></td><td><p><span>+</span> <span>children: [</span></p></td></tr></tbody></table>

These code updates change the app in the following ways.

-   A `SingleChildScrollView` widget can scroll. This allows elements that don’t fit on the current screen to display.
-   A `Column` widget displays any elements within its `children` property in the order listed. The first element listed in the `children` list displays at the top of the list. Elements in the `children` list display in array order on the screen from top to bottom.

### Update the app to display the title section

Add the `TitleSection` widget as the first element in the `children` list. This places it at the top of the screen. Pass the provided name and location to the `TitleSection` constructor.

<table><tbody><tr><td></td><td><p>@@ -23 +19,6 @@</p></td></tr><tr><td><p>19</p></td><td><p><span>+</span> <span>children: [</span></p></td></tr><tr><td><p>20</p></td><td><p><span>+</span> <span>TitleSection(</span></p></td></tr><tr><td><p>21</p></td><td><p><span>+</span> <span>name: <span>'Oeschinen Lake Campground'</span>,</span></p></td></tr><tr><td><p>22</p></td><td><p><span>+</span> <span>location: <span>'Kandersteg, Switzerland'</span>,</span></p></td></tr><tr><td><p>23</p></td><td><p><span>+</span> <span>),</span></p></td></tr><tr><td><p>24</p></td><td><p><span>+</span> <span>],</span></p></td></tr></tbody></table>

## Add the Button section

In this section, add the buttons that will add functionality to your app.

The **Button** section contains three columns that use the same layout: an icon over a row of text.

![The Button section as sketch and prototype UI](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-sketch-button-block-unlabeled.svg)

The Button section as sketch and prototype UI

Plan to distribute these columns in one row so each takes the same amount of space. Paint all text and icons with the primary color.

### Add the `ButtonSection` widget

Add the following code after the `TitleSection` widget to contain the code to build the row of buttons.

```
<span>class</span><span> </span><span>ButtonSection</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ButtonSection</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>Color</span><span> color </span><span>=</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>primaryColor</span><span>;</span><span>
</span><span>// ···</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Create a widget to make buttons

As the code for each column could use the same syntax, create a widget named `ButtonWithText`. The widget’s constructor accepts a color, icon data, and a label for the button. Using these values, the widget builds a `Column` with an `Icon` and a stylized `Text` widget as its children. To help separate these children, a `Padding` widget the `Text` widget is wrapped with a `Padding` widget.

Add the following code after the `ButtonSection` class.

```
<span>class</span><span> </span><span>ButtonSection</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ButtonSection</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
</span><span>// ···</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>ButtonWithText</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ButtonWithText</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>color</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>icon</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>label</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>Color</span><span> color</span><span>;</span><span>
  </span><span>final</span><span> </span><span>IconData</span><span> icon</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> label</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Column</span><span>(</span><span>
      mainAxisSize</span><span>:</span><span> </span><span>MainAxisSize</span><span>.</span><span>min</span><span>,</span><span>
      mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        </span><span>Icon</span><span>(</span><span>icon</span><span>,</span><span> color</span><span>:</span><span> color</span><span>),</span><span>
        </span><span>Padding</span><span>(</span><span>
          padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>only</span><span>(</span><span>top</span><span>:</span><span> </span><span>8</span><span>),</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
            label</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
              fontSize</span><span>:</span><span> </span><span>12</span><span>,</span><span>
              fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w400</span><span>,</span><span>
              color</span><span>:</span><span> color</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span>
```

### Position the buttons with a `Row` widget

Add the following code into the `ButtonSection` widget.

1.  Add three instances of the `ButtonWithText` widget, once for each button.
2.  Pass the color, `Icon`, and text for that specific button.
3.  Align the columns along the main axis with the `MainAxisAlignment.spaceEvenly` value. The main axis for a `Row` widget is horizontal and the main axis for a `Column` widget is vertical. This value, then, tells Flutter to arrange the free space in equal amounts before, between, and after each column along the `Row`.

```
<span>class</span><span> </span><span>ButtonSection</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ButtonSection</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>Color</span><span> color </span><span>=</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>primaryColor</span><span>;</span><span>
    </span><span>return</span><span> </span><span>SizedBox</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Row</span><span>(</span><span>
        mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>spaceEvenly</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>ButtonWithText</span><span>(</span><span>
            color</span><span>:</span><span> color</span><span>,</span><span>
            icon</span><span>:</span><span> </span><span>Icons</span><span>.</span><span>call</span><span>,</span><span>
            label</span><span>:</span><span> </span><span>'CALL'</span><span>,</span><span>
          </span><span>),</span><span>
          </span><span>ButtonWithText</span><span>(</span><span>
            color</span><span>:</span><span> color</span><span>,</span><span>
            icon</span><span>:</span><span> </span><span>Icons</span><span>.</span><span>near_me</span><span>,</span><span>
            label</span><span>:</span><span> </span><span>'ROUTE'</span><span>,</span><span>
          </span><span>),</span><span>
          </span><span>ButtonWithText</span><span>(</span><span>
            color</span><span>:</span><span> color</span><span>,</span><span>
            icon</span><span>:</span><span> </span><span>Icons</span><span>.</span><span>share</span><span>,</span><span>
            label</span><span>:</span><span> </span><span>'SHARE'</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>ButtonWithText</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ButtonWithText</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>color</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>icon</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>label</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>Color</span><span> color</span><span>;</span><span>
  </span><span>final</span><span> </span><span>IconData</span><span> icon</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> label</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Column</span><span>(</span><span>
</span><span>// ···</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Update the app to display the button section

Add the button section to the `children` list.

<table><tbody><tr><td></td><td><p>@@ -5,6 +5,7 @@</p></td></tr><tr><td><p>5</p><p>5</p></td><td><p><span>&nbsp;</span> <span>name: <span>'Oeschinen Lake Campground'</span>,</span></p></td></tr><tr><td><p>6</p><p>6</p></td><td><p><span>&nbsp;</span> <span>location: <span>'Kandersteg, Switzerland'</span>,</span></p></td></tr><tr><td><p>7</p><p>7</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr><tr><td><p>8</p></td><td><p><span>+</span> <span><span>ButtonSection</span>(),</span></p></td></tr><tr><td><p>8</p><p>9</p></td><td><p><span>&nbsp;</span> <span>],</span></p></td></tr><tr><td><p>9</p><p>10</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr><tr><td><p>10</p><p>11</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr></tbody></table>

## Add the Text section

In this section, add the text description to this app.

![The text block as sketch and prototype UI](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-sketch-add-text-block.svg)

The text block as sketch and prototype UI

### Add the `TextSection` widget

Add the following code as a separate widget after the `ButtonSection` widget.

```
<span>class</span><span> </span><span>TextSection</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>TextSection</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>description</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> description</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>32</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        description</span><span>,</span><span>
        softWrap</span><span>:</span><span> </span><span>true</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

By setting [`softWrap`](https://api.flutter.dev/flutter/widgets/Text/softWrap.html) to `true`, text lines fill the column width before wrapping at a word boundary.

### Update the app to display the text section

Add a new `TextSection` widget as a child after the `ButtonSection`. When adding the `TextSection` widget, set its `description` property to the text of the location description.

<table><tbody><tr><td></td><td><p>@@ -6,6 +6,16 @@</p></td></tr><tr><td><p>6</p><p>6</p></td><td><p><span>&nbsp;</span> <span>location: <span>'Kandersteg, Switzerland'</span>,</span></p></td></tr><tr><td><p>7</p><p>7</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr><tr><td><p>8</p><p>8</p></td><td><p><span>&nbsp;</span> <span><span>ButtonSection</span>(),</span></p></td></tr><tr><td><p>9</p></td><td><p><span>+</span> <span>TextSection(</span></p></td></tr><tr><td><p>10</p></td><td><p><span>+</span> <span><span>description</span>:<span></span></span></p></td></tr><tr><td><p>11</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>12</p></td><td><p><span>+</span> <span><span>'Bernese Alps. Situated 1,578 meters above sea level, it '</span></span></p></td></tr><tr><td><p>13</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>14</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>15</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>16</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>17</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>18</p></td><td><p><span>+</span> <span>),</span></p></td></tr><tr><td><p>9</p><p>19</p></td><td><p><span>&nbsp;</span> <span>],</span></p></td></tr><tr><td><p>10</p><p>20</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr><tr><td><p>11</p><p>21</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr></tbody></table>

## Add the Image section

In this section, add the image file to complete your layout.

### Configure your app to use supplied images

To configure your app to reference images, modify its `pubspec.yaml` file.

1.  Create an `images` directory at the top of the project.
    
2.  Download the [`lake.jpg`](https://docs.flutter.dev/ui/layout/%3Chttps://raw.githubusercontent.com/flutter/website/main/examples%3E/layout/lakes/step5/images/lake.jpg) image and add it to the new `images` directory.
    
3.  To include images, add an `assets` tag to the `pubspec.yaml` file at the root directory of your app. When you add `assets`, it serves as the set of pointers to the images available to your code.
    
    <table><tbody><tr><td></td><td><p>@@ -19,3 +19,5 @@</p></td></tr><tr><td><p>19</p><p>19</p></td><td><p><span>&nbsp;</span> <span><span>flutter:</span></span></p></td></tr><tr><td><p>20</p><p>20</p></td><td><p><span>&nbsp;</span> <span><span>uses-material-design:</span> <span>true</span></span></p></td></tr><tr><td><p>21</p></td><td><p><span>+</span> <span><span>assets:</span></span></p></td></tr><tr><td><p>22</p></td><td><p><span>+</span> <span><span>-</span> <span>images/lake.jpg</span></span></p></td></tr></tbody></table>
    

### Create the `ImageSection` widget

Define the following `ImageSection` widget after the other declarations.

```
<span>class</span><span> </span><span>ImageSection</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ImageSection</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>image</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> image</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Image</span><span>.</span><span>asset</span><span>(</span><span>
      image</span><span>,</span><span>
      width</span><span>:</span><span> </span><span>600</span><span>,</span><span>
      height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
      fit</span><span>:</span><span> </span><span>BoxFit</span><span>.</span><span>cover</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The `BoxFit.cover` value tells Flutter to display the image with two constraints. First, display the image as small as possible. Second, cover all the space that the layout allotted, called the render box.

### Update the app to display the image section

Add an `ImageSection` widget as the first child in the `children` list. Set the `image` property to the path of the image you added in [Configure your app to use supplied images](https://docs.flutter.dev/ui/layout/tutorial#configure-your-app-to-use-supplied-images).

<table><tbody><tr><td></td><td><p>@@ -1,6 +1,9 @@</p></td></tr><tr><td><p>1</p><p>1</p></td><td><p><span>&nbsp;</span> <span><span>body</span>: const <span>SingleChildScrollView</span>(</span></p></td></tr><tr><td><p>2</p><p>2</p></td><td><p><span>&nbsp;</span> <span>child: <span>Column</span>(</span></p></td></tr><tr><td><p>3</p><p>3</p></td><td><p><span>&nbsp;</span> <span><span>children</span>: <span>[</span></span></p></td></tr><tr><td><p>4</p></td><td><p><span>+</span> <span>ImageSection(</span></p></td></tr><tr><td><p>5</p></td><td><p><span>+</span> <span>image: <span>'images/lake.jpg'</span>,</span></p></td></tr><tr><td><p>6</p></td><td><p><span>+</span> <span>),</span></p></td></tr><tr><td><p>4</p><p>7</p></td><td><p><span>&nbsp;</span> <span>TitleSection(</span></p></td></tr><tr><td><p>5</p><p>8</p></td><td><p><span>&nbsp;</span> <span>name: <span>'Oeschinen Lake Campground'</span>,</span></p></td></tr><tr><td><p>6</p><p>9</p></td><td><p><span>&nbsp;</span> <span>location: <span>'Kandersteg, Switzerland'</span>,</span></p></td></tr></tbody></table>

## Congratulations

That’s it! When you hot reload the app, your app should look like this.

![The finished app](https://docs.flutter.dev/assets/images/docs/ui/layout/layout-demo-app.png)

The finished app

## Resources

You can access the resources used in this tutorial from these locations:

**Dart code:** [`main.dart`](https://github.com/flutter/website/tree/main/examples/layout/lakes/step6/lib/main.dart)  
**Image:** [ch-photo](https://unsplash.com/photos/red-and-gray-tents-in-grass-covered-mountain-5Rhl-kSRydQ)  
**Pubspec:** [`pubspec.yaml`](https://github.com/flutter/website/tree/main/examples/layout/lakes/step6/pubspec.yaml)  

## Next Steps

To add interactivity to this layout, follow the [interactivity tutorial](https://docs.flutter.dev/ui/interactivity).