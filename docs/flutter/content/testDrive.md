-   [Install Flutter](https://docs.flutter.dev/get-started/install)
-   [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)

1.  [Get started](https://docs.flutter.dev/get-started)
2.  [Test drive](https://docs.flutter.dev/get-started/test-drive)

## What you’ll learn

1.  How to create a new Flutter app from a sample template.
2.  How to run the new Flutter app.
3.  How to use “hot reload” after you make changes to the app.

## Guide depends on your IDE

These tasks depend on which integrated development environment (IDE) you use.

-   **Option 1** explains how to code with Visual Studio Code and its Flutter extension.
    
-   **Option 2** explains how to code with Android Studio or IntelliJ IDEA with its Flutter plugin.
    
    Flutter supports IntelliJ IDEA Community, Educational, and Ultimate editions.
    
-   **Option 3** uses explains how to code with an editor of your choice then use the the terminal to compile and debug your code.
    

## Choose your IDE

Select your preferred IDE for Flutter apps.

-   [Visual Studio Code](https://docs.flutter.dev/get-started/test-drive#vscode)
-   [Android Studio and IntelliJ](https://docs.flutter.dev/get-started/test-drive#androidstudio)
-   [Terminal & editor](https://docs.flutter.dev/get-started/test-drive#terminal)

### Create your sample Flutter app

1.  Open the Command Palette.
    
    Go to **View** \> **Command Palette** or press \+ Shift + P.
    
2.  Type `flutter`
    
3.  Select the **Flutter: New Project**.
    
4.  When prompted for **Which Flutter Project**, select **Application**.
    
5.  Create or select the parent directory for the new project folder.
    
6.  When prompted for a **Project Name**, enter `test_drive`.
    
7.  Press Enter.
    
8.  Wait for project creation to complete.
    
9.  Open the `lib` directory, then the `main.dart`.
    
    To learn what each code block does, check out the comments in that Dart file.
    

The previous commands create a Flutter project directory called `my_app` that contains a simple demo app that uses [Material Components](https://m3.material.io/components).

### Run your sample Flutter app

Run your example application on your desktop platform or in an iOS simulator or Android emulator.

1.  Open the Command Palette.
    
    Go to **View** \> **Command Palette** or press \+ Shift + P.
    
2.  Type `flutter`
    
3.  Select the **Flutter: Select Device**.
    
    If no devices are running, this command prompts you to enable a device.
    
4.  Select a target device from **Select Device** prompt.
    
5.  After you select a target, start the app. Go to **Run** \> **Start Debugging** or press F5.
    
6.  Wait for the app to launch.
    
    You can watch the launch progress in the **Debug Console** view.
    

After the app build completes, your device displays your app.

![Starter app on macOS](https://docs.flutter.dev/assets/images/docs/get-started/macos/starter-app.png)

Starter app

## Try hot reload

Flutter offers a fast development cycle with _Stateful Hot Reload_, the ability to reload the code of a live running app without restarting or losing app state.

You can change your app source code, run the hot reload command in VS Code, and see the change in your target device.

1.  Open `lib/main.dart`.
    
2.  Change the word `pushed` to `clicked` in the following string. It is on line 109 of the `main.dart` file as of this writing.
    
    | **Original** | **New** |
    | --- | --- |
    | `'You have pushed the button this many times:' ,` | `'You have clicked the button this many times:' ,` |
    
3.  Save your changes: invoke **Save All**, or click **Hot Reload** ![lightning bolt](https://docs.flutter.dev/assets/images/docs/get-started/hot-reload.svg) .
    

Your app updates the string as you watch.

![Starter app after hot reload on macOS](https://docs.flutter.dev/assets/images/docs/get-started/macos/starter-app-hot-reload.png)

Starter app after hot reload

-   [Install Flutter](https://docs.flutter.dev/get-started/install)
-   [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)