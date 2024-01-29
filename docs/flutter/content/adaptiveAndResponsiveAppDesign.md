1.  [UI](https://docs.flutter.dev/ui)
2.  [Layout](https://docs.flutter.dev/ui/layout)
3.  [Adaptive design](https://docs.flutter.dev/ui/layout/responsive)
4.  [Responsive and adaptive](https://docs.flutter.dev/ui/layout/responsive/adaptive-responsive)

One of Flutter’s primary goals is to create a framework that allows you to develop apps from a single codebase that look and feel great on any platform.

This means that your app might appear on screens of many different sizes, from a watch, to a foldable phone with two screens, to a high def monitor.

Two terms that describe concepts for this scenario are _adaptive_ and _responsive_. Ideally, you’d want your app to be _both_ but what, exactly, does this mean? These terms are similar, but they are not the same.

## The difference between an adaptive and a responsive app

_Adaptive_ and _responsive_ can be viewed as separate dimensions of an app: you can have an adaptive app that is not responsive, or vice versa. And, of course, an app can be both, or neither.

**Responsive**

Typically, a _responsive_ app has had its layout tuned for the available screen size. Often this means (for example), re-laying out the UI if the user resizes the window, or changes the device’s orientation. This is especially necessary when the same app can run on a variety of devices, from a watch, phone, tablet, to a laptop or desktop computer.

**Adaptive**

_Adapting_ an app to run on different device types, such as mobile and desktop, requires dealing with mouse and keyboard input, as well as touch input. It also means there are different expectations about the app’s visual density, how component selection works (cascading menus vs bottom sheets, for example), using platform-specific features (such as top-level windows), and more.

Learn more in the following 5-minute video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/HD5gYnspYzk?si=dsA37QUjHBb2Zh_-&amp;enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Adaptive vs. Responsive | Decoding Flutter" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="330099582" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

[Adaptive vs Responsive](https://youtube.com/HD5gYnspYzk?si=5ItDD7UjXvGCRM0K)

## Creating a responsive Flutter app

Flutter allows you to create apps that self-adapt to the device’s screen size and orientation.

There are two basic approaches to creating Flutter apps with responsive design:

**Use the [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) class**

From its [`builder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder/builder.html) property, you get a [`BoxConstraints`](https://api.flutter.dev/flutter/rendering/BoxConstraints-class.html) object. Examine the constraint’s properties to decide what to display. For example, if your [`maxWidth`](https://api.flutter.dev/flutter/rendering/BoxConstraints/maxWidth.html) is greater than your width breakpoint, return a [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) object with a row that has a list on the left. If it’s narrower, return a [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) object with a drawer containing that list. You can also adjust your display based on the device’s height, the aspect ratio, or some other property. When the constraints change (for example, the user rotates the phone, or puts your app into a tile UI on Android), the build function runs.

**Use the [`MediaQuery.of()`](https://api.flutter.dev/flutter/widgets/MediaQuery/of.html) method in your build functions**

This gives you the size, orientation, etc, of your current app. This is more useful if you want to make decisions based on the complete context rather than on just the size of your particular widget. Again, if you use this, then your build function automatically runs if the user somehow changes the app’s size.

Other useful widgets and classes for creating a responsive UI:

-   [`AspectRatio`](https://api.flutter.dev/flutter/widgets/AspectRatio-class.html)
-   [`CustomSingleChildLayout`](https://api.flutter.dev/flutter/widgets/CustomSingleChildLayout-class.html)
-   [`CustomMultiChildLayout`](https://api.flutter.dev/flutter/widgets/CustomMultiChildLayout-class.html)
-   [`FittedBox`](https://api.flutter.dev/flutter/widgets/FittedBox-class.html)
-   [`FractionallySizedBox`](https://api.flutter.dev/flutter/widgets/FractionallySizedBox-class.html)
-   [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
-   [`MediaQuery`](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html)
-   [`MediaQueryData`](https://api.flutter.dev/flutter/widgets/MediaQueryData-class.html)
-   [`OrientationBuilder`](https://api.flutter.dev/flutter/widgets/OrientationBuilder-class.html)

### Other resources

For more information, here are a few resources, including contributions from the Flutter community:

-   [Developing for Multiple Screen Sizes and Orientations in Flutter](https://medium.com/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434) by Deven Joshi
-   [Build Responsive UIs in Flutter](https://medium.com/flutter-community/build-responsive-uis-in-flutter-fd450bd59158) by Raouf Rahiche
-   [Making Cross-platform Flutter Landing Page Responsive](https://medium.com/flutter-community/making-cross-platform-flutter-landing-page-responsive-7fffe0655970) by Priyanka Tyagi
-   [How to make flutter app responsive according to different screen size?](https://stackoverflow.com/questions/49704497/how-to-make-flutter-app-responsive-according-to-different-screen-size), a question on StackOverflow

## Creating an adaptive Flutter app

Learn more about creating an adaptive Flutter app with [Building adaptive apps](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps), written by the gskinner team.

You might also check out the following episodes of The Boring Show:

<iframe width="560" height="315" src="https://www.youtube.com/embed/n6Awpg1MO6M?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Adaptive Layouts (The Boring Flutter Development Show, Ep. 45)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="621729186" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

[Adaptive layouts](https://www.youtube.com/watch?v=n6Awpg1MO6M&t=694s)

<iframe width="560" height="315" src="https://www.youtube.com/embed/eikOZzfc0l4?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Adaptive Layouts part 2 (The Boring Flutter Development Show, Ep. 46)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="748938853" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

[Adaptive layouts, part 2](https://www.youtube.com/watch?v=eikOZzfc0l4&t=11s)

For an excellent example of an adaptive app, check out Flutter Folio, a scrapbooking app created in collaboration with gskinner and the Flutter team:

<iframe width="560" height="315" src="https://www.youtube.com/embed/yytBENOnF0w?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Flutter Folio walkthrough" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="99187759" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

The [Folio source code](https://github.com/gskinnerTeam/flutter-folio) is also available on GitHub. Learn more on the [gskinner blog](https://blog.gskinner.com/).

### Other resources

You can learn more about creating platform adaptive apps in the following resources:

-   [Platform-specific behaviors and adaptations](https://docs.flutter.dev/platform-integration/platform-adaptations), a page on this site.
-   [Designing truly adaptive user interfaces](https://www.aloisdeniel.com/blog/designing-truly-adaptative-user-interfaces) a blog post and video by Aloïs Deniel, presented at the Flutter Vikings 2020 conference.
-   The [Flutter gallery app](https://gallery.flutter.dev/) ([repo](https://github.com/flutter/gallery)) has been written as an adaptive app.