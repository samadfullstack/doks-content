1.  [Tools](https://docs.flutter.dev/tools)
2.  [Code formatting](https://docs.flutter.dev/tools/formatting)

While your code might follow any preferred style—in our experience—teams of developers might find it more productive to:

-   Have a single, shared style, and
-   Enforce this style through automatic formatting.

The alternative is often tiring formatting debates during code reviews, where time might be better spent on code behavior rather than code style.

## Automatically formatting code in VS Code

Install the `Flutter` extension (see [Editor setup](https://docs.flutter.dev/get-started/editor)) to get automatic formatting of code in VS Code.

To automatically format the code in the current source code window, right-click in the code window and select `Format Document`. You can add a keyboard shortcut to this VS Code **Preferences**.

To automatically format code whenever you save a file, set the `editor.formatOnSave` setting to `true`.

## Automatically formatting code in Android Studio and IntelliJ

Install the `Dart` plugin (see [Editor setup](https://docs.flutter.dev/get-started/editor)) to get automatic formatting of code in Android Studio and IntelliJ. To format your code in the current source code window:

-   In macOS, press Cmd + Option + L.
-   In Windows and Linux, press Ctrl + Alt + L.

Android Studio and IntelliJ also provide a checkbox named **Format code on save** on the Flutter page in **Preferences** on macOS or **Settings** on Windows and Linux. This option corrects formatting in the current file when you save it.

## Automatically formatting code with the `dart` command

To correct code formatting in the command line interface (CLI), run the `dart format` command:

```
<span>$</span><span> </span>dart format path1 path2 <span>[</span>...]
```

## Using trailing commas

Flutter code often involves building fairly deep tree-shaped data structures, for example in a `build` method. To get good automatic formatting, we recommend you adopt the optional _trailing commas_. The guideline for adding a trailing comma is simple: Always add a trailing comma at the end of a parameter list in functions, methods, and constructors where you care about keeping the formatting you crafted. This helps the automatic formatter to insert an appropriate amount of line breaks for Flutter-style code.

Here is an example of automatically formatted code _with_ trailing commas:

![Automatically formatted code with trailing commas](https://docs.flutter.dev/assets/images/docs/tools/android-studio/trailing-comma-with.png)

And the same code automatically formatted code _without_ trailing commas:

![Automatically formatted code without trailing commas](https://docs.flutter.dev/assets/images/docs/tools/android-studio/trailing-comma-without.png)