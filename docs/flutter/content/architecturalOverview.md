This article is intended to provide a high-level overview of the architecture of Flutter, including the core principles and concepts that form its design.

Flutter is a cross-platform UI toolkit that is designed to allow code reuse across operating systems such as iOS and Android, while also allowing applications to interface directly with underlying platform services. The goal is to enable developers to deliver high-performance apps that feel natural on different platforms, embracing differences where they exist while sharing as much code as possible.

During development, Flutter apps run in a VM that offers stateful hot reload of changes without needing a full recompile. For release, Flutter apps are compiled directly to machine code, whether Intel x64 or ARM instructions, or to JavaScript if targeting the web. The framework is open source, with a permissive BSD license, and has a thriving ecosystem of third-party packages that supplement the core library functionality.

This overview is divided into a number of sections:

1.  The **layer model**: The pieces from which Flutter is constructed.
2.  **Reactive user interfaces**: A core concept for Flutter user interface development.
3.  An introduction to **widgets**: The fundamental building blocks of Flutter user interfaces.
4.  The **rendering process**: How Flutter turns UI code into pixels.
5.  An overview of the **platform embedders**: The code that lets mobile and desktop OSes execute Flutter apps.
6.  **Integrating Flutter with other code**: Information about different techniques available to Flutter apps.
7.  **Support for the web**: Concluding remarks about the characteristics of Flutter in a browser environment.

## Architectural layers

Flutter is designed as an extensible, layered system. It exists as a series of independent libraries that each depend on the underlying layer. No layer has privileged access to the layer below, and every part of the framework level is designed to be optional and replaceable.

![Architectural
diagram](https://docs.flutter.dev/assets/images/docs/arch-overview/archdiagram.png)

To the underlying operating system, Flutter applications are packaged in the same way as any other native application. A platform-specific embedder provides an entrypoint; coordinates with the underlying operating system for access to services like rendering surfaces, accessibility, and input; and manages the message event loop. The embedder is written in a language that is appropriate for the platform: currently Java and C++ for Android, Objective-C/Objective-C++ for iOS and macOS, and C++ for Windows and Linux. Using the embedder, Flutter code can be integrated into an existing application as a module, or the code may be the entire content of the application. Flutter includes a number of embedders for common target platforms, but [other embedders also exist](https://hover.build/blog/one-year-in/).

At the core of Flutter is the **Flutter engine**, which is mostly written in C++ and supports the primitives necessary to support all Flutter applications. The engine is responsible for rasterizing composited scenes whenever a new frame needs to be painted. It provides the low-level implementation of Flutter’s core API, including graphics (through [Impeller](https://docs.flutter.dev/perf/impeller) on iOS and coming to Android, and [Skia](https://skia.org/) on other platforms) text layout, file and network I/O, accessibility support, plugin architecture, and a Dart runtime and compile toolchain.

The engine is exposed to the Flutter framework through [`dart:ui`](https://github.com/flutter/engine/tree/main/lib/ui), which wraps the underlying C++ code in Dart classes. This library exposes the lowest-level primitives, such as classes for driving input, graphics, and text rendering subsystems.

Typically, developers interact with Flutter through the **Flutter framework**, which provides a modern, reactive framework written in the Dart language. It includes a rich set of platform, layout, and foundational libraries, composed of a series of layers. Working from the bottom to the top, we have:

-   Basic **[foundational](https://api.flutter.dev/flutter/foundation/foundation-library.html)** classes, and building block services such as **[animation](https://api.flutter.dev/flutter/animation/animation-library.html), [painting](https://api.flutter.dev/flutter/painting/painting-library.html), and [gestures](https://api.flutter.dev/flutter/gestures/gestures-library.html)** that offer commonly used abstractions over the underlying foundation.
-   The **[rendering layer](https://api.flutter.dev/flutter/rendering/rendering-library.html)** provides an abstraction for dealing with layout. With this layer, you can build a tree of renderable objects. You can manipulate these objects dynamically, with the tree automatically updating the layout to reflect your changes.
-   The **[widgets layer](https://api.flutter.dev/flutter/widgets/widgets-library.html)** is a composition abstraction. Each render object in the rendering layer has a corresponding class in the widgets layer. In addition, the widgets layer allows you to define combinations of classes that you can reuse. This is the layer at which the reactive programming model is introduced.
-   The **[Material](https://api.flutter.dev/flutter/material/material-library.html)** and **[Cupertino](https://api.flutter.dev/flutter/cupertino/cupertino-library.html)** libraries offer comprehensive sets of controls that use the widget layer’s composition primitives to implement the Material or iOS design languages.

The Flutter framework is relatively small; many higher-level features that developers might use are implemented as packages, including platform plugins like [camera](https://pub.dev/packages/camera) and [webview](https://pub.dev/packages/webview_flutter), as well as platform-agnostic features like [characters](https://pub.dev/packages/characters), [http](https://pub.dev/packages/http), and [animations](https://pub.dev/packages/animations) that build upon the core Dart and Flutter libraries. Some of these packages come from the broader ecosystem, covering services like [in-app payments](https://pub.dev/packages/square_in_app_payments), [Apple authentication](https://pub.dev/packages/sign_in_with_apple), and [animations](https://pub.dev/packages/lottie).

The rest of this overview broadly navigates down the layers, starting with the reactive paradigm of UI development. Then, we describe how widgets are composed together and converted into objects that can be rendered as part of an application. We describe how Flutter interoperates with other code at a platform level, before giving a brief summary of how Flutter’s web support differs from other targets.

## Anatomy of an app

The following diagram gives an overview of the pieces that make up a regular Flutter app generated by `flutter create`. It shows where the Flutter Engine sits in this stack, highlights API boundaries, and identifies the repositories where the individual pieces live. The legend below clarifies some of the terminology commonly used to describe the pieces of a Flutter app.

![The layers of a Flutter app created by "flutter create": Dart app, framework, engine, embedder, runner](https://docs.flutter.dev/assets/images/docs/app-anatomy.svg)

**Dart App**

-   Composes widgets into the desired UI.
-   Implements business logic.
-   Owned by app developer.

**Framework** ([source code](https://github.com/flutter/flutter/tree/main/packages/flutter/lib))

-   Provides higher-level API to build high-quality apps (for example, widgets, hit-testing, gesture detection, accessibility, text input).
-   Composites the app’s widget tree into a scene.

**Engine** ([source code](https://github.com/flutter/engine/tree/main/shell/common))

-   Responsible for rasterizing composited scenes.
-   Provides low-level implementation of Flutter’s core APIs (for example, graphics, text layout, Dart runtime).
-   Exposes its functionality to the framework using the **dart:ui API**.
-   Integrates with a specific platform using the Engine’s **Embedder API**.

**Embedder** ([source code](https://github.com/flutter/engine/tree/main/shell/platform))

-   Coordinates with the underlying operating system for access to services like rendering surfaces, accessibility, and input.
-   Manages the event loop.
-   Exposes **platform-specific API** to integrate the Embedder into apps.

**Runner**

-   Composes the pieces exposed by the platform-specific API of the Embedder into an app package runnable on the target platform.
-   Part of app template generated by `flutter create`, owned by app developer.

## Reactive user interfaces

On the surface, Flutter is [a reactive, declarative UI framework](https://docs.flutter.dev/resources/faq#what-programming-paradigm-does-flutters-framework-use), in which the developer provides a mapping from application state to interface state, and the framework takes on the task of updating the interface at runtime when the application state changes. This model is inspired by [work that came from Facebook for their own React framework](https://www.youtube.com/watch?time_continue=2&v=x7cQ3mrcKaY&feature=emb_logo), which includes a rethinking of many traditional design principles.

In most traditional UI frameworks, the user interface’s initial state is described once and then separately updated by user code at runtime, in response to events. One challenge of this approach is that, as the application grows in complexity, the developer needs to be aware of how state changes cascade throughout the entire UI. For example, consider the following UI:

![Color picker dialog](https://docs.flutter.dev/assets/images/docs/arch-overview/color-picker.png)

There are many places where the state can be changed: the color box, the hue slider, the radio buttons. As the user interacts with the UI, changes must be reflected in every other place. Worse, unless care is taken, a minor change to one part of the user interface can cause ripple effects to seemingly unrelated pieces of code.

One solution to this is an approach like MVC, where you push data changes to the model via the controller, and then the model pushes the new state to the view via the controller. However, this also is problematic, since creating and updating UI elements are two separate steps that can easily get out of sync.

Flutter, along with other reactive frameworks, takes an alternative approach to this problem, by explicitly decoupling the user interface from its underlying state. With React-style APIs, you only create the UI description, and the framework takes care of using that one configuration to both create and/or update the user interface as appropriate.

In Flutter, widgets (akin to components in React) are represented by immutable classes that are used to configure a tree of objects. These widgets are used to manage a separate tree of objects for layout, which is then used to manage a separate tree of objects for compositing. Flutter is, at its core, a series of mechanisms for efficiently walking the modified parts of trees, converting trees of objects into lower-level trees of objects, and propagating changes across these trees.

A widget declares its user interface by overriding the `build()` method, which is a function that converts state to UI:

The `build()` method is by design fast to execute and should be free of side effects, allowing it to be called by the framework whenever needed (potentially as often as once per rendered frame).

This approach relies on certain characteristics of a language runtime (in particular, fast object instantiation and deletion). Fortunately, [Dart is particularly well suited for this task](https://medium.com/flutter/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30).

As mentioned, Flutter emphasizes widgets as a unit of composition. Widgets are the building blocks of a Flutter app’s user interface, and each widget is an immutable declaration of part of the user interface.

Widgets form a hierarchy based on composition. Each widget nests inside its parent and can receive context from the parent. This structure carries all the way up to the root widget (the container that hosts the Flutter app, typically `MaterialApp` or `CupertinoApp`), as this trivial example shows:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/services.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'My Home Page'</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Builder</span><span>(</span><span>
            builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>{</span><span>
              </span><span>return</span><span> </span><span>Column</span><span>(</span><span>
                children</span><span>:</span><span> </span><span>[</span><span>
                  </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Hello World'</span><span>),</span><span>
                  </span><span>const</span><span> </span><span>SizedBox</span><span>(</span><span>height</span><span>:</span><span> </span><span>20</span><span>),</span><span>
                  </span><span>ElevatedButton</span><span>(</span><span>
                    onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
                      print</span><span>(</span><span>'Click!'</span><span>);</span><span>
                    </span><span>},</span><span>
                    child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'A button'</span><span>),</span><span>
                  </span><span>),</span><span>
                </span><span>],</span><span>
              </span><span>);</span><span>
            </span><span>},</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

In the preceding code, all instantiated classes are widgets.

Apps update their user interface in response to events (such as a user interaction) by telling the framework to replace a widget in the hierarchy with another widget. The framework then compares the new and old widgets, and efficiently updates the user interface.

Flutter has its own implementations of each UI control, rather than deferring to those provided by the system: for example, there is a pure [Dart implementation](https://api.flutter.dev/flutter/cupertino/CupertinoSwitch-class.html) of both the [iOS Toggle control](https://developer.apple.com/design/human-interface-guidelines/toggles) and the [one for](https://api.flutter.dev/flutter/material/Switch-class.html) the [Android equivalent](https://m3.material.io/components/switch).

This approach provides several benefits:

-   Provides for unlimited extensibility. A developer who wants a variant of the Switch control can create one in any arbitrary way, and is not limited to the extension points provided by the OS.
-   Avoids a significant performance bottleneck by allowing Flutter to composite the entire scene at once, without transitioning back and forth between Flutter code and platform code.
-   Decouples the application behavior from any operating system dependencies. The application looks and feels the same on all versions of the OS, even if the OS changed the implementations of its controls.

### Composition

Widgets are typically composed of many other small, single-purpose widgets that combine to produce powerful effects.

Where possible, the number of design concepts is kept to a minimum while allowing the total vocabulary to be large. For example, in the widgets layer, Flutter uses the same core concept (a `Widget`) to represent drawing to the screen, layout (positioning and sizing), user interactivity, state management, theming, animations, and navigation. In the animation layer, a pair of concepts, `Animation`s and `Tween`s, cover most of the design space. In the rendering layer, `RenderObject`s are used to describe layout, painting, hit testing, and accessibility. In each of these cases, the corresponding vocabulary ends up being large: there are hundreds of widgets and render objects, and dozens of animation and tween types.

The class hierarchy is deliberately shallow and broad to maximize the possible number of combinations, focusing on small, composable widgets that each do one thing well. Core features are abstract, with even basic features like padding and alignment being implemented as separate components rather than being built into the core. (This also contrasts with more traditional APIs where features like padding are built in to the common core of every layout component.) So, for example, to center a widget, rather than adjusting a notional `Align` property, you wrap it in a [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html) widget.

There are widgets for padding, alignment, rows, columns, and grids. These layout widgets do not have a visual representation of their own. Instead, their sole purpose is to control some aspect of another widget’s layout. Flutter also includes utility widgets that take advantage of this compositional approach.

For example, [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html), a commonly used widget, is made up of several widgets responsible for layout, painting, positioning, and sizing. Specifically, Container is made up of the [`LimitedBox`](https://api.flutter.dev/flutter/widgets/LimitedBox-class.html), [`ConstrainedBox`](https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html), [`Align`](https://api.flutter.dev/flutter/widgets/Align-class.html), [`Padding`](https://api.flutter.dev/flutter/widgets/Padding-class.html), [`DecoratedBox`](https://api.flutter.dev/flutter/widgets/DecoratedBox-class.html), and [`Transform`](https://api.flutter.dev/flutter/widgets/Transform-class.html) widgets, as you can see by reading its source code. A defining characteristic of Flutter is that you can drill down into the source for any widget and examine it. So, rather than subclassing `Container` to produce a customized effect, you can compose it and other widgets in novel ways, or just create a new widget using `Container` as inspiration.

### Building widgets

As mentioned earlier, you determine the visual representation of a widget by overriding the [`build()`](https://api.flutter.dev/flutter/widgets/StatelessWidget/build.html) function to return a new element tree. This tree represents the widget’s part of the user interface in more concrete terms. For example, a toolbar widget might have a build function that returns a [horizontal layout](https://api.flutter.dev/flutter/widgets/Row-class.html) of some [text](https://api.flutter.dev/flutter/widgets/Text-class.html) and [various](https://api.flutter.dev/flutter/material/IconButton-class.html) [buttons](https://api.flutter.dev/flutter/material/PopupMenuButton-class.html). As needed, the framework recursively asks each widget to build until the tree is entirely described by [concrete renderable objects](https://api.flutter.dev/flutter/widgets/RenderObjectWidget-class.html). The framework then stitches together the renderable objects into a renderable object tree.

A widget’s build function should be free of side effects. Whenever the function is asked to build, the widget should return a new tree of widgets<sup><a href="https://docs.flutter.dev/resources/architectural-overview#a1">1</a></sup>, regardless of what the widget previously returned. The framework does the heavy lifting work to determine which build methods need to be called based on the render object tree (described in more detail later). More information about this process can be found in the [Inside Flutter topic](https://docs.flutter.dev/resources/inside-flutter#linear-reconciliation).

On each rendered frame, Flutter can recreate just the parts of the UI where the state has changed by calling that widget’s `build()` method. Therefore it is important that build methods should return quickly, and heavy computational work should be done in some asynchronous manner and then stored as part of the state to be used by a build method.

While relatively naïve in approach, this automated comparison is quite effective, enabling high-performance, interactive apps. And, the design of the build function simplifies your code by focusing on declaring what a widget is made of, rather than the complexities of updating the user interface from one state to another.

### Widget state

The framework introduces two major classes of widget: _stateful_ and _stateless_ widgets.

Many widgets have no mutable state: they don’t have any properties that change over time (for example, an icon or a label). These widgets subclass [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html).

However, if the unique characteristics of a widget need to change based on user interaction or other factors, that widget is _stateful_. For example, if a widget has a counter that increments whenever the user taps a button, then the value of the counter is the state for that widget. When that value changes, the widget needs to be rebuilt to update its part of the UI. These widgets subclass [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html), and (because the widget itself is immutable) they store mutable state in a separate class that subclasses [`State`](https://api.flutter.dev/flutter/widgets/State-class.html). `StatefulWidget`s don’t have a build method; instead, their user interface is built through their `State` object.

Whenever you mutate a `State` object (for example, by incrementing the counter), you must call [`setState()`](https://api.flutter.dev/flutter/widgets/State/setState.html) to signal the framework to update the user interface by calling the `State`’s build method again.

Having separate state and widget objects lets other widgets treat both stateless and stateful widgets in exactly the same way, without being concerned about losing state. Instead of needing to hold on to a child to preserve its state, the parent can create a new instance of the child at any time without losing the child’s persistent state. The framework does all the work of finding and reusing existing state objects when appropriate.

### State management

So, if many widgets can contain state, how is state managed and passed around the system?

As with any other class, you can use a constructor in a widget to initialize its data, so a `build()` method can ensure that any child widget is instantiated with the data it needs:

```
<span>@override</span>
<span>Widget</span> <span>build</span><span>(</span><span>BuildContext</span> <span>context</span><span>)</span> <span>{</span>
   <span>return</span> <span>ContentWidget</span><span>(</span><span>importantState</span><span>);</span>
<span>}</span>
```

As widget trees get deeper, however, passing state information up and down the tree hierarchy becomes cumbersome. So, a third widget type, [`InheritedWidget`](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html), provides an easy way to grab data from a shared ancestor. You can use `InheritedWidget` to create a state widget that wraps a common ancestor in the widget tree, as shown in this example:

![Inherited widgets](https://docs.flutter.dev/assets/images/docs/arch-overview/inherited-widget.png)

Whenever one of the `ExamWidget` or `GradeWidget` objects needs data from `StudentState`, it can now access it with a command such as:

```
<span>final</span> <span>studentState</span> <span>=</span> <span>StudentState</span><span>.</span><span>of</span><span>(</span><span>context</span><span>);</span>
```

The `of(context)` call takes the build context (a handle to the current widget location), and returns [the nearest ancestor in the tree](https://api.flutter.dev/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html) that matches the `StudentState` type. `InheritedWidget`s also offer an `updateShouldNotify()` method, which Flutter calls to determine whether a state change should trigger a rebuild of child widgets that use it.

Flutter itself uses `InheritedWidget` extensively as part of the framework for shared state, such as the application’s _visual theme_, which includes [properties like color and type styles](https://api.flutter.dev/flutter/material/ThemeData-class.html) that are pervasive throughout an application. The `MaterialApp` `build()` method inserts a theme in the tree when it builds, and then deeper in the hierarchy a widget can use the `.of()` method to look up the relevant theme data, for example:

```
<span>Container</span><span>(</span><span>
  color</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>secondaryHeaderColor</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
    </span><span>'Text with a background color'</span><span>,</span><span>
    style</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>textTheme</span><span>.</span><span>titleLarge</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

This approach is also used for [Navigator](https://api.flutter.dev/flutter/widgets/Navigator-class.html), which provides page routing; and [MediaQuery](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html), which provides access to screen metrics such as orientation, dimensions, and brightness.

As applications grow, more advanced state management approaches that reduce the ceremony of creating and using stateful widgets become more attractive. Many Flutter apps use utility packages like [provider](https://pub.dev/packages/provider), which provides a wrapper around `InheritedWidget`. Flutter’s layered architecture also enables alternative approaches to implement the transformation of state into UI, such as the [flutter\_hooks](https://pub.dev/packages/flutter_hooks) package.

## Rendering and layout

This section describes the rendering pipeline, which is the series of steps that Flutter takes to convert a hierarchy of widgets into the actual pixels painted onto a screen.

### Flutter’s rendering model

You may be wondering: if Flutter is a cross-platform framework, then how can it offer comparable performance to single-platform frameworks?

It’s useful to start by thinking about how traditional Android apps work. When drawing, you first call the Java code of the Android framework. The Android system libraries provide the components responsible for drawing themselves to a `Canvas` object, which Android can then render with [Skia](https://skia.org/), a graphics engine written in C/C++ that calls the CPU or GPU to complete the drawing on the device.

Cross-platform frameworks _typically_ work by creating an abstraction layer over the underlying native Android and iOS UI libraries, attempting to smooth out the inconsistencies of each platform representation. App code is often written in an interpreted language like JavaScript, which must in turn interact with the Java-based Android or Objective-C-based iOS system libraries to display UI. All this adds overhead that can be significant, particularly where there is a lot of interaction between the UI and the app logic.

By contrast, Flutter minimizes those abstractions, bypassing the system UI widget libraries in favor of its own widget set. The Dart code that paints Flutter’s visuals is compiled into native code, which uses Skia (or, in future, Impeller) for rendering. Flutter also embeds its own copy of Skia as part of the engine, allowing the developer to upgrade their app to stay updated with the latest performance improvements even if the phone hasn’t been updated with a new Android version. The same is true for Flutter on other native platforms, such as Windows or macOS.

### From user input to the GPU

The overriding principle that Flutter applies to its rendering pipeline is that **simple is fast**. Flutter has a straightforward pipeline for how data flows to the system, as shown in the following sequencing diagram:

![Render pipeline sequencing
diagram](https://docs.flutter.dev/assets/images/docs/arch-overview/render-pipeline.png)

Let’s take a look at some of these phases in greater detail.

### Build: from Widget to Element

Consider this code fragment that demonstrates a widget hierarchy:

```
<span>Container</span><span>(</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>,</span><span>
  child</span><span>:</span><span> </span><span>Row</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      </span><span>Image</span><span>.</span><span>network</span><span>(</span><span>'https://www.example.com/1.png'</span><span>),</span><span>
      </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'A'</span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

When Flutter needs to render this fragment, it calls the `build()` method, which returns a subtree of widgets that renders UI based on the current app state. During this process, the `build()` method can introduce new widgets, as necessary, based on its state. As an example, in the preceding code fragment, `Container` has `color` and `child` properties. From looking at the [source code](https://github.com/flutter/flutter/blob/02efffc134ab4ce4ff50a9ddd86c832efdb80462/packages/flutter/lib/src/widgets/container.dart#L401) for `Container`, you can see that if the color is not null, it inserts a `ColoredBox` representing the color:

```
<span>if</span> <span>(</span><span>color</span> <span>!=</span> <span>null</span><span>)</span>
  <span>current</span> <span>=</span> <span>ColoredBox</span><span>(</span><span>color:</span> <span>color</span><span>!</span><span>,</span> <span>child:</span> <span>current</span><span>);</span>
```

Correspondingly, the `Image` and `Text` widgets might insert child widgets such as `RawImage` and `RichText` during the build process. The eventual widget hierarchy may therefore be deeper than what the code represents, as in this case<sup><a href="https://docs.flutter.dev/resources/architectural-overview#a2">2</a></sup>:

![Render pipeline sequencing
diagram](https://docs.flutter.dev/assets/images/docs/arch-overview/widgets.png)

This explains why, when you examine the tree through a debug tool such as the [Flutter inspector](https://docs.flutter.dev/tools/devtools/inspector), part of the Dart DevTools, you might see a structure that is considerably deeper than what is in your original code.

During the build phase, Flutter translates the widgets expressed in code into a corresponding **element tree**, with one element for every widget. Each element represents a specific instance of a widget in a given location of the tree hierarchy. There are two basic types of elements:

-   `ComponentElement`, a host for other elements.
-   `RenderObjectElement`, an element that participates in the layout or paint phases.

![Render pipeline sequencing
diagram](https://docs.flutter.dev/assets/images/docs/arch-overview/widget-element.png)

`RenderObjectElement`s are an intermediary between their widget analog and the underlying `RenderObject`, which we’ll come to later.

The element for any widget can be referenced through its `BuildContext`, which is a handle to the location of a widget in the tree. This is the `context` in a function call such as `Theme.of(context)`, and is supplied to the `build()` method as a parameter.

Because widgets are immutable, including the parent/child relationship between nodes, any change to the widget tree (such as changing `Text('A')` to `Text('B')` in the preceding example) causes a new set of widget objects to be returned. But that doesn’t mean the underlying representation must be rebuilt. The element tree is persistent from frame to frame, and therefore plays a critical performance role, allowing Flutter to act as if the widget hierarchy is fully disposable while caching its underlying representation. By only walking through the widgets that changed, Flutter can rebuild just the parts of the element tree that require reconfiguration.

### Layout and rendering

It would be a rare application that drew only a single widget. An important part of any UI framework is therefore the ability to efficiently lay out a hierarchy of widgets, determining the size and position of each element before they are rendered on the screen.

The base class for every node in the render tree is [`RenderObject`](https://api.flutter.dev/flutter/rendering/RenderObject-class.html), which defines an abstract model for layout and painting. This is extremely general: it does not commit to a fixed number of dimensions or even a Cartesian coordinate system (demonstrated by [this example of a polar coordinate system](https://dartpad.dev/596b1d6331e3b9d7b00420085fab3e27)). Each `RenderObject` knows its parent, but knows little about its children other than how to _visit_ them and their constraints. This provides `RenderObject` with sufficient abstraction to be able to handle a variety of use cases.

During the build phase, Flutter creates or updates an object that inherits from `RenderObject` for each `RenderObjectElement` in the element tree. `RenderObject`s are primitives: [`RenderParagraph`](https://api.flutter.dev/flutter/rendering/RenderParagraph-class.html) renders text, [`RenderImage`](https://api.flutter.dev/flutter/rendering/RenderImage-class.html) renders an image, and [`RenderTransform`](https://api.flutter.dev/flutter/rendering/RenderTransform-class.html) applies a transformation before painting its child.

![Differences between the widgets hierarchy and the element and render
trees](https://docs.flutter.dev/assets/images/docs/arch-overview/trees.png)

Most Flutter widgets are rendered by an object that inherits from the `RenderBox` subclass, which represents a `RenderObject` of fixed size in a 2D Cartesian space. `RenderBox` provides the basis of a _box constraint model_, establishing a minimum and maximum width and height for each widget to be rendered.

To perform layout, Flutter walks the render tree in a depth-first traversal and **passes down size constraints** from parent to child. In determining its size, the child _must_ respect the constraints given to it by its parent. Children respond by **passing up a size** to their parent object within the constraints the parent established.

![Constraints go down, sizes go
up](https://docs.flutter.dev/assets/images/docs/arch-overview/constraints-sizes.png)

At the end of this single walk through the tree, every object has a defined size within its parent’s constraints and is ready to be painted by calling the [`paint()`](https://api.flutter.dev/flutter/rendering/RenderObject/paint.html) method.

The box constraint model is very powerful as a way to layout objects in _O(n)_ time:

-   Parents can dictate the size of a child object by setting maximum and minimum constraints to the same value. For example, the topmost render object in a phone app constrains its child to be the size of the screen. (Children can choose how to use that space. For example, they might just center what they want to render within the dictated constraints.)
-   A parent can dictate the child’s width but give the child flexibility over height (or dictate height but offer flexible over width). A real-world example is flow text, which might have to fit a horizontal constraint but vary vertically depending on the quantity of text.

This model works even when a child object needs to know how much space it has available to decide how it will render its content. By using a [`LayoutBuilder`](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html) widget, the child object can examine the passed-down constraints and use those to determine how it will use them, for example:

```
<span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>LayoutBuilder</span><span>(</span><span>
    builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> constraints</span><span>)</span><span> </span><span>{</span><span>
      </span><span>if</span><span> </span><span>(</span><span>constraints</span><span>.</span><span>maxWidth </span><span>&lt;</span><span> </span><span>600</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>const</span><span> </span><span>OneColumnLayout</span><span>();</span><span>
      </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>const</span><span> </span><span>TwoColumnLayout</span><span>();</span><span>
      </span><span>}</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

More information about the constraint and layout system, along with worked examples, can be found in the [Understanding constraints](https://docs.flutter.dev/ui/layout/constraints) topic.

The root of all `RenderObject`s is the `RenderView`, which represents the total output of the render tree. When the platform demands a new frame to be rendered (for example, because of a [vsync](https://source.android.com/devices/graphics/implement-vsync) or because a texture decompression/upload is complete), a call is made to the `compositeFrame()` method, which is part of the `RenderView` object at the root of the render tree. This creates a `SceneBuilder` to trigger an update of the scene. When the scene is complete, the `RenderView` object passes the composited scene to the `Window.render()` method in `dart:ui`, which passes control to the GPU to render it.

Further details of the composition and rasterization stages of the pipeline are beyond the scope of this high-level article, but more information can be found [in this talk on the Flutter rendering pipeline](https://www.youtube.com/watch?v=UUfXWzp0-DU).

## Platform embedding

As we’ve seen, rather than being translated into the equivalent OS widgets, Flutter user interfaces are built, laid out, composited, and painted by Flutter itself. The mechanism for obtaining the texture and participating in the app lifecycle of the underlying operating system inevitably varies depending on the unique concerns of that platform. The engine is platform-agnostic, presenting a [stable ABI (Application Binary Interface)](https://github.com/flutter/engine/blob/main/shell/platform/embedder/embedder.h) that provides a _platform embedder_ with a way to set up and use Flutter.

The platform embedder is the native OS application that hosts all Flutter content, and acts as the glue between the host operating system and Flutter. When you start a Flutter app, the embedder provides the entrypoint, initializes the Flutter engine, obtains threads for UI and rastering, and creates a texture that Flutter can write to. The embedder is also responsible for the app lifecycle, including input gestures (such as mouse, keyboard, touch), window sizing, thread management, and platform messages. Flutter includes platform embedders for Android, iOS, Windows, macOS, and Linux; you can also create a custom platform embedder, as in [this worked example](https://github.com/chinmaygarde/fluttercast) that supports remoting Flutter sessions through a VNC-style framebuffer or [this worked example for Raspberry Pi](https://github.com/ardera/flutter-pi).

Each platform has its own set of APIs and constraints. Some brief platform-specific notes:

-   On iOS and macOS, Flutter is loaded into the embedder as a `UIViewController` or `NSViewController`, respectively. The platform embedder creates a `FlutterEngine`, which serves as a host to the Dart VM and your Flutter runtime, and a `FlutterViewController`, which attaches to the `FlutterEngine` to pass UIKit or Cocoa input events into Flutter and to display frames rendered by the `FlutterEngine` using Metal or OpenGL.
-   On Android, Flutter is, by default, loaded into the embedder as an `Activity`. The view is controlled by a [`FlutterView`](https://api.flutter.dev/javadoc/io/flutter/embedding/android/FlutterView.html), which renders Flutter content either as a view or a texture, depending on the composition and z-ordering requirements of the Flutter content.
-   On Windows, Flutter is hosted in a traditional Win32 app, and content is rendered using [ANGLE](https://chromium.googlesource.com/angle/angle/+/master/README.md), a library that translates OpenGL API calls to the DirectX 11 equivalents.

## Integrating with other code

Flutter provides a variety of interoperability mechanisms, whether you’re accessing code or APIs written in a language like Kotlin or Swift, calling a native C-based API, embedding native controls in a Flutter app, or embedding Flutter in an existing application.

### Platform channels

For mobile and desktop apps, Flutter allows you to call into custom code through a _platform channel_, which is a mechanism for communicating between your Dart code and the platform-specific code of your host app. By creating a common channel (encapsulating a name and a codec), you can send and receive messages between Dart and a platform component written in a language like Kotlin or Swift. Data is serialized from a Dart type like `Map` into a standard format, and then deserialized into an equivalent representation in Kotlin (such as `HashMap`) or Swift (such as `Dictionary`).

![How platform channels allow Flutter to communicate with host
code](https://docs.flutter.dev/assets/images/docs/arch-overview/platform-channels.png)

The following is a short platform channel example of a Dart call to a receiving event handler in Kotlin (Android) or Swift (iOS):

```
<span>// Dart side</span><span>
</span><span>const</span><span> channel </span><span>=</span><span> </span><span>MethodChannel</span><span>(</span><span>'foo'</span><span>);</span><span>
</span><span>final</span><span> greeting </span><span>=</span><span> </span><span>await</span><span> channel</span><span>.</span><span>invokeMethod</span><span>(</span><span>'bar'</span><span>,</span><span> </span><span>'world'</span><span>)</span><span> </span><span>as</span><span> </span><span>String</span><span>;</span><span>
print</span><span>(</span><span>greeting</span><span>);</span>
```

```
<span>// Android (Kotlin)</span>
<span>val</span> <span>channel</span> <span>=</span> <span>MethodChannel</span><span>(</span><span>flutterView</span><span>,</span> <span>"foo"</span><span>)</span>
<span>channel</span><span>.</span><span>setMethodCallHandler</span> <span>{</span> <span>call</span><span>,</span> <span>result</span> <span>-&gt;</span>
  <span>when</span> <span>(</span><span>call</span><span>.</span><span>method</span><span>)</span> <span>{</span>
    <span>"bar"</span> <span>-&gt;</span> <span>result</span><span>.</span><span>success</span><span>(</span><span>"Hello, ${call.arguments}"</span><span>)</span>
    <span>else</span> <span>-&gt;</span> <span>result</span><span>.</span><span>notImplemented</span><span>()</span>
  <span>}</span>
<span>}</span>
```

```
<span>// iOS (Swift)</span>
<span>let</span> <span>channel</span> <span>=</span> <span>FlutterMethodChannel</span><span>(</span><span>name</span><span>:</span> <span>"foo"</span><span>,</span> <span>binaryMessenger</span><span>:</span> <span>flutterView</span><span>)</span>
<span>channel</span><span>.</span><span>setMethodCallHandler</span> <span>{</span>
  <span>(</span><span>call</span><span>:</span> <span>FlutterMethodCall</span><span>,</span> <span>result</span><span>:</span> <span>FlutterResult</span><span>)</span> <span>-&gt;</span> <span>Void</span> <span>in</span>
  <span>switch</span> <span>(</span><span>call</span><span>.</span><span>method</span><span>)</span> <span>{</span>
    <span>case</span> <span>"bar"</span><span>:</span> <span>result</span><span>(</span><span>"Hello, </span><span>\(</span><span>call</span><span>.</span><span>arguments</span> <span>as!</span> <span>String</span><span>)</span><span>"</span><span>)</span>
    <span>default</span><span>:</span> <span>result</span><span>(</span><span>FlutterMethodNotImplemented</span><span>)</span>
  <span>}</span>
<span>}</span>
```

Further examples of using platform channels, including examples for desktop platforms, can be found in the [flutter/packages](https://github.com/flutter/packages) repository. There are also [thousands of plugins already available](https://pub.dev/flutter) for Flutter that cover many common scenarios, ranging from Firebase to ads to device hardware like camera and Bluetooth.

### Foreign Function Interface

For C-based APIs, including those that can be generated for code written in modern languages like Rust or Go, Dart provides a direct mechanism for binding to native code using the `dart:ffi` library. The foreign function interface (FFI) model can be considerably faster than platform channels, because no serialization is required to pass data. Instead, the Dart runtime provides the ability to allocate memory on the heap that is backed by a Dart object and make calls to statically or dynamically linked libraries. FFI is available for all platforms other than web, where the [js package](https://pub.dev/packages/js) serves an equivalent purpose.

To use FFI, you create a `typedef` for each of the Dart and unmanaged method signatures, and instruct the Dart VM to map between them. As an example, here’s a fragment of code to call the traditional Win32 `MessageBox()` API:

```
<span>import</span><span> </span><span>'dart:ffi'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:ffi/ffi.dart'</span><span>;</span><span> </span><span>// contains .toNativeUtf16() extension method</span><span>

</span><span>typedef</span><span> </span><span>MessageBoxNative</span><span> </span><span>=</span><span> </span><span>Int32</span><span> </span><span>Function</span><span>(</span><span>
  </span><span>IntPtr</span><span> hWnd</span><span>,</span><span>
  </span><span>Pointer</span><span>&lt;</span><span>Utf16</span><span>&gt;</span><span> lpText</span><span>,</span><span>
  </span><span>Pointer</span><span>&lt;</span><span>Utf16</span><span>&gt;</span><span> lpCaption</span><span>,</span><span>
  </span><span>Int32</span><span> uType</span><span>,</span><span>
</span><span>);</span><span>

</span><span>typedef</span><span> </span><span>MessageBoxDart</span><span> </span><span>=</span><span> </span><span>int</span><span> </span><span>Function</span><span>(</span><span>
  </span><span>int</span><span> hWnd</span><span>,</span><span>
  </span><span>Pointer</span><span>&lt;</span><span>Utf16</span><span>&gt;</span><span> lpText</span><span>,</span><span>
  </span><span>Pointer</span><span>&lt;</span><span>Utf16</span><span>&gt;</span><span> lpCaption</span><span>,</span><span>
  </span><span>int</span><span> uType</span><span>,</span><span>
</span><span>);</span><span>

</span><span>void</span><span> exampleFfi</span><span>()</span><span> </span><span>{</span><span>
  </span><span>final</span><span> user32 </span><span>=</span><span> </span><span>DynamicLibrary</span><span>.</span><span>open</span><span>(</span><span>'user32.dll'</span><span>);</span><span>
  </span><span>final</span><span> messageBox </span><span>=</span><span>
      user32</span><span>.</span><span>lookupFunction</span><span>&lt;</span><span>MessageBoxNative</span><span>,</span><span> </span><span>MessageBoxDart</span><span>&gt;(</span><span>'MessageBoxW'</span><span>);</span><span>

  </span><span>final</span><span> result </span><span>=</span><span> messageBox</span><span>(</span><span>
    </span><span>0</span><span>,</span><span> </span><span>// No owner window</span><span>
    </span><span>'Test message'</span><span>.</span><span>toNativeUtf16</span><span>(),</span><span> </span><span>// Message</span><span>
    </span><span>'Window caption'</span><span>.</span><span>toNativeUtf16</span><span>(),</span><span> </span><span>// Window title</span><span>
    </span><span>0</span><span>,</span><span> </span><span>// OK button only</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

### Rendering native controls in a Flutter app

Because Flutter content is drawn to a texture and its widget tree is entirely internal, there’s no place for something like an Android view to exist within Flutter’s internal model or render interleaved within Flutter widgets. That’s a problem for developers that would like to include existing platform components in their Flutter apps, such as a browser control.

Flutter solves this by introducing platform view widgets ([`AndroidView`](https://api.flutter.dev/flutter/widgets/AndroidView-class.html) and [`UiKitView`](https://api.flutter.dev/flutter/widgets/UiKitView-class.html)) that let you embed this kind of content on each platform. Platform views can be integrated with other Flutter content<sup><a href="https://docs.flutter.dev/resources/architectural-overview#a3">3</a></sup>. Each of these widgets acts as an intermediary to the underlying operating system. For example, on Android, `AndroidView` serves three primary functions:

-   Making a copy of the graphics texture rendered by the native view and presenting it to Flutter for composition as part of a Flutter-rendered surface each time the frame is painted.
-   Responding to hit testing and input gestures, and translating those into the equivalent native input.
-   Creating an analog of the accessibility tree, and passing commands and responses between the native and Flutter layers.

Inevitably, there is a certain amount of overhead associated with this synchronization. In general, therefore, this approach is best suited for complex controls like Google Maps where reimplementing in Flutter isn’t practical.

Typically, a Flutter app instantiates these widgets in a `build()` method based on a platform test. As an example, from the [google\_maps\_flutter](https://pub.dev/packages/google_maps_flutter) plugin:

```
<span>if</span> <span>(</span><span>defaultTargetPlatform</span> <span>==</span> <span>TargetPlatform</span><span>.</span><span>android</span><span>)</span> <span>{</span>
  <span>return</span> <span>AndroidView</span><span>(</span>
    <span>viewType:</span> <span>'plugins.flutter.io/google_maps'</span><span>,</span>
    <span>onPlatformViewCreated:</span> <span>onPlatformViewCreated</span><span>,</span>
    <span>gestureRecognizers:</span> <span>gestureRecognizers</span><span>,</span>
    <span>creationParams:</span> <span>creationParams</span><span>,</span>
    <span>creationParamsCodec:</span> <span>const</span> <span>StandardMessageCodec</span><span>(),</span>
  <span>);</span>
<span>}</span> <span>else</span> <span>if</span> <span>(</span><span>defaultTargetPlatform</span> <span>==</span> <span>TargetPlatform</span><span>.</span><span>iOS</span><span>)</span> <span>{</span>
  <span>return</span> <span>UiKitView</span><span>(</span>
    <span>viewType:</span> <span>'plugins.flutter.io/google_maps'</span><span>,</span>
    <span>onPlatformViewCreated:</span> <span>onPlatformViewCreated</span><span>,</span>
    <span>gestureRecognizers:</span> <span>gestureRecognizers</span><span>,</span>
    <span>creationParams:</span> <span>creationParams</span><span>,</span>
    <span>creationParamsCodec:</span> <span>const</span> <span>StandardMessageCodec</span><span>(),</span>
  <span>);</span>
<span>}</span>
<span>return</span> <span>Text</span><span>(</span>
    <span>'</span><span>$defaultTargetPlatform</span><span> is not yet supported by the maps plugin'</span><span>);</span>
```

Communicating with the native code underlying the `AndroidView` or `UiKitView` typically occurs using the platform channels mechanism, as previously described.

At present, platform views aren’t available for desktop platforms, but this is not an architectural limitation; support might be added in the future.

### Hosting Flutter content in a parent app

The converse of the preceding scenario is embedding a Flutter widget in an existing Android or iOS app. As described in an earlier section, a newly created Flutter app running on a mobile device is hosted in an Android activity or iOS `UIViewController`. Flutter content can be embedded into an existing Android or iOS app using the same embedding API.

The Flutter module template is designed for easy embedding; you can either embed it as a source dependency into an existing Gradle or Xcode build definition, or you can compile it into an Android Archive or iOS Framework binary for use without requiring every developer to have Flutter installed.

The Flutter engine takes a short while to initialize, because it needs to load Flutter shared libraries, initialize the Dart runtime, create and run a Dart isolate, and attach a rendering surface to the UI. To minimize any UI delays when presenting Flutter content, it’s best to initialize the Flutter engine during the overall app initialization sequence, or at least ahead of the first Flutter screen, so that users don’t experience a sudden pause while the first Flutter code is loaded. In addition, separating the Flutter engine allows it to be reused across multiple Flutter screens and share the memory overhead involved with loading the necessary libraries.

More information about how Flutter is loaded into an existing Android or iOS app can be found at the [Load sequence, performance and memory topic](https://docs.flutter.dev/add-to-app/performance).

## Flutter web support

While the general architectural concepts apply to all platforms that Flutter supports, there are some unique characteristics of Flutter’s web support that are worthy of comment.

Dart has been compiling to JavaScript for as long as the language has existed, with a toolchain optimized for both development and production purposes. Many important apps compile from Dart to JavaScript and run in production today, including the [advertiser tooling for Google Ads](https://ads.google.com/home/). Because the Flutter framework is written in Dart, compiling it to JavaScript was relatively straightforward.

However, the Flutter engine, written in C++, is designed to interface with the underlying operating system rather than a web browser. A different approach is therefore required. On the web, Flutter provides a reimplementation of the engine on top of standard browser APIs. We currently have two options for rendering Flutter content on the web: HTML and WebGL. In HTML mode, Flutter uses HTML, CSS, Canvas, and SVG. To render to WebGL, Flutter uses a version of Skia compiled to WebAssembly called [CanvasKit](https://skia.org/docs/user/modules/canvaskit/). While HTML mode offers the best code size characteristics, `CanvasKit` provides the fastest path to the browser’s graphics stack, and offers somewhat higher graphical fidelity with the native mobile targets<sup><a href="https://docs.flutter.dev/resources/architectural-overview#a4">4</a></sup>.

The web version of the architectural layer diagram is as follows:

![Flutter web
architecture](https://docs.flutter.dev/assets/images/docs/arch-overview/web-arch.png)

Perhaps the most notable difference compared to other platforms on which Flutter runs is that there is no need for Flutter to provide a Dart runtime. Instead, the Flutter framework (along with any code you write) is compiled to JavaScript. It’s also worthy to note that Dart has very few language semantic differences across all its modes (JIT versus AOT, native versus web compilation), and most developers will never write a line of code that runs into such a difference.

During development time, Flutter web uses [`dartdevc`](https://dart.dev/tools/dartdevc), a compiler that supports incremental compilation and therefore allows hot restart (although not currently hot reload) for apps. Conversely, when you are ready to create a production app for the web, [`dart2js`](https://dart.dev/tools/dart2js), Dart’s highly-optimized production JavaScript compiler is used, packaging the Flutter core and framework along with your application into a minified source file that can be deployed to any web server. Code can be offered in a single file or split into multiple files through [deferred imports](https://dart.dev/language/libraries#lazily-loading-a-library).

## Further information

For those interested in more information about the internals of Flutter, the [Inside Flutter](https://docs.flutter.dev/resources/inside-flutter) whitepaper provides a useful guide to the framework’s design philosophy.

___

**Footnotes:**

<sup><a id="a1">1</a></sup> While the `build` function returns a fresh tree, you only need to return something _different_ if there’s some new configuration to incorporate. If the configuration is in fact the same, you can just return the same widget.

<sup><a id="a2">2</a></sup> This is a slight simplification for ease of reading. In practice, the tree might be more complex.

<sup><a id="a3">3</a></sup> There are some limitations with this approach, for example, transparency doesn’t composite the same way for a platform view as it would for other Flutter widgets.

<sup><a id="a4">4</a></sup> One example is shadows, which have to be approximated with DOM-equivalent primitives at the cost of some fidelity.