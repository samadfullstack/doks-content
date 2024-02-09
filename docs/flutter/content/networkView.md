1.  [Tools](https://docs.flutter.dev/tools)
2.  [DevTools](https://docs.flutter.dev/tools/devtools)
3.  [Using the Network View](https://docs.flutter.dev/tools/devtools/network)

## What is it?

The network view allows you to inspect HTTP, HTTPS, and web socket traffic from your Dart or Flutter application.

![Screenshot of the network screen](https://docs.flutter.dev/assets/images/docs/tools/devtools/network_screenshot.png)

## How to use it

Network traffic should be recording by default when you open the Network page. If it is not, click the **Resume** button in the upper left to begin polling.

Select a network request from the table (left) to view details (right). You can inspect general and timing information about the request, as well as the content of response and request headers and bodies.

### Search and filtering

You can use the search and filter controls to find a specific request or filter requests out of the request table.

![Screenshot of the network screen](https://docs.flutter.dev/assets/images/docs/tools/devtools/network_search_and_filter.png)

To apply a filter, press the filter button (right of the search bar). You will see a filter dialog pop up:

![Screenshot of the network screen](https://docs.flutter.dev/assets/images/docs/tools/devtools/network_filter_dialog.png)

The filter query syntax is described in the dialog. You can filter network requests by the following keys:

-   `method`, `m`: this filter corresponds to the value in the “Method” column
-   `status`, `s`: this filter corresponds to the value in the “Status” column
-   `type`, `t`: this filter corresponds to the value in the “Type” column

Any text that is not paired with an available filter key will be queried against all categories (method, uri, status, type).

Example filter queries:

```
my-endpoint m:get t:json s:200
```

## Other resources

HTTP and HTTPs requests are also surfaced in the [Timeline](https://docs.flutter.dev/tools/devtools/performance#timeline-events-tab) as asynchronous timeline events. Viewing network activity in the timeline can be useful if you want to see how HTTP traffic aligns with other events happening in your app or in the Flutter framework.

To learn how to monitor an app’s network traffic and inspect different types of requests using the DevTools, check out a guided [Network View tutorial](https://medium.com/@fluttergems/mastering-dart-flutter-devtools-network-view-part-4-of-8-afce2463687c). The tutorial also uses the view to identify network activity that causes poor app performance.