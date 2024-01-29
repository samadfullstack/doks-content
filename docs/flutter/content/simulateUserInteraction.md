1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Testing](https://docs.flutter.dev/cookbook/testing)
3.  [Widget](https://docs.flutter.dev/cookbook/testing/widget)
4.  [Tap, drag, and enter text](https://docs.flutter.dev/cookbook/testing/widget/tap-drag)

Many widgets not only display information, but also respond to user interaction. This includes buttons that can be tapped, and [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) for entering text.

To test these interactions, you need a way to simulate them in the test environment. For this purpose, use the [`WidgetTester`](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html) library.

The `WidgetTester` provides methods for entering text, tapping, and dragging.

-   [`enterText()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/enterText.html)
-   [`tap()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/tap.html)
-   [`drag()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/drag.html)

In many cases, user interactions update the state of the app. In the test environment, Flutter doesn’t automatically rebuild widgets when the state changes. To ensure that the widget tree is rebuilt after simulating a user interaction, call the [`pump()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pump.html) or [`pumpAndSettle()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pumpAndSettle.html) methods provided by the `WidgetTester`. This recipe uses the following steps:

1.  Create a widget to test.
2.  Enter text in the text field.
3.  Ensure tapping a button adds the todo.
4.  Ensure swipe-to-dismiss removes the todo.

### 1\. Create a widget to test

For this example, create a basic todo app that tests three features:

1.  Entering text into a `TextField`.
2.  Tapping a `FloatingActionButton` to add the text to a list of todos.
3.  Swiping-to-dismiss to remove the item from the list.

To keep the focus on testing, this recipe won’t provide a detailed guide on how to build the todo app. To learn more about how this app is built, see the relevant recipes:

-   [Create and style a text field](https://docs.flutter.dev/cookbook/forms/text-input)
-   [Handle taps](https://docs.flutter.dev/cookbook/gestures/handling-taps)
-   [Create a basic list](https://docs.flutter.dev/cookbook/lists/basic-list)
-   [Implement swipe to dismiss](https://docs.flutter.dev/cookbook/gestures/dismissible)

```
<span>class</span><span> </span><span>TodoList</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>TodoList</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>TodoList</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _TodoListState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _TodoListState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>TodoList</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> _appTitle </span><span>=</span><span> </span><span>'Todo List'</span><span>;</span><span>
  </span><span>final</span><span> todos </span><span>=</span><span> </span><span>&lt;</span><span>String</span><span>&gt;[];</span><span>
  </span><span>final</span><span> controller </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> _appTitle</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>_appTitle</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>TextField</span><span>(</span><span>
              controller</span><span>:</span><span> controller</span><span>,</span><span>
            </span><span>),</span><span>
            </span><span>Expanded</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
                itemCount</span><span>:</span><span> todos</span><span>.</span><span>length</span><span>,</span><span>
                itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
                  </span><span>final</span><span> todo </span><span>=</span><span> todos</span><span>[</span><span>index</span><span>];</span><span>

                  </span><span>return</span><span> </span><span>Dismissible</span><span>(</span><span>
                    key</span><span>:</span><span> </span><span>Key</span><span>(</span><span>'$todo$index'</span><span>),</span><span>
                    onDismissed</span><span>:</span><span> </span><span>(</span><span>direction</span><span>)</span><span> </span><span>=&gt;</span><span> todos</span><span>.</span><span>removeAt</span><span>(</span><span>index</span><span>),</span><span>
                    background</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>),</span><span>
                    child</span><span>:</span><span> </span><span>ListTile</span><span>(</span><span>title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todo</span><span>)),</span><span>
                  </span><span>);</span><span>
                </span><span>},</span><span>
              </span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
        floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
            setState</span><span>(()</span><span> </span><span>{</span><span>
              todos</span><span>.</span><span>add</span><span>(</span><span>controller</span><span>.</span><span>text</span><span>);</span><span>
              controller</span><span>.</span><span>clear</span><span>();</span><span>
            </span><span>});</span><span>
          </span><span>},</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>add</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### 2\. Enter text in the text field

Now that you have a todo app, begin writing the test. Start by entering text into the `TextField`.

Accomplish this task by:

1.  Building the widget in the test environment.
2.  Using the [`enterText()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/enterText.html) method from the `WidgetTester`.

```
<span>testWidgets</span><span>(</span><span>'Add and remove a todo'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Build the widget</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>TodoList</span><span>());</span><span>

  </span><span>// Enter 'hi' into the TextField.</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>enterText</span><span>(</span><span>find</span><span>.</span><span>byType</span><span>(</span><span>TextField</span><span>),</span><span> </span><span>'hi'</span><span>);</span><span>
</span><span>});</span>
```

### 3\. Ensure tapping a button adds the todo

After entering text into the `TextField`, ensure that tapping the `FloatingActionButton` adds the item to the list.

This involves three steps:

1.  Tap the add button using the [`tap()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/tap.html) method.
2.  Rebuild the widget after the state has changed using the [`pump()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pump.html) method.
3.  Ensure that the list item appears on screen.

```
<span>testWidgets</span><span>(</span><span>'Add and remove a todo'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Enter text code...</span><span>

  </span><span>// Tap the add button.</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>tap</span><span>(</span><span>find</span><span>.</span><span>byType</span><span>(</span><span>FloatingActionButton</span><span>));</span><span>

  </span><span>// Rebuild the widget after the state has changed.</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>pump</span><span>();</span><span>

  </span><span>// Expect to find the item on screen.</span><span>
  expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'hi'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
</span><span>});</span>
```

### 4\. Ensure swipe-to-dismiss removes the todo

Finally, ensure that performing a swipe-to-dismiss action on the todo item removes it from the list. This involves three steps:

1.  Use the [`drag()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/drag.html) method to perform a swipe-to-dismiss action.
2.  Use the [`pumpAndSettle()`](https://api.flutter.dev/flutter/flutter_test/WidgetTester/pumpAndSettle.html) method to continually rebuild the widget tree until the dismiss animation is complete.
3.  Ensure that the item no longer appears on screen.

```
<span>testWidgets</span><span>(</span><span>'Add and remove a todo'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Enter text and add the item...</span><span>

  </span><span>// Swipe the item to dismiss it.</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>drag</span><span>(</span><span>find</span><span>.</span><span>byType</span><span>(</span><span>Dismissible</span><span>),</span><span> </span><span>const</span><span> </span><span>Offset</span><span>(</span><span>500</span><span>,</span><span> </span><span>0</span><span>));</span><span>

  </span><span>// Build the widget until the dismiss animation ends.</span><span>
  </span><span>await</span><span> tester</span><span>.</span><span>pumpAndSettle</span><span>();</span><span>

  </span><span>// Ensure that the item is no longer on screen.</span><span>
  expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'hi'</span><span>),</span><span> findsNothing</span><span>);</span><span>
</span><span>});</span>
```

### Complete example

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  testWidgets</span><span>(</span><span>'Add and remove a todo'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Build the widget.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>TodoList</span><span>());</span><span>

    </span><span>// Enter 'hi' into the TextField.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>enterText</span><span>(</span><span>find</span><span>.</span><span>byType</span><span>(</span><span>TextField</span><span>),</span><span> </span><span>'hi'</span><span>);</span><span>

    </span><span>// Tap the add button.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>tap</span><span>(</span><span>find</span><span>.</span><span>byType</span><span>(</span><span>FloatingActionButton</span><span>));</span><span>

    </span><span>// Rebuild the widget with the new item.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pump</span><span>();</span><span>

    </span><span>// Expect to find the item on screen.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'hi'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>

    </span><span>// Swipe the item to dismiss it.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>drag</span><span>(</span><span>find</span><span>.</span><span>byType</span><span>(</span><span>Dismissible</span><span>),</span><span> </span><span>const</span><span> </span><span>Offset</span><span>(</span><span>500</span><span>,</span><span> </span><span>0</span><span>));</span><span>

    </span><span>// Build the widget until the dismiss animation ends.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpAndSettle</span><span>();</span><span>

    </span><span>// Ensure that the item is no longer on screen.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'hi'</span><span>),</span><span> findsNothing</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>TodoList</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>TodoList</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>TodoList</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _TodoListState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _TodoListState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>TodoList</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>const</span><span> _appTitle </span><span>=</span><span> </span><span>'Todo List'</span><span>;</span><span>
  </span><span>final</span><span> todos </span><span>=</span><span> </span><span>&lt;</span><span>String</span><span>&gt;[];</span><span>
  </span><span>final</span><span> controller </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> _appTitle</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>_appTitle</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>TextField</span><span>(</span><span>
              controller</span><span>:</span><span> controller</span><span>,</span><span>
            </span><span>),</span><span>
            </span><span>Expanded</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
                itemCount</span><span>:</span><span> todos</span><span>.</span><span>length</span><span>,</span><span>
                itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
                  </span><span>final</span><span> todo </span><span>=</span><span> todos</span><span>[</span><span>index</span><span>];</span><span>

                  </span><span>return</span><span> </span><span>Dismissible</span><span>(</span><span>
                    key</span><span>:</span><span> </span><span>Key</span><span>(</span><span>'$todo$index'</span><span>),</span><span>
                    onDismissed</span><span>:</span><span> </span><span>(</span><span>direction</span><span>)</span><span> </span><span>=&gt;</span><span> todos</span><span>.</span><span>removeAt</span><span>(</span><span>index</span><span>),</span><span>
                    background</span><span>:</span><span> </span><span>Container</span><span>(</span><span>color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>),</span><span>
                    child</span><span>:</span><span> </span><span>ListTile</span><span>(</span><span>title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todo</span><span>)),</span><span>
                  </span><span>);</span><span>
                </span><span>},</span><span>
              </span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
        floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
            setState</span><span>(()</span><span> </span><span>{</span><span>
              todos</span><span>.</span><span>add</span><span>(</span><span>controller</span><span>.</span><span>text</span><span>);</span><span>
              controller</span><span>.</span><span>clear</span><span>();</span><span>
            </span><span>});</span><span>
          </span><span>},</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>add</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```