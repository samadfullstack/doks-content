1.  [Testing & debugging](https://docs.flutter.dev/testing)
2.  [Integration testing](https://docs.flutter.dev/testing/integration-tests)

This page describes how to use the [`integration_test`](https://github.com/flutter/flutter/tree/main/packages/integration_test#integration_test) package to run integration tests. Tests written using this package have the following properties:

-   Compatibility with the `flutter drive` command, for running tests on a physical device or emulator.
-   The ability to be run on [Firebase Test Lab](https://firebase.google.com/docs/test-lab), enabling automated testing on a variety of devices.
-   Compatibility with [flutter\_test](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html) APIs, enabling tests to be written in a similar style as [widget tests](https://docs.flutter.dev/testing/overview#widget-tests)

## Overview

**Unit tests, widget tests, and integration tests**

There are three types of tests that Flutter supports. A **unit** test verifies the behavior of a method or class. A **widget test** verifies the behavior of Flutter widgets without running the app itself. An **integration test** (also called end-to-end testing or GUI testing) runs the full app.

**Hosts and targets**

During development, you are probably writing the code on a desktop computer, called the **host** machine, and running the app on a mobile device, browser, or desktop application, called the **target** device. (If you are using a web browser or desktop application, the host machine is also the target device.)

**integration\_test**

Tests written with the `integration_test` package can:

1.  Run directly on the target device, allowing you to test on multiple Android or iOS devices using Firebase Test Lab.
2.  Run using `flutter test integration_test`.
3.  Use `flutter_test` APIs, making integration tests more like writing [widget tests](https://docs.flutter.dev/testing/overview#widget-tests).

**Migrating from flutter\_driver**

Existing projects using `flutter_driver` can be migrated to `integration_test` by following the [Migrating from flutter\_drive](https://docs.flutter.dev/release/breaking-changes/flutter-driver-migration) guide.

## Project setup

Add `integration_test` and `flutter_test` to your `pubspec.yaml` file:

```
<span>$</span><span> </span>flutter pub add <span>'dev:flutter_test:{"sdk":"flutter"}'</span>  <span>'dev:integration_test:{"sdk":"flutter"}'</span>
<span>"flutter_test" is already in "dev_dependencies". Will try to update the constraint.
Resolving dependencies... 
  collection 1.17.2 (1.18.0 available)
+ file 6.1.4 (7.0.0 available)
+ flutter_driver 0.0.0 from sdk flutter
+ fuchsia_remote_debug_protocol 0.0.0 from sdk flutter
+ integration_test 0.0.0 from sdk flutter
  material_color_utilities 0.5.0 (0.8.0 available)
  meta 1.9.1 (1.10.0 available)
+ platform 3.1.0 (3.1.2 available)
+ process 4.2.4 (5.0.0 available)
  stack_trace 1.11.0 (1.11.1 available)
  stream_channel 2.1.1 (2.1.2 available)
+ sync_http 0.3.1
  test_api 0.6.0 (0.6.1 available)
+ vm_service 11.7.1 (11.10.0 available)
+ webdriver 3.0.2
Changed 9 dependencies!
</span>
```

In your project, create a new directory `integration_test` with a new file, `<name>_test.dart`:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:how_to/main.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:integration_test/integration_test.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  testWidgets</span><span>(</span><span>'tap on the floating action button, verify counter'</span><span>,</span><span>
      </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Load app widget.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

    </span><span>// Verify the counter starts at 0.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'0'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>

    </span><span>// Finds the floating action button to tap on.</span><span>
    </span><span>final</span><span> fab </span><span>=</span><span> find</span><span>.</span><span>byKey</span><span>(</span><span>const</span><span> </span><span>Key</span><span>(</span><span>'increment'</span><span>));</span><span>

    </span><span>// Emulate a tap on the floating action button.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>tap</span><span>(</span><span>fab</span><span>);</span><span>

    </span><span>// Trigger a frame.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpAndSettle</span><span>();</span><span>

    </span><span>// Verify the counter increments by 1.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'0'</span><span>),</span><span> findsNothing</span><span>);</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'1'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

If you are looking for more examples, take a look at the [testing\_app](https://github.com/flutter/samples/tree/main/testing_app/integration_test) of the [samples](https://github.com/flutter/samples) repository.

### Directory structure

```
<span>lib/</span>
  <span>...</span>
<span>integration_test/</span>
  <span>foo_test.dart</span>
  <span>bar_test.dart</span>
<span>test/</span>
  <span># Other unit tests go here.</span>
```

See also:

-   [integration\_test usage](https://github.com/flutter/flutter/tree/main/packages/integration_test#usage)

## Running using the flutter command

These tests can be launched with the `flutter test` command, where `<DEVICE_ID>`: is the optional device ID or pattern displayed in the output of the `flutter devices` command:

```
flutter <span>test </span>integration_test/foo_test.dart <span>-d</span> &lt;DEVICE_ID&gt;
```

This runs the tests in `foo_test.dart`. To run all tests in this directory on the default device, run:

```
flutter test integration_test
```

### Running in a browser

First, [Download and install ChromeDriver](https://chromedriver.chromium.org/downloads) and run it on port 4444:

To run tests with `flutter drive`, create a new directory containing a new file, `test_driver/integration_test.dart`:

```
<span>import</span><span> </span><span>'package:integration_test/integration_test_driver.dart'</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> integrationDriver</span><span>();</span>
```

Then add `IntegrationTestWidgetsFlutterBinding.ensureInitialized()` in your `integration_test/<name>_test.dart` file:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:how_to/main.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:integration_test/integration_test.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>IntegrationTestWidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span> </span><span>// NEW</span><span>

  testWidgets</span><span>(</span><span>'tap on the floating action button, verify counter'</span><span>,</span><span>
      </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Load app widget.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

    </span><span>// Verify the counter starts at 0.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'0'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>

    </span><span>// Finds the floating action button to tap on.</span><span>
    </span><span>final</span><span> fab </span><span>=</span><span> find</span><span>.</span><span>byKey</span><span>(</span><span>const</span><span> </span><span>Key</span><span>(</span><span>'increment'</span><span>));</span><span>

    </span><span>// Emulate a tap on the floating action button.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>tap</span><span>(</span><span>fab</span><span>);</span><span>

    </span><span>// Trigger a frame.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpAndSettle</span><span>();</span><span>

    </span><span>// Verify the counter increments by 1.</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'0'</span><span>),</span><span> findsNothing</span><span>);</span><span>
    expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'1'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

In a separate process, run `flutter_drive`:

```
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/counter_test.dart \
  -d web-server
```

To learn more, see the [Running Flutter driver tests with web](https://github.com/flutter/flutter/wiki/Running-Flutter-Driver-tests-with-Web) wiki page.

## Testing on Firebase Test Lab

You can use the Firebase Test Lab with both Android and iOS targets.

### Android setup

Follow the instructions in the [Android Device Testing](https://github.com/flutter/flutter/tree/main/packages/integration_test#android-device-testing) section of the README.

### iOS setup

Follow the instructions in the [iOS Device Testing](https://github.com/flutter/flutter/tree/main/packages/integration_test#ios-device-testing) section of the README.

### Test Lab project setup

Go to the [Firebase Console](http://console.firebase.google.com/), and create a new project if you don’t have one already. Then navigate to **Quality > Test Lab**:

![Firebase Test Lab Console](https://docs.flutter.dev/assets/images/docs/integration-test/test-lab-1.png)

### Uploading an Android APK

Create an APK using Gradle:

```
<span>pushd </span>android
<span># flutter build generates files in android/ for building the app</span>
flutter build apk
./gradlew app:assembleAndroidTest
./gradlew app:assembleDebug <span>-Ptarget</span><span>=</span>integration_test/&lt;name&gt;_test.dart
<span>popd</span>
```

Where `<name>_test.dart` is the file created in the **Project Setup** section.

Drag the “debug” APK from `<flutter_project_directory>/build/app/outputs/apk/debug` into the **Android Robo Test** target on the web page. This starts a Robo test and allows you to run other tests:

![Firebase Test Lab upload](https://docs.flutter.dev/assets/images/docs/integration-test/test-lab-2.png)

Click **Run a test**, select the **Instrumentation** test type and drag the following two files:

-   `<flutter_project_directory>/build/app/outputs/apk/debug/<file>.apk`
-   `<flutter_project_directory>/build/app/outputs/apk/androidTest/debug/<file>.apk`

![Firebase Test Lab upload two APKs](https://docs.flutter.dev/assets/images/docs/integration-test/test-lab-3.png)

If a failure occurs, you can view the output by selecting the red icon:

![Firebase Test Lab test results](https://docs.flutter.dev/assets/images/docs/integration-test/test-lab-4.png)

### Uploading an Android APK from the command line

See the [Firebase Test Lab section of the README](https://github.com/flutter/flutter/tree/main/packages/integration_test#firebase-test-lab) for instructions on uploading the APKs from the command line.

### Uploading Xcode tests

See the [Firebase TestLab iOS instructions](https://firebase.google.com/docs/test-lab/ios/firebase-console) for details on how to upload the .zip file to the Firebase TestLab section of the Firebase Console.

### Uploading Xcode tests from the command line

See the [iOS Device Testing](https://github.com/flutter/flutter/tree/main/packages/integration_test#ios-device-testing) section in the README for instructions on how to upload the .zip file from the command line.