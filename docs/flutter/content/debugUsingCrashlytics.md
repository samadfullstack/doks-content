This quickstart describes how to set up Firebase Crashlytics in your app with the Crashlytics Flutter plugin so that you can get comprehensive crash reports in the Firebase console.

Setting up Crashlytics involves using both a command-line tool and your IDE. To finish setup, you'll need to force a test exception to be thrown to send your first crash report to Firebase.

## Before you begin

1.  If you haven't already, [configure and initialize Firebase](https://firebase.google.com/docs/flutter/setup) in your Flutter project.
    
2.  **Recommended**: To get features like crash-free users, breadcrumb logs, and velocity alerts, you need to enable Google Analytics in your Firebase project.
    
    All Android and Apple platforms supported by Crashlytics (except watchOS) can take advantage of these features from Google Analytics.
    
    Make sure that Google Analytics is enabled in your Firebase project: Go to \> _Project settings_ > _Integrations_ tab, then follow the on-screen instructions for Google Analytics.
    

## **Step 1**: Add Crashlytics to your Flutter project

1.  From the root of your Flutter project, run the following command to install the Crashlytics Flutter plugin:
    
    ```
    <span>flutter pub add firebase_crashlytics<br></span>
    ```
    
2.  From the root directory of your Flutter project, run the following command:
    
    ```
    <span>flutterfire configure<br></span>
    ```
    
    Running this command ensures that your Flutter app's Firebase configuration is up-to-date and, for Android, adds the required Crashlytics Gradle plugin to your app.
    
3.  Once complete, rebuild your Flutter project:
    
    ```
    <span>flutter run<br></span>
    ```
    
4.  _(Optional)_ If your Flutter project uses the `--split-debug-info` flag (and, optionally, also the `--obfuscate` flag), additional steps are required to show readable stack traces for your apps.
    
    -   **Apple platforms:** Make sure that your project is using the recommended version configuration (Flutter 3.12.0+ and Crashlytics Flutter plugin 3.3.4+) so that your project can automatically generate and upload Flutter symbols (dSYM files) to Crashlytics.
        
    -   **Android:** Use the [Firebase CLI](https://firebase.google.com/docs/cli) (v.11.9.0+) to upload Flutter debug symbols. You need to upload the debug symbols _before_ reporting a crash from an obfuscated code build.
        
        From the root directory of your Flutter project, run the following command:
        
        ```
        firebase crashlytics:symbols:upload --app=<devsite-var ready="" translate="no" is-upgraded="" scope="FIREBASE_APP_ID"><span><var spellcheck="false" is-upgraded="">FIREBASE_APP_ID</var></span></devsite-var> <devsite-var ready="" translate="no" is-upgraded="" scope="PATH/TO"><span><var spellcheck="false" is-upgraded="">PATH/TO</var></span></devsite-var>/symbols
        ```
        
        -   FIREBASE\_APP\_ID: Your Firebase Android App ID (not your package name)  
            Example Firebase Android App ID: `1:567383003300:android:17104a2ced0c9b9b`
            
            Need to find your Firebase App ID?
            
        -   `PATH/TO/symbols`: The same directory that you pass to the `--split-debug-info` flag when building the application
            

## **Step 2**: Configure crash handlers

You can automatically catch all errors that are thrown within the Flutter framework by overriding `FlutterError.onError` with `FirebaseCrashlytics.instance.recordFlutterFatalError`:

```
<span>void</span><span> main</span><span>()</span><span> async </span><span>{</span><span><br>&nbsp; </span><span>WidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span><br><br>&nbsp; await </span><span>Firebase</span><span>.</span><span>initializeApp</span><span>();</span><span><br><br>&nbsp; </span><span>// Pass all uncaught "fatal" errors from the framework to Crashlytics</span><span><br>&nbsp; </span><span>FlutterError</span><span>.</span><span>onError </span><span>=</span><span> </span><span>FirebaseCrashlytics</span><span>.</span><span>instance</span><span>.</span><span>recordFlutterFatalError</span><span>;</span><span><br><br>&nbsp; runApp</span><span>(</span><span>MyApp</span><span>());</span><span><br></span><span>}</span><span><br></span>
```

To catch asynchronous errors that aren't handled by the Flutter framework, use `PlatformDispatcher.instance.onError`:

```
<span>Future</span><span>&lt;void&gt;</span><span> main</span><span>()</span><span> async </span><span>{</span><span><br>&nbsp; &nbsp; </span><span>WidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span><br>&nbsp; &nbsp; await </span><span>Firebase</span><span>.</span><span>initializeApp</span><span>();</span><span><br>&nbsp; &nbsp; </span><span>FlutterError</span><span>.</span><span>onError </span><span>=</span><span> </span><span>(</span><span>errorDetails</span><span>)</span><span> </span><span>{</span><span><br>&nbsp; &nbsp; &nbsp; </span><span>FirebaseCrashlytics</span><span>.</span><span>instance</span><span>.</span><span>recordFlutterFatalError</span><span>(</span><span>errorDetails</span><span>);</span><span><br>&nbsp; &nbsp; </span><span>};</span><span><br>&nbsp; &nbsp; </span><span>// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics</span><span><br>&nbsp; &nbsp; </span><span>PlatformDispatcher</span><span>.</span><span>instance</span><span>.</span><span>onError </span><span>=</span><span> </span><span>(</span><span>error</span><span>,</span><span> stack</span><span>)</span><span> </span><span>{</span><span><br>&nbsp; &nbsp; &nbsp; </span><span>FirebaseCrashlytics</span><span>.</span><span>instance</span><span>.</span><span>recordError</span><span>(</span><span>error</span><span>,</span><span> stack</span><span>,</span><span> fatal</span><span>:</span><span> </span><span>true</span><span>);</span><span><br>&nbsp; &nbsp; &nbsp; </span><span>return</span><span> </span><span>true</span><span>;</span><span><br>&nbsp; &nbsp; </span><span>};</span><span><br>&nbsp; &nbsp; runApp</span><span>(</span><span>MyApp</span><span>());</span><span><br><br></span><span>}</span><span><br></span>
```

For examples of how to handle other types of errors, see [Customize crash reports](https://firebase.google.com/docs/crashlytics/customize-crash-reports?platform=flutter).

## **Step 3**: Force a test crash to finish setup

To finish setting up Crashlytics and see initial data in the Crashlytics dashboard of the Firebase console, you need to force a test exception to be thrown.

1.  Add code to your app that you can use to force a test exception to be thrown.
    
    If you’ve added an error handler that calls `FirebaseCrashlytics.instance.recordError(error, stack, fatal: true)` to the top-level `Zone`, you can use the following code to add a button to your app that, when pressed, throws a test exception:
    
    ```
    <span>TextButton</span><span>(</span><span><br>&nbsp; &nbsp; onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> </span><span>throw</span><span> </span><span>Exception</span><span>(),</span><span><br>&nbsp; &nbsp; child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>"Throw Test Exception"</span><span>),</span><span><br></span><span>),</span><span><br></span>
    ```
    
2.  Build and run your app.
    
3.  Force the test exception to be thrown in order to send your app's first report:
    
    1.  Open your app from your test device or emulator.
        
    2.  In your app, press the test exception button that you added using the code above.
        
4.  Go to the [Crashlytics dashboard](https://console.firebase.google.com/project/_/crashlytics) of the Firebase console to see your test crash.
    
    If you've refreshed the console and you're still not seeing the test crash after five minutes, [enable debug logging](https://firebase.google.com/docs/crashlytics/test-implementation#enable-debug-logging) to see if your app is sending crash reports.
    

  
And that's it! Crashlytics is now monitoring your app for crashes and, on Android, non-fatal errors and ANRs. Visit the [Crashlytics dashboard](https://console.firebase.google.com/project/_/crashlytics) to view and investigate all your reports and statistics.

## Next steps

-   [Customize your crash report setup](https://firebase.google.com/docs/crashlytics/customize-crash-reports) by adding opt-in reporting, logs, keys, and tracking of additional non-fatal errors.
    
-   [Integrate with Google Play](https://firebase.google.com/docs/crashlytics/integrate-with-google-play) so that you can filter your Android app's crash reports by Google Play track directly in the Crashlytics dashboard. This allows you to better focus your dashboard on specific builds.
    
-   [View stack traces and crash statistics alongside your code](https://developer.android.com/studio/preview/features#aqi) with the _App Quality Insights_ window in Android Studio (available starting with Electric Eel 2022.1.1).