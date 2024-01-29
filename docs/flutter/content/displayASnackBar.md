1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Design](https://docs.flutter.dev/cookbook/design)
3.  [Display a snackbar](https://docs.flutter.dev/cookbook/design/snackbars)

It can be useful to briefly inform your users when certain actions take place. For example, when a user swipes away a message in a list, you might want to inform them that the message has been deleted. You might even want to give them an option to undo the action.

In Material Design, this is the job of a [`SnackBar`](https://api.flutter.dev/flutter/material/SnackBar-class.html). This recipe implements a snackbar using the following steps:

1.  Create a `Scaffold`.
2.  Display a `SnackBar`.
3.  Provide an optional action.

## 1\. Create a `Scaffold`

When creating apps that follow the Material Design guidelines, give your apps a consistent visual structure. In this example, display the `SnackBar` at the bottom of the screen, without overlapping other important widgets, such as the `FloatingActionButton`.

The [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) widget, from the [material library](https://api.flutter.dev/flutter/material/material-library.html), creates this visual structure and ensures that important widgets don’t overlap.

```
<span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
  title</span><span>:</span><span> </span><span>'SnackBar Demo'</span><span>,</span><span>
  home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
    appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'SnackBar Demo'</span><span>),</span><span>
    </span><span>),</span><span>
    body</span><span>:</span><span> </span><span>const</span><span> </span><span>SnackBarPage</span><span>(),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## 2\. Display a `SnackBar`

With the `Scaffold` in place, display a `SnackBar`. First, create a `SnackBar`, then display it using `ScaffoldMessenger`.

```
<span>const</span><span> snackBar </span><span>=</span><span> </span><span>SnackBar</span><span>(</span><span>
  content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Yay! A SnackBar!'</span><span>),</span><span>
</span><span>);</span><span>

</span><span>// Find the ScaffoldMessenger in the widget tree</span><span>
</span><span>// and use it to show a SnackBar.</span><span>
</span><span>ScaffoldMessenger</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>showSnackBar</span><span>(</span><span>snackBar</span><span>);</span>
```

## 3\. Provide an optional action

You might want to provide an action to the user when the SnackBar is displayed. For example, if the user accidentally deletes a message, they might use an optional action in the SnackBar to recover the message.

Here’s an example of providing an additional `action` to the `SnackBar` widget:

```
<span>final</span><span> snackBar </span><span>=</span><span> </span><span>SnackBar</span><span>(</span><span>
  content</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Yay! A SnackBar!'</span><span>),</span><span>
  action</span><span>:</span><span> </span><span>SnackBarAction</span><span>(</span><span>
    label</span><span>:</span><span> </span><span>'Undo'</span><span>,</span><span>
    onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
      </span><span>// Some code to undo the change.</span><span>
    </span><span>},</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## Interactive example