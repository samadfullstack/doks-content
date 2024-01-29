1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Android](https://docs.flutter.dev/platform-integration/android)
3.  [Targeting ChromeOS with Android](https://docs.flutter.dev/platform-integration/android/chromeos)

This page discusses considerations unique to building Android apps that support ChromeOS with Flutter.

## Flutter & ChromeOS tips & tricks

For the current versions of ChromeOS, only certain ports from Linux are exposed to the rest of the environment. Here’s an example of how to launch Flutter DevTools for an Android app with ports that will work:

```
<span>$</span><span> </span>flutter pub global run devtools <span>--port</span> 8000
<span>$</span><span> </span><span>cd </span>path/to/your/app
<span>$</span><span> </span>flutter run <span>--observatory-port</span><span>=</span>8080
```

Then, navigate to http://127.0.0.1:8000/# in your Chrome browser and enter the URL to your application. The last `flutter run` command you just ran should output a URL similar to the format of `http://127.0.0.1:8080/auth_code=/`. Use this URL and select “Connect” to start the Flutter DevTools for your Android app.

#### Flutter ChromeOS lint analysis

Flutter has ChromeOS-specific lint analysis checks to make sure that the app that you’re building works well on ChromeOS. It looks for things like required hardware in your Android Manifest that aren’t available on ChromeOS devices, permissions that imply requests for unsupported hardware, as well as other properties or code that would bring a lesser experience on these devices.

To activate these, you need to create a new analysis\_options.yaml file in your project folder to include these options. (If you have an existing analysis\_options.yaml file, you can update it)

```
<span>include</span><span>:</span> <span>package:flutter/analysis_options_user.yaml</span>
<span>analyzer</span><span>:</span>
 <span>optional-checks</span><span>:</span>
   <span>chrome-os-manifest-checks</span>
```

To run these from the command line, use the following command:

Sample output for this command might look like:

```
<span>Analyzing ...
warning • This hardware feature is not supported on ChromeOS •
android/app/src/main/AndroidManifest.xml:4:33 • unsupported_chrome_os_hardware
</span>
```