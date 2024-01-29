1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Testing](https://docs.flutter.dev/cookbook/testing)
3.  [Integration](https://docs.flutter.dev/cookbook/testing/integration)
4.  [Introduction](https://docs.flutter.dev/cookbook/testing/integration/introduction)

Unit tests and widget tests are handy for testing individual classes, functions, or widgets. However, they generally don’t test how individual pieces work together as a whole, or capture the performance of an application running on a real device. These tasks are performed with _integration tests_.

Integration tests are written using the [integration\_test](https://github.com/flutter/flutter/tree/main/packages/integration_test) package, provided by the SDK.

In this recipe, learn how to test a counter app. It demonstrates how to setup integration tests, how to verify specific text is displayed by the app, how to tap specific widgets, and how to run integration tests.

This recipe uses the following steps:

1.  Create an app to test.
2.  Add the `integration_test` dependency.
3.  Create the test files.
4.  Write the integration test.
5.  Run the integration test.

### 1\. Create an app to test

First, create an app for testing. In this example, test the counter app produced by the `flutter create` command. This app allows a user to tap on a button to increase a counter.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Counter App'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>MyHomePage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'Counter App Home Page'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyHomePage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyHomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyHomePageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyHomePageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>int</span><span> _counter </span><span>=</span><span> </span><span>0</span><span>;</span><span>

  </span><span>void</span><span> _incrementCounter</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _counter</span><span>++;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>widget</span><span>.</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
          children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
              </span><span>'You have pushed the button this many times:'</span><span>,</span><span>
            </span><span>),</span><span>
            </span><span>Text</span><span>(</span><span>
              </span><span>'$_counter'</span><span>,</span><span>
              style</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>textTheme</span><span>.</span><span>headlineMedium</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        </span><span>// Provide a Key to this button. This allows finding this</span><span>
        </span><span>// specific button inside the test suite, and tapping it.</span><span>
        key</span><span>:</span><span> </span><span>const</span><span> </span><span>Key</span><span>(</span><span>'increment'</span><span>),</span><span>
        onPressed</span><span>:</span><span> _incrementCounter</span><span>,</span><span>
        tooltip</span><span>:</span><span> </span><span>'Increment'</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>add</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### 2\. Add the `integration_test` dependency

Next, use the `integration_test` and `flutter_test` packages to write integration tests. Add these dependencies to the `dev_dependencies` section of the app’s `pubspec.yaml` file.

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

### 3\. Create the test files

Create a new directory, `integration_test`, with an empty `app_test.dart` file:

```
counter_app/
  lib/
    main.dart
  integration_test/
    app_test.dart
```

### 4\. Write the integration test

Now you can write tests. This involves three steps:

1.  Initialize `IntegrationTestWidgetsFlutterBinding`, a singleton service that executes tests on a physical device.
2.  Interact and tests widgets using the `WidgetTester` class.
3.  Test the important scenarios.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:integration_test/integration_test.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:introduction/main.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>IntegrationTestWidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span>

  group</span><span>(</span><span>'end-to-end test'</span><span>,</span><span> </span><span>()</span><span> </span><span>{</span><span>
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
      expect</span><span>(</span><span>find</span><span>.</span><span>text</span><span>(</span><span>'1'</span><span>),</span><span> findsOneWidget</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

### 5\. Run the integration test

The process of running the integration tests varies depending on the platform you are testing against. You can test against a mobile platform or the web.

#### 5a. Mobile

To test on a real iOS / Android device, first connect the device and run the following command from the root of the project:

```
<span>flutter test integration_test/app_test.dart
</span>
```

Or, you can specify the directory to run all integration tests:

```
<span>flutter test integration_test
</span>
```

This command runs the app and integration tests on the target device. For more information, see the [Integration testing](https://docs.flutter.dev/testing/integration-tests) page.

___

#### 5b. Web

To get started testing in a web browser, [Download ChromeDriver](https://chromedriver.chromium.org/downloads).

Next, create a new directory named `test_driver` containing a new file named `integration_test.dart`:

```
<span>import</span><span> </span><span>'package:integration_test/integration_test_driver.dart'</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> integrationDriver</span><span>();</span>
```

Launch `chromedriver` as follows:

From the root of the project, run the following command:

```
<span>flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  -d chrome
</span>
```

For a headless testing experience, you can also run `flutter drive` with `web-server` as the target device identifier as follows:

```
<span>flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_test.dart \
  -d web-server
</span>
```