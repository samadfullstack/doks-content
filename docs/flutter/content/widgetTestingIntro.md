1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Testing](https://docs.flutter.dev/cookbook/testing)
3.  [Widget](https://docs.flutter.dev/cookbook/testing/widget)
4.  [Introduction](https://docs.flutter.dev/cookbook/testing/widget/introduction)

In the [introduction to unit testing](https://docs.flutter.dev/cookbook/testing/unit/introduction) recipe, you learned how to test Dart classes using the `test` package. To test widget classes, you need a few additional tools provided by the [`flutter_test`](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) package, which ships with the Flutter SDK.

The `flutter_test` package provides the following tools for testing widgets:

-   The [`WidgetTester`](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html) allows building and interacting with widgets in a test environment.
-   The [`testWidgets()`](https://api.flutter.dev/flutter/flutter_test/testWidgets.html) function automatically creates a new `WidgetTester` for each test case, and is used in place of the normal `test()` function.
-   The [`Finder`](https://api.flutter.dev/flutter/flutter_test/Finder-class.html) classes allow searching for widgets in the test environment.
-   Widget-specific [`Matcher`](https://api.flutter.dev/flutter/package-matcher_matcher/Matcher-class.html) constants help verify whether a `Finder` locates a widget or multiple widgets in the test environment.

If this sounds overwhelming, don’t worry. Learn how all of these pieces fit together throughout this recipe, which uses the following steps:

1.  Add the `flutter_test` dependency.
2.  Create a widget to test.
3.  Create a `testWidgets` test.
4.  Build the widget using the `WidgetTester`.
5.  Search for the widget using a `Finder`.
6.  Verify the widget using a `Matcher`.

### 1\. Add the `flutter_test` dependency

Before writing tests, include the `flutter_test` dependency in the `dev_dependencies` section of the `pubspec.yaml` file. If creating a new Flutter project with the command line tools or a code editor, this dependency should already be in place.

```
<span>dev_dependencies</span><span>:</span>
  <span>flutter_test</span><span>:</span>
    <span>sdk</span><span>:</span> <span>flutter</span>
```

### 2\. Create a widget to test

Next, create a widget for testing. For this recipe, create a widget that displays a `title` and `message`.

```
<span>class</span><span> </span><span>MyWidget</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyWidget</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>message</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> message</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Flutter Demo'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>title</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>message</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### 3\. Create a `testWidgets` test

With a widget to test, begin by writing your first test. Use the [`testWidgets()`](https://api.flutter.dev/flutter/flutter_test/testWidgets.html) function provided by the `flutter_test` package to define a test. The `testWidgets` function allows you to define a widget test and creates a `WidgetTester` to work with.

This test verifies that `MyWidget` displays a given title and message. It is titled accordingly, and it will be populated in the next section.

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>// Define a test. The TestWidgets function also provides a WidgetTester</span><span>
  </span><span>// to work with. The WidgetTester allows you to build and interact</span><span>
  </span><span>// with widgets in the test environment.</span><span>
  testWidgets</span><span>(</span><span>'MyWidget has a title and message'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Test code goes here.</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

### 4\. Build the widget using the `WidgetTester`

Next, build `MyWidget` inside the test environment by using the [`pumpWidget()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pumpWidget.html) method provided by `WidgetTester`. The `pumpWidget` method builds and renders the provided widget.

Create a `MyWidget` instance that displays “T” as the title and “M” as the message.

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  testWidgets</span><span>(</span><span>'MyWidget has a title and message'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Create the widget by telling the tester to build it.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>MyWidget</span><span>(</span><span>title</span><span>:</span><span> </span><span>'T'</span><span>,</span><span> message</span><span>:</span><span> </span><span>'M'</span><span>));</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

#### Notes about the pump() methods

After the initial call to `pumpWidget()`, the `WidgetTester` provides additional ways to rebuild the same widget. This is useful if you’re working with a `StatefulWidget` or animations.

For example, tapping a button calls `setState()`, but Flutter won’t automatically rebuild your widget in the test environment. Use one of the following methods to ask Flutter to rebuild the widget.

[`tester.pump(Duration duration)`](https://api.flutter.dev/flutter/flutter_test/TestWidgetsFlutterBinding/pump.html)

Schedules a frame and triggers a rebuild of the widget. If a `Duration` is specified, it advances the clock by that amount and schedules a frame. It does not schedule multiple frames even if the duration is longer than a single frame.

[`tester.pumpAndSettle()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pumpAndSettle.html)

Repeatedly calls `pump()` with the given duration until there are no longer any frames scheduled. This, essentially, waits for all animations to complete.

These methods provide fine-grained control over the build lifecycle, which is particularly useful while testing.

### 5\. Search for our widget using a `Finder`

With a widget in the test environment, search through the widget tree for the `title` and `message` Text widgets using a `Finder`. This allows verification that the widgets are being displayed correctly.

For this purpose, use the top-level [`find()`](https://api.flutter.dev/flutter/flutter_test/find-constant.html) method provided by the `flutter_test` package to create the `Finders`. Since you know you’re looking for `Text` widgets, use the [`find.text()`](https://api.flutter.dev/flutter/flutter_test/CommonFinders/text.html) method.

For more information about `Finder` classes, see the [Finding widgets in a widget test](https://docs.flutter.dev/cookbook/testing/widget/finders) recipe.

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  testWidgets</span><span>(</span><span>'MyWidget has a title and message'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>MyWidget</span><span>(</span><span>title</span><span>:</span><span> </span><span>'T'</span><span>,</span><span> message</span><span>:</span><span> </span><span>'M'</span><span>));</span><span>

    </span><span>// Create the Finders.</span><span>
    </span><span>final</span><span> titleFinder </span><span>=</span><span> find</span><span>.</span><span>text</span><span>(</span><span>'T'</span><span>);</span><span>
    </span><span>final</span><span> messageFinder </span><span>=</span><span> find</span><span>.</span><span>text</span><span>(</span><span>'M'</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

### 6\. Verify the widget using a `Matcher`

Finally, verify the title and message `Text` widgets appear on screen using the `Matcher` constants provided by `flutter_test`. `Matcher` classes are a core part of the `test` package, and provide a common way to verify a given value meets expectations.

Ensure that the widgets appear on screen exactly one time. For this purpose, use the [`findsOneWidget`](https://api.flutter.dev/flutter/flutter_test/findsOneWidget-constant.html) `Matcher`.

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  testWidgets</span><span>(</span><span>'MyWidget has a title and message'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>MyWidget</span><span>(</span><span>title</span><span>:</span><span> </span><span>'T'</span><span>,</span><span> message</span><span>:</span><span> </span><span>'M'</span><span>));</span><span>
    </span><span>final</span><span> titleFinder </span><span>=</span><span> find</span><span>.</span><span>text</span><span>(</span><span>'T'</span><span>);</span><span>
    </span><span>final</span><span> messageFinder </span><span>=</span><span> find</span><span>.</span><span>text</span><span>(</span><span>'M'</span><span>);</span><span>

    </span><span>// Use the `findsOneWidget` matcher provided by flutter_test to verify</span><span>
    </span><span>// that the Text widgets appear exactly once in the widget tree.</span><span>
    expect</span><span>(</span><span>titleFinder</span><span>,</span><span> findsOneWidget</span><span>);</span><span>
    expect</span><span>(</span><span>messageFinder</span><span>,</span><span> findsOneWidget</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

#### Additional Matchers

In addition to `findsOneWidget`, `flutter_test` provides additional matchers for common cases.

[`findsNothing`](https://api.flutter.dev/flutter/flutter_test/findsNothing-constant.html)

Verifies that no widgets are found.

[`findsWidgets`](https://api.flutter.dev/flutter/flutter_test/findsWidgets-constant.html)

Verifies that one or more widgets are found.

[`findsNWidgets`](https://api.flutter.dev/flutter/flutter_test/findsNWidgets.html)

Verifies that a specific number of widgets are found.

[`matchesGoldenFile`](https://api.flutter.dev/flutter/flutter_test/matchesGoldenFile.html)

Verifies that a widget’s rendering matches a particular bitmap image (“golden file” testing).

### Complete example

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>// Define a test. The TestWidgets function also provides a WidgetTester</span><span>
  </span><span>// to work with. The WidgetTester allows building and interacting</span><span>
  </span><span>// with widgets in the test environment.</span><span>
  testWidgets</span><span>(</span><span>'MyWidget has a title and message'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Create the widget by telling the tester to build it.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>MyWidget</span><span>(</span><span>title</span><span>:</span><span> </span><span>'T'</span><span>,</span><span> message</span><span>:</span><span> </span><span>'M'</span><span>));</span><span>

    </span><span>// Create the Finders.</span><span>
    </span><span>final</span><span> titleFinder </span><span>=</span><span> find</span><span>.</span><span>text</span><span>(</span><span>'T'</span><span>);</span><span>
    </span><span>final</span><span> messageFinder </span><span>=</span><span> find</span><span>.</span><span>text</span><span>(</span><span>'M'</span><span>);</span><span>

    </span><span>// Use the `findsOneWidget` matcher provided by flutter_test to</span><span>
    </span><span>// verify that the Text widgets appear exactly once in the widget tree.</span><span>
    expect</span><span>(</span><span>titleFinder</span><span>,</span><span> findsOneWidget</span><span>);</span><span>
    expect</span><span>(</span><span>messageFinder</span><span>,</span><span> findsOneWidget</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyWidget</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyWidget</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>message</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> message</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Flutter Demo'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>title</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>message</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```