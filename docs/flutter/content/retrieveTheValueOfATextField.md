1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Forms](https://docs.flutter.dev/cookbook/forms)
3.  [Retrieve the value of a text field](https://docs.flutter.dev/cookbook/forms/retrieve-input)

In this recipe, learn how to retrieve the text a user has entered into a text field using the following steps:

1.  Create a `TextEditingController`.
2.  Supply the `TextEditingController` to a `TextField`.
3.  Display the current value of the text field.

## 1\. Create a `TextEditingController`

To retrieve the text a user has entered into a text field, create a [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) and supply it to a `TextField` or `TextFormField`.

```
<span>// Define a custom Form widget.</span><span>
</span><span>class</span><span> </span><span>MyCustomForm</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyCustomForm</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyCustomForm</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyCustomFormState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>// Define a corresponding State class.</span><span>
</span><span>// This class holds the data related to the Form.</span><span>
</span><span>class</span><span> _MyCustomFormState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyCustomForm</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Create a text controller and use it to retrieve the current value</span><span>
  </span><span>// of the TextField.</span><span>
  </span><span>final</span><span> myController </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Clean up the controller when the widget is disposed.</span><span>
    myController</span><span>.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Fill this out in the next step.</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 2\. Supply the `TextEditingController` to a `TextField`

Now that you have a `TextEditingController`, wire it up to a text field using the `controller` property:

```
<span>return</span><span> </span><span>TextField</span><span>(</span><span>
  controller</span><span>:</span><span> myController</span><span>,</span><span>
</span><span>);</span>
```

## 3\. Display the current value of the text field

After supplying the `TextEditingController` to the text field, begin reading values. Use the [`text()`](https://api.flutter.dev/flutter/widgets/TextEditingController/text.html) method provided by the `TextEditingController` to retrieve the String that the user has entered into the text field.

The following code displays an alert dialog with the current value of the text field when the user taps a floating action button.

```
<span>FloatingActionButton</span><span>(</span><span>
  </span><span>// When the user presses the button, show an alert dialog containing</span><span>
  </span><span>// the text that the user has entered into the text field.</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    showDialog</span><span>(</span><span>
      context</span><span>:</span><span> context</span><span>,</span><span>
      builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>AlertDialog</span><span>(</span><span>
          </span><span>// Retrieve the text that the user has entered by using the</span><span>
          </span><span>// TextEditingController.</span><span>
          content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>myController</span><span>.</span><span>text</span><span>),</span><span>
        </span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
  tooltip</span><span>:</span><span> </span><span>'Show me the value!'</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>text_fields</span><span>),</span><span>
</span><span>),</span>
```

## Interactive example