1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Gestures](https://docs.flutter.dev/cookbook/gestures)
3.  [Implement swipe to dismiss](https://docs.flutter.dev/cookbook/gestures/dismissible)

The “swipe to dismiss” pattern is common in many mobile apps. For example, when writing an email app, you might want to allow a user to swipe away email messages to delete them from a list.

Flutter makes this task easy by providing the [`Dismissible`](https://api.flutter.dev/flutter/widgets/Dismissible-class.html) widget. Learn how to implement swipe to dismiss with the following steps:

1.  Create a list of items.
2.  Wrap each item in a `Dismissible` widget.
3.  Provide “leave behind” indicators.

## 1\. Create a list of items

First, create a list of items. For detailed instructions on how to create a list, follow the [Working with long lists](https://docs.flutter.dev/cookbook/lists/long-lists) recipe.

### Create a data source

In this example, you want 20 sample items to work with. To keep it simple, generate a list of strings.

```
<span>final</span><span> items </span><span>=</span><span> </span><span>List</span><span>&lt;</span><span>String</span><span>&gt;.</span><span>generate</span><span>(</span><span>20</span><span>,</span><span> </span><span>(</span><span>i</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>'Item ${i + 1}'</span><span>);</span>
```

### Convert the data source into a list

Display each item in the list on screen. Users won’t be able to swipe these items away just yet.

```
<span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
  itemCount</span><span>:</span><span> items</span><span>.</span><span>length</span><span>,</span><span>
  itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>items</span><span>[</span><span>index</span><span>]),</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
</span><span>)</span>
```

In this step, give users the ability to swipe an item off the list by using the [`Dismissible`](https://api.flutter.dev/flutter/widgets/Dismissible-class.html) widget.

After the user has swiped away the item, remove the item from the list and display a snackbar. In a real app, you might need to perform more complex logic, such as removing the item from a web service or database.

Update the `itemBuilder()` function to return a `Dismissible` widget:

```
<span>itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
  </span><span>final</span><span> item </span><span>=</span><span> items</span><span>[</span><span>index</span><span>];</span><span>
  </span><span>return</span><span> </span><span>Dismissible</span><span>(</span><span>
    </span><span>// Each Dismissible must contain a Key. Keys allow Flutter to</span><span>
    </span><span>// uniquely identify widgets.</span><span>
    key</span><span>:</span><span> </span><span>Key</span><span>(</span><span>item</span><span>),</span><span>
    </span><span>// Provide a function that tells the app</span><span>
    </span><span>// what to do after an item has been swiped away.</span><span>
    onDismissed</span><span>:</span><span> </span><span>(</span><span>direction</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// Remove the item from the data source.</span><span>
      setState</span><span>(()</span><span> </span><span>{</span><span>
        items</span><span>.</span><span>removeAt</span><span>(</span><span>index</span><span>);</span><span>
      </span><span>});</span><span>

      </span><span>// Then show a snackbar.</span><span>
      </span><span>ScaffoldMessenger</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)</span><span>
          </span><span>.</span><span>showSnackBar</span><span>(</span><span>SnackBar</span><span>(</span><span>content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'$item dismissed'</span><span>)));</span><span>
    </span><span>},</span><span>
    child</span><span>:</span><span> </span><span>ListTile</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>item</span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>},</span>
```

## 3\. Provide “leave behind” indicators

As it stands, the app allows users to swipe items off the list, but it doesn’t give a visual indication of what happens when they do. To provide a cue that items are removed, display a “leave behind” indicator as they swipe the item off the screen. In this case, the indicator is a red background.

To add the indicator, provide a `background` parameter to the `Dismissible`.

<table><tbody><tr><td></td><td><p>@@ -16,6 +16,8 @@</p></td></tr><tr><td><p>16</p><p>16</p></td><td><p><span>&nbsp;</span> <span><span>ScaffoldMessenger</span><span>.of</span>(context)</span></p></td></tr><tr><td><p>17</p><p>17</p></td><td><p><span>&nbsp;</span> <span><span>.showSnackBar</span>(SnackBar(<span>content</span>: <span>Text</span>(<span>'$item dismissed'</span>)));</span></p></td></tr><tr><td><p>18</p><p>18</p></td><td><p><span>&nbsp;</span> <span>},</span></p></td></tr><tr><td><p>19</p></td><td><p><span>+</span><span></span></p></td></tr><tr><td><p>20</p></td><td><p><span>+</span> <span><span>background</span>: <span>Container</span>(color: Colors.red),</span></p></td></tr><tr><td><p>19</p><p>21</p></td><td><p><span>&nbsp;</span> <span>child: <span>ListTile</span>(</span></p></td></tr><tr><td><p>20</p><p>22</p></td><td><p><span>&nbsp;</span> <span>title: <span>Text</span>(item),</span></p></td></tr><tr><td><p>21</p><p>23</p></td><td><p><span>&nbsp;</span> <span>),</span></p></td></tr></tbody></table>

## Interactive example