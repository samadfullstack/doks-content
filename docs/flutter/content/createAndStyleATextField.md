1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Forms](https://docs.flutter.dev/cookbook/forms)
3.  [Create and style a text field](https://docs.flutter.dev/cookbook/forms/text-input)

Text fields allow users to type text into an app. They are used to build forms, send messages, create search experiences, and more. In this recipe, explore how to create and style text fields.

Flutter provides two text fields: [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) and [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html).

## `TextField`

[`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) is the most commonly used text input widget.

By default, a `TextField` is decorated with an underline. You can add a label, icon, inline hint text, and error text by supplying an [`InputDecoration`](https://api.flutter.dev/flutter/material/InputDecoration-class.html) as the [`decoration`](https://api.flutter.dev/flutter/material/TextField/decoration.html) property of the `TextField`. To remove the decoration entirely (including the underline and the space reserved for the label), set the `decoration` to null.

```
<span>TextField</span><span>(</span><span>
  decoration</span><span>:</span><span> </span><span>InputDecoration</span><span>(</span><span>
    border</span><span>:</span><span> </span><span>OutlineInputBorder</span><span>(),</span><span>
    hintText</span><span>:</span><span> </span><span>'Enter a search term'</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

To retrieve the value when it changes, see the [Handle changes to a text field](https://docs.flutter.dev/cookbook/forms/text-field-changes/) recipe.

## `TextFormField`

[`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html) wraps a `TextField` and integrates it with the enclosing [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html). This provides additional functionality, such as validation and integration with other [`FormField`](https://api.flutter.dev/flutter/widgets/FormField-class.html) widgets.

```
<span>TextFormField</span><span>(</span><span>
  decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>InputDecoration</span><span>(</span><span>
    border</span><span>:</span><span> </span><span>UnderlineInputBorder</span><span>(),</span><span>
    labelText</span><span>:</span><span> </span><span>'Enter your username'</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

## Interactive example

For more information on input validation, see the [Building a form with validation](https://docs.flutter.dev/cookbook/forms/validation/) recipe.