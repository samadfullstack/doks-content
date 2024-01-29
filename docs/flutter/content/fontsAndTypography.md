1.  [UI](https://docs.flutter.dev/ui)
2.  [Design & theming](https://docs.flutter.dev/ui/design)
3.  [Text](https://docs.flutter.dev/ui/design/text)
4.  [Flutter's fonts and typography](https://docs.flutter.dev/ui/design/text/typography)

[_Typography_](https://en.wikipedia.org/wiki/Typography) covers the style and appearance of type or fonts: it specifies how heavy the font is, the slant of the font, the spacing between the letters, and other visual aspects of the text.

All fonts are _not_ created the same. Fonts are a huge topic and beyond the scope of this site, however, this page discusses Flutter’s support for variable and static fonts.

## Variable fonts

[Variable fonts](https://fonts.google.com/knowledge/introducing_type/introducing_variable_fonts) (also called OpenType fonts), allow you to control pre-defined aspects of text styling. Variable fonts support specific axes, such as width, weight, slant (to name a few). The user can select _any value along the continuous axis_ when specifying the type.

![Example of two variable font axes](https://docs.flutter.dev/assets/images/docs/development/ui/typography/variable-font-axes.png)

However, the font must first define what axes are available, and that isn’t always easy to figure out. If you are using a Google Font, you _can_ learn what axes are available using the **type tester** feature, described in the next section.

### Using the Google Fonts type tester

The Google Fonts site offers both variable and static fonts. Use the type tester to learn more about its variable fonts.

1.  To investigate a variable Google font, go to the [Google Fonts](https://fonts.google.com/) website. Note that in the upper right corner of each font card, it says either **variable** for a variable font, or **x styles** indicating how many styles a static font supports.
2.  To see all variable fonts, check the **Show only variable fonts** checkbox.
3.  Either scroll down (or use the search field) to find Roboto. This lists several Roboto variable fonts.
4.  Select **Roboto Serif** to open up its details page.
5.  On the details page, select the **Type tester** tab. For the Roboto Serif font, the **Variable axes** column looks like the following:

![Listing of available font axes for Roboto Serif](https://docs.flutter.dev/assets/images/docs/development/ui/typography/roboto-serif-font-axes.png)

In real time, move the slider on any of the axes to see how it affects the font. When programming a variable font, use the [`FontVariation`](https://api.flutter.dev/flutter/dart-ui/FontVariation-class.html) class to modify the font’s design axes. The `FontVariation` class conforms to the [OpenType font variables spec](https://learn.microsoft.com/en-us/typography/opentype/spec/otvaroverview).

## Static fonts

Google Fonts also contains static fonts. As with variable fonts, you need to know how the font is designed to know what options are available to you. Once again, the Google Fonts site can help.

### Using the Google Fonts site

Use the font’s details page to learn more about its static fonts.

1.  To investigate a variable Google font, go to the [Google Fonts](https://fonts.google.com/) website. Note that in the upper right corner of each font card, it says either **variable** for a variable font, or **x styles** indicating how many styles a static font supports.
2.  Make sure that **Show only variable fonts** is **not** checked and the search field is empty.
3.  Open the **Font properties** menu. Check the **Number of styles** checkbox, and move the slider to 10+.
4.  Select a font, such as **Roboto** to open up its details page.
5.  Roboto has 12 styles, and each style is previewed on its details page, along with the name of that variation.
6.  In real time, move the pixel slider to preview the font at different pixel sizes.
7.  Select the **Type tester** tab to see the supported styles for the font. In this case, there are 3 supported styles.
8.  Select the **Glyph** tab. This shows the glyphs that the font supports.

Use the following API to programmatically alter a static font (but remember that this only works if the font was _designed_ to support the feature):

-   [`FontFeature`](https://api.flutter.dev/flutter/dart-ui/FontFeature-class.html) to select glyphs
-   [`FontWeight`](https://api.flutter.dev/flutter/dart-ui/FontWeight-class.html) to modify weight
-   [`FontStyle`](https://api.flutter.dev/flutter/dart-ui/FontStyle.html) to italicize

A `FontFeature` corresponds to an [OpenType feature tag](https://learn.microsoft.com/en-us/typography/opentype/spec/featuretags) and can be thought of as a boolean flag to enable or disable a feature of a given font. The following example is for CSS, but illustrates the concept:

![Example feature tags in CSS](https://docs.flutter.dev/assets/images/docs/development/ui/typography/feature-tag-example.png)

## Other resources

The following video shows you some of the capabilities of Flutter’s typography and combines it with the Material _and_ Cupertino look and feel (depending on the platform the app runs on), animation, and custom fragment shaders:

<iframe width="560" height="315" src="https://www.youtube.com/embed/sA5MRFFUuOU?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to prototype beautiful designs with Flutter" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" id="914136041" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

**Prototyping beautiful designs with Flutter**

To read one engineer’s experience customizing variable fonts and animating them as they morph (and was the basis for the above video), check out [Playful typography with Flutter](https://medium.com/flutter/playful-typography-with-flutter-f030385058b4), a free article on Medium. The associated example also uses a custom shader.