1.  [UI](https://docs.flutter.dev/ui)
2.  [Layout](https://docs.flutter.dev/ui/layout)
3.  [Scrolling](https://docs.flutter.dev/ui/layout/scrolling)

Flutter has many built-in widgets that automatically scroll and also offers a variety of widgets that you can customize to create specific scrolling behavior.

Many Flutter widgets support scrolling out of the box and do most of the work for you. For example, [`SingleChildScrollView`](https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html) automatically scrolls its child when necessary. Other useful widgets include [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) and [`GridView`](https://api.flutter.dev/flutter/widgets/GridView-class.html). You can check out more of these widgets on the [scrolling page](https://docs.flutter.dev/ui/widgets/scrolling) of the Widget catalog.

<iframe width="560" height="315" src="https://www.youtube.com/embed/DbkIQSvwnZc?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to use the Scrollbar Flutter Widget" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" id="797984" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe><iframe width="560" height="315" src="https://www.youtube.com/embed/KJpkjHGiI5A?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to use the ListView Flutter Widget" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="354160477" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

### Infinite scrolling

When you have a long list of items in your `ListView` or `GridView` (including an _infinite_ list), you can build the items on demand as they scroll into view. This provides a much more performant scrolling experience. For more information, check out [`ListView.builder`](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html) or [`GridView.builder`](https://api.flutter.dev/flutter/widgets/GridView/GridView.builder.html).

### Specialized scrollable widgets

The following widgets provide more specific scrolling behavior.

A video on using [`DraggableScrollableSheet`](https://api.flutter.dev/flutter/widgets/DraggableScrollableSheet-class.html)

<iframe width="560" height="315" src="https://www.youtube.com/embed/Hgw819mL_78?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to use the DraggableScrollableSheet Flutter Widget" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="700030912" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

Turn the scrollable area into a wheel! [`ListWheelScrollView`](https://api.flutter.dev/flutter/widgets/ListWheelScrollView-class.html)

<iframe width="560" height="315" src="https://www.youtube.com/embed/dUhmWAz4C7Y?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to use the ListWheelScrollView Flutter Widget" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="577184138" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

Perhaps you want to implement _elastic_ scrolling, also called _scroll bouncing_. Or maybe you want to implement other dynamic scrolling effects, like parallax scrolling. Or perhaps you want a scrolling header with very specific behavior, such as shrinking or disappearing.

You can achieve all this and more using the Flutter `Sliver*` classes. A _sliver_ refers to a piece of the scrollable area. You can define and insert a sliver into a [`CustomScrollView`](https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html) to have finer-grained control over that area.

For more information, check out [Using slivers to achieve fancy scrolling](https://docs.flutter.dev/ui/layout/scrolling/slivers) and the [Sliver classes](https://docs.flutter.dev/ui/widgets/layout#Sliver%20widgets).

How do you nest a scrolling widget inside another scrolling widget without hurting scrolling performance? Do you set the `ShrinkWrap` property to true, or do you use a sliver?

Check out the “ShrinkWrap vs Slivers” video:

<iframe width="560" height="315" src="https://www.youtube.com/embed/LUqDNnv_dh0?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how to nest scrolling widgets in Flutter" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="727415991" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>