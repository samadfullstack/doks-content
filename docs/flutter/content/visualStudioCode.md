1.  [Tools](https://docs.flutter.dev/tools)
2.  [VS Code](https://docs.flutter.dev/tools/vs-code)

-   [Android Studio and IntelliJ](https://docs.flutter.dev/tools/android-studio)
-   Visual Studio Code

## Installation and setup

Follow the [Set up an editor](https://docs.flutter.dev/get-started/editor?tab=vscode) instructions to install the Dart and Flutter extensions (also called plugins).

### Updating the extension

Updates to the extensions are shipped on a regular basis. By default, VS Code automatically updates extensions when updates are available.

To install updates yourself:

1.  Click **Extensions** in the Side Bar.
2.  If the Flutter extension has an available update, click **Update** and then **Reload**.
3.  Restart VS Code.

## Creating projects

There are a couple ways to create a new project.

### Creating a new project

To create a new Flutter project from the Flutter starter app template:

1.  Go to **View** \> **Command Palette…**.
    
    You can also press Ctrl / Cmd + Shift + P.
    
2.  Type `flutter`.
3.  Select the **Flutter: New Project**.
4.  Press Enter.
5.  Select **Application**.
6.  Press Enter.
7.  Select a **Project location**.
8.  Enter your desired **Project name**.

### Opening a project from existing source code

To open an existing Flutter project:

1.  Go to **File** \> **Open**.
    
    You can also press Ctrl / Cmd + O
    
2.  Browse to the directory holding your existing Flutter source code files.
3.  Click **Open**.

## Editing code and viewing issues

The Flutter extension performs code analysis. The code analysis can:

-   Highlight language syntax
-   Complete code based on rich type analysis
-   Navigate to type declarations
    
    -   Go to **Go** \> **Go to Definition**.
    -   You can also press F12.
-   Find type usages.
    
    -   Press Shift + F12.
-   View all current source code problems.
    
    -   Go to **View** \> **Problems**.
    -   You can also press Ctrl / Cmd + Shift + M.
    -   The Problems pane displays any analysis issues:  
        ![Problems pane](https://docs.flutter.dev/assets/images/docs/tools/vs-code/problems.png)

## Running and debugging

Start debugging by clicking **Run > Start Debugging** from the main IDE window, or press F5.

### Selecting a target device

When a Flutter project is open in VS Code, you should see a set of Flutter specific entries in the status bar, including a Flutter SDK version and a device name (or the message **No Devices**):  
![VS Code status bar](https://docs.flutter.dev/assets/images/docs/tools/vs-code/device_status_bar.png)

The Flutter extension automatically selects the last device connected. However, if you have multiple devices/simulators connected, click **device** in the status bar to see a pick-list at the top of the screen. Select the device you want to use for running or debugging.

### Run app without breakpoints

Go to **Run** > **Start Without Debugging**.

You can also press Ctrl + F5.

### Run app with breakpoints

1.  If desired, set breakpoints in your source code.
2.  Click **Run** \> **Start Debugging**. You can also press F5. The status bar turns orange to show you are in a debug session.  
    ![Debug console](https://docs.flutter.dev/assets/images/docs/tools/vs-code/debug_console.png)
    
    -   The left **Debug Sidebar** shows stack frames and variables.
    -   The bottom **Debug Console** pane shows detailed logging output.
    -   Debugging is based on a default launch configuration. To customize, click the cog at the top of the **Debug Sidebar** to create a `launch.json` file. You can then modify the values.

### Run app in debug, profile, or release mode

Flutter offers many different build modes to run your app in. You can read more about them in [Flutter’s build modes](https://docs.flutter.dev/testing/build-modes).

1.  Open the `launch.json` file in VS Code.
    
    If you don’t have a `launch.json` file:
    
    1.  Go to **View** \> **Run**.
        
        You can also press Ctrl / Cmd + Shift + D
        
        The **Run and Debug** panel displays.
        
    2.  Click **create a launch.json file**.
        
2.  In the `configurations` section, change the `flutterMode` property to the build mode you want to target.
    
    For example, if you want to run in debug mode, your `launch.json` might look like this:
    
    ```
    <span> </span><span>"configurations"</span><span>:</span><span> </span><span>[</span><span>
       </span><span>{</span><span>
         </span><span>"name"</span><span>:</span><span> </span><span>"Flutter"</span><span>,</span><span>
         </span><span>"request"</span><span>:</span><span> </span><span>"launch"</span><span>,</span><span>
         </span><span>"type"</span><span>:</span><span> </span><span>"dart"</span><span>,</span><span>
         </span><span>"flutterMode"</span><span>:</span><span> </span><span>"debug"</span><span>
       </span><span>}</span><span>
     </span><span>]</span><span>
    </span>
    ```
    
3.  Run the app through the **Run** panel.
    

## Fast edit and refresh development cycle

Flutter offers a best-in-class developer cycle enabling you to see the effect of your changes almost instantly with the _Stateful Hot Reload_ feature. To learn more, check out [Hot reload](https://docs.flutter.dev/tools/hot-reload).

## Advanced debugging

You might find the following advanced debugging tips useful:

### Debugging visual layout issues

During a debug session, several additional debugging commands are added to the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) and to the [Flutter inspector](https://docs.flutter.dev/tools/devtools/inspector). When space is limited, the icon is used as the visual version of the label.

**Toggle Baseline Painting** ![Baseline painting icon](https://docs.flutter.dev/assets/images/docs/tools/devtools/paint-baselines-icon.png)

Causes each RenderBox to paint a line at each of its baselines.

**Toggle Repaint Rainbow** ![Repaint rainbow icon](https://docs.flutter.dev/assets/images/docs/tools/devtools/repaint-rainbow-icon.png)

Shows rotating colors on layers when repainting.

**Toggle Slow Animations** ![Slow animations icon](https://docs.flutter.dev/assets/images/docs/tools/devtools/slow-animations-icon.png)

Slows down animations to enable visual inspection.

**Toggle Debug Mode Banner** ![Debug mode banner icon](https://docs.flutter.dev/assets/images/docs/tools/devtools/debug-mode-banner-icon.png)

Hides the debug mode banner even when running a debug build.

### Debugging external libraries

By default, debugging an external library is disabled in the Flutter extension. To enable:

1.  Select **Settings > Extensions > Dart Configuration**.
2.  Check the `Debug External Libraries` option.

## Editing tips for Flutter code

If you have additional tips we should share, [let us know](https://github.com/flutter/website/issues/new)!

### Assists & quick fixes

Assists are code changes related to a certain code identifier. A number of these are available when the cursor is placed on a Flutter widget identifier, as indicated by the yellow lightbulb icon. To invoke the assist, click the lightbulb as shown in the following screenshot:

![Code assists](https://docs.flutter.dev/assets/images/docs/tools/vs-code/assists.png)

You can also press Ctrl / Cmd + .

Quick fixes are similar, only they are shown with a piece of code has an error and they can assist in correcting it.

**Wrap with new widget assist**

This can be used when you have a widget that you want to wrap in a surrounding widget, for example if you want to wrap a widget in a `Row` or `Column`.

**Wrap widget list with new widget assist**

Similar to the assist above, but for wrapping an existing list of widgets rather than an individual widget.

**Convert child to children assist**

Changes a child argument to a children argument, and wraps the argument value in a list.

**Convert StatelessWidget to StatefulWidget assist**

Changes the implementation of a `StatelessWidget` to that of a `StatefulWidget`, by creating the `State` class and moving the code there.

### Snippets

Snippets can be used to speed up entering typical code structures. They are invoked by typing their prefix, and then selecting from the code completion window: ![Snippets](https://docs.flutter.dev/assets/images/docs/tools/vs-code/snippets.png)

The Flutter extension includes the following snippets:

-   Prefix `stless`: Create a new subclass of -StatelessWidget\`.
-   Prefix `stful`: Create a new subclass of `StatefulWidget` and its associated State subclass.
-   Prefix `stanim`: Create a new subclass of `StatefulWidget`, and its associated State subclass including a field initialized with an `AnimationController`.

You can also define custom snippets by executing **Configure User Snippets** from the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette).

### Keyboard shortcuts

**Hot reload**

To perform a hot reload during a debug session, click **Hot Reload** on the **Debug Toolbar**.

You can also press Ctrl + F5 (Cmd + F5 on macOS).

Keyboard mappings can be changed by executing the **Open Keyboard Shortcuts** command from the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette).

### Hot reload vs. hot restart

Hot reload works by injecting updated source code files into the running Dart VM (Virtual Machine). This includes not only adding new classes, but also adding methods and fields to existing classes, and changing existing functions. A few types of code changes cannot be hot reloaded though:

-   Global variable initializers
-   Static field initializers
-   The `main()` method of the app

For these changes, restart your app without ending your debugging session. To perform a hot restart, run the **Flutter: Hot Restart** command from the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette).

You can also press Ctrl + Shift + F5 or Cmd + Shift + F5 on macOS.

## Troubleshooting

### Known issues and feedback

All known bugs are tracked in the issue tracker: [Dart and Flutter extensions GitHub issue tracker](https://github.com/Dart-Code/Dart-Code/issues). We welcome feedback, both on bugs/issues and feature requests.

Prior to filing new issues:

-   Do a quick search in the issue trackers to see if the issue is already tracked.
-   Make sure you are [up to date](https://docs.flutter.dev/tools/vs-code#updating) with the most recent version of the plugin.

When filing new issues, include [flutter doctor](https://docs.flutter.dev/resources/bug-reports/#provide-some-flutter-diagnostics) output.