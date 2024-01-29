1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Design](https://docs.flutter.dev/cookbook/design)
3.  [Add a drawer to a screen](https://docs.flutter.dev/cookbook/design/drawer)

In apps that use Material Design, there are two primary options for navigation: tabs and drawers. When there is insufficient space to support tabs, drawers provide a handy alternative.

In Flutter, use the [`Drawer`](https://api.flutter.dev/flutter/material/Drawer-class.html) widget in combination with a [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) to create a layout with a Material Design drawer. This recipe uses the following steps:

1.  Create a `Scaffold`.
2.  Add a drawer.
3.  Populate the drawer with items.
4.  Close the drawer programmatically.

## 1\. Create a `Scaffold`

To add a drawer to the app, wrap it in a [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) widget. The `Scaffold` widget provides a consistent visual structure to apps that follow the Material Design Guidelines. It also supports special Material Design components, such as Drawers, AppBars, and SnackBars.

In this example, create a `Scaffold` with a `drawer`:

```
<span>Scaffold</span><span>(</span><span>
  appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
    title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'AppBar without hamburger button'</span><span>),</span><span>
  </span><span>),</span><span>
  drawer</span><span>:</span><span> </span><span>// Add a Drawer here in the next step.</span><span>
</span><span>);</span>
```

## 2\. Add a drawer

Now add a drawer to the `Scaffold`. A drawer can be any widget, but it’s often best to use the `Drawer` widget from the [material library](https://api.flutter.dev/flutter/material/material-library.html), which adheres to the Material Design spec.

```
<span>Scaffold</span><span>(</span><span>
  appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
    title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'AppBar with hamburger button'</span><span>),</span><span>
  </span><span>),</span><span>
  drawer</span><span>:</span><span> </span><span>Drawer</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>// Populate the Drawer in the next step.</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## 3\. Populate the drawer with items

Now that you have a `Drawer` in place, add content to it. For this example, use a [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html). While you could use a `Column` widget, `ListView` is handy because it allows users to scroll through the drawer if the content takes more space than the screen supports.

Populate the `ListView` with a [`DrawerHeader`](https://api.flutter.dev/flutter/material/DrawerHeader-class.html) and two [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html) widgets. For more information on working with Lists, see the [list recipes](https://docs.flutter.dev/cookbook#lists).

```
<span>Drawer</span><span>(</span><span>
  </span><span>// Add a ListView to the drawer. This ensures the user can scroll</span><span>
  </span><span>// through the options in the drawer if there isn't enough vertical</span><span>
  </span><span>// space to fit everything.</span><span>
  child</span><span>:</span><span> </span><span>ListView</span><span>(</span><span>
    </span><span>// Important: Remove any padding from the ListView.</span><span>
    padding</span><span>:</span><span> </span><span>EdgeInsets</span><span>.</span><span>zero</span><span>,</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      </span><span>const</span><span> </span><span>DrawerHeader</span><span>(</span><span>
        decoration</span><span>:</span><span> </span><span>BoxDecoration</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>,</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Drawer Header'</span><span>),</span><span>
      </span><span>),</span><span>
      </span><span>ListTile</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Item 1'</span><span>),</span><span>
        onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          </span><span>// Update the state of the app.</span><span>
          </span><span>// ...</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
      </span><span>ListTile</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Item 2'</span><span>),</span><span>
        onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          </span><span>// Update the state of the app.</span><span>
          </span><span>// ...</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## 4\. Close the drawer programmatically

After a user taps an item, you might want to close the drawer. You can do this by using the [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html).

When a user opens the drawer, Flutter adds the drawer to the navigation stack. Therefore, to close the drawer, call `Navigator.pop(context)`.

```
<span>ListTile</span><span>(</span><span>
  title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Item 1'</span><span>),</span><span>
  onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Update the state of the app</span><span>
    </span><span>// ...</span><span>
    </span><span>// Then close the drawer</span><span>
    </span><span>Navigator</span><span>.</span><span>pop</span><span>(</span><span>context</span><span>);</span><span>
  </span><span>},</span><span>
</span><span>),</span>
```

## Interactive example

This example shows a [`Drawer`](https://api.flutter.dev/flutter/material/Drawer-class.html) as it is used within a [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) widget. The [`Drawer`](https://api.flutter.dev/flutter/material/Drawer-class.html) has three [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html) items. The `_onItemTapped` function changes the selected item’s index and displays the corresponding text in the center of the `Scaffold`.