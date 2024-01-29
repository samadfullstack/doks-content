1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Testing](https://docs.flutter.dev/cookbook/testing)
3.  [Widget](https://docs.flutter.dev/cookbook/testing/widget)
4.  [Find widgets](https://docs.flutter.dev/cookbook/testing/widget/finders)

To locate widgets in a test environment, use the [`Finder`](https://api.flutter.dev/flutter/flutter_test/Finder-class.html) classes. While it’s possible to write your own `Finder` classes, it’s generally more convenient to locate widgets using the tools provided by the [`flutter_test`](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) package.

During a `flutter run` session on a widget test, you can also interactively tap parts of the screen for the Flutter tool to print the suggested `Finder`.

This recipe looks at the [`find`](https://api.flutter.dev/flutter/flutter_test/find-constant.html) constant provided by the `flutter_test` package, and demonstrates how to work with some of the `Finders` it provides. For a full list of available finders, see the [`CommonFinders` documentation](https://api.flutter.dev/flutter/flutter_test/CommonFinders-class.html).

If you’re unfamiliar with widget testing and the role of `Finder` classes, review the [Introduction to widget testing](https://docs.flutter.dev/cookbook/testing/widget/introduction) recipe.

This recipe uses the following steps:

1.  Find a `Text` widget.
2.  Find a widget with a specific `Key`.
3.  Find a specific widget instance.

### 1\. Find a `Text` widget

In testing, you often need to find widgets that contain specific text. This is exactly what the `find.text()` method is for. It creates a `Finder` that searches for widgets that display a specific `String` of text.

```
<span>testWidgets</span><span>(</span><span>'finds a Text widget'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Build an App with a Text widget that displays the letter 'H'.</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
    home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
      body</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'H'</span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>));</span><span>

  </span><span>// Find a widget that displays the letter 'H'.</span><span>
  expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'H'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
</span><span>});</span>
```

### 2\. Find a widget with a specific `Key`

In some cases, you might want to find a widget based on the Key that has been provided to it. This can be handy if displaying multiple instances of the same widget. For example, a `ListView` might display several `Text` widgets that contain the same text.

In this case, provide a `Key` to each widget in the list. This allows an app to uniquely identify a specific widget, making it easier to find the widget in the test environment.

```
<span>testWidgets</span><span>(</span><span>'finds a widget using a Key'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Define the test key.</span><span>
  </span><span>const</span><span> testKey </span><span>=</span><span> </span><span>Key</span><span>(</span><span>'K'</span><span>);</span><span>

  </span><span>// Build a MaterialApp with the testKey.</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>MaterialApp</span><span>(</span><span>key</span><span>:</span><span> testKey</span><span>,</span><span> home</span><span>:</span><span> </span><span>Container</span><span>()));</span><span>

  </span><span>// Find the MaterialApp widget using the testKey.</span><span>
  expect</span><span>(</span><span>find</span><span>.</span><span>byKey</span><span>(</span><span>testKey</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
</span><span>});</span>
```

### 3\. Find a specific widget instance

Finally, you might be interested in locating a specific instance of a widget. For example, this can be useful when creating widgets that take a `child` property and you want to ensure you’re rendering the `child` widget.

```
<span>testWidgets</span><span>(</span><span>'finds a specific instance'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>const</span><span> childWidget </span><span>=</span><span> </span><span>Padding</span><span>(</span><span>padding</span><span>:</span><span> </span><span>EdgeInsets</span><span>.</span><span>zero</span><span>);</span><span>

  </span><span>// Provide the childWidget to the Container.</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>Container</span><span>(</span><span>child</span><span>:</span><span> childWidget</span><span>));</span><span>

  </span><span>// Search for the childWidget in the tree and verify it exists.</span><span>
  expect</span><span>(</span><span>find</span><span>.</span><span>byWidget</span><span>(</span><span>childWidget</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
</span><span>});</span>
```

### Summary

The `find` constant provided by the `flutter_test` package provides several ways to locate widgets in the test environment. This recipe demonstrated three of these methods, and several more methods exist for different purposes.

If the above examples do not work for a particular use-case, see the [`CommonFinders` documentation](https://api.flutter.dev/flutter/flutter_test/CommonFinders-class.html) to review all available methods.

### Complete example

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  testWidgets</span><span>(</span><span>'finds a Text widget'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Build an App with a Text widget that displays the letter 'H'.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        body</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'H'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>));</span><span>

    </span><span>// Find a widget that displays the letter 'H'.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'H'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
  </span><span>});</span><span>

  testWidgets</span><span>(</span><span>'finds a widget using a Key'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Define the test key.</span><span>
    </span><span>const</span><span> testKey </span><span>=</span><span> </span><span>Key</span><span>(</span><span>'K'</span><span>);</span><span>

    </span><span>// Build a MaterialApp with the testKey.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>MaterialApp</span><span>(</span><span>key</span><span>:</span><span> testKey</span><span>,</span><span> home</span><span>:</span><span> </span><span>Container</span><span>()));</span><span>

    </span><span>// Find the MaterialApp widget using the testKey.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>byKey</span><span>(</span><span>testKey</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
  </span><span>});</span><span>

  testWidgets</span><span>(</span><span>'finds a specific instance'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>const</span><span> childWidget </span><span>=</span><span> </span><span>Padding</span><span>(</span><span>padding</span><span>:</span><span> </span><span>EdgeInsets</span><span>.</span><span>zero</span><span>);</span><span>

    </span><span>// Provide the childWidget to the Container.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>Container</span><span>(</span><span>child</span><span>:</span><span> childWidget</span><span>));</span><span>

    </span><span>// Search for the childWidget in the tree and verify it exists.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>byWidget</span><span>(</span><span>childWidget</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```