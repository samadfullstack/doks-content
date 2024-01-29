1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Forms](https://docs.flutter.dev/cookbook/forms)
3.  [Focus and text fields](https://docs.flutter.dev/cookbook/forms/focus)

When a text field is selected and accepting input, it is said to have “focus.” Generally, users shift focus to a text field by tapping, and developers shift focus to a text field programmatically by using the tools described in this recipe.

Managing focus is a fundamental tool for creating forms with an intuitive flow. For example, say you have a search screen with a text field. When the user navigates to the search screen, you can set the focus to the text field for the search term. This allows the user to start typing as soon as the screen is visible, without needing to manually tap the text field.

In this recipe, learn how to give the focus to a text field as soon as it’s visible, as well as how to give focus to a text field when a button is tapped.

## Focus a text field as soon as it’s visible

To give focus to a text field as soon as it’s visible, use the `autofocus` property.

```
<span>TextField</span><span>(</span>
  <span>autofocus:</span> <span>true</span><span>,</span>
<span>);</span>
```

For more information on handling input and creating text fields, see the [Forms](https://docs.flutter.dev/cookbook#forms) section of the cookbook.

## Focus a text field when a button is tapped

Rather than immediately shifting focus to a specific text field, you might need to give focus to a text field at a later point in time. In the real world, you might also need to give focus to a specific text field in response to an API call or a validation error. In this example, give focus to a text field after the user presses a button using the following steps:

1.  Create a `FocusNode`.
2.  Pass the `FocusNode` to a `TextField`.
3.  Give focus to the `TextField` when a button is tapped.

### 1\. Create a `FocusNode`

First, create a [`FocusNode`](https://api.flutter.dev/flutter/widgets/FocusNode-class.html). Use the `FocusNode` to identify a specific `TextField` in Flutter’s “focus tree.” This allows you to give focus to the `TextField` in the next steps.

Since focus nodes are long-lived objects, manage the lifecycle using a `State` object. Use the following instructions to create a `FocusNode` instance inside the `initState()` method of a `State` class, and clean it up in the `dispose()` method:

```
<span>// Define a custom Form widget.</span><span>
</span><span>class</span><span> </span><span>MyCustomForm</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyCustomForm</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyCustomForm</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyCustomFormState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>// Define a corresponding State class.</span><span>
</span><span>// This class holds data related to the form.</span><span>
</span><span>class</span><span> _MyCustomFormState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyCustomForm</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Define the focus node. To manage the lifecycle, create the FocusNode in</span><span>
  </span><span>// the initState method, and clean it up in the dispose method.</span><span>
  </span><span>late</span><span> </span><span>FocusNode</span><span> myFocusNode</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>

    myFocusNode </span><span>=</span><span> </span><span>FocusNode</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Clean up the focus node when the Form is disposed.</span><span>
    myFocusNode</span><span>.</span><span>dispose</span><span>();</span><span>

    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Fill this out in the next step.</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### 2\. Pass the `FocusNode` to a `TextField`

Now that you have a `FocusNode`, pass it to a specific `TextField` in the `build()` method.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>TextField</span><span>(</span><span>
    focusNode</span><span>:</span><span> myFocusNode</span><span>,</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

### 3\. Give focus to the `TextField` when a button is tapped

Finally, focus the text field when the user taps a floating action button. Use the [`requestFocus()`](https://api.flutter.dev/flutter/widgets/FocusNode/requestFocus.html) method to perform this task.

```
<span>FloatingActionButton</span><span>(</span><span>
  </span><span>// When the button is pressed,</span><span>
  </span><span>// give focus to the text field using myFocusNode.</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> myFocusNode</span><span>.</span><span>requestFocus</span><span>(),</span><span>
</span><span>),</span>
```

## Interactive example