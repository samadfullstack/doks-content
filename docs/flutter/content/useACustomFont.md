1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Design](https://docs.flutter.dev/cookbook/design)
3.  [Use a custom font](https://docs.flutter.dev/cookbook/design/fonts)

Although Android and iOS offer high quality system fonts, designers want support for custom fonts. You might have a custom-built font from a designer, or perhaps you downloaded a font from [Google Fonts](https://fonts.google.com/).

A typeface is the collection of glyphs or shapes that comprise a given style of lettering. A font is one representation of that typeface at a given weight or variation. Roboto is a typeface and Roboto Bold is a font.

Flutter lets you apply a custom font across an entire app or to individual widgets. This recipe creates an app that uses custom fonts with the following steps.

1.  Choose your fonts.
2.  Import the font files.
3.  Declare the font in the pubspec.
4.  Set a font as the default.
5.  Use a font in a specific widget.

You don’t need to follow each step as you go. The guide offers completed example files at the end.

## Choose a font

Your choice of font should be more than a preference. Consider which file formats work with Flutter and how the font could affect design options and app performance.

#### Pick a supported font format

Flutter supports the following font formats:

-   OpenType font collections: `.ttc`
-   TrueType fonts: `.ttf`
-   OpenType fonts: `.otf`

Flutter does not support fonts in the Web Open Font Format, `.woff` and `.woff2`, on desktop platforms.

#### Choose fonts for their specific benefits

Few sources agree on what a font file type is or which uses less space. The key difference between font file types involves how the format encodes the glyphs in the file. Most TrueType and OpenType font files have similiar capabilities as they borrowed from each other as the formats and fonts improved over time.

Which font you should use depends on the following considerations.

-   How much variation you need for fonts in your app?
-   How much file size you can accept fonts using in your app?
-   How many languages you need to support in your app?

Research what options a given font offers, like more than one weight or style per font file, [variable font capability](https://fonts.google.com/knowledge/introducing_type/introducing_variable_fonts), the availabilty of multiple font files for a multiple font weights, or more than one width per font.

Choose the typeface or font family that meets the design needs of your app.

## Import the font files

To work with a font, import its font files into your Flutter project.

To import font files, perform the following steps.

1.  If necessary, to match the remaining steps in this guide, change the name of your Flutter app to `custom_fonts`.
    
    ```
    <span>$</span><span> </span><span>mv</span> /path/to/my_app /path/to/custom_fonts
    ```
    
2.  Navigate to the root of your Flutter project.
    
    ```
    <span>$</span><span> </span><span>cd</span> /path/to/custom_fonts
    ```
    
3.  Create a `fonts` directory at the root of your Flutter project.
    
4.  Move or copy the font files in a `fonts` or `assets` folder at the root of your Flutter project.
    
    ```
    <span>$</span><span> </span><span>cp</span> ~/Downloads/<span>*</span>.ttf ./fonts
    ```
    

The resulting folder structure should resemble the following:

```nocode
custom_fonts/ |- fonts/ |- Raleway-Regular.ttf |- Raleway-Italic.ttf |- RobotoMono-Regular.ttf |- RobotoMono-Bold.ttf
```

## Declare the font in the pubspec.yaml file

After you’ve downloaded a font, include a font definition in the `pubspec.yaml` file. This font definition also specifies which font file should be used to render a given weight or style in your app.

### Define fonts in the `pubspec.yaml` file

To add font files to your Flutter app, complete the following steps.

1.  Open the `pubspec.yaml` file at the root of your Flutter project.
    
2.  Paste the following YAML block after the `flutter` declaration.
    
    ```
      <span>fonts</span><span>:</span>
        <span>-</span> <span>family</span><span>:</span> <span>Raleway</span>
          <span>fonts</span><span>:</span>
            <span>-</span> <span>asset</span><span>:</span> <span>fonts/Raleway-Regular.ttf</span>
            <span>-</span> <span>asset</span><span>:</span> <span>fonts/Raleway-Italic.ttf</span>
              <span>style</span><span>:</span> <span>italic</span>
        <span>-</span> <span>family</span><span>:</span> <span>RobotoMono</span>
          <span>fonts</span><span>:</span>
            <span>-</span> <span>asset</span><span>:</span> <span>fonts/RobotoMono-Regular.ttf</span>
            <span>-</span> <span>asset</span><span>:</span> <span>fonts/RobotoMono-Bold.ttf</span>
             <span>weight</span><span>:</span> <span>700</span>
    ```
    

This `pubspec.yaml` file defines the italic style for the `Raleway` font family as the `Raleway-Italic.ttf` font file. When you you set `style: TextStyle(fontStyle: FontStyle.italic)`, Flutter swaps `Raleway-Regular` with `Raleway-Italic`.

The `family` value sets the name of the typeface. You use this name in the [`fontFamily`](https://api.flutter.dev/flutter/painting/TextStyle/fontFamily.html) property of a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html) object.

The value of an `asset` is a relative path from the `pubspec.yaml` file to the font file. These files contain the outlines for the glyphs in the font. When building the app, Flutter includes these files in the app’s asset bundle.

### Include font files for each font

Different typefaces implement font files in different ways. If you need a typeface with a variety of font weights and styles, choose and import font files that represent that variety.

When you import a font file that doesn’t include either multiple fonts within it or variable font capabilities, don’t use the `style` or `weight` property to adjust how they display. If you do use those properties on a regular font file, Flutter attempts to _simulate_ the look. The visual result will look quite different from using the correct font file.

### Set styles and weights with font files

When you declare which font files represent styles or weights of a font, you can apply the `style` or `weight` properties.

#### Set font weight

The `weight` property specifies the weight of the outlines in the file as an integer multiple of 100, between 100 and 900. These values correspond to the [`FontWeight`](https://api.flutter.dev/flutter/dart-ui/FontWeight-class.html) and can be used in the [`fontWeight`](https://api.flutter.dev/flutter/painting/TextStyle/fontWeight.html) property of a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html) object.

In the `pubspec.yaml` shown in this guide, you defined `RobotoMono-Bold` as the `700` weight of the font family. To use the `RobotoMono-Bold` font that you added to your app, set `fontWeight` to `FontWeight.w700` in your `TextStyle` widget.

If hadn’t added `RobotoMono-Bold` to your app, Flutter attempts to make the font look bold. The text then might appear to be somewhat darker.

You can’t use the `weight` property to override the weight of the font. You can’t set `RobotoMono-Bold` to any other weight than `700`. If you set `TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.w900)`, the displayed font would still render as however bold `RobotoMono-Bold` looks.

#### Set font style

The `style` property specifies whether the glyphs in the font file display as either `italic` or `normal`. These values correspond to the [`FontStyle`](https://api.flutter.dev/flutter/dart-ui/FontStyle.html). You can use these styles in the [`fontStyle`](https://api.flutter.dev/flutter/painting/TextStyle/fontStyle.html) property of a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html) object.

In the `pubspec.yaml` shown in this guide, you defined `Raleway-Italic` as being in the `italic` style. To use the `Raleway-Italic` font that you added to your app, set `style: TextStyle(fontStyle: FontStyle.italic)`. Flutter swaps `Raleway-Regular` with `Raleway-Italic` when rendering.

If hadn’t added `Raleway-Italic` to your app, Flutter attempts to make the font _look_ italic. The text then might appear to be leaning to the right.

You can’t use the `style` property to override the glyphs of a font. If you set `TextStyle(fontFamily: 'Raleway', fontStyle: FontStyle.normal)`, the displayed font would still render as italic. The `regular` style of an italic font _is_ italic.

## Set a font as the default

To apply a font to text, you can set the font as the app’s default font in its `theme`.

To set a default font, set the `fontFamily` property in the app’s `theme`. Match the `fontFamily` value to the `family` name declared in the `pubspec.yaml` file.

The result would resemble the following code.

```
<span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
  title</span><span>:</span><span> </span><span>'Custom Fonts'</span><span>,</span><span>
  </span><span>// Set Raleway as the default app font.</span><span>
  theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>fontFamily</span><span>:</span><span> </span><span>'Raleway'</span><span>),</span><span>
  home</span><span>:</span><span> </span><span>const</span><span> </span><span>MyHomePage</span><span>(),</span><span>
</span><span>);</span>
```

To learn more about themes, check out the [Using Themes to share colors and font styles](https://docs.flutter.dev/cookbook/design/themes) recipe.

To apply the font to a specific widget like a `Text` widget, provide a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html) to the widget.

For this guide, try to apply the `RobotoMono` font to a single `Text` widget. Match the `fontFamily` value to the `family` name declared in the `pubspec.yaml` file.

The result would resemble the following code.

```
<span>child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
  </span><span>'Roboto Mono sample'</span><span>,</span><span>
  style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontFamily</span><span>:</span><span> </span><span>'RobotoMono'</span><span>),</span><span>
</span><span>),</span>
```

## Try the complete example

### Download fonts

Download the Raleway and RobotoMono font files from [Google Fonts](https://fonts.google.com/).

### Update the `pubspec.yaml` file

1.  Open the `pubspec.yaml` file at the root of your Flutter project.
    
2.  Replace its contents with the following YAML.
    
    ```
    <span>name</span><span>:</span> <span>custom_fonts</span>
    <span>description</span><span>:</span> <span>An example of how to use custom fonts with Flutter</span>
       
    <span>dependencies</span><span>:</span>
      <span>flutter</span><span>:</span>
        <span>sdk</span><span>:</span> <span>flutter</span>
       
    <span>dev_dependencies</span><span>:</span>
      <span>flutter_test</span><span>:</span>
        <span>sdk</span><span>:</span> <span>flutter</span>
       
    <span>flutter</span><span>:</span>
      <span>fonts</span><span>:</span>
        <span>-</span> <span>family</span><span>:</span> <span>Raleway</span>
          <span>fonts</span><span>:</span>
            <span>-</span> <span>asset</span><span>:</span> <span>fonts/Raleway-Regular.ttf</span>
            <span>-</span> <span>asset</span><span>:</span> <span>fonts/Raleway-Italic.ttf</span>
              <span>style</span><span>:</span> <span>italic</span>
        <span>-</span> <span>family</span><span>:</span> <span>RobotoMono</span>
          <span>fonts</span><span>:</span>
            <span>-</span> <span>asset</span><span>:</span> <span>fonts/RobotoMono-Regular.ttf</span>
            <span>-</span> <span>asset</span><span>:</span> <span>fonts/RobotoMono-Bold.ttf</span>
              <span>weight</span><span>:</span> <span>700</span>
      <span>uses-material-design</span><span>:</span> <span>true</span>
    ```
    

### Use this `main.dart` file

1.  Open the `main.dart` file in the `lib/` directory of your Flutter project.
    
2.  Replace its contents with the following Dart code.
    
    ```
    <span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
    
    </span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
    
    </span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
      </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
      @override
      </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>'Custom Fonts'</span><span>,</span><span>
          </span><span>// Set Raleway as the default app font.</span><span>
          theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>fontFamily</span><span>:</span><span> </span><span>'Raleway'</span><span>),</span><span>
          home</span><span>:</span><span> </span><span>const</span><span> </span><span>MyHomePage</span><span>(),</span><span>
        </span><span>);</span><span>
      </span><span>}</span><span>
    </span><span>}</span><span>
    
    </span><span>class</span><span> </span><span>MyHomePage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
      </span><span>const</span><span> </span><span>MyHomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>
    
      @override
      </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
          </span><span>// The AppBar uses the app-default Raleway font.</span><span>
          appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Custom Fonts'</span><span>)),</span><span>
          body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
            </span><span>// This Text widget uses the RobotoMono font.</span><span>
            child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
              </span><span>'Roboto Mono sample'</span><span>,</span><span>
              style</span><span>:</span><span> </span><span>TextStyle</span><span>(</span><span>fontFamily</span><span>:</span><span> </span><span>'RobotoMono'</span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>);</span><span>
      </span><span>}</span><span>
    </span><span>}</span>
    ```
    

The resulting Flutter app should display the following screen.

![Custom Fonts Demo](https://docs.flutter.dev/assets/images/docs/cookbook/fonts.png)