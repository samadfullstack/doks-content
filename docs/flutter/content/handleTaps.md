1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Gestures](https://docs.flutter.dev/cookbook/gestures)
3.  [Handle taps](https://docs.flutter.dev/cookbook/gestures/handling-taps)

You not only want to display information to users, you want users to interact with your app. Use the [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) widget to respond to fundamental actions, such as tapping and dragging.

This recipe shows how to make a custom button that shows a snackbar when tapped with the following steps:

1.  Create the button.
2.  Wrap it in a `GestureDetector` that an `onTap()` callback.

```
<span>// The GestureDetector wraps the button.</span><span>
</span><span>GestureDetector</span><span>(</span><span>
  </span><span>// When the child is tapped, show a snackbar.</span><span>
  onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>const</span><span> snackBar </span><span>=</span><span> </span><span>SnackBar</span><span>(</span><span>content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Tap'</span><span>));</span><span>

    </span><span>ScaffoldMessenger</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>showSnackBar</span><span>(</span><span>snackBar</span><span>);</span><span>
  </span><span>},</span><span>
  </span><span>// The custom button</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
    padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>12</span><span>),</span><span>
    decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
      color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>lightBlue</span><span>,</span><span>
      borderRadius</span><span>:</span><span> </span><span>BorderRadius</span><span>.</span><span>circular</span><span>(</span><span>8</span><span>),</span><span>
    </span><span>),</span><span>
    child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'My Button'</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

## Notes

1.  For information on adding the Material ripple effect to your button, see the [Add Material touch ripples](https://docs.flutter.dev/cookbook/gestures/ripples) recipe.
2.  Although this example creates a custom button, Flutter includes a handful of button implementations, such as: [`ElevatedButton`](https://api.flutter.dev/flutter/material/ElevatedButton-class.html), [`TextButton`](https://api.flutter.dev/flutter/material/TextButton-class.html), and [`CupertinoButton`](https://api.flutter.dev/flutter/cupertino/CupertinoButton-class.html).

## Interactive example