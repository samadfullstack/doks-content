1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Forms](https://docs.flutter.dev/cookbook/forms)
3.  [Handle changes to a text field](https://docs.flutter.dev/cookbook/forms/text-field-changes)

In some cases, it’s useful to run a callback function every time the text in a text field changes. For example, you might want to build a search screen with autocomplete functionality where you want to update the results as the user types.

How do you run a callback function every time the text changes? With Flutter, you have two options:

1.  Supply an `onChanged()` callback to a `TextField` or a `TextFormField`.
2.  Use a `TextEditingController`.

## 1\. Supply an `onChanged()` callback to a `TextField` or a `TextFormField`

The simplest approach is to supply an [`onChanged()`](https://api.flutter.dev/flutter/material/TextField/onChanged.html) callback to a [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) or a [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html). Whenever the text changes, the callback is invoked.

In this example, print the current value and length of the text field to the console every time the text changes.

It’s important to use [characters](https://pub.dev/packages/characters) when dealing with user input, as text may contain complex characters. This ensures that every character is counted correctly as they appear to the user.

```
<span>TextField</span><span>(</span><span>
  onChanged</span><span>:</span><span> </span><span>(</span><span>text</span><span>)</span><span> </span><span>{</span><span>
    print</span><span>(</span><span>'First text field: $text (${text.characters.length})'</span><span>);</span><span>
  </span><span>},</span><span>
</span><span>),</span>
```

## 2\. Use a `TextEditingController`

A more powerful, but more elaborate approach, is to supply a [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) as the [`controller`](https://api.flutter.dev/flutter/material/TextField/controller.html) property of the `TextField` or a `TextFormField`.

To be notified when the text changes, listen to the controller using the [`addListener()`](https://api.flutter.dev/flutter/foundation/ChangeNotifier/addListener.html) method using the following steps:

1.  Create a `TextEditingController`.
2.  Connect the `TextEditingController` to a text field.
3.  Create a function to print the latest value.
4.  Listen to the controller for changes.

### Create a `TextEditingController`

Create a `TextEditingController`:

```
<span>// Define a custom Form widget.</span><span>
</span><span>class</span><span> </span><span>MyCustomForm</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyCustomForm</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyCustomForm</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyCustomFormState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>// Define a corresponding State class.</span><span>
</span><span>// This class holds data related to the Form.</span><span>
</span><span>class</span><span> _MyCustomFormState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyCustomForm</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Create a text controller. Later, use it to retrieve the</span><span>
  </span><span>// current value of the TextField.</span><span>
  </span><span>final</span><span> myController </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Clean up the controller when the widget is removed from the</span><span>
    </span><span>// widget tree.</span><span>
    myController</span><span>.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Fill this out in the next step.</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Connect the `TextEditingController` to a text field

Supply the `TextEditingController` to either a `TextField` or a `TextFormField`. Once you wire these two classes together, you can begin listening for changes to the text field.

```
<span>TextField</span><span>(</span><span>
  controller</span><span>:</span><span> myController</span><span>,</span><span>
</span><span>),</span>
```

### Create a function to print the latest value

You need a function to run every time the text changes. Create a method in the `_MyCustomFormState` class that prints out the current value of the text field.

```
<span>void</span><span> _printLatestValue</span><span>()</span><span> </span><span>{</span><span>
  </span><span>final</span><span> text </span><span>=</span><span> myController</span><span>.</span><span>text</span><span>;</span><span>
  print</span><span>(</span><span>'Second text field: $text (${text.characters.length})'</span><span>);</span><span>
</span><span>}</span>
```

### Listen to the controller for changes

Finally, listen to the `TextEditingController` and call the `_printLatestValue()` method when the text changes. Use the [`addListener()`](https://api.flutter.dev/flutter/foundation/ChangeNotifier/addListener.html) method for this purpose.

Begin listening for changes when the `_MyCustomFormState` class is initialized, and stop listening when the `_MyCustomFormState` is disposed.

```
<span>@override
</span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
  </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>

  </span><span>// Start listening to changes.</span><span>
  myController</span><span>.</span><span>addListener</span><span>(</span><span>_printLatestValue</span><span>);</span><span>
</span><span>}</span>
```

```
<span>@override
</span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
  </span><span>// Clean up the controller when the widget is removed from the widget tree.</span><span>
  </span><span>// This also removes the _printLatestValue listener.</span><span>
  myController</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
</span><span>}</span>
```

## Interactive example