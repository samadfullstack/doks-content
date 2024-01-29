1.  [UI](https://docs.flutter.dev/ui)
2.  [Animations](https://docs.flutter.dev/ui/animations)
3.  [Staggered](https://docs.flutter.dev/ui/animations/staggered-animations)

Staggered animations are a straightforward concept: visual changes happen as a series of operations, rather than all at once. The animation might be purely sequential, with one change occurring after the next, or it might partially or completely overlap. It might also have gaps, where no changes occur.

This guide shows how to build a staggered animation in Flutter.

The following video demonstrates the animation performed by basic\_staggered\_animation:

<iframe width="560" height="315" src="https://www.youtube.com/embed/0fFvnZemmh8?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Stagger Demo" frameborder="0" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="548510407" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

In the video, you see the following animation of a single widget, which begins as a bordered blue square with slightly rounded corners. The square runs through changes in the following order:

1.  Fades in
2.  Widens
3.  Becomes taller while moving upwards
4.  Transforms into a bordered circle
5.  Changes color to orange

After running forward, the animation runs in reverse.

## Basic structure of a staggered animation

The following diagram shows the `Interval`s used in the [basic\_staggered\_animation](https://github.com/flutter/website/tree/main/examples/_animation/basic_staggered_animation) example. You might notice the following characteristics:

-   The opacity changes during the first 10% of the timeline.
-   A tiny gap occurs between the change in opacity, and the change in width.
-   Nothing animates during the last 25% of the timeline.
-   Increasing the padding makes the widget appear to rise upward.
-   Increasing the border radius to 0.5, transforms the square with rounded corners into a circle.
-   The padding and height changes occur during the same exact interval, but they don’t have to.

![Diagram showing the interval specified for each motion](https://docs.flutter.dev/assets/images/docs/ui/animations/StaggeredAnimationIntervals.png)

To set up the animation:

-   Create an `AnimationController` that manages all of the `Animations`.
-   Create a `Tween` for each property being animated.
    -   The `Tween` defines a range of values.
    -   The `Tween`’s `animate` method requires the `parent` controller, and produces an `Animation` for that property.
-   Specify the interval on the `Animation`’s `curve` property.

When the controlling animation’s value changes, the new animation’s value changes, triggering the UI to update.

The following code creates a tween for the `width` property. It builds a [`CurvedAnimation`](https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html), specifying an eased curve. See [`Curves`](https://api.flutter.dev/flutter/animation/Curves-class.html) for other available pre-defined animation curves.

```
<span>width</span> <span>=</span> <span>Tween</span><span>&lt;</span><span>double</span><span>&gt;(</span>
  <span>begin:</span> <span>50.0</span><span>,</span>
  <span>end:</span> <span>150.0</span><span>,</span>
<span>)</span><span>.</span><span>animate</span><span>(</span>
  <span>CurvedAnimation</span><span>(</span>
    <span>parent:</span> <span>controller</span><span>,</span>
    <span>curve:</span> <span>const</span> <span>Interval</span><span>(</span>
      <span>0.125</span><span>,</span>
      <span>0.250</span><span>,</span>
      <span>curve:</span> <span>Curves</span><span>.</span><span>ease</span><span>,</span>
    <span>),</span>
  <span>),</span>
<span>),</span>
```

The `begin` and `end` values don’t have to be doubles. The following code builds the tween for the `borderRadius` property (which controls the roundness of the square’s corners), using `BorderRadius.circular()`.

```
<span>borderRadius</span> <span>=</span> <span>BorderRadiusTween</span><span>(</span>
  <span>begin:</span> <span>BorderRadius</span><span>.</span><span>circular</span><span>(</span><span>4</span><span>),</span>
  <span>end:</span> <span>BorderRadius</span><span>.</span><span>circular</span><span>(</span><span>75</span><span>),</span>
<span>)</span><span>.</span><span>animate</span><span>(</span>
  <span>CurvedAnimation</span><span>(</span>
    <span>parent:</span> <span>controller</span><span>,</span>
    <span>curve:</span> <span>const</span> <span>Interval</span><span>(</span>
      <span>0.375</span><span>,</span>
      <span>0.500</span><span>,</span>
      <span>curve:</span> <span>Curves</span><span>.</span><span>ease</span><span>,</span>
    <span>),</span>
  <span>),</span>
<span>),</span>
```

### Complete staggered animation

Like all interactive widgets, the complete animation consists of a widget pair: a stateless and a stateful widget.

The stateless widget specifies the `Tween`s, defines the `Animation` objects, and provides a `build()` function responsible for building the animating portion of the widget tree.

The stateful widget creates the controller, plays the animation, and builds the non-animating portion of the widget tree. The animation begins when a tap is detected anywhere in the screen.

[Full code for basic\_staggered\_animation’s main.dart](https://github.com/flutter/website/tree/main/examples/_animation/basic_staggered_animation/lib/main.dart)

### Stateless widget: StaggerAnimation

In the stateless widget, `StaggerAnimation`, the `build()` function instantiates an [`AnimatedBuilder`](https://api.flutter.dev/flutter/widgets/AnimatedBuilder-class.html)—a general purpose widget for building animations. The `AnimatedBuilder` builds a widget and configures it using the `Tweens`’ current values. The example creates a function named `_buildAnimation()` (which performs the actual UI updates), and assigns it to its `builder` property. AnimatedBuilder listens to notifications from the animation controller, marking the widget tree dirty as values change. For each tick of the animation, the values are updated, resulting in a call to `_buildAnimation()`.

```
<span><span>class</span><span> </span><span>StaggerAnimation</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span></span><span> </span><span>{</span><span>
  </span><span>StaggerAnimation</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>controller</span><span>})</span><span> </span><span>:</span><span>

    </span><span>// Each animation defined here transforms its value during the subset</span><span>
    </span><span>// of the controller's duration defined by the animation's interval.</span><span>
    </span><span>// For example the opacity animation transforms its value during</span><span>
    </span><span>// the first 10% of the controller's duration.</span><span>

    </span><span><span>opacity </span><span>=</span><span> </span><span>Tween</span><span>&lt;</span><span>double</span><span>&gt;</span></span><span>(</span><span>
      begin</span><span>:</span><span> </span><span>0.0</span><span>,</span><span>
      end</span><span>:</span><span> </span><span>1.0</span><span>,</span><span>
    </span><span>).</span><span>animate</span><span>(</span><span>
      </span><span>CurvedAnimation</span><span>(</span><span>
        parent</span><span>:</span><span> controller</span><span>,</span><span>
        curve</span><span>:</span><span> </span><span>const</span><span> </span><span>Interval</span><span>(</span><span>
          </span><span>0.0</span><span>,</span><span>
          </span><span>0.100</span><span>,</span><span>
          curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>ease</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>

    </span><span>// ... Other tween definitions ...</span><span>
    </span><span>);</span><span>

  </span><span><span>final</span><span> </span><span>AnimationController</span><span> controller</span><span>;</span></span><span>
  </span><span><span>final</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> opacity</span><span>;</span></span><span>
  </span><span><span>final</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> width</span><span>;</span></span><span>
  </span><span><span>final</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> height</span><span>;</span></span><span>
  </span><span><span>final</span><span> </span><span>Animation</span><span>&lt;</span><span>EdgeInsets</span><span>&gt;</span><span> padding</span><span>;</span></span><span>
  </span><span><span>final</span><span> </span><span>Animation</span><span>&lt;</span><span>BorderRadius</span><span>?&gt;</span><span> borderRadius</span><span>;</span></span><span>
  </span><span><span>final</span><span> </span><span>Animation</span><span>&lt;</span><span>Color</span><span>?&gt;</span><span> color</span><span>;</span></span><span>

  </span><span>// This function is called each time the controller "ticks" a new frame.</span><span>
  </span><span>// When it runs, all of the animation's values will have been</span><span>
  </span><span>// updated to reflect the controller's current value.</span><span>
  </span><span><span>Widget</span><span> _buildAnimation</span><span>(</span><span>BuildContext</span><span> context</span><span>,</span><span> </span><span>Widget</span><span>?</span><span> child</span><span>)</span></span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Container</span><span>(</span><span>
      padding</span><span>:</span><span> padding</span><span>.</span><span>value</span><span>,</span><span>
      alignment</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>bottomCenter</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>Opacity</span><span>(</span><span>
        opacity</span><span>:</span><span> opacity</span><span>.</span><span>value</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
          width</span><span>:</span><span> width</span><span>.</span><span>value</span><span>,</span><span>
          height</span><span>:</span><span> height</span><span>.</span><span>value</span><span>,</span><span>
          decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
            color</span><span>:</span><span> color</span><span>.</span><span>value</span><span>,</span><span>
            border</span><span>:</span><span> </span><span>Border</span><span>.</span><span>all</span><span>(</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>indigo</span><span>[</span><span>300</span><span>]!,</span><span>
              width</span><span>:</span><span> </span><span>3</span><span>,</span><span>
            </span><span>),</span><span>
            borderRadius</span><span>:</span><span> borderRadius</span><span>.</span><span>value</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span></span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span><span>AnimatedBuilder</span></span><span>(</span><span>
      </span><span><span>builder</span><span>:</span><span> _buildAnimation</span></span><span>,</span><span>
      animation</span><span>:</span><span> controller</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Stateful widget: StaggerDemo

The stateful widget, `StaggerDemo`, creates the `AnimationController` (the one who rules them all), specifying a 2000 ms duration. It plays the animation, and builds the non-animating portion of the widget tree. The animation begins when a tap is detected in the screen. The animation runs forward, then backward.

```
<span><span>class</span><span> </span><span>StaggerDemo</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span></span><span> </span><span>{</span><span>
  @override
  </span><span>State</span><span>&lt;</span><span>StaggerDemo</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _StaggerDemoState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _StaggerDemoState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>StaggerDemo</span><span>&gt;</span><span>
    </span><span>with</span><span> </span><span>TickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>AnimationController_controller</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>

    _controller </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
      duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>2000</span><span>),</span><span>
      vsync</span><span>:</span><span> </span><span>this</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>// ...Boilerplate...</span><span>

  </span><span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _playAnimation</span><span>()</span><span> </span><span>async</span></span><span> </span><span>{</span><span>
    </span><span>try</span><span> </span><span>{</span><span>
      </span><span><span>await</span><span> _controller</span><span>.</span><span>forward</span><span>().</span><span>orCancel</span><span>;</span></span><span>
      </span><span><span>await</span><span> _controller</span><span>.</span><span>reverse</span><span>().</span><span>orCancel</span><span>;</span></span><span>
    </span><span>}</span><span> </span><span>on</span><span> </span><span>TickerCanceled</span><span> </span><span>{</span><span>
      </span><span>// The animation got canceled, probably because it was disposed of.</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  @override
  </span><span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span></span><span> </span><span>{</span><span>
    timeDilation </span><span>=</span><span> </span><span>10.0</span><span>;</span><span> </span><span>// 1.0 is normal animation speed.</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Staggered Animation'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>GestureDetector</span><span>(</span><span>
        behavior</span><span>:</span><span> </span><span>HitTestBehavior</span><span>.</span><span>opaque</span><span>,</span><span>
        onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          _playAnimation</span><span>();</span><span>
        </span><span>},</span><span>
        child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
            width</span><span>:</span><span> </span><span>300</span><span>,</span><span>
            height</span><span>:</span><span> </span><span>300</span><span>,</span><span>
            decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black</span><span>.</span><span>withOpacity</span><span>(</span><span>0.1</span><span>),</span><span>
              border</span><span>:</span><span> </span><span>Border</span><span>.</span><span>all</span><span>(</span><span>
                color</span><span>:</span><span>  </span><span>Colors</span><span>.</span><span>black</span><span>.</span><span>withOpacity</span><span>(</span><span>0.5</span><span>),</span><span>
              </span><span>),</span><span>
            </span><span>),</span><span>
            child</span><span>:</span><span> </span><span>StaggerAnimation</span><span>(</span><span>controller</span><span>:</span><span>_controller</span><span>.</span><span>view</span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```