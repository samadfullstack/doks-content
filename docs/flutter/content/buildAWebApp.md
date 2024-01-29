1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Web](https://docs.flutter.dev/platform-integration/web)
3.  [Web development](https://docs.flutter.dev/platform-integration/web/building)

This page covers the following steps for getting started with web support:

-   Configure the `flutter` tool for web support.
-   Create a new project with web support.
-   Run a new project with web support.
-   Build an app with web support.
-   Add web support to an existing project.

## Requirements

To create a Flutter app with web support, you need the following software:

-   Flutter SDK. See the [Flutter SDK](https://docs.flutter.dev/get-started/install) installation instructions.
-   [Chrome](https://www.google.com/chrome/); debugging a web app requires the Chrome browser.
-   Optional: An IDE that supports Flutter. You can install [Visual Studio Code](https://code.visualstudio.com/), [Android Studio](https://developer.android.com/studio), [IntelliJ IDEA](https://www.jetbrains.com/idea/). Also [install the Flutter and Dart plugins](https://docs.flutter.dev/get-started/editor) to enable language support and tools for refactoring, running, debugging, and reloading your web app within an editor. See [setting up an editor](https://docs.flutter.dev/get-started/editor) for more details.

For more information, see the [web FAQ](https://docs.flutter.dev/platform-integration/web/faq).

## Create a new project with web support

You can use the following steps to create a new project with web support.

### Set up

Run the following commands to use the latest version of the Flutter SDK:

```
<span>$</span><span> </span>flutter channel stable
<span>$</span><span> </span>flutter upgrade
```

If Chrome is installed, the `flutter devices` command outputs a `Chrome` device that opens the Chrome browser with your app running, and a `Web Server` that provides the URL serving the app.

```
<span>$</span><span> </span>flutter devices
<span>1 connected device:

Chrome (web) • chrome • web-javascript • Google Chrome 88.0.4324.150
</span>
```

In your IDE, you should see **Chrome (web)** in the device pulldown.

### Create and run

Creating a new project with web support is no different than [creating a new Flutter project](https://docs.flutter.dev/get-started/test-drive) for other platforms.

#### IDE

Create a new app in your IDE and it automatically creates iOS, Android, [desktop](https://docs.flutter.dev/platform-integration/desktop), and web versions of your app. From the device pulldown, select **Chrome (web)** and run your app to see it launch in Chrome.

#### Command line

To create a new app that includes web support (in addition to mobile support), run the following commands, substituting `my_app` with the name of your project:

```
<span>$</span><span> </span>flutter create my_app
<span>$</span><span> </span><span>cd </span>my_app
```

To serve your app from `localhost` in Chrome, enter the following from the top of the package:

The `flutter run` command launches the application using the [development compiler](https://dart.dev/tools/dartdevc) in a Chrome browser.

### Build

Run the following command to generate a release build:

A release build uses [dart2js](https://dart.dev/tools/dart2js) (instead of the [development compiler](https://dart.dev/tools/dartdevc)) to produce a single JavaScript file `main.dart.js`. You can create a release build using release mode (`flutter run --release`) or by using `flutter build web`. This populates a `build/web` directory with built files, including an `assets` directory, which need to be served together.

You can also include `--web-renderer html` or `--web-renderer canvaskit` to select between the HTML or CanvasKit renderers, respectively. For more information, see [Web renderers](https://docs.flutter.dev/platform-integration/web/renderers).

For more information, see [Build and release a web app](https://docs.flutter.dev/deployment/web).

## Add web support to an existing app

To add web support to an existing project created using a previous version of Flutter, run the following command from your project’s top-level directory:

```
<span>$</span><span> </span>flutter create <span>--platforms</span> web <span>.</span>
```