1.  [UI](https://docs.flutter.dev/ui)
2.  [Animations](https://docs.flutter.dev/ui/animations)
3.  [Tutorial](https://docs.flutter.dev/ui/animations/tutorial)

This tutorial shows you how to build explicit animations in Flutter. After introducing some of the essential concepts, classes, and methods in the animation library, it walks you through 5 animation examples. The examples build on each other, introducing you to different aspects of the animation library.

The Flutter SDK also provides built-in explicit animations, such as [`FadeTransition`](https://api.flutter.dev/flutter/widgets/FadeTransition-class.html), [`SizeTransition`](https://api.flutter.dev/flutter/widgets/SizeTransition-class.html), and [`SlideTransition`](https://api.flutter.dev/flutter/widgets/SlideTransition-class.html). These simple animations are triggered by setting a beginning and ending point. They are simpler to implement than custom explicit animations, which are described here.

## Essential animation concepts and classes

The animation system in Flutter is based on typed [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html) objects. Widgets can either incorporate these animations in their build functions directly by reading their current value and listening to their state changes or they can use the animations as the basis of more elaborate animations that they pass along to other widgets.

### Animation<double>

In Flutter, an `Animation` object knows nothing about what is onscreen. An `Animation` is an abstract class that understands its current value and its state (completed or dismissed). One of the more commonly used animation types is `Animation<double>`.

An `Animation` object sequentially generates interpolated numbers between two values over a certain duration. The output of an `Animation` object might be linear, a curve, a step function, or any other mapping you can devise. Depending on how the `Animation` object is controlled, it could run in reverse, or even switch directions in the middle.

Animations can also interpolate types other than double, such as `Animation<Color>` or `Animation<Size>`.

An `Animation` object has state. Its current value is always available in the `.value` member.

An `Animation` object knows nothing about rendering or `build()` functions.

### CurvedAnimation

A [`CurvedAnimation`](https://api.flutter.dev/flutter/animation/CurvedAnimation-class.html) defines the animation’s progress as a non-linear curve.

```
<span>animation </span><span>=</span><span> </span><span>CurvedAnimation</span><span>(</span><span>parent</span><span>:</span><span> controller</span><span>,</span><span> curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>easeIn</span><span>);</span>
```

`CurvedAnimation` and `AnimationController` (described in the next section) are both of type `Animation<double>`, so you can pass them interchangeably. The `CurvedAnimation` wraps the object it’s modifying—you don’t subclass `AnimationController` to implement a curve.

### AnimationController

[`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html) is a special `Animation` object that generates a new value whenever the hardware is ready for a new frame. By default, an `AnimationController` linearly produces the numbers from 0.0 to 1.0 during a given duration. For example, this code creates an `Animation` object, but does not start it running:

```
<span>controller </span><span>=</span><span>
    </span><span>AnimationController</span><span>(</span><span>duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>seconds</span><span>:</span><span> </span><span>2</span><span>),</span><span> vsync</span><span>:</span><span> </span><span>this</span><span>);</span>
```

`AnimationController` derives from `Animation<double>`, so it can be used wherever an `Animation` object is needed. However, the `AnimationController` has additional methods to control the animation. For example, you start an animation with the `.forward()` method. The generation of numbers is tied to the screen refresh, so typically 60 numbers are generated per second. After each number is generated, each `Animation` object calls the attached `Listener` objects. To create a custom display list for each child, see [`RepaintBoundary`](https://api.flutter.dev/flutter/widgets/RepaintBoundary-class.html).

When creating an `AnimationController`, you pass it a `vsync` argument. The presence of `vsync` prevents offscreen animations from consuming unnecessary resources. You can use your stateful object as the vsync by adding `SingleTickerProviderStateMixin` to the class definition. You can see an example of this in [animate1](https://github.com/flutter/website/tree/main/examples/animation/animate1) on GitHub.

### Tween

By default, the `AnimationController` object ranges from 0.0 to 1.0. If you need a different range or a different data type, you can use a [`Tween`](https://api.flutter.dev/flutter/animation/Tween-class.html) to configure an animation to interpolate to a different range or data type. For example, the following `Tween` goes from -200.0 to 0.0:

```
<span>tween </span><span>=</span><span> </span><span>Tween</span><span>&lt;</span><span>double</span><span>&gt;(</span><span>begin</span><span>:</span><span> </span><span>-</span><span>200</span><span>,</span><span> end</span><span>:</span><span> </span><span>0</span><span>);</span>
```

A `Tween` is a stateless object that takes only `begin` and `end`. The sole job of a `Tween` is to define a mapping from an input range to an output range. The input range is commonly 0.0 to 1.0, but that’s not a requirement.

A `Tween` inherits from `Animatable<T>`, not from `Animation<T>`. An `Animatable`, like `Animation`, doesn’t have to output double. For example, `ColorTween` specifies a progression between two colors.

```
<span>colorTween </span><span>=</span><span> </span><span>ColorTween</span><span>(</span><span>begin</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>transparent</span><span>,</span><span> end</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black54</span><span>);</span>
```

A `Tween` object doesn’t store any state. Instead, it provides the [`evaluate(Animation<double> animation)`](https://api.flutter.dev/flutter/animation/Animation/value.html) method that uses the `transform` function to map the current value of the animation (between 0.0 and 1.0), to the actual animation value.

The current value of the `Animation` object can be found in the `.value` method. The evaluate function also performs some housekeeping, such as ensuring that begin and end are returned when the animation values are 0.0 and 1.0, respectively.

#### Tween.animate

To use a `Tween` object, call `animate()` on the `Tween`, passing in the controller object. For example, the following code generates the integer values from 0 to 255 over the course of 500 ms.

```
<span>AnimationController</span><span> controller </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
    duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>500</span><span>),</span><span> vsync</span><span>:</span><span> </span><span>this</span><span>);</span><span>
</span><span>Animation</span><span>&lt;</span><span>int</span><span>&gt;</span><span> alpha </span><span>=</span><span> </span><span>IntTween</span><span>(</span><span>begin</span><span>:</span><span> </span><span>0</span><span>,</span><span> end</span><span>:</span><span> </span><span>255</span><span>).</span><span>animate</span><span>(</span><span>controller</span><span>);</span>
```

The following example shows a controller, a curve, and a `Tween`:

```
<span>AnimationController</span><span> controller </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
    duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>500</span><span>),</span><span> vsync</span><span>:</span><span> </span><span>this</span><span>);</span><span>
</span><span>final</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> curve </span><span>=</span><span>
    </span><span>CurvedAnimation</span><span>(</span><span>parent</span><span>:</span><span> controller</span><span>,</span><span> curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>easeOut</span><span>);</span><span>
</span><span>Animation</span><span>&lt;</span><span>int</span><span>&gt;</span><span> alpha </span><span>=</span><span> </span><span>IntTween</span><span>(</span><span>begin</span><span>:</span><span> </span><span>0</span><span>,</span><span> end</span><span>:</span><span> </span><span>255</span><span>).</span><span>animate</span><span>(</span><span>curve</span><span>);</span>
```

### Animation notifications

An [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html) object can have `Listener`s and `StatusListener`s, defined with `addListener()` and `addStatusListener()`. A `Listener` is called whenever the value of the animation changes. The most common behavior of a `Listener` is to call `setState()` to cause a rebuild. A `StatusListener` is called when an animation begins, ends, moves forward, or moves reverse, as defined by `AnimationStatus`. The next section has an example of the `addListener()` method, and [Monitoring the progress of the animation](https://docs.flutter.dev/ui/animations/tutorial#monitoring) shows an example of `addStatusListener()`.

___

## Animation examples

This section walks you through 5 animation examples. Each section provides a link to the source code for that example.

### Rendering animations

So far you’ve learned how to generate a sequence of numbers over time. Nothing has been rendered to the screen. To render with an `Animation` object, store the `Animation` object as a member of your widget, then use its value to decide how to draw.

Consider the following app that draws the Flutter logo without animation:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>LogoApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>LogoApp</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>LogoApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>LogoApp</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _LogoAppState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _LogoAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>LogoApp</span><span>&gt;</span><span> </span><span>{</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        margin</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>vertical</span><span>:</span><span> </span><span>10</span><span>),</span><span>
        height</span><span>:</span><span> </span><span>300</span><span>,</span><span>
        width</span><span>:</span><span> </span><span>300</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

**App source:** [animate0](https://github.com/flutter/website/tree/main/examples/animation/animate0)

The following shows the same code modified to animate the logo to grow from nothing to full size. When defining an `AnimationController`, you must pass in a `vsync` object. The `vsync` parameter is described in the [`AnimationController` section](https://docs.flutter.dev/ui/animations/tutorial#animationcontroller).

The changes from the non-animated example are highlighted:

<table><tbody><tr><td></td><td><p>@@ -9,16 +9,39 @@</p></td></tr><tr><td><p>9</p><p>9</p></td><td><p><span>&nbsp;</span> <span>State&lt;LogoApp&gt; createState() =&gt; _LogoAppState();</span></p></td></tr><tr><td><p>10</p><p>10</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>11</p></td><td><p><span>-</span> <span><span><span>class</span> <span>_LogoAppState</span> <span>extends</span> <span>State</span>&lt;<span>LogoApp</span>&gt; </span>{</span></p></td></tr><tr><td><p>11</p></td><td><p><span>+</span> <span><span><span>class</span> <span>_LogoAppState</span> <span>extends</span> <span>State</span>&lt;<span>LogoApp</span>&gt; </span><ins><span><span>with</span> <span>SingleTickerProviderStateMixin</span> </span></ins>{</span></p></td></tr><tr><td><p>12</p></td><td><p><span>+</span> <span><span>late</span> Animation&lt;<span>double</span>&gt; animation;</span></p></td></tr><tr><td><p>13</p></td><td><p><span>+</span> <span><span>late</span> AnimationController controller;</span></p></td></tr><tr><td><p>14</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>15</p></td><td><p><span>+</span> <span><span>@override</span></span></p></td></tr><tr><td><p>16</p></td><td><p><span>+</span> <span><span>void</span> initState() {</span></p></td></tr><tr><td><p>17</p></td><td><p><span>+</span> <span><span>super</span>.initState();</span></p></td></tr><tr><td><p>18</p></td><td><p><span>+</span> <span>controller =</span></p></td></tr><tr><td><p>19</p></td><td><p><span>+</span> <span>AnimationController(duration: <span>const</span> <span>Duration</span>(seconds: <span>2</span>), vsync: <span>this</span>);</span></p></td></tr><tr><td><p>20</p></td><td><p><span>+</span> <span>animation = Tween&lt;<span>double</span>&gt;(begin: <span>0</span>, end: <span>300</span>).animate(controller)</span></p></td></tr><tr><td><p>21</p></td><td><p><span>+</span> <span>..addListener(() {</span></p></td></tr><tr><td><p>22</p></td><td><p><span>+</span> <span>setState(() {</span></p></td></tr><tr><td><p>23</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>24</p></td><td><p><span>+</span> <span>});</span></p></td></tr><tr><td><p>25</p></td><td><p><span>+</span> <span>});</span></p></td></tr><tr><td><p>26</p></td><td><p><span>+</span> <span>controller.forward();</span></p></td></tr><tr><td><p>27</p></td><td><p><span>+</span> <span>}</span></p></td></tr><tr><td><p>28</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>12</p><p>29</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>13</p><p>30</p></td><td><p><span>&nbsp;</span> <span>Widget build(BuildContext context) {</span></p></td></tr><tr><td><p>14</p><p>31</p></td><td><p><span>&nbsp;</span> <span><span>return</span> Center(</span></p></td></tr><tr><td><p>15</p><p>32</p></td><td><p><span>&nbsp;</span> <span>child: Container(</span></p></td></tr><tr><td><p>16</p><p>33</p></td><td><p><span>&nbsp;</span> <span>margin: <span>const</span> EdgeInsets.symmetric(vertical: <span>10</span>),</span></p></td></tr><tr><td><p>17</p></td><td><p><span>-</span> <span>height: <del><span>300</span></del>,</span></p></td></tr><tr><td><p>18</p></td><td><p><span>-</span> <span>width: <del><span>300</span></del>,</span></p></td></tr><tr><td><p>34</p></td><td><p><span>+</span> <span>height: <ins>animation.value</ins>,</span></p></td></tr><tr><td><p>35</p></td><td><p><span>+</span> <span>width: <ins>animation.value</ins>,</span></p></td></tr><tr><td><p>19</p><p>36</p></td><td><p><span>&nbsp;</span> <span>child: <span>const</span> FlutterLogo(),</span></p></td></tr><tr><td><p>20</p><p>37</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr><tr><td><p>21</p><p>38</p></td><td><p><span>&nbsp;</span> <span>);</span></p></td></tr><tr><td><p>22</p><p>39</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>40</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>41</p></td><td><p><span>+</span> <span><span>@override</span></span></p></td></tr><tr><td><p>42</p></td><td><p><span>+</span> <span><span>void</span> dispose() {</span></p></td></tr><tr><td><p>43</p></td><td><p><span>+</span> <span>controller.dispose();</span></p></td></tr><tr><td><p>44</p></td><td><p><span>+</span> <span><span>super</span>.dispose();</span></p></td></tr><tr><td><p>45</p></td><td><p><span>+</span> <span>}</span></p></td></tr><tr><td><p>23</p><p>46</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr></tbody></table>

**App source:** [animate1](https://github.com/flutter/website/tree/main/examples/animation/animate1)

The `addListener()` function calls `setState()`, so every time the `Animation` generates a new number, the current frame is marked dirty, which forces `build()` to be called again. In `build()`, the container changes size because its height and width now use `animation.value` instead of a hardcoded value. Dispose of the controller when the `State` object is discarded to prevent memory leaks.

With these few changes, you’ve created your first animation in Flutter!

### Simplifying with AnimatedWidget

The `AnimatedWidget` base class allows you to separate out the core widget code from the animation code. `AnimatedWidget` doesn’t need to maintain a `State` object to hold the animation. Add the following `AnimatedLogo` class:

```
<span>class</span><span> </span><span>AnimatedLogo</span><span> </span><span>extends</span><span> </span><span>AnimatedWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>AnimatedLogo</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> animation</span><span>})</span><span>
      </span><span>:</span><span> </span><span>super</span><span>(</span><span>listenable</span><span>:</span><span> animation</span><span>);</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> animation </span><span>=</span><span> listenable </span><span>as</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;;</span><span>
    </span><span>return</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        margin</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>vertical</span><span>:</span><span> </span><span>10</span><span>),</span><span>
        height</span><span>:</span><span> animation</span><span>.</span><span>value</span><span>,</span><span>
        width</span><span>:</span><span> animation</span><span>.</span><span>value</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

`AnimatedLogo` uses the current value of the `animation` when drawing itself.

The `LogoApp` still manages the `AnimationController` and the `Tween`, and it passes the `Animation` object to `AnimatedLogo`:

<table><tbody><tr><td></td><td><p>@@ -1,10 +1,28 @@</p></td></tr><tr><td><p>1</p><p>1</p></td><td><p><span>&nbsp;</span> <span><span>import</span> <span>'package:flutter/material.dart'</span>;</span></p></td></tr><tr><td><p>2</p><p>2</p></td><td><p><span>&nbsp;</span> <span><span>void</span> main() =&gt; runApp(<span>const</span> LogoApp());</span></p></td></tr><tr><td><p>3</p></td><td><p><span>+</span> <span><span><span>class</span> <span>AnimatedLogo</span> <span>extends</span> <span>AnimatedWidget</span> </span>{</span></p></td></tr><tr><td><p>4</p></td><td><p><span>+</span> <span><span>const</span> AnimatedLogo({<span>super</span>.key, <span>required</span> Animation&lt;<span>double</span>&gt; animation})</span></p></td></tr><tr><td><p>5</p></td><td><p><span>+</span> <span>: <span>super</span>(listenable: animation);</span></p></td></tr><tr><td><p>6</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>7</p></td><td><p><span>+</span> <span><span>@override</span></span></p></td></tr><tr><td><p>8</p></td><td><p><span>+</span> <span>Widget build(BuildContext context) {</span></p></td></tr><tr><td><p>9</p></td><td><p><span>+</span> <span><span>final</span> animation = listenable <span>as</span> Animation&lt;<span>double</span>&gt;;</span></p></td></tr><tr><td><p>10</p></td><td><p><span>+</span> <span><span>return</span> Center(</span></p></td></tr><tr><td><p>11</p></td><td><p><span>+</span> <span>child: Container(</span></p></td></tr><tr><td><p>12</p></td><td><p><span>+</span> <span>margin: <span>const</span> EdgeInsets.symmetric(vertical: <span>10</span>),</span></p></td></tr><tr><td><p>13</p></td><td><p><span>+</span> <span>height: animation.value,</span></p></td></tr><tr><td><p>14</p></td><td><p><span>+</span> <span>width: animation.value,</span></p></td></tr><tr><td><p>15</p></td><td><p><span>+</span> <span>child: <span>const</span> FlutterLogo(),</span></p></td></tr><tr><td><p>16</p></td><td><p><span>+</span> <span>),</span></p></td></tr><tr><td><p>17</p></td><td><p><span>+</span> <span>);</span></p></td></tr><tr><td><p>18</p></td><td><p><span>+</span> <span>}</span></p></td></tr><tr><td><p>19</p></td><td><p><span>+</span> <span>}</span></p></td></tr><tr><td><p>20</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>3</p><p>21</p></td><td><p><span>&nbsp;</span> <span><span><span>class</span> <span>LogoApp</span> <span>extends</span> <span>StatefulWidget</span> </span>{</span></p></td></tr><tr><td><p>4</p><p>22</p></td><td><p><span>&nbsp;</span> <span><span>const</span> LogoApp({<span>super</span>.key});</span></p></td></tr><tr><td><p>5</p><p>23</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>6</p><p>24</p></td><td><p><span>&nbsp;</span> <span>State&lt;LogoApp&gt; createState() =&gt; _LogoAppState();</span></p></td></tr><tr><td><p>7</p><p>25</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td></td><td><p>@@ -15,32 +33,18 @@</p></td></tr><tr><td><p>15</p><p>33</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>16</p><p>34</p></td><td><p><span>&nbsp;</span> <span><span>void</span> initState() {</span></p></td></tr><tr><td><p>17</p><p>35</p></td><td><p><span>&nbsp;</span> <span><span>super</span>.initState();</span></p></td></tr><tr><td><p>18</p><p>36</p></td><td><p><span>&nbsp;</span> <span>controller =</span></p></td></tr><tr><td><p>19</p><p>37</p></td><td><p><span>&nbsp;</span> <span>AnimationController(duration: <span>const</span> <span>Duration</span>(seconds: <span>2</span>), vsync: <span>this</span>);</span></p></td></tr><tr><td><p>20</p></td><td><p><span>-</span> <span>animation = Tween&lt;<span>double</span>&gt;(begin: <span>0</span>, end: <span>300</span>).animate(controller)</span></p></td></tr><tr><td><p>21</p></td><td><p><span>-</span> <span>..addListener(() {</span></p></td></tr><tr><td><p>22</p></td><td><p><span>-</span> <span>setState(() {</span></p></td></tr><tr><td><p>23</p></td><td><p><span>-</span><span></span></p></td></tr><tr><td><p>24</p></td><td><p><span>-</span> <span>});</span></p></td></tr><tr><td><p>25</p></td><td><p><span>-</span> <span>});</span></p></td></tr><tr><td><p>38</p></td><td><p><span>+</span> <span>animation = Tween&lt;<span>double</span>&gt;(begin: <span>0</span>, end: <span>300</span>).animate(controller)<ins>;</ins></span></p></td></tr><tr><td><p>26</p><p>39</p></td><td><p><span>&nbsp;</span> <span>controller.forward();</span></p></td></tr><tr><td><p>27</p><p>40</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>28</p><p>41</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>29</p></td><td><p><span>-</span> <span>Widget build(BuildContext context) <del>{</del></span></p></td></tr><tr><td><p>30</p></td><td><p><span>-</span> <span><span>return</span> Center(</span></p></td></tr><tr><td><p>31</p></td><td><p><span>-</span> <span>child: Container(</span></p></td></tr><tr><td><p>32</p></td><td><p><span>-</span> <span>margin: <span>const</span> EdgeInsets.symmetric(vertical: <span>10</span>),</span></p></td></tr><tr><td><p>33</p></td><td><p><span>-</span> <span>height: animation.value,</span></p></td></tr><tr><td><p>34</p></td><td><p><span>-</span> <span>width: animation.value,</span></p></td></tr><tr><td><p>35</p></td><td><p><span>-</span> <span>child: <span>const</span> FlutterLogo(),</span></p></td></tr><tr><td><p>36</p></td><td><p><span>-</span> <span>),</span></p></td></tr><tr><td><p>37</p></td><td><p><span>-</span> <span>);</span></p></td></tr><tr><td><p>38</p></td><td><p><span>-</span> <span>}</span></p></td></tr><tr><td><p>42</p></td><td><p><span>+</span> <span>Widget build(BuildContext context) <ins>=&gt; AnimatedLogo(animation: animation);</ins></span></p></td></tr><tr><td><p>39</p><p>43</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>40</p><p>44</p></td><td><p><span>&nbsp;</span> <span><span>void</span> dispose() {</span></p></td></tr><tr><td><p>41</p><p>45</p></td><td><p><span>&nbsp;</span> <span>controller.dispose();</span></p></td></tr><tr><td><p>42</p><p>46</p></td><td><p><span>&nbsp;</span> <span><span>super</span>.dispose();</span></p></td></tr><tr><td><p>43</p><p>47</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr></tbody></table>

**App source:** [animate2](https://github.com/flutter/website/tree/main/examples/animation/animate2)

### Monitoring the progress of the animation

It’s often helpful to know when an animation changes state, such as finishing, moving forward, or reversing. You can get notifications for this with `addStatusListener()`. The following code modifies the previous example so that it listens for a state change and prints an update. The highlighted line shows the change:

```
<span>class</span><span> _LogoAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>LogoApp</span><span>&gt;</span><span> </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> animation</span><span>;</span><span>
  </span><span>late</span><span> </span><span>AnimationController</span><span> controller</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    controller </span><span>=</span><span>
        </span><span>AnimationController</span><span>(</span><span>duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>seconds</span><span>:</span><span> </span><span>2</span><span>),</span><span> vsync</span><span>:</span><span> </span><span>this</span><span>);</span><span>
    animation </span><span>=</span><span> </span><span>Tween</span><span>&lt;</span><span>double</span><span>&gt;(</span><span>begin</span><span>:</span><span> </span><span>0</span><span>,</span><span> end</span><span>:</span><span> </span><span>300</span><span>).</span><span>animate</span><span>(</span><span>controller</span><span>)</span><span>
      </span><span><span>..</span><span>addStatusListener</span><span>((</span><span>status</span><span>)</span><span> </span><span>=&gt;</span><span> print</span><span>(</span><span>'$status'</span><span>));</span></span><span>
    controller</span><span>.</span><span>forward</span><span>();</span><span>
  </span><span>}</span><span>
  </span><span>// ...</span><span>
</span><span>}</span>
```

Running this code produces this output:

```
<span>AnimationStatus.forward
AnimationStatus.completed
</span>
```

Next, use `addStatusListener()` to reverse the animation at the beginning or the end. This creates a “breathing” effect:

<table><tbody><tr><td></td><td><p>@@ -35,7 +35,15 @@</p></td></tr><tr><td><p>35</p><p>35</p></td><td><p><span>&nbsp;</span> <span><span>void</span> initState() {</span></p></td></tr><tr><td><p>36</p><p>36</p></td><td><p><span>&nbsp;</span> <span><span>super</span>.initState();</span></p></td></tr><tr><td><p>37</p><p>37</p></td><td><p><span>&nbsp;</span> <span>controller =</span></p></td></tr><tr><td><p>38</p><p>38</p></td><td><p><span>&nbsp;</span> <span>AnimationController(duration: <span>const</span> <span>Duration</span>(seconds: <span>2</span>), vsync: <span>this</span>);</span></p></td></tr><tr><td><p>39</p></td><td><p><span>-</span> <span>animation = Tween&lt;<span>double</span>&gt;(begin: <span>0</span>, end: <span>300</span>).animate(controller)<del>;</del></span></p></td></tr><tr><td><p>39</p></td><td><p><span>+</span> <span>animation = Tween&lt;<span>double</span>&gt;(begin: <span>0</span>, end: <span>300</span>).animate(controller)</span></p></td></tr><tr><td><p>40</p></td><td><p><span>+</span> <span>..addStatusListener((status) {</span></p></td></tr><tr><td><p>41</p></td><td><p><span>+</span> <span><span>if</span> (status == AnimationStatus.completed) {</span></p></td></tr><tr><td><p>42</p></td><td><p><span>+</span> <span>controller.reverse();</span></p></td></tr><tr><td><p>43</p></td><td><p><span>+</span> <span>} <span>else</span> <span>if</span> (status == AnimationStatus.dismissed) {</span></p></td></tr><tr><td><p>44</p></td><td><p><span>+</span> <span>controller.forward();</span></p></td></tr><tr><td><p>45</p></td><td><p><span>+</span> <span>}</span></p></td></tr><tr><td><p>46</p></td><td><p><span>+</span> <span>})</span></p></td></tr><tr><td><p>47</p></td><td><p><span>+</span> <span>..addStatusListener((status) =&gt; <span>print</span>(<span>'<span>$status</span>'</span>));</span></p></td></tr><tr><td><p>40</p><p>48</p></td><td><p><span>&nbsp;</span> <span>controller.forward();</span></p></td></tr><tr><td><p>41</p><p>49</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr></tbody></table>

**App source:** [animate3](https://github.com/flutter/website/tree/main/examples/animation/animate3)

### Refactoring with AnimatedBuilder

One problem with the code in the [animate3](https://github.com/flutter/website/tree/main/examples/animation/animate3) example, is that changing the animation required changing the widget that renders the logo. A better solution is to separate responsibilities into different classes:

-   Render the logo
-   Define the `Animation` object
-   Render the transition

You can accomplish this separation with the help of the `AnimatedBuilder` class. An `AnimatedBuilder` is a separate class in the render tree. Like `AnimatedWidget`, `AnimatedBuilder` automatically listens to notifications from the `Animation` object, and marks the widget tree dirty as necessary, so you don’t need to call `addListener()`.

The widget tree for the [animate4](https://github.com/flutter/website/tree/main/examples/animation/animate4) example looks like this:

![AnimatedBuilder widget tree](https://docs.flutter.dev/assets/images/docs/ui/AnimatedBuilder-WidgetTree.png)

Starting from the bottom of the widget tree, the code for rendering the logo is straightforward:

```
<span>class</span><span> </span><span>LogoWidget</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>LogoWidget</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>// Leave out the height and width so it fills the animating parent</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Container</span><span>(</span><span>
      margin</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>vertical</span><span>:</span><span> </span><span>10</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The middle three blocks in the diagram are all created in the `build()` method in `GrowTransition`, shown below. The `GrowTransition` widget itself is stateless and holds the set of final variables necessary to define the transition animation. The build() function creates and returns the `AnimatedBuilder`, which takes the (`Anonymous` builder) method and the `LogoWidget` object as parameters. The work of rendering the transition actually happens in the (`Anonymous` builder) method, which creates a `Container` of the appropriate size to force the `LogoWidget` to shrink to fit.

One tricky point in the code below is that the child looks like it’s specified twice. What’s happening is that the outer reference of child is passed to `AnimatedBuilder`, which passes it to the anonymous closure, which then uses that object as its child. The net result is that the `AnimatedBuilder` is inserted in between the two widgets in the render tree.

```
<span>class</span><span> </span><span>GrowTransition</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>GrowTransition</span><span>(</span><span>
      </span><span>{</span><span>required</span><span> </span><span>this</span><span>.</span><span>child</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>animation</span><span>,</span><span> </span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>final</span><span> </span><span>Widget</span><span> child</span><span>;</span><span>
  </span><span>final</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> animation</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>AnimatedBuilder</span><span>(</span><span>
        animation</span><span>:</span><span> animation</span><span>,</span><span>
        builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> </span><span>SizedBox</span><span>(</span><span>
            height</span><span>:</span><span> animation</span><span>.</span><span>value</span><span>,</span><span>
            width</span><span>:</span><span> animation</span><span>.</span><span>value</span><span>,</span><span>
            child</span><span>:</span><span> child</span><span>,</span><span>
          </span><span>);</span><span>
        </span><span>},</span><span>
        child</span><span>:</span><span> child</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Finally, the code to initialize the animation looks very similar to the [animate2](https://github.com/flutter/website/tree/main/examples/animation/animate2) example. The `initState()` method creates an `AnimationController` and a `Tween`, then binds them with `animate()`. The magic happens in the `build()` method, which returns a `GrowTransition` object with a `LogoWidget` as a child, and an animation object to drive the transition. These are the three elements listed in the bullet points above.

<table><tbody><tr><td></td><td><p>@@ -1,27 +1,47 @@</p></td></tr><tr><td><p>1</p><p>1</p></td><td><p><span>&nbsp;</span> <span><span>import</span> <span>'package:flutter/material.dart'</span>;</span></p></td></tr><tr><td><p>2</p><p>2</p></td><td><p><span>&nbsp;</span> <span><span>void</span> main() =&gt; runApp(<span>const</span> LogoApp());</span></p></td></tr><tr><td><p>3</p></td><td><p><span>-</span> <span><span><span>class</span> </span><del><span><span>AnimatedLogo</span></span></del><span> <span>extends</span> </span><del><span><span>AnimatedWidget</span></span></del><span> </span>{</span></p></td></tr><tr><td><p>4</p></td><td><p><span>-</span> <span><span>const</span> <del>AnimatedLogo</del>({<span>super</span>.key<del>, <span>required</span> Animation&lt;<span>double</span>&gt; animation</del>})</span></p></td></tr><tr><td><p>5</p></td><td><p><span>-</span> <span><del>: <span>super</span>(listenable: animation);</del></span></p></td></tr><tr><td><p>3</p></td><td><p><span>+</span> <span><span><span>class</span> </span><ins><span><span>LogoWidget</span></span></ins><span> <span>extends</span> </span><ins><span><span>StatelessWidget</span></span></ins><span> </span>{</span></p></td></tr><tr><td><p>4</p></td><td><p><span>+</span> <span><span>const</span> <ins>LogoWidget</ins>({<span>super</span>.key})<ins>;</ins></span></p></td></tr><tr><td><p>5</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>6</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>7</p></td><td><p><span>+</span> <span><span>@override</span></span></p></td></tr><tr><td><p>8</p></td><td><p><span>+</span> <span>Widget build(BuildContext context) {</span></p></td></tr><tr><td><p>9</p></td><td><p><span>+</span> <span><span>return</span> Container(</span></p></td></tr><tr><td><p>10</p></td><td><p><span>+</span> <span>margin: <span>const</span> EdgeInsets.symmetric(vertical: <span>10</span>),</span></p></td></tr><tr><td><p>11</p></td><td><p><span>+</span> <span>child: <span>const</span> FlutterLogo(),</span></p></td></tr><tr><td><p>12</p></td><td><p><span>+</span> <span>);</span></p></td></tr><tr><td><p>13</p></td><td><p><span>+</span> <span>}</span></p></td></tr><tr><td><p>14</p></td><td><p><span>+</span> <span>}</span></p></td></tr><tr><td><p>15</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>16</p></td><td><p><span>+</span> <span><span><span>class</span> <span>GrowTransition</span> <span>extends</span> <span>StatelessWidget</span> </span>{</span></p></td></tr><tr><td><p>17</p></td><td><p><span>+</span> <span><span>const</span> GrowTransition(</span></p></td></tr><tr><td><p>18</p></td><td><p><span>+</span> <span>{<span>required</span> <span>this</span>.child, <span>required</span> <span>this</span>.animation, <span>super</span>.key});</span></p></td></tr><tr><td><p>19</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>20</p></td><td><p><span>+</span> <span><span>final</span> Widget child;</span></p></td></tr><tr><td><p>21</p></td><td><p><span>+</span> <span><span>final</span> Animation&lt;<span>double</span>&gt; animation;</span></p></td></tr><tr><td><p>6</p><p>22</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>7</p><p>23</p></td><td><p><span>&nbsp;</span> <span>Widget build(BuildContext context) {</span></p></td></tr><tr><td><p>8</p></td><td><p><span>-</span> <span><span>final</span> animation = listenable <span>as</span> Animation&lt;<span>double</span>&gt;;</span></p></td></tr><tr><td><p>9</p><p>24</p></td><td><p><span>&nbsp;</span> <span><span>return</span> Center(</span></p></td></tr><tr><td><p>10</p></td><td><p><span>-</span> <span>child: <del>Container</del>(</span></p></td></tr><tr><td><p>11</p></td><td><p><span>-</span> <span><del>margin</del>: <del><span>const</span> EdgeInsets.symmetric(vertical: <span>10</span>)</del>,</span></p></td></tr><tr><td><p>12</p></td><td><p><span>-</span> <span><del>height</del>: <del>animation.value</del>,</span></p></td></tr><tr><td><p>13</p></td><td><p><span>-</span> <span><del>width:</del> <del>animation.value,</del></span></p></td></tr><tr><td><p>14</p></td><td><p><span>-</span> <span><del>child</del>: <del><span>const</span> FlutterLogo()</del>,</span></p></td></tr><tr><td><p>25</p></td><td><p><span>+</span> <span>child: <ins>AnimatedBuilder</ins>(</span></p></td></tr><tr><td><p>26</p></td><td><p><span>+</span> <span><ins>animation</ins>: <ins>animation</ins>,</span></p></td></tr><tr><td><p>27</p></td><td><p><span>+</span> <span><ins>builder</ins>: <ins>(context</ins>,<ins> child) {</ins></span></p></td></tr><tr><td><p>28</p></td><td><p><span>+</span> <span><ins><span>return</span></ins> <ins>SizedBox(</ins></span></p></td></tr><tr><td><p>29</p></td><td><p><span>+</span> <span><ins>height</ins>: <ins>animation.value</ins>,</span></p></td></tr><tr><td><p>30</p></td><td><p><span>+</span> <span>width: animation.value,</span></p></td></tr><tr><td><p>31</p></td><td><p><span>+</span> <span>child: child,</span></p></td></tr><tr><td><p>32</p></td><td><p><span>+</span> <span>);</span></p></td></tr><tr><td><p>33</p></td><td><p><span>+</span> <span>},</span></p></td></tr><tr><td><p>34</p></td><td><p><span>+</span> <span>child: child,</span></p></td></tr><tr><td><p>15</p><p>35</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr><tr><td><p>16</p><p>36</p></td><td><p><span>&nbsp;</span> <span>);</span></p></td></tr><tr><td><p>17</p><p>37</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>18</p><p>38</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>19</p><p>39</p></td><td><p><span>&nbsp;</span> <span><span><span>class</span> <span>LogoApp</span> <span>extends</span> <span>StatefulWidget</span> </span>{</span></p></td></tr><tr><td><p>20</p><p>40</p></td><td><p><span>&nbsp;</span> <span><span>const</span> LogoApp({<span>super</span>.key});</span></p></td></tr><tr><td><p>21</p><p>41</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>22</p><p>42</p></td><td><p><span>&nbsp;</span> <span>State&lt;LogoApp&gt; createState() =&gt; _LogoAppState();</span></p></td></tr><tr><td></td><td><p>@@ -34,18 +54,23 @@</p></td></tr><tr><td><p>34</p><p>54</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>35</p><p>55</p></td><td><p><span>&nbsp;</span> <span><span>void</span> initState() {</span></p></td></tr><tr><td><p>36</p><p>56</p></td><td><p><span>&nbsp;</span> <span><span>super</span>.initState();</span></p></td></tr><tr><td><p>37</p><p>57</p></td><td><p><span>&nbsp;</span> <span>controller =</span></p></td></tr><tr><td><p>38</p><p>58</p></td><td><p><span>&nbsp;</span> <span>AnimationController(duration: <span>const</span> <span>Duration</span>(seconds: <span>2</span>), vsync: <span>this</span>);</span></p></td></tr><tr><td><p>39</p><p>59</p></td><td><p><span>&nbsp;</span> <span>animation = Tween&lt;<span>double</span>&gt;(begin: <span>0</span>, end: <span>300</span>).animate(controller);</span></p></td></tr><tr><td><p>40</p><p>60</p></td><td><p><span>&nbsp;</span> <span>controller.forward();</span></p></td></tr><tr><td><p>41</p><p>61</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>42</p><p>62</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>43</p></td><td><p><span>-</span> <span>Widget build(BuildContext context) <del>=&gt; AnimatedLogo(animation: animation);</del></span></p></td></tr><tr><td><p>63</p></td><td><p><span>+</span> <span>Widget build(BuildContext context) <ins>{</ins></span></p></td></tr><tr><td><p>64</p></td><td><p><span>+</span> <span><span>return</span> GrowTransition(</span></p></td></tr><tr><td><p>65</p></td><td><p><span>+</span> <span>animation: animation,</span></p></td></tr><tr><td><p>66</p></td><td><p><span>+</span> <span>child: <span>const</span> LogoWidget(),</span></p></td></tr><tr><td><p>67</p></td><td><p><span>+</span> <span>);</span></p></td></tr><tr><td><p>68</p></td><td><p><span>+</span> <span>}</span></p></td></tr><tr><td><p>44</p><p>69</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>45</p><p>70</p></td><td><p><span>&nbsp;</span> <span><span>void</span> dispose() {</span></p></td></tr><tr><td><p>46</p><p>71</p></td><td><p><span>&nbsp;</span> <span>controller.dispose();</span></p></td></tr><tr><td><p>47</p><p>72</p></td><td><p><span>&nbsp;</span> <span><span>super</span>.dispose();</span></p></td></tr><tr><td><p>48</p><p>73</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>49</p><p>74</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr></tbody></table>

**App source:** [animate4](https://github.com/flutter/website/tree/main/examples/animation/animate4)

### Simultaneous animations

In this section, you’ll build on the example from [monitoring the progress of the animation](https://docs.flutter.dev/ui/animations/tutorial#monitoring) ([animate3](https://github.com/flutter/website/tree/main/examples/animation/animate3)), which used `AnimatedWidget` to animate in and out continuously. Consider the case where you want to animate in and out while the opacity animates from transparent to opaque.

Each tween manages an aspect of the animation. For example:

```
<span>controller </span><span>=</span><span>
    </span><span>AnimationController</span><span>(</span><span>duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>seconds</span><span>:</span><span> </span><span>2</span><span>),</span><span> vsync</span><span>:</span><span> </span><span>this</span><span>);</span><span>
sizeAnimation </span><span>=</span><span> </span><span>Tween</span><span>&lt;</span><span>double</span><span>&gt;(</span><span>begin</span><span>:</span><span> </span><span>0</span><span>,</span><span> end</span><span>:</span><span> </span><span>300</span><span>).</span><span>animate</span><span>(</span><span>controller</span><span>);</span><span>
opacityAnimation </span><span>=</span><span> </span><span>Tween</span><span>&lt;</span><span>double</span><span>&gt;(</span><span>begin</span><span>:</span><span> </span><span>0.1</span><span>,</span><span> end</span><span>:</span><span> </span><span>1</span><span>).</span><span>animate</span><span>(</span><span>controller</span><span>);</span>
```

You can get the size with `sizeAnimation.value` and the opacity with `opacityAnimation.value`, but the constructor for `AnimatedWidget` only takes a single `Animation` object. To solve this problem, the example creates its own `Tween` objects and explicitly calculates the values.

Change `AnimatedLogo` to encapsulate its own `Tween` objects, and its `build()` method calls `Tween.evaluate()` on the parent’s animation object to calculate the required size and opacity values. The following code shows the changes with highlights:

```
<span>class</span><span> </span><span>AnimatedLogo</span><span> </span><span>extends</span><span> </span><span>AnimatedWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>AnimatedLogo</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> animation</span><span>})</span><span>
      </span><span>:</span><span> </span><span>super</span><span>(</span><span>listenable</span><span>:</span><span> animation</span><span>);</span><span>

  </span><span>// Make the Tweens static because they don't change.</span><span>
  </span><span><span>static</span><span> </span><span>final</span><span> _opacityTween </span><span>=</span><span> </span><span>Tween</span><span>&lt;</span><span>double</span><span>&gt;(</span><span>begin</span><span>:</span><span> </span><span>0.1</span><span>,</span><span> end</span><span>:</span><span> </span><span>1</span><span>);</span></span><span>
  </span><span><span>static</span><span> </span><span>final</span><span> _sizeTween </span><span>=</span><span> </span><span>Tween</span><span>&lt;</span><span>double</span><span>&gt;(</span><span>begin</span><span>:</span><span> </span><span>0</span><span>,</span><span> end</span><span>:</span><span> </span><span>300</span><span>);</span></span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> animation </span><span>=</span><span> listenable </span><span>as</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;;</span><span>
    </span><span>return</span><span> </span><span>Center</span><span>(</span><span>
      </span><span><span>child</span><span>:</span><span> </span><span>Opacity</span><span>(</span></span><span>
        </span><span><span>opacity</span><span>:</span><span> _opacityTween</span><span>.</span><span>evaluate</span><span>(</span><span>animation</span><span>),</span></span><span>
        child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
          margin</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>vertical</span><span>:</span><span> </span><span>10</span><span>),</span><span>
          height</span><span>:</span><span> </span><span><span>_sizeTween</span><span>.</span><span>evaluate</span><span>(</span><span>animation</span><span>),</span></span><span>
          width</span><span>:</span><span> </span><span><span>_sizeTween</span><span>.</span><span>evaluate</span><span>(</span><span>animation</span><span>),</span></span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>FlutterLogo</span><span>(),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>LogoApp</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>LogoApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>LogoApp</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _LogoAppState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _LogoAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>LogoApp</span><span>&gt;</span><span> </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> animation</span><span>;</span><span>
  </span><span>late</span><span> </span><span>AnimationController</span><span> controller</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    controller </span><span>=</span><span>
        </span><span>AnimationController</span><span>(</span><span>duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>seconds</span><span>:</span><span> </span><span>2</span><span>),</span><span> vsync</span><span>:</span><span> </span><span>this</span><span>);</span><span>
    animation </span><span>=</span><span> </span><span><span>CurvedAnimation</span><span>(</span><span>parent</span><span>:</span><span> controller</span><span>,</span><span> curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>easeIn</span><span>)</span></span><span>
      </span><span>..</span><span>addStatusListener</span><span>((</span><span>status</span><span>)</span><span> </span><span>{</span><span>
        </span><span>if</span><span> </span><span>(</span><span>status </span><span>==</span><span> </span><span>AnimationStatus</span><span>.</span><span>completed</span><span>)</span><span> </span><span>{</span><span>
          controller</span><span>.</span><span>reverse</span><span>();</span><span>
        </span><span>}</span><span> </span><span>else</span><span> </span><span>if</span><span> </span><span>(</span><span>status </span><span>==</span><span> </span><span>AnimationStatus</span><span>.</span><span>dismissed</span><span>)</span><span> </span><span>{</span><span>
          controller</span><span>.</span><span>forward</span><span>();</span><span>
        </span><span>}</span><span>
      </span><span>});</span><span>
    controller</span><span>.</span><span>forward</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>AnimatedLogo</span><span>(</span><span>animation</span><span>:</span><span> animation</span><span>);</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    controller</span><span>.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

**App source:** [animate5](https://github.com/flutter/website/tree/main/examples/animation/animate5)

## Next steps

This tutorial gives you a foundation for creating animations in Flutter using `Tweens`, but there are many other classes to explore. You might investigate the specialized `Tween` classes, animations specific to Material Design, `ReverseAnimation`, shared element transitions (also known as Hero animations), physics simulations and `fling()` methods. See the [animations landing page](https://docs.flutter.dev/ui/animations) for the latest available documents and examples.