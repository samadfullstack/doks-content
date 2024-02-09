1. [UI](https://docs.flutter.dev/ui)
2. [Interactivity](https://docs.flutter.dev/ui/interactivity)

How do you modify your app to make it react to user input? In this tutorial, you’ll add interactivity to an app that contains only non-interactive widgets. Specifically, you’ll modify an icon to make it tappable by creating a custom stateful widget that manages two stateless widgets.

The [building layouts tutorial](https://docs.flutter.dev/ui/layout/tutorial) showed you how to create the layout for the following screenshot.

![The layout tutorial app](https://docs.flutter.dev/assets/images/docs/ui/layout/lakes.jpg)

The layout tutorial app

When the app first launches, the star is solid red, indicating that this lake has previously been favorited. The number next to the star indicates that 41 people have favorited this lake. After completing this tutorial, tapping the star removes its favorited status, replacing the solid star with an outline and decreasing the count. Tapping again favorites the lake, drawing a solid star and increasing the count.

![The custom widget you'll create](https://docs.flutter.dev/assets/images/docs/ui/favorited-not-favorited.png)

To accomplish this, you’ll create a single custom widget that includes both the star and the count, which are themselves widgets. Tapping the star changes state for both widgets, so the same widget should manage both.

You can get right to touching the code in [Step 2: Subclass StatefulWidget](https://docs.flutter.dev/ui/interactivity#step-2). If you want to try different ways of managing state, skip to [Managing state](https://docs.flutter.dev/ui/interactivity#managing-state).

A widget is either stateful or stateless. If a widget can change—when a user interacts with it, for example—it’s stateful.

A _stateless_ widget never changes. [`Icon`](https://api.flutter.dev/flutter/widgets/Icon-class.html), [`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html), and [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) are examples of stateless widgets. Stateless widgets subclass [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html).

A _stateful_ widget is dynamic: for example, it can change its appearance in response to events triggered by user interactions or when it receives data. [`Checkbox`](https://api.flutter.dev/flutter/material/Checkbox-class.html), [`Radio`](https://api.flutter.dev/flutter/material/Radio-class.html), [`Slider`](https://api.flutter.dev/flutter/material/Slider-class.html), [`InkWell`](https://api.flutter.dev/flutter/material/InkWell-class.html), [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html), and [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) are examples of stateful widgets. Stateful widgets subclass [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).

A widget’s state is stored in a [`State`](https://api.flutter.dev/flutter/widgets/State-class.html) object, separating the widget’s state from its appearance. The state consists of values that can change, like a slider’s current value or whether a checkbox is checked. When the widget’s state changes, the state object calls `setState()`, telling the framework to redraw the widget.

In this section, you’ll create a custom stateful widget. You’ll replace two stateless widgets—the solid red star and the numeric count next to it—with a single custom stateful widget that manages a row with two children widgets: an `IconButton` and `Text`.

Implementing a custom stateful widget requires creating two classes:

- A subclass of `StatefulWidget` that defines the widget.
- A subclass of `State` that contains the state for that widget and defines the widget’s `build()` method.

This section shows you how to build a stateful widget, called `FavoriteWidget`, for the lakes app. After setting up, your first step is choosing how state is managed for `FavoriteWidget`.

### Step 0: Get ready

If you’ve already built the app in the [building layouts tutorial](https://docs.flutter.dev/ui/layout/tutorial), skip to the next section.

1. Make sure you’ve [set up](https://docs.flutter.dev/get-started/install) your environment.
2. [Create a new Flutter app](https://docs.flutter.dev/get-started/test-drive).
3. Replace the `lib/main.dart` file with [`main.dart`](https://github.com/flutter/website/tree/main/examples/layout/lakes/step6/lib/main.dart).
4. Replace the `pubspec.yaml` file with [`pubspec.yaml`](https://github.com/flutter/website/tree/main/examples/layout/lakes/step6/pubspec.yaml).
5. Create an `images` directory in your project, and add [`lake.jpg`](https://github.com/flutter/website/tree/main/examples/layout/lakes/step6/images/lake.jpg).

Once you have a connected and enabled device, or you’ve launched the [iOS simulator](https://docs.flutter.dev/get-started/install/macos/mobile-ios#configure-your-target-ios-device) (part of the Flutter install) or the [Android emulator](https://docs.flutter.dev/get-started/install/windows/mobile?tab=virtual#configure-your-target-android-device) (part of the Android Studio install), you are good to go!

### Step 1: Decide which object manages the widget’s state

A widget’s state can be managed in several ways, but in our example the widget itself, `FavoriteWidget`, will manage its own state. In this example, toggling the star is an isolated action that doesn’t affect the parent widget or the rest of the UI, so the widget can handle its state internally.

Learn more about the separation of widget and state, and how state might be managed, in [Managing state](https://docs.flutter.dev/ui/interactivity#managing-state).

### Step 2: Subclass StatefulWidget

The `FavoriteWidget` class manages its own state, so it overrides `createState()` to create a `State` object. The framework calls `createState()` when it wants to build the widget. In this example, `createState()` returns an instance of `_FavoriteWidgetState`, which you’ll implement in the next step.

```
<span>class</span><span> </span><span>FavoriteWidget</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>FavoriteWidget</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span><</span><span>FavoriteWidget</span><span>></span><span> createState</span><span>()</span><span> </span><span>=></span><span> _FavoriteWidgetState</span><span>();</span><span>
</span><span>}</span>
```

### Step 3: Subclass State

The `_FavoriteWidgetState` class stores the mutable data that can change over the lifetime of the widget. When the app first launches, the UI displays a solid red star, indicating that the lake has “favorite” status, along with 41 likes. These values are stored in the `_isFavorited` and `_favoriteCount` fields:

```
<span>class</span><span> _FavoriteWidgetState </span><span>extends</span><span> </span><span>State</span><span><</span><span>FavoriteWidget</span><span>></span><span> </span><span>{</span><span>
  </span><span><span>bool</span><span> _isFavorited </span><span>=</span><span> </span><span>true</span><span>;</span></span><span>
  </span><span><span>int</span><span> _favoriteCount </span><span>=</span><span> </span><span>41</span><span>;</span></span><span>

  </span><span>// ···</span><span>
</span><span>}</span>
```

The class also defines a `build()` method, which creates a row containing a red `IconButton`, and `Text`. You use [`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html) (instead of `Icon`) because it has an `onPressed` property that defines the callback function (`_toggleFavorite`) for handling a tap. You’ll define the callback function next.

```
<span>class</span><span> _FavoriteWidgetState </span><span>extends</span><span> </span><span>State</span><span><</span><span>FavoriteWidget</span><span>></span><span> </span><span>{</span><span>
  </span><span>// ···</span><span>
  @override
  </span><span>Widget</span><span> </span><span><span>build</span></span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Row</span><span>(</span><span>
      mainAxisSize</span><span>:</span><span> </span><span>MainAxisSize</span><span>.</span><span>min</span><span>,</span><span>
      children</span><span>:</span><span> </span><span>[</span><span>
        </span><span>Container</span><span>(</span><span>
          padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>0</span><span>),</span><span>
          child</span><span>:</span><span> </span><span>IconButton</span><span>(</span><span>
            padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>0</span><span>),</span><span>
            alignment</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>centerRight</span><span>,</span><span>
            </span><span><span>icon</span><span>:</span><span> </span><span>(</span><span>_isFavorited</span></span><span>
                </span><span>?</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star</span><span>)</span><span>
                </span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>star_border</span><span>)),</span><span>
            color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>[</span><span>500</span><span>],</span><span>
            </span><span><span>onPressed</span><span>:</span><span> _toggleFavorite</span><span>,</span></span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
        </span><span>SizedBox</span><span>(</span><span>
          width</span><span>:</span><span> </span><span>18</span><span>,</span><span>
          child</span><span>:</span><span> </span><span>SizedBox</span><span>(</span><span>
            </span><span><span>child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'$_favoriteCount'</span><span>),</span></span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The `_toggleFavorite()` method, which is called when the `IconButton` is pressed, calls `setState()`. Calling `setState()` is critical, because this tells the framework that the widget’s state has changed and that the widget should be redrawn. The function argument to `setState()` toggles the UI between these two states:

- A `star` icon and the number 41
- A `star_border` icon and the number 40

```
<span>void</span><span> _toggleFavorite</span><span>()</span><span> </span><span>{</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>_isFavorited</span><span>)</span><span> </span><span>{</span><span>
      _favoriteCount </span><span>-=</span><span> </span><span>1</span><span>;</span><span>
      _isFavorited </span><span>=</span><span> </span><span>false</span><span>;</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
      _favoriteCount </span><span>+=</span><span> </span><span>1</span><span>;</span><span>
      _isFavorited </span><span>=</span><span> </span><span>true</span><span>;</span><span>
    </span><span>}</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

### Step 4: Plug the stateful widget into the widget tree

Add your custom stateful widget to the widget tree in the app’s `build()` method. First, locate the code that creates the `Icon` and `Text`, and delete it. In the same location, create the stateful widget:

<table><tbody><tr><td></td><td><p>@@ -83,11 +83,7 @@</p></td></tr><tr><td><p>83</p><p>83</p></td><td><p><span> </span> <span>],</span></p></td></tr><tr><td><p>84</p><p>84</p></td><td><p><span> </span> <span>),</span></p></td></tr><tr><td><p>85</p><p>85</p></td><td><p><span> </span> <span>),</span></p></td></tr><tr><td><p>86</p></td><td><p><span>-</span> <span><del>Icon</del>(</span></p></td></tr><tr><td><p>87</p></td><td><p><span>-</span> <span>Icons.star,</span></p></td></tr><tr><td><p>88</p></td><td><p><span>-</span> <span>color: Colors.red[<span>500</span>],</span></p></td></tr><tr><td><p>89</p></td><td><p><span>-</span> <span>),</span></p></td></tr><tr><td><p>90</p></td><td><p><span>-</span> <span><span>const</span> Text(<span>'41'</span>),</span></p></td></tr><tr><td><p>86</p></td><td><p><span>+</span> <span><ins><span>const</span> FavoriteWidget</ins>(<ins>),</ins></span></p></td></tr><tr><td><p>91</p><p>87</p></td><td><p><span> </span> <span>],</span></p></td></tr><tr><td><p>92</p><p>88</p></td><td><p><span> </span> <span>),</span></p></td></tr><tr><td><p>93</p><p>89</p></td><td><p><span> </span> <span>);</span></p></td></tr></tbody></table>

That’s it! When you hot reload the app, the star icon should now respond to taps.

### Problems?

If you can’t get your code to run, look in your IDE for possible errors. [Debugging Flutter apps](https://docs.flutter.dev/testing/debugging) might help. If you still can’t find the problem, check your code against the interactive lakes example on GitHub.

- [`lib/main.dart`](https://github.com/flutter/website/tree/main/examples/layout/lakes/interactive/lib/main.dart)
- [`pubspec.yaml`](https://github.com/flutter/website/tree/main/examples/layout/lakes/interactive/pubspec.yaml)
- [`lakes.jpg`](https://github.com/flutter/website/tree/main/examples/layout/lakes/interactive/images/lake.jpg)

If you still have questions, refer to any one of the developer [community](https://flutter.dev/community) channels.

---

The rest of this page covers several ways a widget’s state can be managed, and lists other available interactive widgets.

## Managing state

Who manages the stateful widget’s state? The widget itself? The parent widget? Both? Another object? The answer is… it depends. There are several valid ways to make your widget interactive. You, as the widget designer, make the decision based on how you expect your widget to be used. Here are the most common ways to manage state:

- [The widget manages its own state](https://docs.flutter.dev/ui/interactivity#self-managed)
- [The parent manages the widget’s state](https://docs.flutter.dev/ui/interactivity#parent-managed)
- [A mix-and-match approach](https://docs.flutter.dev/ui/interactivity#mix-and-match)

How do you decide which approach to use? The following principles should help you decide:

- If the state in question is user data, for example the checked or unchecked mode of a checkbox, or the position of a slider, then the state is best managed by the parent widget.
- If the state in question is aesthetic, for example an animation, then the state is best managed by the widget itself.

If in doubt, start by managing state in the parent widget.

We’ll give examples of the different ways of managing state by creating three simple examples: TapboxA, TapboxB, and TapboxC. The examples all work similarly—each creates a container that, when tapped, toggles between a green or grey box. The `_active` boolean determines the color: green for active or grey for inactive.

![Active state](https://docs.flutter.dev/assets/images/docs/ui/tapbox-active-state.png) ![Inactive state](https://docs.flutter.dev/assets/images/docs/ui/tapbox-inactive-state.png)

These examples use [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) to capture activity on the `Container`.

### The widget manages its own state

Sometimes it makes the most sense for the widget to manage its state internally. For example, [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) automatically scrolls when its content exceeds the render box. Most developers using `ListView` don’t want to manage `ListView`’s scrolling behavior, so `ListView` itself manages its scroll offset.

The `_TapboxAState` class:

- Manages state for `TapboxA`.
- Defines the `_active` boolean which determines the box’s current color.
- Defines the `_handleTap()` function, which updates `_active` when the box is tapped and calls the `setState()` function to update the UI.
- Implements all interactive behavior for the widget.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>// TapboxA manages its own state.</span><span>

</span><span>//------------------------- TapboxA ----------------------------------</span><span>

</span><span>class</span><span> </span><span>TapboxA</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>TapboxA</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span><</span><span>TapboxA</span><span>></span><span> createState</span><span>()</span><span> </span><span>=></span><span> _TapboxAState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _TapboxAState </span><span>extends</span><span> </span><span>State</span><span><</span><span>TapboxA</span><span>></span><span> </span><span>{</span><span>
  </span><span>bool</span><span> _active </span><span>=</span><span> </span><span>false</span><span>;</span><span>

  </span><span>void</span><span> _handleTap</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _active </span><span>=</span><span> </span><span>!</span><span>_active</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onTap</span><span>:</span><span> _handleTap</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        width</span><span>:</span><span> </span><span>200</span><span>,</span><span>
        height</span><span>:</span><span> </span><span>200</span><span>,</span><span>
        decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          color</span><span>:</span><span> _active </span><span>?</span><span> </span><span>Colors</span><span>.</span><span>lightGreen</span><span>[</span><span>700</span><span>]</span><span> </span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>600</span><span>],</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
            _active </span><span>?</span><span> </span><span>'Active'</span><span> </span><span>:</span><span> </span><span>'Inactive'</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>fontSize</span><span>:</span><span> </span><span>32</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>//------------------------- MyApp ----------------------------------</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Flutter Demo'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Flutter Demo'</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>TapboxA</span><span>(),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

---

### The parent widget manages the widget’s state

Often it makes the most sense for the parent widget to manage the state and tell its child widget when to update. For example, [`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html) allows you to treat an icon as a tappable button. `IconButton` is a stateless widget because we decided that the parent widget needs to know whether the button has been tapped, so it can take appropriate action.

In the following example, TapboxB exports its state to its parent through a callback. Because TapboxB doesn’t manage any state, it subclasses StatelessWidget.

The ParentWidgetState class:

- Manages the `_active` state for TapboxB.
- Implements `_handleTapboxChanged()`, the method called when the box is tapped.
- When the state changes, calls `setState()` to update the UI.

The TapboxB class:

- Extends StatelessWidget because all state is handled by its parent.
- When a tap is detected, it notifies the parent.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>// ParentWidget manages the state for TapboxB.</span><span>

</span><span>//------------------------ ParentWidget --------------------------------</span><span>

</span><span>class</span><span> </span><span>ParentWidget</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ParentWidget</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span><</span><span>ParentWidget</span><span>></span><span> createState</span><span>()</span><span> </span><span>=></span><span> _ParentWidgetState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _ParentWidgetState </span><span>extends</span><span> </span><span>State</span><span><</span><span>ParentWidget</span><span>></span><span> </span><span>{</span><span>
  </span><span>bool</span><span> _active </span><span>=</span><span> </span><span>false</span><span>;</span><span>

  </span><span>void</span><span> _handleTapboxChanged</span><span>(</span><span>bool</span><span> newValue</span><span>)</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _active </span><span>=</span><span> newValue</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>SizedBox</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>TapboxB</span><span>(</span><span>
        active</span><span>:</span><span> _active</span><span>,</span><span>
        onChanged</span><span>:</span><span> _handleTapboxChanged</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>//------------------------- TapboxB ----------------------------------</span><span>

</span><span>class</span><span> </span><span>TapboxB</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>TapboxB</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>this</span><span>.</span><span>active </span><span>=</span><span> </span><span>false</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>onChanged</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>bool</span><span> active</span><span>;</span><span>
  </span><span>final</span><span> </span><span>ValueChanged</span><span><</span><span>bool</span><span>></span><span> onChanged</span><span>;</span><span>

  </span><span>void</span><span> _handleTap</span><span>()</span><span> </span><span>{</span><span>
    onChanged</span><span>(!</span><span>active</span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onTap</span><span>:</span><span> _handleTap</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        width</span><span>:</span><span> </span><span>200</span><span>,</span><span>
        height</span><span>:</span><span> </span><span>200</span><span>,</span><span>
        decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          color</span><span>:</span><span> active </span><span>?</span><span> </span><span>Colors</span><span>.</span><span>lightGreen</span><span>[</span><span>700</span><span>]</span><span> </span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>600</span><span>],</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
            active </span><span>?</span><span> </span><span>'Active'</span><span> </span><span>:</span><span> </span><span>'Inactive'</span><span>,</span><span>
            style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>fontSize</span><span>:</span><span> </span><span>32</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

---

### A mix-and-match approach

For some widgets, a mix-and-match approach makes the most sense. In this scenario, the stateful widget manages some of the state, and the parent widget manages other aspects of the state.

In the `TapboxC` example, on tap down, a dark green border appears around the box. On tap up, the border disappears and the box’s color changes. `TapboxC` exports its `_active` state to its parent but manages its `_highlight` state internally. This example has two `State` objects, `_ParentWidgetState` and `_TapboxCState`.

The `_ParentWidgetState` object:

- Manages the `_active` state.
- Implements `_handleTapboxChanged()`, the method called when the box is tapped.
- Calls `setState()` to update the UI when a tap occurs and the `_active` state changes.

The `_TapboxCState` object:

- Manages the `_highlight` state.
- The `GestureDetector` listens to all tap events. As the user taps down, it adds the highlight (implemented as a dark green border). As the user releases the tap, it removes the highlight.
- Calls `setState()` to update the UI on tap down, tap up, or tap cancel, and the `_highlight` state changes.
- On a tap event, passes that state change to the parent widget to take appropriate action using the [`widget`](https://api.flutter.dev/flutter/widgets/State/widget.html) property.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>//---------------------------- ParentWidget ----------------------------</span><span>

</span><span>class</span><span> </span><span>ParentWidget</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>ParentWidget</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span><</span><span>ParentWidget</span><span>></span><span> createState</span><span>()</span><span> </span><span>=></span><span> _ParentWidgetState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _ParentWidgetState </span><span>extends</span><span> </span><span>State</span><span><</span><span>ParentWidget</span><span>></span><span> </span><span>{</span><span>
  </span><span>bool</span><span> _active </span><span>=</span><span> </span><span>false</span><span>;</span><span>

  </span><span>void</span><span> _handleTapboxChanged</span><span>(</span><span>bool</span><span> newValue</span><span>)</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _active </span><span>=</span><span> newValue</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>SizedBox</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>TapboxC</span><span>(</span><span>
        active</span><span>:</span><span> _active</span><span>,</span><span>
        onChanged</span><span>:</span><span> _handleTapboxChanged</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>//----------------------------- TapboxC ------------------------------</span><span>

</span><span>class</span><span> </span><span>TapboxC</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>TapboxC</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>this</span><span>.</span><span>active </span><span>=</span><span> </span><span>false</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>onChanged</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>bool</span><span> active</span><span>;</span><span>
  </span><span>final</span><span> </span><span>ValueChanged</span><span><</span><span>bool</span><span>></span><span> onChanged</span><span>;</span><span>

  @override
  </span><span>State</span><span><</span><span>TapboxC</span><span>></span><span> createState</span><span>()</span><span> </span><span>=></span><span> _TapboxCState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _TapboxCState </span><span>extends</span><span> </span><span>State</span><span><</span><span>TapboxC</span><span>></span><span> </span><span>{</span><span>
  </span><span>bool</span><span> _highlight </span><span>=</span><span> </span><span>false</span><span>;</span><span>

  </span><span>void</span><span> _handleTapDown</span><span>(</span><span>TapDownDetails</span><span> details</span><span>)</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _highlight </span><span>=</span><span> </span><span>true</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>void</span><span> _handleTapUp</span><span>(</span><span>TapUpDetails</span><span> details</span><span>)</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _highlight </span><span>=</span><span> </span><span>false</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>void</span><span> _handleTapCancel</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _highlight </span><span>=</span><span> </span><span>false</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>void</span><span> _handleTap</span><span>()</span><span> </span><span>{</span><span>
    widget</span><span>.</span><span>onChanged</span><span>(!</span><span>widget</span><span>.</span><span>active</span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// This example adds a green border on tap down.</span><span>
    </span><span>// On tap up, the square changes to the opposite state.</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
      onTapDown</span><span>:</span><span> _handleTapDown</span><span>,</span><span> </span><span>// Handle the tap events in the order that</span><span>
      onTapUp</span><span>:</span><span> _handleTapUp</span><span>,</span><span> </span><span>// they occur: down, up, tap, cancel</span><span>
      onTap</span><span>:</span><span> _handleTap</span><span>,</span><span>
      onTapCancel</span><span>:</span><span> _handleTapCancel</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
        width</span><span>:</span><span> </span><span>200</span><span>,</span><span>
        height</span><span>:</span><span> </span><span>200</span><span>,</span><span>
        decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          color</span><span>:</span><span> widget</span><span>.</span><span>active </span><span>?</span><span> </span><span>Colors</span><span>.</span><span>lightGreen</span><span>[</span><span>700</span><span>]</span><span> </span><span>:</span><span> </span><span>Colors</span><span>.</span><span>grey</span><span>[</span><span>600</span><span>],</span><span>
          border</span><span>:</span><span> _highlight
              </span><span>?</span><span> </span><span>Border</span><span>.</span><span>all</span><span>(</span><span>
                  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>teal</span><span>[</span><span>700</span><span>]!,</span><span>
                  width</span><span>:</span><span> </span><span>10</span><span>,</span><span>
                </span><span>)</span><span>
              </span><span>:</span><span> </span><span>null</span><span>,</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>widget</span><span>.</span><span>active </span><span>?</span><span> </span><span>'Active'</span><span> </span><span>:</span><span> </span><span>'Inactive'</span><span>,</span><span>
              style</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>fontSize</span><span>:</span><span> </span><span>32</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>white</span><span>)),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

An alternate implementation might have exported the highlight state to the parent while keeping the active state internal, but if you asked someone to use that tap box, they’d probably complain that it doesn’t make much sense. The developer cares whether the box is active. The developer probably doesn’t care how the highlighting is managed, and prefers that the tap box handles those details.

---

Flutter offers a variety of buttons and similar interactive widgets. Most of these widgets implement the [Material Design guidelines](https://m3.material.io/styles), which define a set of components with an opinionated UI.

If you prefer, you can use [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) to build interactivity into any custom widget. You can find examples of `GestureDetector` in [Managing state](https://docs.flutter.dev/ui/interactivity#managing-state). Learn more about the `GestureDetector` in [Handle taps](https://docs.flutter.dev/cookbook/gestures/handling-taps), a recipe in the [Flutter cookbook](https://docs.flutter.dev/cookbook).

When you need interactivity, it’s easiest to use one of the prefabricated widgets. Here’s a partial list:

### Standard widgets

- [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html)
- [`FormField`](https://api.flutter.dev/flutter/widgets/FormField-class.html)

### Material Components

- [`Checkbox`](https://api.flutter.dev/flutter/material/Checkbox-class.html)
- [`DropdownButton`](https://api.flutter.dev/flutter/material/DropdownButton-class.html)
- [`TextButton`](https://api.flutter.dev/flutter/material/TextButton-class.html)
- [`FloatingActionButton`](https://api.flutter.dev/flutter/material/FloatingActionButton-class.html)
- [`IconButton`](https://api.flutter.dev/flutter/material/IconButton-class.html)
- [`Radio`](https://api.flutter.dev/flutter/material/Radio-class.html)
- [`ElevatedButton`](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)
- [`Slider`](https://api.flutter.dev/flutter/material/Slider-class.html)
- [`Switch`](https://api.flutter.dev/flutter/material/Switch-class.html)
- [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html)

## Resources

The following resources might help when adding interactivity to your app.

[Gestures](https://docs.flutter.dev/cookbook/gestures), a section in the [Flutter cookbook](https://docs.flutter.dev/cookbook).

[Handling gestures](https://docs.flutter.dev/ui#handling-gestures)

How to create a button and make it respond to input.

[Gestures in Flutter](https://docs.flutter.dev/ui/interactivity/gestures)

A description of Flutter’s gesture mechanism.

[Flutter API documentation](https://api.flutter.dev/)

Reference documentation for all of the Flutter libraries.

Flutter Gallery [running app](https://gallery.flutter.dev/), [repo](https://github.com/flutter/gallery)

Demo app showcasing many Material components and other Flutter features.

[Flutter’s Layered Design](https://www.youtube.com/watch?v=dkyY9WCGMi0) (video)

This video includes information about state and stateless widgets. Presented by Google engineer, Ian Hickson.
