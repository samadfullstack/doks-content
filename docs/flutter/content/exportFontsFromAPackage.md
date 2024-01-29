Rather than declaring a font as part of an app, you can declare a font as part of a separate package. This is a convenient way to share the same font across several different projects, or for coders publishing their packages to [pub.dev](https://pub.dev/). This recipe uses the following steps:

To export a font from a package, you need to import the font files into the `lib` folder of the package project. You can place font files directly in the `lib` folder or in a subdirectory, such as `lib/fonts`.

In this example, assume you’ve got a Flutter library called `awesome_package` with fonts living in a `lib/fonts` folder.

```
awesome_package/
  lib/
    awesome_package.dart
    fonts/
      Raleway-Regular.ttf
      Raleway-Italic.ttf
```

Now you can use the fonts in the package by updating the `pubspec.yaml` in the _app’s_ root directory.

Now that you’ve imported the package, tell Flutter where to find the fonts from the `awesome_package`.

To declare package fonts, prefix the path to the font with `packages/awesome_package`. This tells Flutter to look in the `lib` folder of the package for the font.

Use a [`TextStyle`](https://api.flutter.dev/flutter/painting/TextStyle-class.html) to change the appearance of text. To use package fonts, declare which font you’d like to use and which package the font belongs to.