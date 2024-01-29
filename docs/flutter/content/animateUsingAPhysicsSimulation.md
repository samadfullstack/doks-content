1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Animation](https://docs.flutter.dev/cookbook/animation)
3.  [Animate a widget using a physics simulation](https://docs.flutter.dev/cookbook/animation/physics-simulation)

Physics simulations can make app interactions feel realistic and interactive. For example, you might want to animate a widget to act as if it were attached to a spring or falling with gravity.

This recipe demonstrates how to move a widget from a dragged point back to the center using a spring simulation.

This recipe uses these steps:

1.  Set up an animation controller
2.  Move the widget using gestures
3.  Animate the widget
4.  Calculate the velocity to simulate a springing motion

## Step 1: Set up an animation controller

Start with a stateful widget called `DraggableCard`:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>home</span><span>:</span><span> </span><span>PhysicsCardDragDemo</span><span>()));</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>PhysicsCardDragDemo</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>PhysicsCardDragDemo</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(),</span><span>
      body</span><span>:</span><span> </span><span>const</span><span> </span><span>DraggableCard</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>FlutterLogo</span><span>(</span><span>
          size</span><span>:</span><span> </span><span>128</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>DraggableCard</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>DraggableCard</span><span>({</span><span>required</span><span> </span><span>this</span><span>.</span><span>child</span><span>,</span><span> </span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>final</span><span> </span><span>Widget</span><span> child</span><span>;</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>DraggableCard</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _DraggableCardState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _DraggableCardState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>DraggableCard</span><span>&gt;</span><span> </span><span>{</span><span>
  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Align</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Card</span><span>(</span><span>
        child</span><span>:</span><span> widget</span><span>.</span><span>child</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Make the `_DraggableCardState` class extend from [SingleTickerProviderStateMixin](https://api.flutter.dev/flutter/widgets/SingleTickerProviderStateMixin-mixin.html). Then construct an [AnimationController](https://api.flutter.dev/flutter/animation/AnimationController-class.html) in `initState` and set `vsync` to `this`.

<table><tbody><tr><td></td><td><p>@@ -29,14 +29,20 @@</p></td></tr><tr><td><p>29</p><p>29</p></td><td><p><span>&nbsp;</span> <span>State&lt;DraggableCard&gt; createState() =&gt; _DraggableCardState();</span></p></td></tr><tr><td><p>30</p><p>30</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>31</p></td><td><p><span>-</span> <span><span><span>class</span> <span>_DraggableCardState</span> <span>extends</span> <span>State</span>&lt;<span>DraggableCard</span>&gt;</span><del><span> </span>{</del></span></p></td></tr><tr><td><p>31</p></td><td><p><span>+</span> <span><span><span>class</span> <span>_DraggableCardState</span> <span>extends</span> <span>State</span>&lt;<span>DraggableCard</span>&gt;</span></span></p></td></tr><tr><td><p>32</p></td><td><p><span>+</span> <span><span><span>with</span> <span>SingleTickerProviderStateMixin</span> </span>{</span></p></td></tr><tr><td><p>33</p></td><td><p><span>+</span> <span><span>late</span> AnimationController _controller;</span></p></td></tr><tr><td><p>34</p></td><td><p><span>+</span><span><br></span></p></td></tr><tr><td><p>32</p><p>35</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>33</p><p>36</p></td><td><p><span>&nbsp;</span> <span><span>void</span> initState() {</span></p></td></tr><tr><td><p>34</p><p>37</p></td><td><p><span>&nbsp;</span> <span><span>super</span>.initState();</span></p></td></tr><tr><td><p>38</p></td><td><p><span>+</span> <span>_controller =</span></p></td></tr><tr><td><p>39</p></td><td><p><span>+</span> <span>AnimationController(vsync: <span>this</span>, duration: <span>const</span> <span>Duration</span>(seconds: <span>1</span>));</span></p></td></tr><tr><td><p>35</p><p>40</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr><tr><td><p>36</p><p>41</p></td><td><p><span>&nbsp;</span> <span><span>@override</span></span></p></td></tr><tr><td><p>37</p><p>42</p></td><td><p><span>&nbsp;</span> <span><span>void</span> dispose() {</span></p></td></tr><tr><td><p>43</p></td><td><p><span>+</span> <span>_controller.dispose();</span></p></td></tr><tr><td><p>38</p><p>44</p></td><td><p><span>&nbsp;</span> <span><span>super</span>.dispose();</span></p></td></tr><tr><td><p>39</p><p>45</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr></tbody></table>

Make the widget move when it’s dragged, and add an [Alignment](https://api.flutter.dev/flutter/painting/Alignment-class.html) field to the `_DraggableCardState` class:

<table><tbody><tr><td></td><td><p>@@ -1,3 +1,4 @@</p></td></tr><tr><td><p>1</p><p>1</p></td><td><p><span>&nbsp;</span> <span><span><span>class</span> <span>_DraggableCardState</span> <span>extends</span> <span>State</span>&lt;<span>DraggableCard</span>&gt;</span></span></p></td></tr><tr><td><p>2</p><p>2</p></td><td><p><span>&nbsp;</span> <span><span>with</span> SingleTickerProviderStateMixin {</span></p></td></tr><tr><td><p>3</p><p>3</p></td><td><p><span>&nbsp;</span> <span><span>late</span> AnimationController _controller;</span></p></td></tr><tr><td><p>4</p></td><td><p><span>+</span> <span><span>Alignment</span> _dragAlignment = Alignment.center;</span></p></td></tr></tbody></table>

Add a [GestureDetector](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) that handles the `onPanDown`, `onPanUpdate`, and `onPanEnd` callbacks. To adjust the alignment, use a [MediaQuery](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html) to get the size of the widget, and divide by 2. (This converts units of “pixels dragged” to coordinates that [Align](https://api.flutter.dev/flutter/widgets/Align-class.html) uses.) Then, set the `Align` widget’s `alignment` to `_dragAlignment`:

<table><tbody><tr><td></td><td><p>@@ -1,8 +1,22 @@</p></td></tr><tr><td><p>1</p><p>1</p></td><td><p><span>&nbsp;</span> <span>@override</span></p></td></tr><tr><td><p>2</p><p>2</p></td><td><p><span>&nbsp;</span> <span>Wid<span>get</span> <span>build</span>(<span>BuildContext context</span>) {</span></p></td></tr><tr><td><p>3</p></td><td><p><span>-</span> <span><del><span>return</span></del> <del>Align</del>(</span></p></td></tr><tr><td><p>4</p></td><td><p><span>-</span> <span><del>child:</del> <del><span>Card</span></del>(</span></p></td></tr><tr><td><p>5</p></td><td><p><span>-</span> <span><del><span>child</span></del>: <del><span>widget.child</span></del><span>,</span></span></p></td></tr><tr><td><p>3</p></td><td><p><span>+</span> <span><ins><span>var</span></ins> <ins>size = MediaQuery.of</ins>(<ins>context).size;</ins></span></p></td></tr><tr><td><p>4</p></td><td><p><span>+</span> <span><ins><span>return</span></ins> <ins>GestureDetector</ins>(</span></p></td></tr><tr><td><p>5</p></td><td><p><span>+</span> <span><ins>onPanDown</ins>: <ins>(details) {}</ins>,</span></p></td></tr><tr><td><p>6</p></td><td><p><span>+</span> <span><span>onPanUpdate</span>: <span>(details) {</span></span></p></td></tr><tr><td><p>7</p></td><td><p><span>+</span> <span>setState(() {</span></p></td></tr><tr><td><p>8</p></td><td><p><span>+</span> <span><span>_dragAlignment</span> += Alignment(</span></p></td></tr><tr><td><p>9</p></td><td><p><span>+</span> <span><span>details</span><span>.delta</span><span>.dx</span> / (size.width / <span>2</span>),</span></p></td></tr><tr><td><p>10</p></td><td><p><span>+</span> <span><span>details</span><span>.delta</span><span>.dy</span> / (size.height / <span>2</span>),</span></p></td></tr><tr><td><p>11</p></td><td><p><span>+</span> <span>);</span></p></td></tr><tr><td><p>12</p></td><td><p><span>+</span> <span>});</span></p></td></tr><tr><td><p>13</p></td><td><p><span>+</span> <span>},</span></p></td></tr><tr><td><p>14</p></td><td><p><span>+</span> <span>onPanEnd: (details) {},</span></p></td></tr><tr><td><p>15</p></td><td><p><span>+</span> <span>child: <span>Align</span>(</span></p></td></tr><tr><td><p>16</p></td><td><p><span>+</span> <span><span>alignment</span>: <span>_dragAlignment,</span></span></p></td></tr><tr><td><p>17</p></td><td><p><span>+</span> <span>child: <span>Card</span>(</span></p></td></tr><tr><td><p>18</p></td><td><p><span>+</span> <span><span>child</span>: <span>widget.child,</span></span></p></td></tr><tr><td><p>19</p></td><td><p><span>+</span> <span>),</span></p></td></tr><tr><td><p>6</p><p>20</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr><tr><td><p>7</p><p>21</p></td><td><p><span>&nbsp;</span> <span>);</span></p></td></tr><tr><td><p>8</p><p>22</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr></tbody></table>

When the widget is released, it should spring back to the center.

Add an `Animation<Alignment>` field and an `_runAnimation` method. This method defines a `Tween` that interpolates between the point the widget was dragged to, to the point in the center.

<table><tbody><tr><td></td><td><p>@@ -1,4 +1,5 @@</p></td></tr><tr><td><p>1</p><p>1</p></td><td><p><span>&nbsp;</span> <span><span><span>class</span> <span>_DraggableCardState</span> <span>extends</span> <span>State</span>&lt;<span>DraggableCard</span>&gt;</span></span></p></td></tr><tr><td><p>2</p><p>2</p></td><td><p><span>&nbsp;</span> <span><span>with</span> SingleTickerProviderStateMixin {</span></p></td></tr><tr><td><p>3</p><p>3</p></td><td><p><span>&nbsp;</span> <span><span>late</span> AnimationController _controller;</span></p></td></tr><tr><td><p>4</p></td><td><p><span>+</span> <span>late <span>Animation</span>&lt;Alignment&gt; _animation;</span></p></td></tr><tr><td><p>4</p><p>5</p></td><td><p><span>&nbsp;</span> <span><span>Alignment</span> _dragAlignment = Alignment.center;</span></p></td></tr></tbody></table>

```
<span>void</span><span> _runAnimation</span><span>()</span><span> </span><span>{</span><span>
  _animation </span><span>=</span><span> _controller</span><span>.</span><span>drive</span><span>(</span><span>
    </span><span>AlignmentTween</span><span>(</span><span>
      begin</span><span>:</span><span> _dragAlignment</span><span>,</span><span>
      end</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>center</span><span>,</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
  _controller</span><span>.</span><span>reset</span><span>();</span><span>
  _controller</span><span>.</span><span>forward</span><span>();</span><span>
</span><span>}</span>
```

Next, update `_dragAlignment` when the `AnimationController` produces a value:

<table><tbody><tr><td></td><td><p>@@ -3,4 +3,9 @@</p></td></tr><tr><td><p>3</p><p>3</p></td><td><p><span>&nbsp;</span> <span>super<span>.initState</span>();</span></p></td></tr><tr><td><p>4</p><p>4</p></td><td><p><span>&nbsp;</span> <span><span>_controller</span> =</span></p></td></tr><tr><td><p>5</p><p>5</p></td><td><p><span>&nbsp;</span> <span><span>AnimationController</span>(<span>vsync</span>: this, <span>duration</span>: const Duration(<span>seconds</span>: <span>1</span>));</span></p></td></tr><tr><td><p>6</p></td><td><p><span>+</span> <span>_controller<span>.addListener</span>(() {</span></p></td></tr><tr><td><p>7</p></td><td><p><span>+</span> <span>setState(() {</span></p></td></tr><tr><td><p>8</p></td><td><p><span>+</span> <span><span>_dragAlignment</span> = _animation.value</span></p></td></tr><tr><td><p>9</p></td><td><p><span>+</span> <span>});</span></p></td></tr><tr><td><p>10</p></td><td><p><span>+</span> <span>});</span></p></td></tr><tr><td><p>6</p><p>11</p></td><td><p><span>&nbsp;</span> <span>}</span></p></td></tr></tbody></table>

Next, make the `Align` widget use the `_dragAlignment` field:

```
<span>child</span><span>:</span><span> </span><span>Align</span><span>(</span><span>
  alignment</span><span>:</span><span> _dragAlignment</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>Card</span><span>(</span><span>
    child</span><span>:</span><span> widget</span><span>.</span><span>child</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

Finally, update the `GestureDetector` to manage the animation controller:

<table><tbody><tr><td></td><td><p>@@ -1,5 +1,7 @@</p></td></tr><tr><td><p>1</p><p>1</p></td><td><p><span>&nbsp;</span> <span><span>return</span> GestureDetector(</span></p></td></tr><tr><td><p>2</p></td><td><p><span>-</span> <span>onPanDown: (details) {<del>},</del></span></p></td></tr><tr><td><p>2</p></td><td><p><span>+</span> <span><span>onPanDown</span>: <span>(details) {</span></span></p></td></tr><tr><td><p>3</p></td><td><p><span>+</span> <span><span>_controller</span><span>.stop</span>();</span></p></td></tr><tr><td><p>4</p></td><td><p><span>+</span> <span>},</span></p></td></tr><tr><td><p>3</p><p>5</p></td><td><p><span>&nbsp;</span> <span><span>onPanUpdate</span>: <span>(details) {</span></span></p></td></tr><tr><td><p>4</p><p>6</p></td><td><p><span>&nbsp;</span> <span>setState(() {</span></p></td></tr><tr><td><p>5</p><p>7</p></td><td><p><span>&nbsp;</span> <span><span>_dragAlignment</span> += Alignment(</span></p></td></tr><tr><td></td><td><p>@@ -8,7 +10,9 @@</p></td></tr><tr><td><p>8</p><p>10</p></td><td><p><span>&nbsp;</span> <span>);</span></p></td></tr><tr><td><p>9</p><p>11</p></td><td><p><span>&nbsp;</span> <span>});</span></p></td></tr><tr><td><p>10</p><p>12</p></td><td><p><span>&nbsp;</span> <span>},</span></p></td></tr><tr><td><p>11</p></td><td><p><span>-</span> <span>onPanEnd: (details) {<del>},</del></span></p></td></tr><tr><td><p>13</p></td><td><p><span>+</span> <span><span>onPanEnd</span>: <span>(details) {</span></span></p></td></tr><tr><td><p>14</p></td><td><p><span>+</span> <span><span>_runAnimation</span>();</span></p></td></tr><tr><td><p>15</p></td><td><p><span>+</span> <span>},</span></p></td></tr><tr><td><p>12</p><p>16</p></td><td><p><span>&nbsp;</span> <span>child: <span>Align</span>(</span></p></td></tr><tr><td><p>13</p><p>17</p></td><td><p><span>&nbsp;</span> <span><span>alignment</span>: <span>_dragAlignment,</span></span></p></td></tr><tr><td><p>14</p><p>18</p></td><td><p><span>&nbsp;</span> <span>child: <span>Card</span>(</span></p></td></tr></tbody></table>

## Step 4: Calculate the velocity to simulate a springing motion

The last step is to do a little math, to calculate the velocity of the widget after it’s finished being dragged. This is so that the widget realistically continues at that speed before being snapped back. (The `_runAnimation` method already sets the direction by setting the animation’s start and end alignment.)

First, import the `physics` package:

```
<span>import</span><span> </span><span>'package:flutter/physics.dart'</span><span>;</span>
```

The `onPanEnd` callback provides a [DragEndDetails](https://api.flutter.dev/flutter/gestures/DragEndDetails-class.html) object. This object provides the velocity of the pointer when it stopped contacting the screen. The velocity is in pixels per second, but the `Align` widget doesn’t use pixels. It uses coordinate values between \[-1.0, -1.0\] and \[1.0, 1.0\], where \[0.0, 0.0\] represents the center. The `size` calculated in step 2 is used to convert pixels to coordinate values in this range.

Finally, `AnimationController` has an `animateWith()` method that can be given a [SpringSimulation](https://api.flutter.dev/flutter/physics/SpringSimulation-class.html):

```
<span>/// Calculates and runs a [SpringSimulation].</span><span>
</span><span>void</span><span> _runAnimation</span><span>(</span><span>Offset</span><span> pixelsPerSecond</span><span>,</span><span> </span><span>Size</span><span> size</span><span>)</span><span> </span><span>{</span><span>
  _animation </span><span>=</span><span> _controller</span><span>.</span><span>drive</span><span>(</span><span>
    </span><span>AlignmentTween</span><span>(</span><span>
      begin</span><span>:</span><span> _dragAlignment</span><span>,</span><span>
      end</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>center</span><span>,</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
  </span><span>// Calculate the velocity relative to the unit interval, [0,1],</span><span>
  </span><span>// used by the animation controller.</span><span>
  </span><span>final</span><span> unitsPerSecondX </span><span>=</span><span> pixelsPerSecond</span><span>.</span><span>dx </span><span>/</span><span> size</span><span>.</span><span>width</span><span>;</span><span>
  </span><span>final</span><span> unitsPerSecondY </span><span>=</span><span> pixelsPerSecond</span><span>.</span><span>dy </span><span>/</span><span> size</span><span>.</span><span>height</span><span>;</span><span>
  </span><span>final</span><span> unitsPerSecond </span><span>=</span><span> </span><span>Offset</span><span>(</span><span>unitsPerSecondX</span><span>,</span><span> unitsPerSecondY</span><span>);</span><span>
  </span><span>final</span><span> unitVelocity </span><span>=</span><span> unitsPerSecond</span><span>.</span><span>distance</span><span>;</span><span>

  </span><span>const</span><span> spring </span><span>=</span><span> </span><span>SpringDescription</span><span>(</span><span>
    mass</span><span>:</span><span> </span><span>30</span><span>,</span><span>
    stiffness</span><span>:</span><span> </span><span>1</span><span>,</span><span>
    damping</span><span>:</span><span> </span><span>1</span><span>,</span><span>
  </span><span>);</span><span>

  </span><span>final</span><span> simulation </span><span>=</span><span> </span><span>SpringSimulation</span><span>(</span><span>spring</span><span>,</span><span> </span><span>0</span><span>,</span><span> </span><span>1</span><span>,</span><span> </span><span>-</span><span>unitVelocity</span><span>);</span><span>

  _controller</span><span>.</span><span>animateWith</span><span>(</span><span>simulation</span><span>);</span><span>
</span><span>}</span>
```

Don’t forget to call `_runAnimation()` with the velocity and size:

```
<span>onPanEnd</span><span>:</span><span> </span><span>(</span><span>details</span><span>)</span><span> </span><span>{</span><span>
  _runAnimation</span><span>(</span><span>details</span><span>.</span><span>velocity</span><span>.</span><span>pixelsPerSecond</span><span>,</span><span> size</span><span>);</span><span>
</span><span>},</span>
```

## Interactive Example