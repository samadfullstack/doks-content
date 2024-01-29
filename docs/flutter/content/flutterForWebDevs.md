This page is for users who are familiar with the HTML and CSS syntax for arranging components of an application’s UI. It maps HTML/CSS code snippets to their Flutter/Dart code equivalents.

Flutter is a framework for building cross-platform applications that uses the Dart programming language. To understand some differences between programming with Dart and programming with Javascript, see [Learning Dart as a JavaScript Developer](https://dart.dev/guides/language/coming-from/js-to-dart).

One of the fundamental differences between designing a web layout and a Flutter layout, is learning how constraints work, and how widgets are sized and positioned. To learn more, see [Understanding constraints](https://docs.flutter.dev/ui/layout/constraints).

The examples assume:

-   The HTML document starts with `<!DOCTYPE html>`, and the CSS box model for all HTML elements is set to [`border-box`](https://css-tricks.com/box-sizing/), for consistency with the Flutter model.
    
    ```
    <span>{</span>
        <span>box-sizing</span><span>:</span> <span>border-box</span><span>;</span>
    <span>}</span>
    ```
    
-   In Flutter, the default styling of the ‘Lorem ipsum’ text is defined by the `bold24Roboto` variable as follows, to keep the syntax simple:
    
    ```
    <span>TextStyle</span><span> bold24Roboto </span><span>=</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>
      color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>,</span><span>
      fontSize</span><span>:</span><span> </span><span>24</span><span>,</span><span>
      fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span>
    </span><span>);</span>
    ```
    

## Performing basic layout operations

The following examples show how to perform the most common UI layout tasks.

### Styling and aligning text

Font style, size, and other text attributes that CSS handles with the font and color properties are individual properties of a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html) child of a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget.

For text-align property in CSS that is used for aligning text, there is a textAlign property of a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget.

In both HTML and Flutter, child elements or widgets are anchored at the top left, by default.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  Lorem ipsum
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Georgia</span><span>;</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
    </span><span>'Lorem ipsum'</span><span>,</span><span>
    style</span><span>:</span><span> </span><span><span>TextStyle</span><span>(</span><span>
      fontFamily</span><span>:</span><span> </span><span>'Georgia'</span><span>,</span><span>
      fontSize</span><span>:</span><span> </span><span>24</span><span>,</span><span>
      fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span>
    </span><span>),</span><span>
    </span></span><span>
    </span><span><span>textAlign</span><span>:</span><span> </span><span>TextAlign</span><span>.</span><span>center</span><span>,</span><span> </span></span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Setting background color

In Flutter, you set the background color using the `color` property or the `decoration` property of a [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html). However, you cannot supply both, since it would potentially result in the decoration drawing over the background color. The `color` property should be preferred when the background is a simple color. For other cases, such as gradients or images, use the `decoration` property.

The CSS examples use the hex color equivalents to the Material color palette.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  Lorem ipsum
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span></span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  </span><span><span>color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  </span></span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
    </span><span>'Lorem ipsum'</span><span>,</span><span>
    style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  </span><span><span>decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
    color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  </span><span>),</span><span>
  </span></span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
    </span><span>'Lorem ipsum'</span><span>,</span><span>
    style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Centering components

A [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html) widget centers its child both horizontally and vertically.

To accomplish a similar effect in CSS, the parent element uses either a flex or table-cell display behavior. The examples on this page show the flex behavior.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  Lorem ipsum
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span></span><span>Text</span><span>(</span><span>
      </span><span>'Lorem ipsum'</span><span>,</span><span>
      style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Setting container width

To specify the width of a [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) widget, use its `width` property. This is a fixed width, unlike the CSS max-width property that adjusts the container width up to a maximum value. To mimic that effect in Flutter, use the `constraints` property of the Container. Create a new [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html) widget with a `minWidth` or `maxWidth`.

For nested Containers, if the parent’s width is less than the child’s width, the child Container sizes itself to match the parent.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span></span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>width</span><span>:</span><span> </span><span>100%</span><span>;</span><span>
    </span><span>max-width</span><span>:</span><span> </span><span>240px</span><span>;</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  </span><span><span>width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  </span></span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red box</span><span>
      </span><span><span>width</span><span>:</span><span> </span><span>240</span><span>,</span><span>
      </span></span><span>// max-width is 240</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
      </span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Lorem ipsum'</span><span>,</span><span>
        style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## Manipulating position and size

The following examples show how to perform more complex operations on widget position, size, and background.

### Setting absolute position

By default, widgets are positioned relative to their parent.

To specify an absolute position for a widget as x-y coordinates, nest it in a [`Positioned`](https://api.flutter.dev/flutter/widgets/Positioned-class.html) widget that is, in turn, nested in a [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html) widget.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span><span>position</span><span>:</span><span> relative</span><span>;</span></span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>position</span><span>:</span><span> absolute</span><span>;</span><span>
    </span><span>top</span><span>:</span><span> </span><span>24px</span><span>;</span><span>
    </span><span>left</span><span>:</span><span> </span><span>24px</span><span>;</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  </span><span><span>child</span><span>:</span><span> </span><span>Stack</span><span>(</span><span>
    children</span><span>:</span><span> </span></span><span>[</span><span>
      </span><span>Positioned</span><span>(</span><span>
        </span><span>// red box</span><span>
        </span><span><span>left</span><span>:</span><span> </span><span>24</span><span>,</span><span>
        top</span><span>:</span><span> </span><span>24</span><span>,</span><span>
        </span></span><span>
        child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
          padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
          decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
            color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
          </span><span>),</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
            </span><span>'Lorem ipsum'</span><span>,</span><span>
            style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Rotating components

To rotate a widget, nest it in a [`Transform`](https://api.flutter.dev/flutter/widgets/Transform-class.html) widget. Use the `Transform` widget’s `alignment` and `origin` properties to specify the transform origin (fulcrum) in relative and absolute terms, respectively.

For a simple 2D rotation, in which the widget is rotated on the Z axis, create a new [`Matrix4`](https://api.flutter.dev/flutter/vector_math_64/Matrix4-class.html) identity object and use its `rotateZ()` method to specify the rotation factor using radians (degrees × π / 180).

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>transform</span><span>:</span><span> rotate</span><span>(</span><span>15deg</span><span>);</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span><span>Transform</span><span>(</span><span>
      alignment</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>center</span><span>,</span><span>
      transform</span><span>:</span><span> </span><span>Matrix4</span><span>.</span><span>identity</span><span>()..</span><span>rotateZ</span><span>(</span><span>15</span><span> </span><span>*</span><span> </span><span>3.1415927</span><span> </span><span>/</span><span> </span><span>180</span><span>),</span><span>
      child</span><span>:</span><span> </span></span><span>Container</span><span>(</span><span>
        </span><span>// red box</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
        decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'Lorem ipsum'</span><span>,</span><span>
          style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
          textAlign</span><span>:</span><span> </span><span>TextAlign</span><span>.</span><span>center</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Scaling components

To scale a widget up or down, nest it in a [`Transform`](https://api.flutter.dev/flutter/widgets/Transform-class.html) widget. Use the Transform widget’s `alignment` and `origin` properties to specify the transform origin (fulcrum) in relative or absolute terms, respectively.

For a simple scaling operation along the x-axis, create a new [`Matrix4`](https://api.flutter.dev/flutter/vector_math_64/Matrix4-class.html) identity object and use its `scale()` method to specify the scaling factor.

When you scale a parent widget, its child widgets are scaled accordingly.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>transform</span><span>:</span><span> scale</span><span>(</span><span>1.5</span><span>);</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span><span>Transform</span><span>(</span><span>
      alignment</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>center</span><span>,</span><span>
      transform</span><span>:</span><span> </span><span>Matrix4</span><span>.</span><span>identity</span><span>()..</span><span>scale</span><span>(</span><span>1.5</span><span>),</span><span>
      child</span><span>:</span><span> </span></span><span>Container</span><span>(</span><span>
        </span><span>// red box</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
        decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'Lorem ipsum'</span><span>,</span><span>
          style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
          textAlign</span><span>:</span><span> </span><span>TextAlign</span><span>.</span><span>center</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Applying a linear gradient

To apply a linear gradient to a widget’s background, nest it in a [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) widget. Then use the `Container` widget’s `decoration` property to create a [`BoxDecoration`](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html) object, and use `BoxDecoration`’s `gradient` property to transform the background fill.

The gradient “angle” is based on the Alignment (x, y) values:

-   If the beginning and ending x values are equal, the gradient is vertical (0° | 180°).
-   If the beginning and ending y values are equal, the gradient is horizontal (90° | 270°).

#### Vertical gradient

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>background</span><span>:</span><span> linear-gradient</span><span>(</span><span>180deg</span><span>,</span><span> </span><span>#ef5350</span><span>,</span><span> rgba</span><span>(</span><span>0</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>0</span><span>)</span><span> </span><span>80%</span><span>);</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red box</span><span>
      </span><span><span>decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        gradient</span><span>:</span><span> </span><span>LinearGradient</span><span>(</span><span>
          begin</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>topCenter</span><span>,</span><span>
          end</span><span>:</span><span> </span><span>Alignment</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>0.6</span><span>),</span><span>
          colors</span><span>:</span><span> </span><span>&lt;</span><span>Color</span><span>&gt;[</span><span>
            </span><span>Color</span><span>(</span><span>0xffef5350</span><span>),</span><span>
            </span><span>Color</span><span>(</span><span>0x00ef5350</span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      </span></span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Lorem ipsum'</span><span>,</span><span>
        style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

#### Horizontal gradient

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>background</span><span>:</span><span> linear-gradient</span><span>(</span><span>90deg</span><span>,</span><span> </span><span>#ef5350</span><span>,</span><span> rgba</span><span>(</span><span>0</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>0</span><span>)</span><span> </span><span>80%</span><span>);</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red box</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      </span><span><span>decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        gradient</span><span>:</span><span> </span><span>LinearGradient</span><span>(</span><span>
          begin</span><span>:</span><span> </span><span>Alignment</span><span>(-</span><span>1.0</span><span>,</span><span> </span><span>0.0</span><span>),</span><span>
          end</span><span>:</span><span> </span><span>Alignment</span><span>(</span><span>0.6</span><span>,</span><span> </span><span>0.0</span><span>),</span><span>
          colors</span><span>:</span><span> </span><span>&lt;</span><span>Color</span><span>&gt;[</span><span>
            </span><span>Color</span><span>(</span><span>0xffef5350</span><span>),</span><span>
            </span><span>Color</span><span>(</span><span>0x00ef5350</span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      </span></span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Lorem ipsum'</span><span>,</span><span>
        style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## Manipulating shapes

The following examples show how to make and customize shapes.

### Rounding corners

To round the corners of a rectangular shape, use the `borderRadius` property of a [`BoxDecoration`](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html) object. Create a new [`BorderRadius`](https://api.flutter.dev/flutter/painting/BorderRadius-class.html) object that specifies the radius for rounding each corner.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>border-radius</span><span>:</span><span> </span><span>8px</span><span>;</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red circle</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
        </span><span><span>borderRadius</span><span>:</span><span> </span><span>const</span><span> </span><span>BorderRadius</span><span>.</span><span>all</span><span>(</span><span>
          </span><span>Radius</span><span>.</span><span>circular</span><span>(</span><span>8</span><span>),</span><span>
        </span><span>),</span><span> </span></span><span>
      </span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Lorem ipsum'</span><span>,</span><span>
        style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Adding box shadows

In CSS you can specify shadow offset and blur in shorthand, using the box-shadow property. This example shows two box shadows, with properties:

-   `xOffset: 0px, yOffset: 2px, blur: 4px, color: black @80% alpha`
-   `xOffset: 0px, yOffset: 06x, blur: 20px, color: black @50% alpha`

In Flutter, each property and value is specified separately. Use the `boxShadow` property of `BoxDecoration` to create a list of [`BoxShadow`](https://api.flutter.dev/flutter/painting/BoxShadow-class.html) widgets. You can define one or multiple `BoxShadow` widgets, which can be stacked to customize the shadow depth, color, and so on.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>box-shadow</span><span>:</span><span> </span><span>0</span><span> </span><span>2px</span><span> </span><span>4px</span><span> rgba</span><span>(</span><span>0</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>0.8</span><span>),</span><span>
              </span><span>0</span><span> </span><span>6px</span><span> </span><span>20px</span><span> rgba</span><span>(</span><span>0</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>0.5</span><span>);</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  margin</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>only</span><span>(</span><span>bottom</span><span>:</span><span> </span><span>16</span><span>),</span><span>
  decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
    color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  </span><span>),</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red box</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
        </span><span><span>boxShadow</span><span>:</span><span> </span><span>const</span><span> </span><span>&lt;</span><span>BoxShadow</span><span>&gt;[</span><span>
          </span><span>BoxShadow</span><span>(</span><span>
            color</span><span>:</span><span> </span><span>Color</span><span>(</span><span>0xcc000000</span><span>),</span><span>
            offset</span><span>:</span><span> </span><span>Offset</span><span>(</span><span>0</span><span>,</span><span> </span><span>2</span><span>),</span><span>
            blurRadius</span><span>:</span><span> </span><span>4</span><span>,</span><span>
          </span><span>),</span><span>
          </span><span>BoxShadow</span><span>(</span><span>
            color</span><span>:</span><span> </span><span>Color</span><span>(</span><span>0x80000000</span><span>),</span><span>
            offset</span><span>:</span><span> </span><span>Offset</span><span>(</span><span>0</span><span>,</span><span> </span><span>6</span><span>),</span><span>
            blurRadius</span><span>:</span><span> </span><span>20</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>],</span><span> </span></span><span>
      </span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Lorem ipsum'</span><span>,</span><span>
        style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Making circles and ellipses

Making a circle in CSS requires a workaround of applying a border-radius of 50% to all four sides of a rectangle, though there are [basic shapes](https://developer.mozilla.org/en-US/docs/Web/CSS/basic-shape).

While this approach is supported with the `borderRadius` property of [`BoxDecoration`](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html), Flutter provides a `shape` property with [`BoxShape` enum](https://api.flutter.dev/flutter/painting/BoxShape.html) for this purpose.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-circle"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-circle </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>text-align</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>width</span><span>:</span><span> </span><span>160px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>160px</span><span>;</span><span>
    </span><span>border-radius</span><span>:</span><span> </span><span>50%</span><span>;</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red circle</span><span>
      decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
        </span><span><span>shape</span><span>:</span><span> </span><span>BoxShape</span><span>.</span><span>circle</span><span>,</span><span> </span></span><span>
      </span><span>),</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      </span><span><span>width</span><span>:</span><span> </span><span>160</span><span>,</span><span>
      height</span><span>:</span><span> </span><span>160</span><span>,</span><span>
      </span></span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Lorem ipsum'</span><span>,</span><span>
        style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
        </span><span><span>textAlign</span><span>:</span><span> </span><span>TextAlign</span><span>.</span><span>center</span><span>,</span><span> </span></span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## Manipulating text

The following examples show how to specify fonts and other text attributes. They also show how to transform text strings, customize spacing, and create excerpts.

### Adjusting text spacing

In CSS, you specify the amount of white space between each letter or word by giving a length value for the letter-spacing and word-spacing properties, respectively. The amount of space can be in px, pt, cm, em, etc.

In Flutter, you specify white space as logical pixels (negative values are allowed) for the `letterSpacing` and `wordSpacing` properties of a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html) child of a `Text` widget.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>letter-spacing</span><span>:</span><span> </span><span>4px</span><span>;</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red box</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
      </span><span>),</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Lorem ipsum'</span><span>,</span><span>
        style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>,</span><span>
          fontSize</span><span>:</span><span> </span><span>24</span><span>,</span><span>
          fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w900</span><span>,</span><span>
          </span><span><span>letterSpacing</span><span>:</span><span> </span><span>4</span><span>,</span><span> </span></span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Making inline formatting changes

A [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget lets you display text with some formatting characteristics. To display text that uses multiple styles (in this example, a single word with emphasis), use a [`RichText`](https://api.flutter.dev/flutter/widgets/RichText-class.html) widget instead. Its `text` property can specify one or more [`TextSpan`](https://api.flutter.dev/flutter/painting/TextSpan-class.html) objects that can be individually styled.

In the following example, “Lorem” is in a `TextSpan` with the default (inherited) text styling, and “ipsum” is in a separate `TextSpan` with custom styling.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    </span><span><span>Lorem </span><span>&lt;</span><span>em</span><span>&gt;</span><span>ipsum</span><span>&lt;/</span><span>em</span><span>&gt;</span></span><span>
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span></span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
</span><span>}</span><span>
</span><span><span>.</span><span>red-box em </span><span>{</span><span>
    </span><span>font</span><span>:</span><span> </span><span>300</span><span> </span><span>48px</span><span> Roboto</span><span>;</span><span>
    </span><span>font-style</span><span>:</span><span> italic</span><span>;</span><span>
</span><span>}</span></span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red box</span><span>
      decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
      </span><span>),</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      child</span><span>:</span><span> </span><span><span>RichText</span><span>(</span><span>
        text</span><span>:</span><span> </span><span>TextSpan</span><span>(</span><span>
          style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
          children</span><span>:</span><span> </span><span>const</span><span> </span><span>&lt;</span><span>TextSpan</span><span>&gt;[</span><span>
            </span><span>TextSpan</span><span>(</span><span>text</span><span>:</span><span> </span><span>'Lorem '</span><span>),</span><span>
            </span><span>TextSpan</span><span>(</span><span>
              text</span><span>:</span><span> </span><span>'ipsum'</span><span>,</span><span>
              style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
                fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w300</span><span>,</span><span>
                fontStyle</span><span>:</span><span> </span><span>FontStyle</span><span>.</span><span>italic</span><span>,</span><span>
                fontSize</span><span>:</span><span> </span><span>48</span><span>,</span><span>
              </span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span> </span></span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Creating text excerpts

An excerpt displays the initial line(s) of text in a paragraph, and handles the overflow text, often using an ellipsis.

In Flutter, use the `maxLines` property of a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget to specify the number of lines to include in the excerpt, and the `overflow` property for handling overflow text.

```
<span>&lt;</span><span>div class</span><span>=</span><span>"grey-box"</span><span>&gt;</span><span>
  </span><span>&lt;</span><span>div class</span><span>=</span><span>"red-box"</span><span>&gt;</span><span>
    Lorem ipsum dolor sit amet</span><span>,</span><span> consec etur
  </span><span>&lt;/</span><span>div</span><span>&gt;</span><span>
</span><span>&lt;/</span><span>div</span><span>&gt;</span><span>

</span><span>.</span><span>grey-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#e0e0e0</span><span>;</span><span> </span><span>/* grey 300 */</span><span>
    </span><span>width</span><span>:</span><span> </span><span>320px</span><span>;</span><span>
    </span><span>height</span><span>:</span><span> </span><span>240px</span><span>;</span><span>
    </span><span>font</span><span>:</span><span> </span><span>900</span><span> </span><span>24px</span><span> Roboto</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> flex</span><span>;</span><span>
    </span><span>align-items</span><span>:</span><span> center</span><span>;</span><span>
    </span><span>justify-content</span><span>:</span><span> center</span><span>;</span><span>
</span><span>}</span><span>
</span><span>.</span><span>red-box </span><span>{</span><span>
    </span><span>background-color</span><span>:</span><span> </span><span>#ef5350</span><span>;</span><span> </span><span>/* red 400 */</span><span>
    </span><span>padding</span><span>:</span><span> </span><span>16px</span><span>;</span><span>
    </span><span>color</span><span>:</span><span> </span><span>#ffffff</span><span>;</span><span>
    </span><span><span>overflow</span><span>:</span><span> hidden</span><span>;</span><span>
    </span><span>display</span><span>:</span><span> -webkit-box</span><span>;</span><span>
    </span><span>-webkit-box-orient</span><span>:</span><span> vertical</span><span>;</span><span>
    </span><span>-webkit-line-clamp</span><span>:</span><span> </span><span>2</span><span>;</span></span><span>
</span><span>}</span>
```

```
<span>final</span><span> container </span><span>=</span><span> </span><span>Container</span><span>(</span><span>
  </span><span>// grey box</span><span>
  width</span><span>:</span><span> </span><span>320</span><span>,</span><span>
  height</span><span>:</span><span> </span><span>240</span><span>,</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>300</span><span>],</span><span>
  child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>// red box</span><span>
      decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>400</span><span>],</span><span>
      </span><span>),</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Lorem ipsum dolor sit amet, consec etur'</span><span>,</span><span>
        style</span><span>:</span><span> bold24Roboto</span><span>,</span><span>
        </span><span><span>overflow</span><span>:</span><span> </span><span>TextOverflow</span><span>.</span><span>ellipsis</span><span>,</span><span>
        maxLines</span><span>:</span><span> </span><span>1</span><span>,</span><span> </span></span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```