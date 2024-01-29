1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Design](https://docs.flutter.dev/cookbook/design)
3.  [Themes](https://docs.flutter.dev/cookbook/design/themes)

To share colors and font styles throughout an app, use themes.

You can define app-wide themes. You can extend a theme to change a theme style for one component. Each theme defines the colors, type style, and other parameters applicable for the type of Material component.

Flutter applies styling in the following order:

1.  Styles applied to the specific widget.
2.  Themes that override the immediate parent theme.
3.  Main theme for the entire app.

After you define a `Theme`, use it within your own widgets. Flutter’s Material widgets use your theme to set the background colors and font styles for app bars, buttons, checkboxes, and more.

## Create an app theme

To share a `Theme` across your entire app, set the `theme` property to your `MaterialApp` constructor. This property takes a [`ThemeData`](https://api.flutter.dev/flutter/material/ThemeData-class.html) instance.

As of the Flutter 3.16 release, Material 3 is Flutter’s default theme.

If you don’t specify a theme in the constructor, Flutter creates a default theme for you.

```
<span>MaterialApp</span><span>(</span><span>
  title</span><span>:</span><span> appName</span><span>,</span><span>
  theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
    useMaterial3</span><span>:</span><span> </span><span>true</span><span>,</span><span>

    </span><span>// Define the default brightness and colors.</span><span>
    colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>
      seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>purple</span><span>,</span><span>
      </span><span>// ···</span><span>
      brightness</span><span>:</span><span> </span><span>Brightness</span><span>.</span><span>dark</span><span>,</span><span>
    </span><span>),</span><span>

    </span><span>// Define the default `TextTheme`. Use this to specify the default</span><span>
    </span><span>// text styling for headlines, titles, bodies of text, and more.</span><span>
    textTheme</span><span>:</span><span> </span><span>TextTheme</span><span>(</span><span>
      displayLarge</span><span>:</span><span> </span><span>const</span><span> </span><span>TextStyle</span><span>(</span><span>
        fontSize</span><span>:</span><span> </span><span>72</span><span>,</span><span>
        fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>bold</span><span>,</span><span>
      </span><span>),</span><span>
      </span><span>// ···</span><span>
      titleLarge</span><span>:</span><span> </span><span>GoogleFonts</span><span>.</span><span>oswald</span><span>(</span><span>
        fontSize</span><span>:</span><span> </span><span>30</span><span>,</span><span>
        fontStyle</span><span>:</span><span> </span><span>FontStyle</span><span>.</span><span>italic</span><span>,</span><span>
      </span><span>),</span><span>
      bodyMedium</span><span>:</span><span> </span><span>GoogleFonts</span><span>.</span><span>merriweather</span><span>(),</span><span>
      displaySmall</span><span>:</span><span> </span><span>GoogleFonts</span><span>.</span><span>pacifico</span><span>(),</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
  home</span><span>:</span><span> </span><span>const</span><span> </span><span>MyHomePage</span><span>(</span><span>
    title</span><span>:</span><span> appName</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

Most instances of `ThemeData` set values for the following two properties. These properties affect the entire app.

1.  [`colorScheme`](https://api.flutter.dev/flutter/material/ThemeData/colorScheme.html) defines the colors.
2.  [`textTheme`](https://api.flutter.dev/flutter/material/ThemeData/textTheme.html) defines text styling.

To learn what colors, fonts, and other properties, you can define, check out the [`ThemeData`](https://api.flutter.dev/flutter/material/ThemeData-class.html) documentation.

## Apply a theme

To apply your new theme, use the `Theme.of(context)` method when specifying a widget’s styling properties. These can include, but are not limited to, `style` and `color`.

The `Theme.of(context)` method looks up the widget tree and retrieves the nearest `Theme` in the tree. If you have a standalone `Theme`, that’s applied. If not, Flutter applies the app’s theme.

In the following example, the `Container` constructor uses this technique to set its `color`.

```
<span>Container</span><span>(</span><span>
  padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>symmetric</span><span>(</span><span>
    horizontal</span><span>:</span><span> </span><span>12</span><span>,</span><span>
    vertical</span><span>:</span><span> </span><span>12</span><span>,</span><span>
  </span><span>),</span><span>
  color</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>colorScheme</span><span>.</span><span>primary</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
    </span><span>'Text with a background color'</span><span>,</span><span>
    </span><span>// ···</span><span>
    style</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>textTheme</span><span>.</span><span>bodyMedium</span><span>!.</span><span>copyWith</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>colorScheme</span><span>.</span><span>onPrimary</span><span>,</span><span>
        </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>),</span>
```

## Override a theme

To override the overall theme in part of an app, wrap that section of the app in a `Theme` widget.

You can override a theme in two ways:

1.  Create a unique `ThemeData` instance.
2.  Extend the parent theme.

### Set a unique `ThemeData` instance

If you want a component of your app to ignore the overall theme, create a `ThemeData` instance. Pass that instance to the `Theme` widget.

```
<span>Theme</span><span>(</span><span>
  </span><span>// Create a unique theme with `ThemeData`.</span><span>
  data</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
    colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>
      seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>pink</span><span>,</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
  child</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
    onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{},</span><span>
    child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>add</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Extend the parent theme

Instead of overriding everything, consider extending the parent theme. To extend a theme, use the [`copyWith()`](https://api.flutter.dev/flutter/material/ThemeData/copyWith.html) method.

```
<span>Theme</span><span>(</span><span>
  </span><span>// Find and extend the parent theme using `copyWith`.</span><span>
  </span><span>// To learn more, check out the section on `Theme.of`.</span><span>
  data</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>copyWith</span><span>(</span><span>
    colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>
      seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>pink</span><span>,</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
    onPressed</span><span>:</span><span> </span><span>null</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>add</span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

## Watch a video on `Theme`

To learn more, watch this short Widget of the Week video on the `Theme` widget:

<iframe src="https://www.youtube.com/embed/oTvQDJOBXmM?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Theme (Flutter Hallowidget of the Week)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="449016686" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

## Try an interactive example