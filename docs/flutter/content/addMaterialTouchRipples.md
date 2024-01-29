1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Gestures](https://docs.flutter.dev/cookbook/gestures)
3.  [Add Material touch ripples](https://docs.flutter.dev/cookbook/gestures/ripples)

Widgets that follow the Material Design guidelines display a ripple animation when tapped.

Flutter provides the [`InkWell`](https://api.flutter.dev/flutter/material/InkWell-class.html) widget to perform this effect. Create a ripple effect using the following steps:

1.  Create a widget that supports tap.
2.  Wrap it in an `InkWell` widget to manage tap callbacks and ripple animations.

```
<span>// The InkWell wraps the custom flat button widget.</span><span>
</span><span>InkWell</span><span>(</span><span>
  </span><span>// When the user taps the button, show a snackbar.</span><span>
  onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>ScaffoldMessenger</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>showSnackBar</span><span>(</span><span>const</span><span> </span><span>SnackBar</span><span>(</span><span>
      content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Tap'</span><span>),</span><span>
    </span><span>));</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Padding</span><span>(</span><span>
    padding</span><span>:</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>12</span><span>),</span><span>
    child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Flat Button'</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

## Interactive example