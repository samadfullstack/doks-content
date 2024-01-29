1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Testing](https://docs.flutter.dev/cookbook/testing)
3.  [Widget](https://docs.flutter.dev/cookbook/testing/widget)
4.  [Handle scrolling](https://docs.flutter.dev/cookbook/testing/widget/scrolling)

Many apps feature lists of content, from email clients to music apps and beyond. To verify that lists contain the expected content using widget tests, you need a way to scroll through lists to search for particular items.

To scroll through lists via integration tests, use the methods provided by the [`WidgetTester`](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html) class, which is included in the [`flutter_test`](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) package:

In this recipe, learn how to scroll through a list of items to verify a specific widget is being displayed, and discuss the pros on cons of different approaches.

This recipe uses the following steps:

1.  Create an app with a list of items.
2.  Write a test that scrolls through the list.
3.  Run the test.

### 1\. Create an app with a list of items

This recipe builds an app that shows a long list of items. To keep this recipe focused on testing, use the app created in the [Work with long lists](https://docs.flutter.dev/cookbook/lists/long-lists) recipe. If you’re unsure of how to work with long lists, see that recipe for an introduction.

Add keys to the widgets you want to interact with inside the integration tests.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>MyApp</span><span>(</span><span>
    items</span><span>:</span><span> </span><span>List</span><span>&lt;</span><span>String</span><span>&gt;.</span><span>generate</span><span>(</span><span>10000</span><span>,</span><span> </span><span>(</span><span>i</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>'Item $i'</span><span>),</span><span>
  </span><span>));</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>String</span><span>&gt;</span><span> items</span><span>;</span><span>

  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>items</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>const</span><span> title </span><span>=</span><span> </span><span>'Long List'</span><span>;</span><span>

    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> title</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>title</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
          </span><span>// Add a key to the ListView. This makes it possible to</span><span>
          </span><span>// find the list and scroll through it in the tests.</span><span>
          key</span><span>:</span><span> </span><span>const</span><span> </span><span>Key</span><span>(</span><span>'long_list'</span><span>),</span><span>
          itemCount</span><span>:</span><span> items</span><span>.</span><span>length</span><span>,</span><span>
          itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
            </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
              title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
                items</span><span>[</span><span>index</span><span>],</span><span>
                </span><span>// Add a key to the Text widget for each item. This makes</span><span>
                </span><span>// it possible to look for a particular item in the list</span><span>
                </span><span>// and verify that the text is correct</span><span>
                key</span><span>:</span><span> </span><span>Key</span><span>(</span><span>'item_${index}_text'</span><span>),</span><span>
              </span><span>),</span><span>
            </span><span>);</span><span>
          </span><span>},</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### 2\. Write a test that scrolls through the list

Now, you can write a test. In this example, scroll through the list of items and verify that a particular item exists in the list. The [`WidgetTester`](https://api.flutter.dev/flutter/flutter_test/WidgetTester-class.html) class provides the [`scrollUntilVisible()`](https://api.flutter.dev/flutter/flutter_test/WidgetController/scrollUntilVisible.html) method, which scrolls through a list until a specific widget is visible. This is useful because the height of the items in the list can change depending on the device.

Rather than assuming that you know the height of all the items in a list, or that a particular widget is rendered on all devices, the `scrollUntilVisible()` method repeatedly scrolls through a list of items until it finds what it’s looking for.

The following code shows how to use the `scrollUntilVisible()` method to look through the list for a particular item. This code lives in a file called `test/widget_test.dart`.

```
<span>
</span><span>// This is a basic Flutter widget test.</span><span>
</span><span>//</span><span>
</span><span>// To perform an interaction with a widget in your test, use the WidgetTester</span><span>
</span><span>// utility that Flutter provides. For example, you can send tap and scroll</span><span>
</span><span>// gestures. You can also use WidgetTester to find child widgets in the widget</span><span>
</span><span>// tree, read text, and verify that the values of widget properties are correct.</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:scrolling/main.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  testWidgets</span><span>(</span><span>'finds a deep item in a long list'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Build our app and trigger a frame.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>MyApp</span><span>(</span><span>
      items</span><span>:</span><span> </span><span>List</span><span>&lt;</span><span>String</span><span>&gt;.</span><span>generate</span><span>(</span><span>10000</span><span>,</span><span> </span><span>(</span><span>i</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>'Item $i'</span><span>),</span><span>
    </span><span>));</span><span>

    </span><span>final</span><span> listFinder </span><span>=</span><span> find</span><span>.</span><span>byType</span><span>(</span><span>Scrollable</span><span>);</span><span>
    </span><span>final</span><span> itemFinder </span><span>=</span><span> find</span><span>.</span><span>byKey</span><span>(</span><span>const</span><span> </span><span>ValueKey</span><span>(</span><span>'item_50_text'</span><span>));</span><span>

    </span><span>// Scroll until the item to be found appears.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>scrollUntilVisible</span><span>(</span><span>
      itemFinder</span><span>,</span><span>
      </span><span>500.0</span><span>,</span><span>
      scrollable</span><span>:</span><span> listFinder</span><span>,</span><span>
    </span><span>);</span><span>

    </span><span>// Verify that the item contains the correct text.</span><span>
    expect</span><span>(</span><span>itemFinder</span><span>,</span><span> findsOneWidget</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

### 3\. Run the test

Run the test using the following command from the root of the project:

```
flutter test test/widget_test.dart
```