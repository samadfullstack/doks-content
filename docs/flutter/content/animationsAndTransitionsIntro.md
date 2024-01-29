1.  [UI](https://docs.flutter.dev/ui)
2.  [Animations](https://docs.flutter.dev/ui/animations)

Well-designed animations make a UI feel more intuitive, contribute to the slick look and feel of a polished app, and improve the user experience. Flutter’s animation support makes it easy to implement a variety of animation types. Many widgets, especially [Material widgets](https://docs.flutter.dev/ui/widgets/material), come with the standard motion effects defined in their design spec, but it’s also possible to customize these effects.

## Choosing an approach

There are different approaches you can take when creating animations in Flutter. Which approach is right for you? To help you decide, check out the video, [How to choose which Flutter Animation Widget is right for you?](https://www.youtube.com/watch?v=GXIJJkq_H8g) (Also published as a [_companion article_](https://medium.com/flutter/how-to-choose-which-flutter-animation-widget-is-right-for-you-79ecfb7e72b5).)

<iframe width="560" height="315" src="https://www.youtube.com/embed/GXIJJkq_H8g?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="How to choose which Flutter Animation Widget is right for you? - Flutter in Focus" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" id="68106241" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

(To dive deeper into the decision process, watch the [Animations in Flutter done right](https://www.youtube.com/watch?v=wnARLByOtKA&t=3s) video, presented at Flutter Europe.)

As shown in the video, the following decision tree helps you decide what approach to use when implementing a Flutter animation:

![The animation decision tree](https://docs.flutter.dev/assets/images/docs/ui/animations/animation-decision-tree.png)

If a pre-packaged implicit animation (the easiest animation to implement) suits your needs, watch [Animation basics with implicit animations](https://www.youtube.com/watch?v=IVTjpW3W33s&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=1). (Also published as a [_companion article_](https://medium.com/flutter/flutter-animation-basics-with-implicit-animations-95db481c5916).)

<iframe width="560" height="315" src="https://www.youtube.com/embed/IVTjpW3W33s?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Animation Basics with Implicit Animations" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="137881297" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

[Learn about Animation Basics with Implicit Animations](https://www.youtube.com/watch/IVTjpW3W33s)

To create a custom implicit animation, watch [Creating your own custom implicit animations with TweenAnimationBuilder](https://www.youtube.com/watch?v=6KiPEqzJIKQ&feature=youtu.be). (Also published as a [_companion article_](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185).)

<iframe width="560" height="315" src="https://www.youtube.com/embed/6KiPEqzJIKQ?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Creating your own Custom Implicit Animations with TweenAnimationBuilder" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="459586177" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

[Learn about building Custom Implicit Animations with TweenAnimationBuilder](https://www.youtube.com/watch/6KiPEqzJIKQ)

To create an explicit animation (where you control the animation, rather than letting the framework control it), perhaps you can use one of the built-in explicit animations classes. For more information, watch [Making your first directional animations with built-in explicit animations](https://www.youtube.com/watch?v=CunyH6unILQ&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=3). (Also published as a [_companion article_](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7).)

<iframe width="560" height="315" src="https://www.youtube.com/embed/CunyH6unILQ?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Making Your First Directional Animations with Built-in Explicit Animations" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="254524957" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

If you need to build an explicit animation from scratch, watch [Creating custom explicit animations with AnimatedBuilder and AnimatedWidget](https://www.youtube.com/watch?v=fneC7t4R_B0&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=4). (Also published as a [_companion article_](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8).)

<iframe width="560" height="315" src="https://www.youtube.com/embed/fneC7t4R_B0?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn about building Custom Explicit Animations with the AnimatedBuilder and AnimatedWidget Flutter Widgets" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="788492082" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

For a deeper understanding of just how animations work in Flutter, watch [Animation deep dive](https://www.youtube.com/watch?v=PbcILiN8rbo&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=5). (Also published as a [_companion article_](https://medium.com/flutter/animation-deep-dive-39d3ffea111f).)

<iframe width="560" height="315" src="https://www.youtube.com/embed/PbcILiN8rbo?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Take a deep dive into Flutter animation" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="71395708" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

## Codelabs, tutorials, and articles

The following resources are a good place to start learning the Flutter animation framework. Each of these documents shows how to write animation code.

-   [Implicit animations codelab](https://docs.flutter.dev/codelabs/implicit-animations)  
    Covers how to use implicit animations using step-by-step instructions and interactive examples.
    
-   [Animations tutorial](https://docs.flutter.dev/ui/animations/tutorial)  
    Explains the fundamental classes in the Flutter animation package (controllers, `Animatable`, curves, listeners, builders), as it guides you through a progression of tween animations using different aspects of the animation APIs. This tutorial shows how to create your own custom explicit animations.
    
-   [Zero to One with Flutter, part 1](https://medium.com/dartlang/zero-to-one-with-flutter-43b13fd7b354) and [part 2](https://medium.com/dartlang/zero-to-one-with-flutter-part-two-5aa2f06655cb)  
    Medium articles showing how to create an animated chart using tweening.
    
-   [Write your first Flutter app on the web](https://docs.flutter.dev/get-started/codelab-web)  
    Codelab demonstrating how to create a form that uses animation to show the user’s progress as they fill in the fields.
    

## Animation types

Generally, animations are either tween- or physics-based. The following sections explain what these terms mean, and point you to resources where you can learn more.

### Tween animation

Short for _in-betweening_. In a tween animation, the beginning and ending points are defined, as well as a timeline, and a curve that defines the timing and speed of the transition. The framework calculates how to transition from the beginning point to the end point.

The documents listed above, such as the [Animations tutorial](https://docs.flutter.dev/ui/animations/tutorial), are not specifically about tweening, but they use tweens in their examples.

### Physics-based animation

In physics-based animation, motion is modeled to resemble real-world behavior. When you toss a ball, for example, where and when it lands depends on how fast it was tossed and how far it was from the ground. Similarly, dropping a ball attached to a spring falls (and bounces) differently than dropping a ball attached to a string.

-   [Animate a widget using a physics simulation](https://docs.flutter.dev/cookbook/animation/physics-simulation)  
    A recipe in the animations section of the Flutter cookbook.
    
-   [Flutter Gallery](https://github.com/flutter/gallery)  
    Under **Material Components**, the [`Grid`](https://github.com/flutter/gallery/blob/main/lib/demos/material/grid_list_demo.dart) example demonstrates a fling animation. Select one of the images from the grid and zoom in. You can pan the image with flinging or dragging gestures.
    
-   Also see the API documentation for [`AnimationController.animateWith`](https://api.flutter.dev/flutter/animation/AnimationController/animateWith.html) and [`SpringSimulation`](https://api.flutter.dev/flutter/physics/SpringSimulation-class.html).
    

## Pre-canned animations

If you are using Material widgets, you might check out the [animations package](https://pub.dev/packages/animations) available on pub.dev. This package contains pre-built animations for the following commonly used patterns: `Container` transforms, shared axis transitions, fade through transitions, and fade transitions.

## Common animation patterns

Most UX or motion designers find that certain animation patterns are used repeatedly when designing a UI. This section lists some of the commonly used animation patterns, and tells you where to learn more.

### Animated list or grid

This pattern involves animating the addition or removal of elements from a list or grid.

-   [`AnimatedList` example](https://flutter.github.io/samples/animations.html)  
    This demo, from the [Sample app catalog](https://flutter.github.io/samples), shows how to animate adding an element to a list, or removing a selected element. The internal Dart list is synced as the user modifies the list using the plus (+) and minus (-) buttons.

### Shared element transition

In this pattern, the user selects an element—often an image—from the page, and the UI animates the selected element to a new page with more detail. In Flutter, you can easily implement shared element transitions between routes (pages) using the `Hero` widget.

-   [Hero animations](https://docs.flutter.dev/ui/animations/hero-animations) How to create two styles of Hero animations:
    -   The hero flies from one page to another while changing position and size.
    -   The hero’s boundary changes shape, from a circle to a square, as its flies from one page to another.
-   [Flutter Gallery](https://github.com/flutter/gallery)  
    You can build the Gallery app yourself, or download it from the Play Store. The [Shrine](https://github.com/flutter/gallery/tree/main/lib/studies/shrine) demo includes an example of a hero animation.
    
-   Also see the API documentation for the [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html), [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html), and [`PageRoute`](https://api.flutter.dev/flutter/widgets/PageRoute-class.html) classes.

### Staggered animation

Animations that are broken into smaller motions, where some of the motion is delayed. The smaller animations might be sequential, or might partially or completely overlap.

-   [Staggered Animations](https://docs.flutter.dev/ui/animations/staggered-animations)

## Other resources

Learn more about Flutter animations at the following links:

-   [Animation samples](https://github.com/flutter/samples/tree/main/animations#animation-samples) from the [Sample app catalog](https://flutter.github.io/samples).
    
-   [Animation recipes](https://docs.flutter.dev/cookbook/animation) from the Flutter cookbook.
    
-   [Animation videos](https://www.youtube.com/@flutterdev/search?query=animation) from the Flutter YouTube channel.
    
-   [Animations: overview](https://docs.flutter.dev/ui/animations/overview)  
    A look at some of the major classes in the animations library, and Flutter’s animation architecture.
    
-   [Animation and motion widgets](https://docs.flutter.dev/ui/widgets/animation)  
    A catalog of some of the animation widgets provided in the Flutter APIs.
    
-   The [animation library](https://api.flutter.dev/flutter/animation/animation-library.html) in the [Flutter API documentation](https://api.flutter.dev/)  
    The animation API for the Flutter framework. This link takes you to a technical overview page for the library.