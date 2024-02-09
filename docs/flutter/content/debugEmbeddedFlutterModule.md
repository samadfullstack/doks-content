1.  [Add to app](https://docs.flutter.dev/add-to-app)
2.  [Debugging](https://docs.flutter.dev/add-to-app/debugging)

Once you’ve integrated the Flutter module to your project and used Flutter’s platform APIs to run the Flutter engine and/or UI, you can then build and run your Android or iOS app the same way you run normal Android or iOS apps.

However, Flutter is now powering the UI in places where you’re showing a `FlutterActivity` or `FlutterViewController`.

### Debugging

You might be used to having your suite of favorite Flutter debugging tools available to you automatically when running `flutter run` or an equivalent command from an IDE. But you can also use all your Flutter [debugging functionalities](https://docs.flutter.dev/testing/debugging) such as hot reload, performance overlays, DevTools, and setting breakpoints in add-to-app scenarios.

These functionalities are provided by the `flutter attach` mechanism. `flutter attach` can be initiated through different pathways, such as through the SDK’s CLI tools, through VS Code or IntelliJ/Android Studio.

`flutter attach` can connect as soon as you run your `FlutterEngine`, and remains attached until your `FlutterEngine` is disposed. But you can invoke `flutter attach` before starting your engine. `flutter attach` waits for the next available Dart VM that is hosted by your engine.

#### Terminal

Run `flutter attach` or `flutter attach -d deviceId` to attach from the terminal.

![flutter attach via terminal](https://docs.flutter.dev/assets/images/docs/development/add-to-app/debugging/cli-attach.png)

flutter attach via terminal

#### VS Code

#### Build the iOS version of the Flutter app in the Terminal

To generate the needed iOS platform dependencies, run the `flutter build` command.

```
<span>flutter build ios --config-only --no-codesign --debug
</span>
```

```
<span>Warning: Building for device with codesigning disabled. You will have to manually codesign before deploying to device.
Building com.example.myApp for device (ios)...
</span>
```

-   [Start from VS Code](https://docs.flutter.dev/add-to-app/debugging#from-vscode-to-xcode-ios)
-   [Start from Xcode](https://docs.flutter.dev/add-to-app/debugging#from-xcode-ios)

#### Start debugging with VS Code first

If you use VS Code to debug most of your code, start with this section.

##### Start the Dart debugger in VS Code

1.  To open the Flutter app directory, go to **File** \> **Open Folder…** and choose the `my_app` directory.
    
2.  Open the `lib/main.dart` file.
    
3.  If you can build an app for more than one device, you must select the device first.
    
    Go to **View** \> **Command Palette…**
    
    You can also press Ctrl / Cmd + Shift + P.
    
4.  Type `flutter select`.
    
5.  Click the **Flutter: Select Device** command.
    
6.  Choose your target device.
    
7.  Click the debug icon (![VS Code's bug icon to trigger the debugging mode of a Flutter app](https://docs.flutter.dev/assets/images/docs/testing/debugging/vscode-ui/icons/debug.png)). This opens the **Debug** pane and launches the app. Wait for the app to launch on the device and for the debug pane to indicate **Connected**. The debugger takes longer to launch the first time. Subsequent launches start faster.
    
    This Flutter app contains two buttons:
    
    -   **Launch in browser**: This button opens this page in the default browser of your device.
    -   **Launch in app**: This button opens this page within your app. This button only works for iOS or Android. Desktop apps launch a browser.

##### Attach to the Flutter process in Xcode

1.  To attach to the Flutter app, go to **Debug** \> **Attach to Process** \> **Runner**.
    
    **Runner** should be at the top of the **Attach to Process** menu under the **Likely Targets** heading.
    

You can also create a `.vscode/launch.json` file in your Flutter module project. This enables you to attach using the **Run > Start Debugging** command or `F5`:

```
<span>{</span><span>
  </span><span>name:</span><span> </span><span>"Flutter: Attach"</span><span>,</span><span>
  </span><span>request:</span><span> </span><span>"attach"</span><span>,</span><span>
  </span><span>type:</span><span> </span><span>"dart"</span><span>,</span><span>
</span><span>}</span><span>
</span>
```

#### IntelliJ / Android Studio

Select the device on which the Flutter module runs so `flutter attach` filters for the right start signals.

![flutter attach via IntelliJ](https://docs.flutter.dev/assets/images/docs/development/add-to-app/debugging/intellij-attach.png)

flutter attach via IntelliJ

### Wireless debugging

You can debug your app wirelessly on an iOS or Android device using `flutter attach`.

#### iOS

On iOS, you must follow the steps below:

1.  Ensure that your device is wirelessly connected to Xcode as described in the [iOS setup guide](https://docs.flutter.dev/get-started/install/macos/mobile-ios).
    
2.  Open **Xcode > Product > Scheme > Edit Scheme**
    
3.  Select the **Arguments** tab
    
4.  Add either `--vm-service-host=0.0.0.0` for IPv4, or `--vm-service-host=::0` for IPv6 as a launch argument
    
    You can determine if you’re on an IPv6 network by opening your Mac’s **Settings > Wi-Fi > Details (of the network you’re connected to) > TCP/IP** and check to see if there is an **IPv6 address** section.
    
    ![Check the box that says 'connect via network' from the devices and simulators page](https://docs.flutter.dev/assets/images/docs/development/add-to-app/debugging/wireless-port.png)
    

#### Android

Ensure that your device is wirelessly connected to Android Studio as described in the [Android setup guide](https://docs.flutter.dev/get-started/install/macos/mobile-android?tab=physical#configure-your-target-android-device).