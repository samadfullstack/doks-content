1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Animation](https://docs.flutter.dev/cookbook/animation)
3.  [Animate a page route transition](https://docs.flutter.dev/cookbook/animation/page-route-animation)

A design language, such as Material, defines standard behaviors when transitioning between routes (or screens). Sometimes, though, a custom transition between screens can make an app more unique. To help, [`PageRouteBuilder`](https://api.flutter.dev/flutter/widgets/PageRouteBuilder-class.html) provides an [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html) object. This `Animation` can be used with [`Tween`](https://api.flutter.dev/flutter/animation/Tween-class.html) and [`Curve`](https://api.flutter.dev/flutter/animation/Curve-class.html) objects to customize the transition animation. This recipe shows how to transition between routes by animating the new route into view from the bottom of the screen.

To create a custom page route transition, this recipe uses the following steps:

1.  Set up a PageRouteBuilder
2.  Create a `Tween`
3.  Add an `AnimatedWidget`
4.  Use a `CurveTween`
5.  Combine the two `Tween`s

To start, use a [`PageRouteBuilder`](https://api.flutter.dev/flutter/widgets/PageRouteBuilder-class.html) to create a [`Route`](https://api.flutter.dev/flutter/widgets/Route-class.html). `PageRouteBuilder` has two callbacks, one to build the content of the route (`pageBuilder`), and one to build the route’s transition (`transitionsBuilder`).

The following example creates two routes: a home route with a “Go!” button, and a second route titled “Page 2”.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      home</span><span>:</span><span> </span><span>Page1</span><span>(),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>Page1</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>Page1</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
            </span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>push</span><span>(</span><span>_createRoute</span><span>());</span><span>
          </span><span>},</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Go!'</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>Route</span><span> _createRoute</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>PageRouteBuilder</span><span>(</span><span>
    pageBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> animation</span><span>,</span><span> secondaryAnimation</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>Page2</span><span>(),</span><span>
    transitionsBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> animation</span><span>,</span><span> secondaryAnimation</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> child</span><span>;</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>Page2</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>Page2</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(),</span><span>
      body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Page 2'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 2\. Create a Tween

To make the new page animate in from the bottom, it should animate from `Offset(0,1)` to `Offset(0, 0)` (usually defined using the `Offset.zero` constructor). In this case, the Offset is a 2D vector for the [‘FractionalTranslation’](https://api.flutter.dev/flutter/widgets/FractionalTranslation-class.html) widget. Setting the `dy` argument to 1 represents a vertical translation one full height of the page.

The `transitionsBuilder` callback has an `animation` parameter. It’s an `Animation<double>` that produces values between 0 and 1. Convert the Animation into an Animation using a Tween:

```
<span>transitionsBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> animation</span><span>,</span><span> secondaryAnimation</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
  </span><span>const</span><span> begin </span><span>=</span><span> </span><span>Offset</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
  </span><span>const</span><span> end </span><span>=</span><span> </span><span>Offset</span><span>.</span><span>zero</span><span>;</span><span>
  </span><span>final</span><span> tween </span><span>=</span><span> </span><span>Tween</span><span>(</span><span>begin</span><span>:</span><span> begin</span><span>,</span><span> end</span><span>:</span><span> end</span><span>);</span><span>
  </span><span>final</span><span> offsetAnimation </span><span>=</span><span> animation</span><span>.</span><span>drive</span><span>(</span><span>tween</span><span>);</span><span>
  </span><span>return</span><span> child</span><span>;</span><span>
</span><span>},</span>
```

Flutter has a set of widgets extending [`AnimatedWidget`](https://api.flutter.dev/flutter/widgets/AnimatedWidget-class.html) that rebuild themselves when the value of the animation changes. For instance, SlideTransition takes an `Animation<Offset>` and translates its child (using a FractionalTranslation widget) whenever the value of the animation changes.

AnimatedWidget Return a [`SlideTransition`](https://api.flutter.dev/flutter/widgets/SlideTransition-class.html) with the `Animation<Offset>` and the child widget:

```
<span>transitionsBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> animation</span><span>,</span><span> secondaryAnimation</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
  </span><span>const</span><span> begin </span><span>=</span><span> </span><span>Offset</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
  </span><span>const</span><span> end </span><span>=</span><span> </span><span>Offset</span><span>.</span><span>zero</span><span>;</span><span>
  </span><span>final</span><span> tween </span><span>=</span><span> </span><span>Tween</span><span>(</span><span>begin</span><span>:</span><span> begin</span><span>,</span><span> end</span><span>:</span><span> end</span><span>);</span><span>
  </span><span>final</span><span> offsetAnimation </span><span>=</span><span> animation</span><span>.</span><span>drive</span><span>(</span><span>tween</span><span>);</span><span>

  </span><span>return</span><span> </span><span>SlideTransition</span><span>(</span><span>
    position</span><span>:</span><span> offsetAnimation</span><span>,</span><span>
    child</span><span>:</span><span> child</span><span>,</span><span>
  </span><span>);</span><span>
</span><span>},</span>
```

## 4\. Use a CurveTween

Flutter provides a selection of easing curves that adjust the rate of the animation over time. The [`Curves`](https://api.flutter.dev/flutter/animation/Curves-class.html) class provides a predefined set of commonly used curves. For example, `Curves.easeOut` makes the animation start quickly and end slowly.

To use a Curve, create a new [`CurveTween`](https://api.flutter.dev/flutter/animation/CurveTween-class.html) and pass it a Curve:

```
<span>var</span><span> curve </span><span>=</span><span> </span><span>Curves</span><span>.</span><span>ease</span><span>;</span><span>
</span><span>var</span><span> curveTween </span><span>=</span><span> </span><span>CurveTween</span><span>(</span><span>curve</span><span>:</span><span> curve</span><span>);</span>
```

This new Tween still produces values from 0 to 1. In the next step, it will be combined the `Tween<Offset>` from step 2.

## 5\. Combine the two Tweens

To combine the tweens, use [`chain()`](https://api.flutter.dev/flutter/animation/Animatable/chain.html):

```
<span>const</span><span> begin </span><span>=</span><span> </span><span>Offset</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
</span><span>const</span><span> end </span><span>=</span><span> </span><span>Offset</span><span>.</span><span>zero</span><span>;</span><span>
</span><span>const</span><span> curve </span><span>=</span><span> </span><span>Curves</span><span>.</span><span>ease</span><span>;</span><span>

</span><span>var</span><span> tween </span><span>=</span><span> </span><span>Tween</span><span>(</span><span>begin</span><span>:</span><span> begin</span><span>,</span><span> end</span><span>:</span><span> end</span><span>).</span><span>chain</span><span>(</span><span>CurveTween</span><span>(</span><span>curve</span><span>:</span><span> curve</span><span>));</span>
```

Then use this tween by passing it to `animation.drive()`. This creates a new `Animation<Offset>` that can be given to the `SlideTransition` widget:

```
<span>return</span><span> </span><span>SlideTransition</span><span>(</span><span>
  position</span><span>:</span><span> animation</span><span>.</span><span>drive</span><span>(</span><span>tween</span><span>),</span><span>
  child</span><span>:</span><span> child</span><span>,</span><span>
</span><span>);</span>
```

This new Tween (or Animatable) produces `Offset` values by first evaluating the `CurveTween`, then evaluating the `Tween<Offset>.` When the animation runs, the values are computed in this order:

1.  The animation (provided to the transitionsBuilder callback) produces values from 0 to 1.
2.  The CurveTween maps those values to new values between 0 and 1 based on its curve.
3.  The `Tween<Offset>` maps the `double` values to `Offset` values.

Another way to create an `Animation<Offset>` with an easing curve is to use a `CurvedAnimation`:

```
<span>transitionsBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> animation</span><span>,</span><span> secondaryAnimation</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
  </span><span>const</span><span> begin </span><span>=</span><span> </span><span>Offset</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
  </span><span>const</span><span> end </span><span>=</span><span> </span><span>Offset</span><span>.</span><span>zero</span><span>;</span><span>
  </span><span>const</span><span> curve </span><span>=</span><span> </span><span>Curves</span><span>.</span><span>ease</span><span>;</span><span>

  </span><span>final</span><span> tween </span><span>=</span><span> </span><span>Tween</span><span>(</span><span>begin</span><span>:</span><span> begin</span><span>,</span><span> end</span><span>:</span><span> end</span><span>);</span><span>
  </span><span>final</span><span> curvedAnimation </span><span>=</span><span> </span><span>CurvedAnimation</span><span>(</span><span>
    parent</span><span>:</span><span> animation</span><span>,</span><span>
    curve</span><span>:</span><span> curve</span><span>,</span><span>
  </span><span>);</span><span>

  </span><span>return</span><span> </span><span>SlideTransition</span><span>(</span><span>
    position</span><span>:</span><span> tween</span><span>.</span><span>animate</span><span>(</span><span>curvedAnimation</span><span>),</span><span>
    child</span><span>:</span><span> child</span><span>,</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

## Interactive example