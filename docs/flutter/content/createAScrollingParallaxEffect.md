1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Effects](https://docs.flutter.dev/cookbook/effects)
3.  [Create a scrolling parallax effect](https://docs.flutter.dev/cookbook/effects/parallax-scrolling)

When you scroll a list of cards (containing images, for example) in an app, you might notice that those images appear to scroll more slowly than the rest of the screen. It almost looks as if the cards in the list are in the foreground, but the images themselves sit far off in the distant background. This effect is known as parallax.

In this recipe, you create the parallax effect by building a list of cards (with rounded corners containing some text). Each card also contains an image. As the cards slide up the screen, the images within each card slide down.

The following animation shows the app’s behavior:

![Parallax scrolling](https://docs.flutter.dev/assets/images/docs/cookbook/effects/ParallaxScrolling.gif)

## Create a list to hold the parallax items

To display a list of parallax scrolling images, you must first display a list.

Create a new stateless widget called `ParallaxRecipe`. Within `ParallaxRecipe`, build a widget tree with a `SingleChildScrollView` and a `Column`, which forms a list.

```
<span>class</span><span> </span><span>ParallaxRecipe</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ParallaxRecipe</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>SingleChildScrollView</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Display items with text and a static image

Each list item displays a rounded-rectangle background image, exemplifying one of seven locations in the world. Stacked on top of that background image is the name of the location and its country, positioned in the lower left. Between the background image and the text is a dark gradient, which improves the legibility of the text against the background.

Implement a stateless widget called `LocationListItem` that consists of the previously mentioned visuals. For now, use a static `Image` widget for the background. Later, you’ll replace that widget with a parallax version.

```
<span>@immutable
</span><span>class</span><span> </span><span>LocationListItem</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>LocationListItem</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>imageUrl</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>name</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>country</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> imageUrl</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> name</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> country</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>horizontal</span><span>:</span><span> </span><span>24</span><span>,</span><span> vertical</span><span>:</span><span> </span><span>16</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>AspectRatio</span><span>(</span><span>
        aspectRatio</span><span>:</span><span> </span><span>16</span><span> </span><span>/</span><span> </span><span>9</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>ClipRRect</span><span>(</span><span>
          borderRadius</span><span>:</span><span> </span><span>BorderRadius</span><span>.</span><span>circular</span><span>(</span><span>16</span><span>),</span><span>
          child</span><span>:</span><span> </span><span>Stack</span><span>(</span><span>
            children</span><span>:</span><span> </span><span>[</span><span>
              _buildParallaxBackground</span><span>(</span><span>context</span><span>),</span><span>
              _buildGradient</span><span>(),</span><span>
              _buildTitleAndSubtitle</span><span>(),</span><span>
            </span><span>],</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> _buildParallaxBackground</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Positioned</span><span>.</span><span>fill</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Image</span><span>.</span><span>network</span><span>(</span><span>
        imageUrl</span><span>,</span><span>
        fit</span><span>:</span><span> </span><span>BoxFit</span><span>.</span><span>cover</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> _buildGradient</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Positioned</span><span>.</span><span>fill</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>DecoratedBox</span><span>(</span><span>
        decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          gradient</span><span>:</span><span> </span><span>LinearGradient</span><span>(</span><span>
            colors</span><span>:</span><span> </span><span>[</span><span>Colors</span><span>.</span><span>transparent</span><span>,</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>.</span><span>withOpacity</span><span>(</span><span>0.7</span><span>)],</span><span>
            begin</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>topCenter</span><span>,</span><span>
            end</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>bottomCenter</span><span>,</span><span>
            stops</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>0.6</span><span>,</span><span> </span><span>0.95</span><span>],</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> _buildTitleAndSubtitle</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Positioned</span><span>(</span><span>
      left</span><span>:</span><span> </span><span>20</span><span>,</span><span>
      bottom</span><span>:</span><span> </span><span>20</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        mainAxisSize</span><span>:</span><span> </span><span>MainAxisSize</span><span>.</span><span>min</span><span>,</span><span>
        crossAxisAlignment</span><span>:</span><span> </span><span>CrossAxisAlignment</span><span>.</span><span>start</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>Text</span><span>(</span><span>
            name</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>,</span><span>
              fontSize</span><span>:</span><span> </span><span>20</span><span>,</span><span>
              fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
          </span><span>Text</span><span>(</span><span>
            country</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>,</span><span>
              fontSize</span><span>:</span><span> </span><span>14</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Next, add the list items to your `ParallaxRecipe` widget.

```
<span>class</span><span> </span><span>ParallaxRecipe</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ParallaxRecipe</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>SingleChildScrollView</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          </span><span>for</span><span> </span><span>(</span><span>final</span><span> location </span><span>in</span><span> locations</span><span>)</span><span>
            </span><span>LocationListItem</span><span>(</span><span>
              imageUrl</span><span>:</span><span> location</span><span>.</span><span>imageUrl</span><span>,</span><span>
              name</span><span>:</span><span> location</span><span>.</span><span>name</span><span>,</span><span>
              country</span><span>:</span><span> location</span><span>.</span><span>place</span><span>,</span><span>
            </span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

You now have a typical, scrollable list of cards that displays seven unique locations in the world. In the next step, you add a parallax effect to the background image.

## Implement the parallax effect

A parallax scrolling effect is achieved by slightly pushing the background image in the opposite direction of the rest of the list. As the list items slide up the screen, each background image slides slightly downward. Conversely, as the list items slide down the screen, each background image slides slightly upward. Visually, this results in parallax.

The parallax effect depends on the list item’s current position within its ancestor `Scrollable`. As the list item’s scroll position changes, the position of the list item’s background image must also change. This is an interesting problem to solve. The position of a list item within the `Scrollable` isn’t available until Flutter’s layout phase is complete. This means that the position of the background image must be determined in the paint phase, which comes after the layout phase. Fortunately, Flutter provides a widget called `Flow`, which is specifically designed to give you control over the transform of a child widget immediately before the widget is painted. In other words, you can intercept the painting phase and take control to reposition your child widgets however you want.

Wrap your background `Image` widget with a [`Flow`](https://api.flutter.dev/flutter/widgets/Flow-class.html) widget.

```
<span>Widget</span><span> _buildParallaxBackground</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Flow</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      </span><span>Image</span><span>.</span><span>network</span><span>(</span><span>
        imageUrl</span><span>,</span><span>
        fit</span><span>:</span><span> </span><span>BoxFit</span><span>.</span><span>cover</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

Introduce a new `FlowDelegate` called `ParallaxFlowDelegate`.

```
<span>Widget</span><span> _buildParallaxBackground</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Flow</span><span>(</span><span>
    delegate</span><span>:</span><span> </span><span>ParallaxFlowDelegate</span><span>(),</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      </span><span>Image</span><span>.</span><span>network</span><span>(</span><span>
        imageUrl</span><span>,</span><span>
        fit</span><span>:</span><span> </span><span>BoxFit</span><span>.</span><span>cover</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

```
<span>class</span><span> </span><span>ParallaxFlowDelegate</span><span> </span><span>extends</span><span> </span><span>FlowDelegate</span><span> </span><span>{</span><span>
  </span><span>ParallaxFlowDelegate</span><span>();</span><span>

  @override
  </span><span>BoxConstraints</span><span> getConstraintsForChild</span><span>(</span><span>int</span><span> i</span><span>,</span><span> </span><span>BoxConstraints</span><span> constraints</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// TODO: We'll add more to this later.</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> paintChildren</span><span>(</span><span>FlowPaintingContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// TODO: We'll add more to this later.</span><span>
  </span><span>}</span><span>

  @override
  </span><span>bool</span><span> shouldRepaint</span><span>(</span><span>covariant</span><span> </span><span>FlowDelegate</span><span> oldDelegate</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// TODO: We'll add more to this later.</span><span>
    </span><span>return</span><span> </span><span>true</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

A `FlowDelegate` controls how its children are sized and where those children are painted. In this case, your `Flow` widget has only one child: the background image. That image must be exactly as wide as the `Flow` widget.

Return tight width constraints for your background image child.

```
<span>@override
</span><span>BoxConstraints</span><span> getConstraintsForChild</span><span>(</span><span>int</span><span> i</span><span>,</span><span> </span><span>BoxConstraints</span><span> constraints</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>BoxConstraints</span><span>.</span><span>tightFor</span><span>(</span><span>
    width</span><span>:</span><span> constraints</span><span>.</span><span>maxWidth</span><span>,</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

Your background images are now sized appropriately. But, you still need to calculate the vertical position of each background image based on its scroll position, and then paint it.

There are three critical pieces of information that you need to compute the desired position of a background image:

-   The bounds of the ancestor `Scrollable`
-   The bounds of the individual list item
-   The size of the image after it’s scaled down to fit in the list item

To look up the bounds of the `Scrollable`, you pass a `ScrollableState` into your `FlowDelegate`.

To look up the bounds of your individual list item, you pass your list item’s `BuildContext` into your `FlowDelegate`.

To look up the final size of your background image, you assign a `GlobalKey` to your `Image` widget, and then you pass that `GlobalKey` into your `FlowDelegate`.

Make this information available to `ParallaxFlowDelegate`.

```
<span>@immutable
</span><span>class</span><span> </span><span>LocationListItem</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>GlobalKey</span><span> _backgroundImageKey </span><span>=</span><span> </span><span>GlobalKey</span><span>();</span><span>

  </span><span>Widget</span><span> _buildParallaxBackground</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Flow</span><span>(</span><span>
      delegate</span><span>:</span><span> </span><span>ParallaxFlowDelegate</span><span>(</span><span>
        scrollable</span><span>:</span><span> </span><span>Scrollable</span><span>.</span><span>of</span><span>(</span><span>context</span><span>),</span><span>
        listItemContext</span><span>:</span><span> context</span><span>,</span><span>
        backgroundImageKey</span><span>:</span><span> _backgroundImageKey</span><span>,</span><span>
      </span><span>),</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        </span><span>Image</span><span>.</span><span>network</span><span>(</span><span>
          imageUrl</span><span>,</span><span>
          key</span><span>:</span><span> _backgroundImageKey</span><span>,</span><span>
          fit</span><span>:</span><span> </span><span>BoxFit</span><span>.</span><span>cover</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

```
<span>class</span><span> </span><span>ParallaxFlowDelegate</span><span> </span><span>extends</span><span> </span><span>FlowDelegate</span><span> </span><span>{</span><span>
  </span><span>ParallaxFlowDelegate</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>scrollable</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>listItemContext</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>backgroundImageKey</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>ScrollableState</span><span> scrollable</span><span>;</span><span>
  </span><span>final</span><span> </span><span>BuildContext</span><span> listItemContext</span><span>;</span><span>
  </span><span>final</span><span> </span><span>GlobalKey</span><span> backgroundImageKey</span><span>;</span><span>
</span><span>}</span>
```

Having all the information needed to implement parallax scrolling, implement the `shouldRepaint()` method.

```
<span>@override
</span><span>bool</span><span> shouldRepaint</span><span>(</span><span>ParallaxFlowDelegate</span><span> oldDelegate</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> scrollable </span><span>!=</span><span> oldDelegate</span><span>.</span><span>scrollable </span><span>||</span><span>
      listItemContext </span><span>!=</span><span> oldDelegate</span><span>.</span><span>listItemContext </span><span>||</span><span>
      backgroundImageKey </span><span>!=</span><span> oldDelegate</span><span>.</span><span>backgroundImageKey</span><span>;</span><span>
</span><span>}</span>
```

Now, implement the layout calculations for the parallax effect.

First, calculate the pixel position of a list item within its ancestor `Scrollable`.

```
<span>@override
</span><span>void</span><span> paintChildren</span><span>(</span><span>FlowPaintingContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>// Calculate the position of this list item within the viewport.</span><span>
  </span><span>final</span><span> scrollableBox </span><span>=</span><span> scrollable</span><span>.</span><span>context</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemBox </span><span>=</span><span> listItemContext</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemOffset </span><span>=</span><span> listItemBox</span><span>.</span><span>localToGlobal</span><span>(</span><span>
      listItemBox</span><span>.</span><span>size</span><span>.</span><span>centerLeft</span><span>(</span><span>Offset</span><span>.</span><span>zero</span><span>),</span><span>
      ancestor</span><span>:</span><span> scrollableBox</span><span>);</span><span>
</span><span>}</span>
```

Use the pixel position of the list item to calculate its percentage from the top of the `Scrollable`. A list item at the top of the scrollable area should produce 0%, and a list item at the bottom of the scrollable area should produce 100%.

```
<span>@override
</span><span>void</span><span> paintChildren</span><span>(</span><span>FlowPaintingContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>// Calculate the position of this list item within the viewport.</span><span>
  </span><span>final</span><span> scrollableBox </span><span>=</span><span> scrollable</span><span>.</span><span>context</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemBox </span><span>=</span><span> listItemContext</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemOffset </span><span>=</span><span> listItemBox</span><span>.</span><span>localToGlobal</span><span>(</span><span>
      listItemBox</span><span>.</span><span>size</span><span>.</span><span>centerLeft</span><span>(</span><span>Offset</span><span>.</span><span>zero</span><span>),</span><span>
      ancestor</span><span>:</span><span> scrollableBox</span><span>);</span><span>
</span><span>}</span><span>

  </span><span>// Determine the percent position of this list item within the</span><span>
  </span><span>// scrollable area.</span><span>
  </span><span>final</span><span> viewportDimension </span><span>=</span><span> scrollable</span><span>.</span><span>position</span><span>.</span><span>viewportDimension</span><span>;</span><span>
  </span><span>final</span><span> scrollFraction </span><span>=</span><span>
      </span><span>(</span><span>listItemOffset</span><span>.</span><span>dy </span><span>/</span><span> viewportDimension</span><span>).</span><span>clamp</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
</span><span>}</span>
```

Use the scroll percentage to calculate an `Alignment`. At 0%, you want `Alignment(0.0, -1.0)`, and at 100%, you want `Alignment(0.0, 1.0)`. These coordinates correspond to top and bottom alignment, respectively.

```
<span>@override
</span><span>void</span><span> paintChildren</span><span>(</span><span>FlowPaintingContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>// Calculate the position of this list item within the viewport.</span><span>
  </span><span>final</span><span> scrollableBox </span><span>=</span><span> scrollable</span><span>.</span><span>context</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemBox </span><span>=</span><span> listItemContext</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemOffset </span><span>=</span><span> listItemBox</span><span>.</span><span>localToGlobal</span><span>(</span><span>
      listItemBox</span><span>.</span><span>size</span><span>.</span><span>centerLeft</span><span>(</span><span>Offset</span><span>.</span><span>zero</span><span>),</span><span>
      ancestor</span><span>:</span><span> scrollableBox</span><span>);</span><span>
</span><span>}</span><span>

  </span><span>// Determine the percent position of this list item within the</span><span>
  </span><span>// scrollable area.</span><span>
  </span><span>final</span><span> viewportDimension </span><span>=</span><span> scrollable</span><span>.</span><span>position</span><span>.</span><span>viewportDimension</span><span>;</span><span>
  </span><span>final</span><span> scrollFraction </span><span>=</span><span>
      </span><span>(</span><span>listItemOffset</span><span>.</span><span>dy </span><span>/</span><span> viewportDimension</span><span>).</span><span>clamp</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
</span><span>}</span><span>
  </span><span>// Calculate the vertical alignment of the background</span><span>
  </span><span>// based on the scroll percent.</span><span>
  </span><span>final</span><span> verticalAlignment </span><span>=</span><span> </span><span>Alignment</span><span>(</span><span>0.0</span><span>,</span><span> scrollFraction </span><span>*</span><span> </span><span>2</span><span> </span><span>-</span><span> </span><span>1</span><span>);</span><span>
</span><span>}</span>
```

Use `verticalAlignment`, along with the size of the list item and the size of the background image, to produce a `Rect` that determines where the background image should be positioned.

```
<span>@override
</span><span>void</span><span> paintChildren</span><span>(</span><span>FlowPaintingContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>// Calculate the position of this list item within the viewport.</span><span>
  </span><span>final</span><span> scrollableBox </span><span>=</span><span> scrollable</span><span>.</span><span>context</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemBox </span><span>=</span><span> listItemContext</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemOffset </span><span>=</span><span> listItemBox</span><span>.</span><span>localToGlobal</span><span>(</span><span>
      listItemBox</span><span>.</span><span>size</span><span>.</span><span>centerLeft</span><span>(</span><span>Offset</span><span>.</span><span>zero</span><span>),</span><span>
      ancestor</span><span>:</span><span> scrollableBox</span><span>);</span><span>
</span><span>}</span><span>

  </span><span>// Determine the percent position of this list item within the</span><span>
  </span><span>// scrollable area.</span><span>
  </span><span>final</span><span> viewportDimension </span><span>=</span><span> scrollable</span><span>.</span><span>position</span><span>.</span><span>viewportDimension</span><span>;</span><span>
  </span><span>final</span><span> scrollFraction </span><span>=</span><span>
      </span><span>(</span><span>listItemOffset</span><span>.</span><span>dy </span><span>/</span><span> viewportDimension</span><span>).</span><span>clamp</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
</span><span>}</span><span>
  </span><span>// Calculate the vertical alignment of the background</span><span>
  </span><span>// based on the scroll percent.</span><span>
  </span><span>final</span><span> verticalAlignment </span><span>=</span><span> </span><span>Alignment</span><span>(</span><span>0.0</span><span>,</span><span> scrollFraction </span><span>*</span><span> </span><span>2</span><span> </span><span>-</span><span> </span><span>1</span><span>);</span><span>
</span><span>}</span><span>
  </span><span>// Convert the background alignment into a pixel offset for</span><span>
  </span><span>// painting purposes.</span><span>
  </span><span>final</span><span> backgroundSize </span><span>=</span><span>
      </span><span>(</span><span>backgroundImageKey</span><span>.</span><span>currentContext</span><span>!.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>)</span><span>
          </span><span>.</span><span>size</span><span>;</span><span>
  </span><span>final</span><span> listItemSize </span><span>=</span><span> context</span><span>.</span><span>size</span><span>;</span><span>
  </span><span>final</span><span> childRect </span><span>=</span><span>
      verticalAlignment</span><span>.</span><span>inscribe</span><span>(</span><span>backgroundSize</span><span>,</span><span> </span><span>Offset</span><span>.</span><span>zero </span><span>&amp;</span><span> listItemSize</span><span>);</span><span>
</span><span>}</span>
```

Using `childRect`, paint the background image with the desired translation transformation. It’s this transformation over time that gives you the parallax effect.

```
<span>@override
</span><span>void</span><span> paintChildren</span><span>(</span><span>FlowPaintingContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>// Calculate the position of this list item within the viewport.</span><span>
  </span><span>final</span><span> scrollableBox </span><span>=</span><span> scrollable</span><span>.</span><span>context</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemBox </span><span>=</span><span> listItemContext</span><span>.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>;</span><span>
  </span><span>final</span><span> listItemOffset </span><span>=</span><span> listItemBox</span><span>.</span><span>localToGlobal</span><span>(</span><span>
      listItemBox</span><span>.</span><span>size</span><span>.</span><span>centerLeft</span><span>(</span><span>Offset</span><span>.</span><span>zero</span><span>),</span><span>
      ancestor</span><span>:</span><span> scrollableBox</span><span>);</span><span>
</span><span>}</span><span>

  </span><span>// Determine the percent position of this list item within the</span><span>
  </span><span>// scrollable area.</span><span>
  </span><span>final</span><span> viewportDimension </span><span>=</span><span> scrollable</span><span>.</span><span>position</span><span>.</span><span>viewportDimension</span><span>;</span><span>
  </span><span>final</span><span> scrollFraction </span><span>=</span><span>
      </span><span>(</span><span>listItemOffset</span><span>.</span><span>dy </span><span>/</span><span> viewportDimension</span><span>).</span><span>clamp</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
</span><span>}</span><span>
  </span><span>// Calculate the vertical alignment of the background</span><span>
  </span><span>// based on the scroll percent.</span><span>
  </span><span>final</span><span> verticalAlignment </span><span>=</span><span> </span><span>Alignment</span><span>(</span><span>0.0</span><span>,</span><span> scrollFraction </span><span>*</span><span> </span><span>2</span><span> </span><span>-</span><span> </span><span>1</span><span>);</span><span>
</span><span>}</span><span>
  </span><span>// Convert the background alignment into a pixel offset for</span><span>
  </span><span>// painting purposes.</span><span>
  </span><span>final</span><span> backgroundSize </span><span>=</span><span>
      </span><span>(</span><span>backgroundImageKey</span><span>.</span><span>currentContext</span><span>!.</span><span>findRenderObject</span><span>()</span><span> </span><span>as</span><span> </span><span>RenderBox</span><span>)</span><span>
          </span><span>.</span><span>size</span><span>;</span><span>
  </span><span>final</span><span> listItemSize </span><span>=</span><span> context</span><span>.</span><span>size</span><span>;</span><span>
  </span><span>final</span><span> childRect </span><span>=</span><span>
      verticalAlignment</span><span>.</span><span>inscribe</span><span>(</span><span>backgroundSize</span><span>,</span><span> </span><span>Offset</span><span>.</span><span>zero </span><span>&amp;</span><span> listItemSize</span><span>);</span><span>
</span><span>}</span><span>
  </span><span>// Paint the background.</span><span>
  context</span><span>.</span><span>paintChild</span><span>(</span><span>
    </span><span>0</span><span>,</span><span>
    transform</span><span>:</span><span>
        </span><span>Transform</span><span>.</span><span>translate</span><span>(</span><span>offset</span><span>:</span><span> </span><span>Offset</span><span>(</span><span>0.0</span><span>,</span><span> childRect</span><span>.</span><span>top</span><span>)).</span><span>transform</span><span>,</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

You need one final detail to achieve the parallax effect. The `ParallaxFlowDelegate` repaints when the inputs change, but the `ParallaxFlowDelegate` doesn’t repaint every time the scroll position changes.

Pass the `ScrollableState`’s `ScrollPosition` to the `FlowDelegate` superclass so that the `FlowDelegate` repaints every time the `ScrollPosition` changes.

```
<span>class</span><span> </span><span>ParallaxFlowDelegate</span><span> </span><span>extends</span><span> </span><span>FlowDelegate</span><span> </span><span>{</span><span>
  </span><span>ParallaxFlowDelegate</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>scrollable</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>listItemContext</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>backgroundImageKey</span><span>,</span><span>
  </span><span>})</span><span> </span><span>:</span><span> </span><span>super</span><span>(</span><span>repaint</span><span>:</span><span> scrollable</span><span>.</span><span>position</span><span>);</span><span>
</span><span>}</span>
```

Congratulations! You now have a list of cards with parallax, scrolling background images.

## Interactive example

Run the app:

-   Scroll up and down to observe the parallax effect.