1.  [UI](https://docs.flutter.dev/ui)
2.  [Animations](https://docs.flutter.dev/ui/animations)
3.  [Hero](https://docs.flutter.dev/ui/animations/hero-animations)

You’ve probably seen hero animations many times. For example, a screen displays a list of thumbnails representing items for sale. Selecting an item flies it to a new screen, containing more details and a “Buy” button. Flying an image from one screen to another is called a _hero animation_ in Flutter, though the same motion is sometimes referred to as a _shared element transition_.

You might want to watch this one-minute video introducing the Hero widget:

<iframe width="560" height="315" src="https://www.youtube.com/embed/Be9UH1kXFDw?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Hero (Flutter Widget of the Week)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="311765411" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

This guide demonstrates how to build standard hero animations, and hero animations that transform the image from a circular shape to a square shape during flight.

You can create this animation in Flutter with Hero widgets. As the hero animates from the source to the destination route, the destination route (minus the hero) fades into view. Typically, heroes are small parts of the UI, like images, that both routes have in common. From the user’s perspective the hero “flies” between the routes. This guide shows how to create the following hero animations:

**Standard hero animations**  

A _standard hero animation_ flies the hero from one route to a new route, usually landing at a different location and with a different size.

The following video (recorded at slow speed) shows a typical example. Tapping the flippers in the center of the route flies them to the upper left corner of a new, blue route, at a smaller size. Tapping the flippers in the blue route (or using the device’s back-to-previous-route gesture) flies the flippers back to the original route.

<iframe width="560" height="315" src="https://www.youtube.com/embed/CEcFnqRDfgw?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Standard Hero Animation" frameborder="0" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="229178412" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

  
**Radial hero animations**  

In _radial hero animation_, as the hero flies between routes its shape appears to change from circular to rectangular.

The following video (recorded at slow speed), shows an example of a radial hero animation. At the start, a row of three circular images appears at the bottom of the route. Tapping any of the circular images flies that image to a new route that displays it with a square shape. Tapping the square image flies the hero back to the original route, displayed with a circular shape.

<iframe width="560" height="315" src="https://www.youtube.com/embed/LWKENpwDKiM?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Radial Hero Animation" frameborder="0" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="658266052" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

  
Before moving to the sections specific to [standard](https://docs.flutter.dev/ui/animations/hero-animations#standard-hero-animations) or [radial](https://docs.flutter.dev/ui/animations/hero-animations#radial-hero-animations) hero animations, read [basic structure of a hero animation](https://docs.flutter.dev/ui/animations/hero-animations#basic-structure) to learn how to structure hero animation code, and [behind the scenes](https://docs.flutter.dev/ui/animations/hero-animations#behind-the-scenes) to understand how Flutter performs a hero animation.

## Basic structure of a hero animation

Hero animations are implemented using two [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html) widgets: one describing the widget in the source route, and another describing the widget in the destination route. From the user’s point of view, the hero appears to be shared, and only the programmer needs to understand this implementation detail. Hero animation code has the following structure:

1.  Define a starting Hero widget, referred to as the _source hero_. The hero specifies its graphical representation (typically an image), and an identifying tag, and is in the currently displayed widget tree as defined by the source route.
2.  Define an ending Hero widget, referred to as the _destination hero_. This hero also specifies its graphical representation, and the same tag as the source hero. It’s **essential that both hero widgets are created with the same tag**, typically an object that represents the underlying data. For best results, the heroes should have virtually identical widget trees.
3.  Create a route that contains the destination hero. The destination route defines the widget tree that exists at the end of the animation.
4.  Trigger the animation by pushing the destination route on the Navigator’s stack. The Navigator push and pop operations trigger a hero animation for each pair of heroes with matching tags in the source and destination routes.

Flutter calculates the tween that animates the Hero’s bounds from the starting point to the endpoint (interpolating size and position), and performs the animation in an overlay.

The next section describes Flutter’s process in greater detail.

## Behind the scenes

The following describes how Flutter performs the transition from one route to another.

![Before the transition the source hero appears in the source route](https://docs.flutter.dev/assets/images/docs/ui/animations/hero-transition-0.png)

Before transition, the source hero waits in the source route’s widget tree. The destination route does not yet exist, and the overlay is empty.

___

![The transition begins](https://docs.flutter.dev/assets/images/docs/ui/animations/hero-transition-1.png)

Pushing a route to the `Navigator` triggers the animation. At `t=0.0`, Flutter does the following:

-   Calculates the destination hero’s path, offscreen, using the curved motion as described in the Material motion spec. Flutter now knows where the hero ends up.
    
-   Places the destination hero in the overlay, at the same location and size as the _source_ hero. Adding a hero to the overlay changes its Z-order so that it appears on top of all routes.
    
-   Moves the source hero offscreen.
    

___

![The hero flies in the overlay to its final position and size](https://docs.flutter.dev/assets/images/docs/ui/animations/hero-transition-2.png)

As the hero flies, its rectangular bounds are animated using [Tween<Rect>](https://api.flutter.dev/flutter/animation/Tween-class.html), specified in Hero’s [`createRectTween`](https://api.flutter.dev/flutter/widgets/CreateRectTween.html) property. By default, Flutter uses an instance of [`MaterialRectArcTween`](https://api.flutter.dev/flutter/material/MaterialRectArcTween-class.html), which animates the rectangle’s opposing corners along a curved path. (See [Radial hero animations](https://docs.flutter.dev/ui/animations/hero-animations#radial-hero-animations) for an example that uses a different Tween animation.)

___

![When the transition is complete, the hero is moved from the overlay to the destination route](https://docs.flutter.dev/assets/images/docs/ui/animations/hero-transition-3.png)

When the flight completes:

-   Flutter moves the hero widget from the overlay to the destination route. The overlay is now empty.
    
-   The destination hero appears in its final position in the destination route.
    
-   The source hero is restored to its route.
    

___

Popping the route performs the same process, animating the hero back to its size and location in the source route.

### Essential classes

The examples in this guide use the following classes to implement hero animations:

[`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html)

The widget that flies from the source to the destination route. Define one Hero for the source route and another for the destination route, and assign each the same tag. Flutter animates pairs of heroes with matching tags.

[`InkWell`](https://api.flutter.dev/flutter/material/InkWell-class.html)

Specifies what happens when tapping the hero. The `InkWell`’s `onTap()` method builds the new route and pushes it to the `Navigator`’s stack.

[`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html)

The `Navigator` manages a stack of routes. Pushing a route on or popping a route from the `Navigator`’s stack triggers the animation.

[`Route`](https://api.flutter.dev/flutter/widgets/Route-class.html)

Specifies a screen or page. Most apps, beyond the most basic, have multiple routes.

## Standard hero animations

### What’s going on?

Flying an image from one route to another is easy to implement using Flutter’s hero widget. When using `MaterialPageRoute` to specify the new route, the image flies along a curved path, as described by the [Material Design motion spec](https://m2.material.io/design/motion/understanding-motion.html#principles).

[Create a new Flutter example](https://docs.flutter.dev/get-started/test-drive) and update it using the files from the [hero\_animation](https://github.com/flutter/website/tree/main/examples/_animation/hero_animation/).

To run the example:

-   Tap on the home route’s photo to fly the image to a new route showing the same photo at a different location and scale.
-   Return to the previous route by tapping the image, or by using the device’s back-to-the-previous-route gesture.
-   You can slow the transition further using the `timeDilation` property.

### PhotoHero class

The custom PhotoHero class maintains the hero, and its size, image, and behavior when tapped. The PhotoHero builds the following widget tree:

![PhotoHero class widget tree](https://docs.flutter.dev/assets/images/docs/ui/animations/photohero-class.png)

Here’s the code:

```
<span>class</span> <span>PhotoHero</span> <span>extends</span> <span>StatelessWidget</span> <span>{</span>
  <span>const</span> <span>PhotoHero</span><span>({</span>
    <span>super</span><span>.</span><span>key</span><span>,</span>
    <span>required</span> <span>this</span><span>.</span><span>photo</span><span>,</span>
    <span>this</span><span>.</span><span>onTap</span><span>,</span>
    <span>required</span> <span>this</span><span>.</span><span>width</span><span>,</span>
  <span>});</span>

  <span>final</span> <span>String</span> <span>photo</span><span>;</span>
  <span>final</span> <span>VoidCallback</span><span>?</span> <span>onTap</span><span>;</span>
  <span>final</span> <span>double</span> <span>width</span><span>;</span>

  <span>@override</span>
  <span>Widget</span> <span>build</span><span>(</span><span>BuildContext</span> <span>context</span><span>)</span> <span>{</span>
    <span>return</span> <span>SizedBox</span><span>(</span>
      <span>width:</span> <span>width</span><span>,</span>
      <span>child:</span> <span>Hero</span><span>(</span>
        <span>tag:</span> <span>photo</span><span>,</span>
        <span>child:</span> <span>Material</span><span>(</span>
          <span>color:</span> <span>Colors</span><span>.</span><span>transparent</span><span>,</span>
          <span>child:</span> <span>InkWell</span><span>(</span>
            <span>onTap:</span> <span>onTap</span><span>,</span>
            <span>child:</span> <span>Image</span><span>.</span><span>asset</span><span>(</span>
              <span>photo</span><span>,</span>
              <span>fit:</span> <span>BoxFit</span><span>.</span><span>contain</span><span>,</span>
            <span>),</span>
          <span>),</span>
        <span>),</span>
      <span>),</span>
    <span>);</span>
  <span>}</span>
<span>}</span>
```

Key information:

-   The starting route is implicitly pushed by `MaterialApp` when `HeroAnimation` is provided as the app’s home property.
-   An `InkWell` wraps the image, making it trivial to add a tap gesture to the both the source and destination heroes.
-   Defining the Material widget with a transparent color enables the image to “pop out” of the background as it flies to its destination.
-   The `SizedBox` specifies the hero’s size at the start and end of the animation.
-   Setting the Image’s `fit` property to `BoxFit.contain`, ensures that the image is as large as possible during the transition without changing its aspect ratio.

### HeroAnimation class

The `HeroAnimation` class creates the source and destination PhotoHeroes, and sets up the transition.

Here’s the code:

```
<span>class</span><span> </span><span>HeroAnimation</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>HeroAnimation</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span><span>timeDilation </span><span>=</span><span> </span><span>5.0</span><span>;</span><span> </span><span>// 1.0 means normal animation speed.</span></span><span>

    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Basic Hero Animation'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        </span><span><span>child</span><span>:</span><span> </span><span>PhotoHero</span><span>(</span></span><span>
          photo</span><span>:</span><span> </span><span>'images/flippers-alpha.png'</span><span>,</span><span>
          width</span><span>:</span><span> </span><span>300.0</span><span>,</span><span>
          </span><span><span>onTap</span><span>:</span><span> </span><span>()</span></span><span> </span><span>{</span><span>
            </span><span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>push</span><span>(</span><span>MaterialPageRoute</span><span>&lt;</span><span>void</span><span>&gt;(</span></span><span>
              </span><span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span></span><span> </span><span>{</span><span>
                </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
                  appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
                    title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Flippers Page'</span><span>),</span><span>
                  </span><span>),</span><span>
                  body</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
                    </span><span>// Set background to blue to emphasize that it's a new route.</span><span>
                    color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>lightBlueAccent</span><span>,</span><span>
                    padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
                    alignment</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>topLeft</span><span>,</span><span>
                    </span><span><span>child</span><span>:</span><span> </span><span>PhotoHero</span><span>(</span></span><span>
                      photo</span><span>:</span><span> </span><span>'images/flippers-alpha.png'</span><span>,</span><span>
                      width</span><span>:</span><span> </span><span>100.0</span><span>,</span><span>
                      </span><span><span>onTap</span><span>:</span><span> </span><span>()</span></span><span> </span><span>{</span><span>
                        </span><span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pop</span><span>();</span></span><span>
                      </span><span>},</span><span>
                    </span><span>),</span><span>
                  </span><span>),</span><span>
                </span><span>);</span><span>
              </span><span>}</span><span>
            </span><span>));</span><span>
          </span><span>},</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Key information:

-   When the user taps the `InkWell` containing the source hero, the code creates the destination route using `MaterialPageRoute`. Pushing the destination route to the `Navigator`’s stack triggers the animation.
-   The `Container` positions the `PhotoHero` in the destination route’s top-left corner, below the `AppBar`.
-   The `onTap()` method for the destination `PhotoHero` pops the `Navigator`’s stack, triggering the animation that flies the `Hero` back to the original route.
-   Use the `timeDilation` property to slow the transition while debugging.

___

## Radial hero animations

Flying a hero from one route to another as it transforms from a circular shape to a rectangular shape is a slick effect that you can implement using Hero widgets. To accomplish this, the code animates the intersection of two clip shapes: a circle and a square. Throughout the animation, the circle clip (and the image) scales from `minRadius` to `maxRadius`, while the square clip maintains constant size. At the same time, the image flies from its position in the source route to its position in the destination route. For visual examples of this transition, see [Radial transformation](https://web.archive.org/web/20180223140424/https://material.io/guidelines/motion/transforming-material.html) in the Material motion spec.

This animation might seem complex (and it is), but you can **customize the provided example to your needs.** The heavy lifting is done for you.

### What’s going on?

The following diagram shows the clipped image at the beginning (`t = 0.0`), and the end (`t = 1.0`) of the animation.

![Radial transformation from beginning to end](https://docs.flutter.dev/assets/images/docs/ui/animations/radial-hero-animation.png)

The blue gradient (representing the image), indicates where the clip shapes intersect. At the beginning of the transition, the result of the intersection is a circular clip ([`ClipOval`](https://api.flutter.dev/flutter/widgets/ClipOval-class.html)). During the transformation, the `ClipOval` scales from `minRadius` to `maxRadius` while the [ClipRect](https://api.flutter.dev/flutter/widgets/ClipRect-class.html) maintains a constant size. At the end of the transition the intersection of the circular and rectangular clips yield a rectangle that’s the same size as the hero widget. In other words, at the end of the transition the image is no longer clipped.

[Create a new Flutter example](https://docs.flutter.dev/get-started/test-drive) and update it using the files from the [radial\_hero\_animation](https://github.com/flutter/website/tree/main/examples/_animation/radial_hero_animation) GitHub directory.

To run the example:

-   Tap on one of the three circular thumbnails to animate the image to a larger square positioned in the middle of a new route that obscures the original route.
-   Return to the previous route by tapping the image, or by using the device’s back-to-the-previous-route gesture.
-   You can slow the transition further using the `timeDilation` property.

### Photo class

The `Photo` class builds the widget tree that holds the image:

```
<span>class</span><span> </span><span>Photo</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>Photo</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>photo</span><span>,</span><span> </span><span>this</span><span>.</span><span>color</span><span>,</span><span> </span><span>this</span><span>.</span><span>onTap</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> photo</span><span>;</span><span>
  </span><span>final</span><span> </span><span>Color</span><span>?</span><span> color</span><span>;</span><span>
  </span><span>final</span><span> </span><span>VoidCallback</span><span> onTap</span><span>;</span><span>

  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span><span>Material</span><span>(</span></span><span>
      </span><span>// Slightly opaque color appears where the image has transparency.</span><span>
      </span><span><span>color</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>primaryColor</span><span>.</span><span>withOpacity</span><span>(</span><span>0.25</span><span>),</span></span><span>
      child</span><span>:</span><span> </span><span><span>InkWell</span><span>(</span></span><span>
        onTap</span><span>:</span><span> </span><span><span>onTap</span><span>,</span></span><span>
        child</span><span>:</span><span> </span><span><span>Image</span><span>.</span><span>asset</span><span>(</span></span><span>
          photo</span><span>,</span><span>
          fit</span><span>:</span><span> </span><span>BoxFit</span><span>.</span><span>contain</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Key information:

-   The `InkWell` captures the tap gesture. The calling function passes the `onTap()` function to the `Photo`’s constructor.
-   During flight, the `InkWell` draws its splash on its first Material ancestor.
-   The Material widget has a slightly opaque color, so the transparent portions of the image are rendered with color. This ensures that the circle-to-square transition is easy to see, even for images with transparency.
-   The `Photo` class does not include the `Hero` in its widget tree. For the animation to work, the hero wraps the `RadialExpansion` widget.

### RadialExpansion class

The `RadialExpansion` widget, the core of the demo, builds the widget tree that clips the image during the transition. The clipped shape results from the intersection of a circular clip (that grows during flight), with a rectangular clip (that remains a constant size throughout).

To do this, it builds the following widget tree:

![RadialExpansion widget tree](https://docs.flutter.dev/assets/images/docs/ui/animations/radial-expansion-class.png)

Here’s the code:

```
<span>class</span><span> </span><span>RadialExpansion</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>RadialExpansion</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>maxRadius</span><span>,</span><span>
    </span><span>this</span><span>.</span><span>child</span><span>,</span><span>
  </span><span>})</span><span> </span><span>:</span><span> </span><span><span>clipRectSize </span><span>=</span><span> </span><span>2.0</span><span> </span><span>*</span><span> </span><span>(</span><span>maxRadius </span><span>/</span><span> math</span><span>.</span><span>sqrt2</span><span>);</span></span><span>

  </span><span>final</span><span> </span><span>double</span><span> maxRadius</span><span>;</span><span>
  </span><span>final</span><span> clipRectSize</span><span>;</span><span>
  </span><span>final</span><span> </span><span>Widget</span><span> child</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span><span>ClipOval</span><span>(</span></span><span>
      child</span><span>:</span><span> </span><span><span>Center</span><span>(</span></span><span>
        child</span><span>:</span><span> </span><span><span>SizedBox</span><span>(</span></span><span>
          width</span><span>:</span><span> clipRectSize</span><span>,</span><span>
          height</span><span>:</span><span> clipRectSize</span><span>,</span><span>
          child</span><span>:</span><span> </span><span><span>ClipRect</span><span>(</span></span><span>
            child</span><span>:</span><span> </span><span><span>child</span><span>,</span></span><span> </span><span>// Photo</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Key information:

-   The hero wraps the `RadialExpansion` widget.
-   As the hero flies, its size changes and, because it constrains its child’s size, the `RadialExpansion` widget changes size to match.
-   The `RadialExpansion` animation is created by two overlapping clips.
-   The example defines the tweening interpolation using [`MaterialRectCenterArcTween`](https://api.flutter.dev/flutter/material/MaterialRectCenterArcTween-class.html). The default flight path for a hero animation interpolates the tweens using the corners of the heroes. This approach affects the hero’s aspect ratio during the radial transformation, so the new flight path uses `MaterialRectCenterArcTween` to interpolate the tweens using the center point of each hero.
    
    Here’s the code:
    
    ```
    <span>static</span> <span>RectTween</span> <span>_createRectTween</span><span>(</span><span>Rect</span><span>?</span> <span>begin</span><span>,</span> <span>Rect</span><span>?</span> <span>end</span><span>)</span> <span>{</span>
      <span>return</span> <span>MaterialRectCenterArcTween</span><span>(</span><span>begin:</span> <span>begin</span><span>,</span> <span>end:</span> <span>end</span><span>);</span>
    <span>}</span>
    ```
    
    The hero’s flight path still follows an arc, but the image’s aspect ratio remains constant.