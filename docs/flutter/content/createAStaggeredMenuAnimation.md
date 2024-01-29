1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Effects](https://docs.flutter.dev/cookbook/effects)
3.  [Create a staggered menu animation](https://docs.flutter.dev/cookbook/effects/staggered-menu-animation)

A single app screen might contain multiple animations. Playing all of the animations at the same time can be overwhelming. Playing the animations one after the other can take too long. A better option is to stagger the animations. Each animation begins at a different time, but the animations overlap to create a shorter duration. In this recipe, you build a drawer menu with animated content that is staggered and has a button that pops in at the bottom.

The following animation shows the app’s behavior:

![Staggered Menu Animation Example](https://docs.flutter.dev/assets/images/docs/cookbook/effects/StaggeredMenuAnimation.gif)

The drawer menu displays a list of titles, followed by a Get started button at the bottom of the menu.

Define a stateful widget called `Menu` that displays the list and button in static locations.

```
<span>class</span><span> </span><span>Menu</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>Menu</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>Menu</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MenuState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MenuState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>Menu</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> _menuTitles </span><span>=</span><span> </span><span>[</span><span>
    </span><span>'Declarative Style'</span><span>,</span><span>
    </span><span>'Premade Widgets'</span><span>,</span><span>
    </span><span>'Stateful Hot Reload'</span><span>,</span><span>
    </span><span>'Native Performance'</span><span>,</span><span>
    </span><span>'Great Community'</span><span>,</span><span>
  </span><span>];</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Container</span><span>(</span><span>
      color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>Stack</span><span>(</span><span>
        fit</span><span>:</span><span> </span><span>StackFit</span><span>.</span><span>expand</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>
          _buildFlutterLogo</span><span>(),</span><span>
          _buildContent</span><span>(),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> _buildFlutterLogo</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// TODO: We'll implement this later.</span><span>
    </span><span>return</span><span> </span><span>Container</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> _buildContent</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Column</span><span>(</span><span>
      crossAxisAlignment</span><span>:</span><span> </span><span>CrossAxisAlignment</span><span>.</span><span>start</span><span>,</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        </span><span>const</span><span> </span><span>SizedBox</span><span>(</span><span>height</span><span>:</span><span> </span><span>16</span><span>),</span><span>
        </span><span>...</span><span>_buildListItems</span><span>(),</span><span>
        </span><span>const</span><span> </span><span>Spacer</span><span>(),</span><span>
        _buildGetStartedButton</span><span>(),</span><span>
      </span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> _buildListItems</span><span>()</span><span> </span><span>{</span><span>
    </span><span>final</span><span> listItems </span><span>=</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[];</span><span>
    </span><span>for</span><span> </span><span>(</span><span>var</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> _menuTitles</span><span>.</span><span>length</span><span>;</span><span> </span><span>++</span><span>i</span><span>)</span><span> </span><span>{</span><span>
      listItems</span><span>.</span><span>add</span><span>(</span><span>
        </span><span>Padding</span><span>(</span><span>
          padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>horizontal</span><span>:</span><span> </span><span>36</span><span>,</span><span> vertical</span><span>:</span><span> </span><span>16</span><span>),</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
            _menuTitles</span><span>[</span><span>i</span><span>],</span><span>
            textAlign</span><span>:</span><span> </span><span>TextAlign</span><span>.</span><span>left</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>
              fontSize</span><span>:</span><span> </span><span>24</span><span>,</span><span>
              fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w500</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span>
    </span><span>return</span><span> listItems</span><span>;</span><span>
  </span><span>}</span><span>

  </span><span>Widget</span><span> _buildGetStartedButton</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>SizedBox</span><span>(</span><span>
      width</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>24</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
          style</span><span>:</span><span> </span><span>ElevatedButton</span><span>.</span><span>styleFrom</span><span>(</span><span>
            shape</span><span>:</span><span> </span><span>const</span><span> </span><span>StadiumBorder</span><span>(),</span><span>
            backgroundColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>,</span><span>
            padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>horizontal</span><span>:</span><span> </span><span>48</span><span>,</span><span> vertical</span><span>:</span><span> </span><span>14</span><span>),</span><span>
          </span><span>),</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
            </span><span>'Get Started'</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>,</span><span>
              fontSize</span><span>:</span><span> </span><span>22</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Prepare for animations

Control of the animation timing requires an `AnimationController`.

Add the `SingleTickerProviderStateMixin` to the `MenuState` class. Then, declare and instantiate an `AnimationController`.

```
<span>class</span><span> _MenuState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>Menu</span><span>&gt;</span><span> </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>AnimationController</span><span> _staggeredController</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>

    _staggeredController </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
      vsync</span><span>:</span><span> </span><span>this</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    _staggeredController</span><span>.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The length of the delay before every animation is up to you. Define the animation delays, individual animation durations, and the total animation duration.

```
<span>class</span><span> _MenuState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>Menu</span><span>&gt;</span><span> </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> _initialDelayTime </span><span>=</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>50</span><span>);</span><span>
  </span><span>static</span><span> </span><span>const</span><span> _itemSlideTime </span><span>=</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>250</span><span>);</span><span>
  </span><span>static</span><span> </span><span>const</span><span> _staggerTime </span><span>=</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>50</span><span>);</span><span>
  </span><span>static</span><span> </span><span>const</span><span> _buttonDelayTime </span><span>=</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>150</span><span>);</span><span>
  </span><span>static</span><span> </span><span>const</span><span> _buttonTime </span><span>=</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>500</span><span>);</span><span>
  </span><span>final</span><span> _animationDuration </span><span>=</span><span> _initialDelayTime </span><span>+</span><span>
      </span><span>(</span><span>_staggerTime </span><span>*</span><span> _menuTitles</span><span>.</span><span>length</span><span>)</span><span> </span><span>+</span><span>
      _buttonDelayTime </span><span>+</span><span>
      _buttonTime</span><span>;</span><span>
</span><span>}</span>
```

In this case, all the animations are delayed by 50 ms. After that, list items begin to appear. Each list item’s appearance is delayed by 50 ms after the previous list item begins to slide in. Each list item takes 250 ms to slide from right to left. After the last list item begins to slide in, the button at the bottom waits another 150 ms to pop in. The button animation takes 500 ms.

With each delay and animation duration defined, the total duration is calculated so that it can be used to calculate the individual animation times.

The desired animation times are shown in the following diagram:

![Animation Timing Diagram](https://docs.flutter.dev/assets/images/docs/cookbook/effects/TimingDiagram.png)

To animate a value during a subsection of a larger animation, Flutter provides the `Interval` class. An `Interval` takes a start time percentage and an end time percentage. That `Interval` can then be used to animate a value between those start and end times, instead of using the entire animation’s start and end times. For example, given an animation that takes 1 second, an interval from 0.2 to 0.5 would start at 200 ms (20%) and end at 500 ms (50%).

Declare and calculate each list item’s `Interval` and the bottom button `Interval`.

```
<span>class</span><span> _MenuState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>Menu</span><span>&gt;</span><span> </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Interval</span><span>&gt;</span><span> _itemSlideIntervals </span><span>=</span><span> </span><span>[];</span><span>
  </span><span>late</span><span> </span><span>Interval</span><span> _buttonInterval</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>

    _createAnimationIntervals</span><span>();</span><span>

    _staggeredController </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
      vsync</span><span>:</span><span> </span><span>this</span><span>,</span><span>
      duration</span><span>:</span><span> _animationDuration</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>void</span><span> _createAnimationIntervals</span><span>()</span><span> </span><span>{</span><span>
    </span><span>for</span><span> </span><span>(</span><span>var</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> _menuTitles</span><span>.</span><span>length</span><span>;</span><span> </span><span>++</span><span>i</span><span>)</span><span> </span><span>{</span><span>
      </span><span>final</span><span> startTime </span><span>=</span><span> _initialDelayTime </span><span>+</span><span> </span><span>(</span><span>_staggerTime </span><span>*</span><span> i</span><span>);</span><span>
      </span><span>final</span><span> endTime </span><span>=</span><span> startTime </span><span>+</span><span> _itemSlideTime</span><span>;</span><span>
      _itemSlideIntervals</span><span>.</span><span>add</span><span>(</span><span>
        </span><span>Interval</span><span>(</span><span>
          startTime</span><span>.</span><span>inMilliseconds </span><span>/</span><span> _animationDuration</span><span>.</span><span>inMilliseconds</span><span>,</span><span>
          endTime</span><span>.</span><span>inMilliseconds </span><span>/</span><span> _animationDuration</span><span>.</span><span>inMilliseconds</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span>

    </span><span>final</span><span> buttonStartTime </span><span>=</span><span>
        </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>(</span><span>_menuTitles</span><span>.</span><span>length </span><span>*</span><span> </span><span>50</span><span>))</span><span> </span><span>+</span><span> _buttonDelayTime</span><span>;</span><span>
    </span><span>final</span><span> buttonEndTime </span><span>=</span><span> buttonStartTime </span><span>+</span><span> _buttonTime</span><span>;</span><span>
    _buttonInterval </span><span>=</span><span> </span><span>Interval</span><span>(</span><span>
      buttonStartTime</span><span>.</span><span>inMilliseconds </span><span>/</span><span> _animationDuration</span><span>.</span><span>inMilliseconds</span><span>,</span><span>
      buttonEndTime</span><span>.</span><span>inMilliseconds </span><span>/</span><span> _animationDuration</span><span>.</span><span>inMilliseconds</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Animate the list items and button

The staggered animation plays as soon as the menu becomes visible.

Start the animation in `initState()`.

```
<span>@override
</span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
  </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>

  _createAnimationIntervals</span><span>();</span><span>

  _staggeredController </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
    vsync</span><span>:</span><span> </span><span>this</span><span>,</span><span>
    duration</span><span>:</span><span> _animationDuration</span><span>,</span><span>
  </span><span>)..</span><span>forward</span><span>();</span><span>
</span><span>}</span>
```

Each list item slides from right to left and fades in at the same time.

Use the list item’s `Interval` and an `easeOut` curve to animate the opacity and translation values for each list item.

```
<span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span><span> _buildListItems</span><span>()</span><span> </span><span>{</span><span>
  </span><span>final</span><span> listItems </span><span>=</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[];</span><span>
  </span><span>for</span><span> </span><span>(</span><span>var</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span> i </span><span>&lt;</span><span> _menuTitles</span><span>.</span><span>length</span><span>;</span><span> </span><span>++</span><span>i</span><span>)</span><span> </span><span>{</span><span>
    listItems</span><span>.</span><span>add</span><span>(</span><span>
      </span><span>AnimatedBuilder</span><span>(</span><span>
        animation</span><span>:</span><span> _staggeredController</span><span>,</span><span>
        builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
          </span><span>final</span><span> animationPercent </span><span>=</span><span> </span><span>Curves</span><span>.</span><span>easeOut</span><span>.</span><span>transform</span><span>(</span><span>
            _itemSlideIntervals</span><span>[</span><span>i</span><span>].</span><span>transform</span><span>(</span><span>_staggeredController</span><span>.</span><span>value</span><span>),</span><span>
          </span><span>);</span><span>
          </span><span>final</span><span> opacity </span><span>=</span><span> animationPercent</span><span>;</span><span>
          </span><span>final</span><span> slideDistance </span><span>=</span><span> </span><span>(</span><span>1.0</span><span> </span><span>-</span><span> animationPercent</span><span>)</span><span> </span><span>*</span><span> </span><span>150</span><span>;</span><span>

          </span><span>return</span><span> </span><span>Opacity</span><span>(</span><span>
            opacity</span><span>:</span><span> opacity</span><span>,</span><span>
            child</span><span>:</span><span> </span><span>Transform</span><span>.</span><span>translate</span><span>(</span><span>
              offset</span><span>:</span><span> </span><span>Offset</span><span>(</span><span>slideDistance</span><span>,</span><span> </span><span>0</span><span>),</span><span>
              child</span><span>:</span><span> child</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>);</span><span>
        </span><span>},</span><span>
        child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
          padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>horizontal</span><span>:</span><span> </span><span>36</span><span>,</span><span> vertical</span><span>:</span><span> </span><span>16</span><span>),</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
            _menuTitles</span><span>[</span><span>i</span><span>],</span><span>
            textAlign</span><span>:</span><span> </span><span>TextAlign</span><span>.</span><span>left</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>
              fontSize</span><span>:</span><span> </span><span>24</span><span>,</span><span>
              fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w500</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
  </span><span>return</span><span> listItems</span><span>;</span><span>
</span><span>}</span>
```

Use the same approach to animate the opacity and scale of the bottom button. This time, use an `elasticOut` curve to give the button a springy effect.

```
<span>Widget</span><span> _buildGetStartedButton</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>SizedBox</span><span>(</span><span>
    width</span><span>:</span><span> </span><span>double</span><span>.</span><span>infinity</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
      padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>24</span><span>),</span><span>
      child</span><span>:</span><span> </span><span>AnimatedBuilder</span><span>(</span><span>
        animation</span><span>:</span><span> _staggeredController</span><span>,</span><span>
        builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
          </span><span>final</span><span> animationPercent </span><span>=</span><span> </span><span>Curves</span><span>.</span><span>elasticOut</span><span>.</span><span>transform</span><span>(</span><span>
              _buttonInterval</span><span>.</span><span>transform</span><span>(</span><span>_staggeredController</span><span>.</span><span>value</span><span>));</span><span>
          </span><span>final</span><span> opacity </span><span>=</span><span> animationPercent</span><span>.</span><span>clamp</span><span>(</span><span>0.0</span><span>,</span><span> </span><span>1.0</span><span>);</span><span>
          </span><span>final</span><span> scale </span><span>=</span><span> </span><span>(</span><span>animationPercent </span><span>*</span><span> </span><span>0.5</span><span>)</span><span> </span><span>+</span><span> </span><span>0.5</span><span>;</span><span>

          </span><span>return</span><span> </span><span>Opacity</span><span>(</span><span>
            opacity</span><span>:</span><span> opacity</span><span>,</span><span>
            child</span><span>:</span><span> </span><span>Transform</span><span>.</span><span>scale</span><span>(</span><span>
              scale</span><span>:</span><span> scale</span><span>,</span><span>
              child</span><span>:</span><span> child</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>);</span><span>
        </span><span>},</span><span>
        child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
          style</span><span>:</span><span> </span><span>ElevatedButton</span><span>.</span><span>styleFrom</span><span>(</span><span>
            shape</span><span>:</span><span> </span><span>const</span><span> </span><span>StadiumBorder</span><span>(),</span><span>
            backgroundColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>,</span><span>
            padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>horizontal</span><span>:</span><span> </span><span>48</span><span>,</span><span> vertical</span><span>:</span><span> </span><span>14</span><span>),</span><span>
          </span><span>),</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
            </span><span>'Get Started'</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>
              color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>,</span><span>
              fontSize</span><span>:</span><span> </span><span>22</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

Congratulations! You have an animated menu where the appearance of each list item is staggered, followed by a bottom button that pops into place.

## Interactive example