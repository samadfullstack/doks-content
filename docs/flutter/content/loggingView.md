1.  [Tools](https://docs.flutter.dev/tools)
2.  [DevTools](https://docs.flutter.dev/tools/devtools)
3.  [Using the Logging view](https://docs.flutter.dev/tools/devtools/logging)

## What is it?

The logging view displays events from the Dart runtime, application frameworks (like Flutter), and application-level logging events.

## Standard logging events

By default, the logging view shows:

-   Garbage collection events from the Dart runtime
-   Flutter framework events, like frame creation events
-   `stdout` and `stderr` from applications
-   Custom logging events from applications

![Screenshot of a logging view](https://docs.flutter.dev/assets/images/docs/tools/devtools/logging_log_entries.png)

## Logging from your application

To implement logging in your code, see the [Logging](https://docs.flutter.dev/testing/code-debugging#add-logging-to-your-application) section in the [Debugging Flutter apps programmatically](https://docs.flutter.dev/testing/code-debugging) page.

## Clearing logs

To clear the log entries in the logging view, click the **Clear logs** button.

## Other resources

To learn about different methods of logging and how to effectively use DevTools to analyze and debug Flutter apps faster, check out a guided [Logging View tutorial](https://medium.com/@fluttergems/mastering-dart-flutter-devtools-logging-view-part-5-of-8-b634f3a3af26).