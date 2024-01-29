1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Forms](https://docs.flutter.dev/cookbook/forms)
3.  [Build a form with validation](https://docs.flutter.dev/cookbook/forms/validation)

Apps often require users to enter information into a text field. For example, you might require users to log in with an email address and password combination.

To make apps secure and easy to use, check whether the information the user has provided is valid. If the user has correctly filled out the form, process the information. If the user submits incorrect information, display a friendly error message letting them know what went wrong.

In this example, learn how to add validation to a form that has a single text field using the following steps:

1.  Create a `Form` with a `GlobalKey`.
2.  Add a `TextFormField` with validation logic.
3.  Create a button to validate and submit the form.

## 1\. Create a `Form` with a `GlobalKey`

First, create a [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html). The `Form` widget acts as a container for grouping and validating multiple form fields.

When creating the form, provide a [`GlobalKey`](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html). This uniquely identifies the `Form`, and allows validation of the form in a later step.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>// Define a custom Form widget.</span><span>
</span><span>class</span><span> </span><span>MyCustomForm</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyCustomForm</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>MyCustomFormState</span><span> createState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MyCustomFormState</span><span>();</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>// Define a corresponding State class.</span><span>
</span><span>// This class holds data related to the form.</span><span>
</span><span>class</span><span> </span><span>MyCustomFormState</span><span> </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyCustomForm</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>// Create a global key that uniquely identifies the Form widget</span><span>
  </span><span>// and allows validation of the form.</span><span>
  </span><span>//</span><span>
  </span><span>// Note: This is a `GlobalKey&lt;FormState&gt;`,</span><span>
  </span><span>// not a GlobalKey&lt;MyCustomFormState&gt;.</span><span>
  </span><span>final</span><span> _formKey </span><span>=</span><span> </span><span>GlobalKey</span><span>&lt;</span><span>FormState</span><span>&gt;();</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Build a Form widget using the _formKey created above.</span><span>
    </span><span>return</span><span> </span><span>Form</span><span>(</span><span>
      key</span><span>:</span><span> _formKey</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Column</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
          </span><span>// Add TextFormFields and ElevatedButton here.</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 2\. Add a `TextFormField` with validation logic

Although the `Form` is in place, it doesn’t have a way for users to enter text. That’s the job of a [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html). The `TextFormField` widget renders a material design text field and can display validation errors when they occur.

Validate the input by providing a `validator()` function to the `TextFormField`. If the user’s input isn’t valid, the `validator` function returns a `String` containing an error message. If there are no errors, the validator must return null.

For this example, create a `validator` that ensures the `TextFormField` isn’t empty. If it is empty, return a friendly error message.

```
<span>TextFormField</span><span>(</span><span>
  </span><span>// The validator receives the text that the user has entered.</span><span>
  validator</span><span>:</span><span> </span><span>(</span><span>value</span><span>)</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>value </span><span>==</span><span> </span><span>null</span><span> </span><span>||</span><span> value</span><span>.</span><span>isEmpty</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>'Please enter some text'</span><span>;</span><span>
    </span><span>}</span><span>
    </span><span>return</span><span> </span><span>null</span><span>;</span><span>
  </span><span>},</span><span>
</span><span>),</span>
```

## 3\. Create a button to validate and submit the form

Now that you have a form with a text field, provide a button that the user can tap to submit the information.

When the user attempts to submit the form, check if the form is valid. If it is, display a success message. If it isn’t (the text field has no content) display the error message.

```
<span>ElevatedButton</span><span>(</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Validate returns true if the form is valid, or false otherwise.</span><span>
    </span><span>if</span><span> </span><span>(</span><span>_formKey</span><span>.</span><span>currentState</span><span>!.</span><span>validate</span><span>())</span><span> </span><span>{</span><span>
      </span><span>// If the form is valid, display a snackbar. In the real world,</span><span>
      </span><span>// you'd often call a server or save the information in a database.</span><span>
      </span><span>ScaffoldMessenger</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>showSnackBar</span><span>(</span><span>
        </span><span>const</span><span> </span><span>SnackBar</span><span>(</span><span>content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Processing Data'</span><span>)),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Submit'</span><span>),</span><span>
</span><span>),</span>
```

### How does this work?

To validate the form, use the `_formKey` created in step 1. You can use the `_formKey.currentState()` method to access the [`FormState`](https://api.flutter.dev/flutter/widgets/FormState-class.html), which is automatically created by Flutter when building a `Form`.

The `FormState` class contains the `validate()` method. When the `validate()` method is called, it runs the `validator()` function for each text field in the form. If everything looks good, the `validate()` method returns `true`. If any text field contains errors, the `validate()` method rebuilds the form to display any error messages and returns `false`.

## Interactive example

To learn how to retrieve these values, check out the [Retrieve the value of a text field](https://docs.flutter.dev/cookbook/forms/retrieve-input) recipe.