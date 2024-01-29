1.  [UI](https://docs.flutter.dev/ui)
2.  [Navigation and routing](https://docs.flutter.dev/ui/navigation)

Flutter provides a complete system for navigating between screens and handling deep links. Small applications without complex deep linking can use [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html), while apps with specific deep linking and navigation requirements should also use the [`Router`](https://api.flutter.dev/flutter/widgets/Router-class.html) to correctly handle deep links on Android and iOS, and to stay in sync with the address bar when the app is running on the web.

To configure your Android or iOS application to handle deep links, see [Deep linking](https://docs.flutter.dev/ui/navigation/deep-linking).

## Using the Navigator

The `Navigator` widget displays screens as a stack using the correct transition animations for the target platform. To navigate to a new screen, access the `Navigator` through the route’s `BuildContext` and call imperative methods such as `push()` `or pop()`:

```
<span>onPressed:</span> <span>()</span> <span>{</span>
  <span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)</span><span>.</span><span>push</span><span>(</span>
    <span>MaterialPageRoute</span><span>(</span>
      <span>builder:</span> <span>(</span><span>context</span><span>)</span> <span>=</span><span>&gt;</span> <span>const</span> <span>SongScreen</span><span>(</span><span>song:</span> <span>song</span><span>),</span>
    <span>),</span>
  <span>);</span>
<span>},</span>
<span>child:</span> <span>Text</span><span>(</span><span>song</span><span>.</span><span>name</span><span>),</span>
```

Because `Navigator` keeps a stack of `Route` objects (representing the history stack), The `push()` method also takes a `Route` object. The `MaterialPageRoute` object is a subclass of `Route` that specifies the transition animations for Material Design. For more examples of how to use the `Navigator`, follow the [navigation recipes](https://docs.flutter.dev/cookbook#navigation) from the Flutter Cookbook or visit the [Navigator API documentation](https://api.flutter.dev/flutter/widgets/Navigator-class.html).

## Using named routes

Applications with simple navigation and deep linking requirements can use the `Navigator` for navigation and the [`MaterialApp.routes`](https://api.flutter.dev/flutter/material/MaterialApp/routes.html) parameter for deep links:

```
<span>@override</span>
<span>Widget</span> <span>build</span><span>(</span><span>BuildContext</span> <span>context</span><span>)</span> <span>{</span>
  <span>return</span> <span>MaterialApp</span><span>(</span>
    <span>routes:</span> <span>{</span>
      <span>'/'</span><span>:</span> <span>(</span><span>context</span><span>)</span> <span>=</span><span>&gt;</span> <span>HomeScreen</span><span>(),</span>
      <span>'/details'</span><span>:</span> <span>(</span><span>context</span><span>)</span> <span>=</span><span>&gt;</span> <span>DetailScreen</span><span>(),</span>
    <span>},</span>
  <span>);</span>
<span>}</span>
```

Routes specified here are called _named routes_. For a complete example, follow the [Navigate with named routes](https://docs.flutter.dev/cookbook/navigation/named-routes) recipe from the Flutter Cookbook.

### Limitations

Although named routes can handle deep links, the behavior is always the same and can’t be customized. When a new deep link is received by the platform, Flutter pushes a new `Route` onto the Navigator regardless where the user currently is.

Flutter also doesn’t support the browser forward button for applications using named routes. For these reasons, we don’t recommend using named routes in most applications.

## Using the Router

Flutter applications with advanced navigation and routing requirements (such as a web app that uses direct links to each screen, or an app with multiple `Navigator` widgets) should use a routing package such as [go\_router](https://pub.dev/packages/go_router) that can parse the route path and configure the `Navigator` whenever the app receives a new deep link.

To use the Router, switch to the `router` constructor on `MaterialApp` or `CupertinoApp` and provide it with a `Router` configuration. Routing packages, such as [go\_router](https://pub.dev/packages/go_router), typically provide a configuration for you. For example:

```
<span>MaterialApp</span><span>.</span><span>router</span><span>(</span>
  <span>routerConfig:</span> <span>GoRouter</span><span>(</span>
    <span>// …</span>
  <span>)</span>
<span>);</span>
```

Because packages like go\_router are _declarative_, they will always display the same screen(s) when a deep link is received.

## Using Router and Navigator together

The `Router` and `Navigator` are designed to work together. You can navigate using the `Router` API through a declarative routing package, such as `go_router`, or by calling imperative methods such as `push()` and `pop()` on the `Navigator`.

When you navigate using the `Router` or a declarative routing package, each route on the Navigator is _page-backed_, meaning it was created from a [`Page`](https://api.flutter.dev/flutter/widgets/Page-class.html) using the [`pages`](https://api.flutter.dev/flutter/widgets/Navigator/pages.html) argument on the `Navigator` constructor. Conversely, any `Route` created by calling `Navigator.push` or `showDialog` will add a _pageless_ route to the Navigator. If you are using a routing package, Routes that are _page-backed_ are always deep-linkable, whereas _pageless_ routes are not.

When a _page-backed_ `Route` is removed from the `Navigator`, all of the _pageless_ routes after it are also removed. For example, if a deep link navigates by removing a _page-backed_ route from the Navigator, all _pageless \_routes after (up until the next \_page-backed_ route) are removed too.

## Web support

Apps using the `Router` class integrate with the browser History API to provide a consistent experience when using the browser’s back and forward buttons. Whenever you navigate using the `Router`, a History API entry is added to the browser’s history stack. Pressing the **back** button uses _[reverse chronological navigation](https://material.io/design/navigation/understanding-navigation.html#reverse-navigation)_, meaning that the user is taken to the previously visited location that was shown using the `Router`. This means that if the user pops a page from the `Navigator` and then presses the browser **back** button the previous page is pushed back onto the stack.

## More information

For more information on navigation and routing, check out the following resources:

-   The Flutter cookbook includes multiple [navigation recipes](https://docs.flutter.dev/cookbook#navigation) that show how to use the `Navigator`.
-   The [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html) and [`Router`](https://api.flutter.dev/flutter/widgets/Router-class.html) API documentation contain details on how to set up declarative navigation without a routing package.
-   [Understanding navigation](https://material.io/design/navigation/understanding-navigation.html), a page from the Material Design documentation, outlines concepts for designing the navigation in your app, including explanations for forward, upward, and chronological navigation.
-   [Learning Flutter’s new navigation and routing system](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade), an article on Medium, describes how to use the `Router` widget directly, without a routing package.
-   The [Router design document](https://flutter.dev/go/navigator-with-router) contains the motivation and design of the Router\` API.