1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Navigation](https://docs.flutter.dev/cookbook/navigation)
3.  [Navigate to a new screen and back](https://docs.flutter.dev/cookbook/navigation/navigation-basics)

Most apps contain several screens for displaying different types of information. For example, an app might have a screen that displays products. When the user taps the image of a product, a new screen displays details about the product.

In Android, a route is equivalent to an Activity. In iOS, a route is equivalent to a ViewController. In Flutter, a route is just a widget.

This recipe uses the [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html) to navigate to a new route.

The next few sections show how to navigate between two routes, using these steps:

1.  Create two routes.
2.  Navigate to the second route using Navigator.push().
3.  Return to the first route using Navigator.pop().

## 1\. Create two routes

First, create two routes to work with. Since this is a basic example, each route contains only a single button. Tapping the button on the first route navigates to the second route. Tapping the button on the second route returns to the first route.

First, set up the visual structure:

```
<span>class</span><span> </span><span>FirstRoute</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>FirstRoute</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'First Route'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Open route'</span><span>),</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
            </span><span>// Navigate to second route when tapped.</span><span>
          </span><span>},</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>SecondRoute</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SecondRoute</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Second Route'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
            </span><span>// Navigate back to first route when tapped.</span><span>
          </span><span>},</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Go back!'</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 2\. Navigate to the second route using Navigator.push()

To switch to a new route, use the [`Navigator.push()`](https://api.flutter.dev/flutter/widgets/Navigator/push.html) method. The `push()` method adds a `Route` to the stack of routes managed by the `Navigator`. Where does the `Route` come from? You can create your own, or use a [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html), which is useful because it transitions to the new route using a platform-specific animation.

In the `build()` method of the `FirstRoute` widget, update the `onPressed()` callback:

```
<span>// Within the `FirstRoute` widget</span><span>
onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
  </span><span>Navigator</span><span>.</span><span>push</span><span>(</span><span>
    context</span><span>,</span><span>
    </span><span>MaterialPageRoute</span><span>(</span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>SecondRoute</span><span>()),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

## 3\. Return to the first route using Navigator.pop()

How do you close the second route and return to the first? By using the [`Navigator.pop()`](https://api.flutter.dev/flutter/widgets/Navigator/pop.html) method. The `pop()` method removes the current `Route` from the stack of routes managed by the `Navigator`.

To implement a return to the original route, update the `onPressed()` callback in the `SecondRoute` widget:

```
<span>// Within the SecondRoute widget</span><span>
onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
  </span><span>Navigator</span><span>.</span><span>pop</span><span>(</span><span>context</span><span>);</span><span>
</span><span>}</span>
```

## Interactive example

In the previous example you learned how to navigate between screens using the [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html) from [Material Components](https://docs.flutter.dev/ui/widgets/material). However, in Flutter you are not limited to Material design language, instead, you also have access to [Cupertino](https://docs.flutter.dev/ui/widgets/cupertino) (iOS-style) widgets.

Implementing navigation with Cupertino widgets follows the same steps as when using [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html), but instead you use [`CupertinoPageRoute`](https://api.flutter.dev/flutter/cupertino/CupertinoPageRoute-class.html) which provides an iOS-style transition animation.

In the following example, these widgets have been replaced:

-   [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html) replaced by [`CupertinoApp`](https://api.flutter.dev/flutter/cupertino/CupertinoApp-class.html).
-   [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) replaced by [`CupertinoPageScaffold`](https://api.flutter.dev/flutter/cupertino/CupertinoPageScaffold-class.html).
-   [`ElevatedButton`](https://api.flutter.dev/flutter/material/ElevatedButton-class.html) replaced by [`CupertinoButton`](https://api.flutter.dev/flutter/cupertino/CupertinoButton-class.html).

This way, the example follows the current iOS design language.