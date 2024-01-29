This document is for React Native (RN) developers looking to apply their existing RN knowledge to build mobile apps with Flutter. If you understand the fundamentals of the RN framework then you can use this document as a way to get started learning Flutter development.

This document can be used as a cookbook by jumping around and finding questions that are most relevant to your needs.

## Introduction to Dart for JavaScript Developers (ES6)

Like React Native, Flutter uses reactive-style views. However, while RN transpiles to native widgets, Flutter compiles all the way to native code. Flutter controls each pixel on the screen, which avoids performance problems caused by the need for a JavaScript bridge.

Dart is an easy language to learn and offers the following features:

-   Provides an open-source, scalable programming language for building web, server, and mobile apps.
-   Provides an object-oriented, single inheritance language that uses a C-style syntax that is AOT-compiled into native.
-   Transcompiles optionally into JavaScript.
-   Supports interfaces and abstract classes.

A few examples of the differences between JavaScript and Dart are described below.

### Entry point

JavaScript doesn’t have a pre-defined entry function—you define the entry point.

```
<span>// JavaScript</span>
<span>function</span> <span>startHere</span><span>()</span> <span>{</span>
  <span>// Can be used as entry point</span>
<span>}</span>
```

In Dart, every app must have a top-level `main()` function that serves as the entry point to the app.

Try it out in [DartPad](https://dartpad.dev/0df636e00f348bdec2bc1c8ebc7daeb1).

### Printing to the console

To print to the console in Dart, use `print()`.

```
<span>// JavaScript</span>
<span>console</span><span>.</span><span>log</span><span>(</span><span>'</span><span>Hello world!</span><span>'</span><span>);</span>
```

```
<span>/// Dart</span><span>
print</span><span>(</span><span>'Hello world!'</span><span>);</span>
```

Try it out in [DartPad](https://dartpad.dev/cf9e652f77636224d3e37d96dcf238e5).

### Variables

Dart is type safe—it uses a combination of static type checking and runtime checks to ensure that a variable’s value always matches the variable’s static type. Although types are mandatory, some type annotations are optional because Dart performs type inference.

#### Creating and assigning variables

In JavaScript, variables cannot be typed.

In [Dart](https://dart.dev/dart-2), variables must either be explicitly typed or the type system must infer the proper type automatically.

```
<span>// JavaScript</span>
<span>let</span> <span>name</span> <span>=</span> <span>'</span><span>JavaScript</span><span>'</span><span>;</span>
```

```
<span>/// Dart</span><span>
</span><span>/// Both variables are acceptable.</span><span>
</span><span>String</span><span> name </span><span>=</span><span> </span><span>'dart'</span><span>;</span><span> </span><span>// Explicitly typed as a [String].</span><span>
</span><span>var</span><span> otherName </span><span>=</span><span> </span><span>'Dart'</span><span>;</span><span> </span><span>// Inferred [String] type.</span>
```

Try it out in [DartPad](https://dartpad.dev/3f4625c16e05eec396d6046883739612).

For more information, see [Dart’s Type System](https://dart.dev/guides/language/sound-dart).

#### Default value

In JavaScript, uninitialized variables are `undefined`.

In Dart, uninitialized variables have an initial value of `null`. Because numbers are objects in Dart, even uninitialized variables with numeric types have the value `null`.

```
<span>// JavaScript</span>
<span>let</span> <span>name</span><span>;</span> <span>// == undefined</span>
```

```
<span>// Dart</span><span>
</span><span>var</span><span> name</span><span>;</span><span> </span><span>// == null; raises a linter warning</span><span>
</span><span>int</span><span>?</span><span> x</span><span>;</span><span> </span><span>// == null</span>
```

Try it out in [DartPad](https://dartpad.dev/57ec21faa8b6fe2326ffd74e9781a2c7).

For more information, see the documentation on [variables](https://dart.dev/language/variables).

### Checking for null or zero

In JavaScript, values of 1 or any non-null objects are treated as `true` when using the `==` comparison operator.

```
<span>// JavaScript</span>
<span>let</span> <span>myNull</span> <span>=</span> <span>null</span><span>;</span>
<span>if </span><span>(</span><span>!</span><span>myNull</span><span>)</span> <span>{</span>
  <span>console</span><span>.</span><span>log</span><span>(</span><span>'</span><span>null is treated as false</span><span>'</span><span>);</span>
<span>}</span>
<span>let</span> <span>zero</span> <span>=</span> <span>0</span><span>;</span>
<span>if </span><span>(</span><span>!</span><span>zero</span><span>)</span> <span>{</span>
  <span>console</span><span>.</span><span>log</span><span>(</span><span>'</span><span>0 is treated as false</span><span>'</span><span>);</span>
<span>}</span>
```

In Dart, only the boolean value `true` is treated as true.

```
<span>/// Dart</span><span>
</span><span>var</span><span> myNull</span><span>;</span><span>
</span><span>var</span><span> zero </span><span>=</span><span> </span><span>0</span><span>;</span><span>
</span><span>if</span><span> </span><span>(</span><span>zero </span><span>==</span><span> </span><span>0</span><span>)</span><span> </span><span>{</span><span>
  print</span><span>(</span><span>'use "== 0" to check zero'</span><span>);</span><span>
</span><span>}</span>
```

Try it out in [DartPad](https://dartpad.dev/c85038ad677963cb6dc943eb1a0b72e6).

### Functions

Dart and JavaScript functions are generally similar. The primary difference is the declaration.

```
<span>// JavaScript</span>
<span>function</span> <span>fn</span><span>()</span> <span>{</span>
  <span>return</span> <span>true</span><span>;</span>
<span>}</span>
```

```
<span>/// Dart</span><span>
</span><span>/// You can explicitly define the return type.</span><span>
</span><span>bool</span><span> fn</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>true</span><span>;</span><span>
</span><span>}</span>
```

Try it out in [DartPad](https://dartpad.dev/5454e8bfadf3000179d19b9bc6be9918).

For more information, see the documentation on [functions](https://dart.dev/language/functions).

### Asynchronous programming

#### Futures

Like JavaScript, Dart supports single-threaded execution. In JavaScript, the Promise object represents the eventual completion (or failure) of an asynchronous operation and its resulting value.

Dart uses [`Future`](https://dart.dev/tutorials/language/futures) objects to handle this.

```
<span>// JavaScript</span>
<span>class</span> <span>Example</span> <span>{</span>
  <span>_getIPAddress</span><span>()</span> <span>{</span>
    <span>const</span> <span>url</span> <span>=</span> <span>'</span><span>https://httpbin.org/ip</span><span>'</span><span>;</span>
    <span>return</span> <span>fetch</span><span>(</span><span>url</span><span>)</span>
      <span>.</span><span>then</span><span>(</span><span>response</span> <span>=&gt;</span> <span>response</span><span>.</span><span>json</span><span>())</span>
      <span>.</span><span>then</span><span>(</span><span>responseJson</span> <span>=&gt;</span> <span>{</span>
        <span>const</span> <span>ip</span> <span>=</span> <span>responseJson</span><span>.</span><span>origin</span><span>;</span>
        <span>return</span> <span>ip</span><span>;</span>
      <span>});</span>
  <span>}</span>
<span>}</span>

<span>function</span> <span>main</span><span>()</span> <span>{</span>
  <span>const</span> <span>example</span> <span>=</span> <span>new</span> <span>Example</span><span>();</span>
  <span>example</span>
    <span>.</span><span>_getIPAddress</span><span>()</span>
    <span>.</span><span>then</span><span>(</span><span>ip</span> <span>=&gt;</span> <span>console</span><span>.</span><span>log</span><span>(</span><span>ip</span><span>))</span>
    <span>.</span><span>catch</span><span>(</span><span>error</span> <span>=&gt;</span> <span>console</span><span>.</span><span>error</span><span>(</span><span>error</span><span>));</span>
<span>}</span>

<span>main</span><span>();</span>
```

```
<span>// Dart</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>class</span><span> </span><span>Example</span><span> </span><span>{</span><span>
  </span><span>Future</span><span>&lt;</span><span>String</span><span>&gt;</span><span> _getIPAddress</span><span>()</span><span> </span><span>{</span><span>
    </span><span>final</span><span> url </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>https</span><span>(</span><span>'httpbin.org'</span><span>,</span><span> </span><span>'/ip'</span><span>);</span><span>
    </span><span>return</span><span> http</span><span>.</span><span>get</span><span>(</span><span>url</span><span>).</span><span>then</span><span>((</span><span>response</span><span>)</span><span> </span><span>{</span><span>
      </span><span>final</span><span> ip </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)[</span><span>'origin'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>;</span><span>
      </span><span>return</span><span> ip</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>final</span><span> example </span><span>=</span><span> </span><span>Example</span><span>();</span><span>
  example
      </span><span>.</span><span>_getIPAddress</span><span>()</span><span>
      </span><span>.</span><span>then</span><span>((</span><span>ip</span><span>)</span><span> </span><span>=&gt;</span><span> print</span><span>(</span><span>ip</span><span>))</span><span>
      </span><span>.</span><span>catchError</span><span>((</span><span>error</span><span>)</span><span> </span><span>=&gt;</span><span> print</span><span>(</span><span>error</span><span>));</span><span>
</span><span>}</span>
```

For more information, see the documentation on [`Future`](https://dart.dev/tutorials/language/futures) objects.

#### `async` and `await`

The `async` function declaration defines an asynchronous function.

In JavaScript, the `async` function returns a `Promise`. The `await` operator is used to wait for a `Promise`.

```
<span>// JavaScript</span>
<span>class</span> <span>Example</span> <span>{</span>
  <span>async</span> <span>function</span> <span>_getIPAddress</span><span>()</span> <span>{</span>
    <span>const</span> <span>url</span> <span>=</span> <span>'</span><span>https://httpbin.org/ip</span><span>'</span><span>;</span>
    <span>const</span> <span>response</span> <span>=</span> <span>await</span> <span>fetch</span><span>(</span><span>url</span><span>);</span>
    <span>const</span> <span>json</span> <span>=</span> <span>await</span> <span>response</span><span>.</span><span>json</span><span>();</span>
    <span>const</span> <span>data</span> <span>=</span> <span>json</span><span>.</span><span>origin</span><span>;</span>
    <span>return</span> <span>data</span><span>;</span>
  <span>}</span>
<span>}</span>

<span>async</span> <span>function</span> <span>main</span><span>()</span> <span>{</span>
  <span>const</span> <span>example</span> <span>=</span> <span>new</span> <span>Example</span><span>();</span>
  <span>try</span> <span>{</span>
    <span>const</span> <span>ip</span> <span>=</span> <span>await</span> <span>example</span><span>.</span><span>_getIPAddress</span><span>();</span>
    <span>console</span><span>.</span><span>log</span><span>(</span><span>ip</span><span>);</span>
  <span>}</span> <span>catch </span><span>(</span><span>error</span><span>)</span> <span>{</span>
    <span>console</span><span>.</span><span>error</span><span>(</span><span>error</span><span>);</span>
  <span>}</span>
<span>}</span>

<span>main</span><span>();</span>
```

In Dart, an `async` function returns a `Future`, and the body of the function is scheduled for execution later. The `await` operator is used to wait for a `Future`.

```
<span>// Dart</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>class</span><span> </span><span>Example</span><span> </span><span>{</span><span>
  </span><span>Future</span><span>&lt;</span><span>String</span><span>&gt;</span><span> _getIPAddress</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> url </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>https</span><span>(</span><span>'httpbin.org'</span><span>,</span><span> </span><span>'/ip'</span><span>);</span><span>
    </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>url</span><span>);</span><span>
    </span><span>final</span><span> ip </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)[</span><span>'origin'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>;</span><span>
    </span><span>return</span><span> ip</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>/// An async function returns a `Future`.</span><span>
</span><span>/// It can also return `void`, unless you use</span><span>
</span><span>/// the `avoid_void_async` lint. In that case,</span><span>
</span><span>/// return `Future&lt;void&gt;`.</span><span>
</span><span>void</span><span> main</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> example </span><span>=</span><span> </span><span>Example</span><span>();</span><span>
  </span><span>try</span><span> </span><span>{</span><span>
    </span><span>final</span><span> ip </span><span>=</span><span> </span><span>await</span><span> example</span><span>.</span><span>_getIPAddress</span><span>();</span><span>
    print</span><span>(</span><span>ip</span><span>);</span><span>
  </span><span>}</span><span> </span><span>catch</span><span> </span><span>(</span><span>error</span><span>)</span><span> </span><span>{</span><span>
    print</span><span>(</span><span>error</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

For more information, see the documentation for [async and await](https://dart.dev/language/async).

## The basics

### How do I create a Flutter app?

To create an app using React Native, you would run `create-react-native-app` from the command line.

```
<span>$</span><span> </span>create-react-native-app &lt;projectname&gt;
```

To create an app in Flutter, do one of the following:

-   Use an IDE with the Flutter and Dart plugins installed.
-   Use the `flutter create` command from the command line. Make sure that the Flutter SDK is in your PATH.

```
<span>$</span><span> </span>flutter create &lt;projectname&gt;
```

For more information, see [Getting started](https://docs.flutter.dev/get-started), which walks you through creating a button-click counter app. Creating a Flutter project builds all the files that you need to run a sample app on both Android and iOS devices.

### How do I run my app?

In React Native, you would run `npm run` or `yarn run` from the project directory.

You can run Flutter apps in a couple of ways:

-   Use the “run” option in an IDE with the Flutter and Dart plugins.
-   Use `flutter run` from the project’s root directory.

Your app runs on a connected device, the iOS simulator, or the Android emulator.

For more information, see the Flutter [Getting started](https://docs.flutter.dev/get-started) documentation.

### How do I import widgets?

In React Native, you need to import each required component.

```
<span>// React Native</span>
<span>import</span> <span>React</span> <span>from</span> <span>'</span><span>react</span><span>'</span><span>;</span>
<span>import</span> <span>{</span> <span>StyleSheet</span><span>,</span> <span>Text</span><span>,</span> <span>View</span> <span>}</span> <span>from</span> <span>'</span><span>react-native</span><span>'</span><span>;</span>
```

In Flutter, to use widgets from the Material Design library, import the `material.dart` package. To use iOS style widgets, import the Cupertino library. To use a more basic widget set, import the Widgets library. Or, you can write your own widget library and import that.

```
<span>import</span><span> </span><span>'package:flutter/cupertino.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/widgets.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:my_widgets/my_widgets.dart'</span><span>;</span>
```

Whichever widget package you import, Dart pulls in only the widgets that are used in your app.

For more information, see the [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets).

### What is the equivalent of the React Native “Hello world!” app in Flutter?

In React Native, the `HelloWorldApp` class extends `React.Component` and implements the render method by returning a view component.

```
<span>// React Native</span>
<span>import</span> <span>React</span> <span>from</span> <span>'</span><span>react</span><span>'</span><span>;</span>
<span>import</span> <span>{</span> <span>StyleSheet</span><span>,</span> <span>Text</span><span>,</span> <span>View</span> <span>}</span> <span>from</span> <span>'</span><span>react-native</span><span>'</span><span>;</span>

<span>const</span> <span>App</span> <span>=</span> <span>()</span> <span>=&gt;</span> <span>{</span>
  <span>return </span><span>(</span>
    <span>&lt;</span><span>View</span> <span>style</span><span>=</span><span>{</span><span>styles</span><span>.</span><span>container</span><span>}</span><span>&gt;</span>
      <span>&lt;</span><span>Text</span><span>&gt;</span><span>Hello</span> <span>world</span><span>!&lt;</span><span>/Text</span><span>&gt;
</span>    <span>&lt;</span><span>/View</span><span>&gt;
</span>  <span>);</span>
<span>};</span>

<span>const</span> <span>styles</span> <span>=</span> <span>StyleSheet</span><span>.</span><span>create</span><span>({</span>
  <span>container</span><span>:</span> <span>{</span>
    <span>flex</span><span>:</span> <span>1</span><span>,</span>
    <span>backgroundColor</span><span>:</span> <span>'</span><span>#fff</span><span>'</span><span>,</span>
    <span>alignItems</span><span>:</span> <span>'</span><span>center</span><span>'</span><span>,</span>
    <span>justifyContent</span><span>:</span> <span>'</span><span>center</span><span>'</span>
  <span>}</span>
<span>});</span>

<span>export</span> <span>default</span> <span>App</span><span>;</span>
```

In Flutter, you can create an identical “Hello world!” app using the `Center` and `Text` widgets from the core widget library. The `Center` widget becomes the root of the widget tree and has one child, the `Text` widget.

```
<span>// Flutter</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        </span><span>'Hello, world!'</span><span>,</span><span>
        textDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The following images show the Android and iOS UI for the basic Flutter “Hello world!” app.

![Hello world app on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/hello-world-basic.png)

Android

![Hello world app on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/hello-world-basic.png)

iOS

Now that you’ve seen the most basic Flutter app, the next section shows how to take advantage of Flutter’s rich widget libraries to create a modern, polished app.

### How do I use widgets and nest them to form a widget tree?

In Flutter, almost everything is a widget.

Widgets are the basic building blocks of an app’s user interface. You compose widgets into a hierarchy, called a widget tree. Each widget nests inside a parent widget and inherits properties from its parent. Even the application object itself is a widget. There is no separate “application” object. Instead, the root widget serves this role.

A widget can define:

-   A structural element—like a button or menu
-   A stylistic element—like a font or color scheme
-   An aspect of layout—like padding or alignment

The following example shows the “Hello world!” app using widgets from the Material library. In this example, the widget tree is nested inside the `MaterialApp` root widget.

```
<span>// Flutter</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Welcome to Flutter'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Welcome to Flutter'</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Hello world'</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The following images show “Hello world!” built from Material Design widgets. You get more functionality for free than in the basic “Hello world!” app.

![Hello world app on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/hello-world.png)

Android

![Hello world app on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/hello-world.png)

iOS

When writing an app, you’ll use two types of widgets: [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) or [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html). A `StatelessWidget` is just what it sounds like—a widget with no state. A `StatelessWidget` is created once, and never changes its appearance. A `StatefulWidget` dynamically changes state based on data received, or user input.

The important difference between stateless and stateful widgets is that `StatefulWidget`s have a `State` object that stores state data and carries it over across tree rebuilds, so it’s not lost.

In simple or basic apps it’s easy to nest widgets, but as the code base gets larger and the app becomes complex, you should break deeply nested widgets into functions that return the widget or smaller classes. Creating separate functions and widgets allows you to reuse the components within the app.

### How do I create reusable components?

In React Native, you would define a class to create a reusable component and then use `props` methods to set or return properties and values of the selected elements. In the example below, the `CustomCard` class is defined and then used inside a parent class.

```
<span>// React Native</span>
<span>const</span> <span>CustomCard</span> <span>=</span> <span>({</span> <span>index</span><span>,</span> <span>onPress</span> <span>})</span> <span>=&gt;</span> <span>{</span>
  <span>return </span><span>(</span>
    <span>&lt;</span><span>View</span><span>&gt;</span>
      <span>&lt;</span><span>Text</span><span>&gt;</span> <span>Card</span> <span>{</span><span>index</span><span>}</span> <span>&lt;</span><span>/Text</span><span>&gt;
</span>      <span>&lt;</span><span>Button</span>
        <span>title</span><span>=</span><span>"</span><span>Press</span><span>"</span>
        <span>onPress</span><span>=</span><span>{()</span> <span>=&gt;</span> <span>onPress</span><span>(</span><span>index</span><span>)}</span>
      <span>/</span><span>&gt;
</span>    <span>&lt;</span><span>/View</span><span>&gt;
</span>  <span>);</span>
<span>};</span>

<span>// Usage</span>
<span>&lt;</span><span>CustomCard</span> <span>onPress</span><span>=</span><span>{</span><span>this</span><span>.</span><span>onPress</span><span>}</span> <span>index</span><span>=</span><span>{</span><span>item</span><span>.</span><span>key</span><span>}</span> <span>/</span><span>&gt;
</span>
```

In Flutter, define a class to create a custom widget and then reuse the widget. You can also define and call a function that returns a reusable widget as shown in the `build` function in the following example.

```
<span>/// Flutter</span><span>
</span><span>class</span><span> </span><span>CustomCard</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>CustomCard</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>index</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>onPress</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>int</span><span> index</span><span>;</span><span>
  </span><span>final</span><span> </span><span>void</span><span> </span><span>Function</span><span>()</span><span> onPress</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Card</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
          </span><span>Text</span><span>(</span><span>'Card $index'</span><span>),</span><span>
          </span><span>TextButton</span><span>(</span><span>
            onPressed</span><span>:</span><span> onPress</span><span>,</span><span>
            child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Press'</span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>UseCard</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>UseCard</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>index</span><span>});</span><span>

  </span><span>final</span><span> </span><span>int</span><span> index</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>/// Usage</span><span>
    </span><span>return</span><span> </span><span>CustomCard</span><span>(</span><span>
      index</span><span>:</span><span> index</span><span>,</span><span>
      onPress</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        print</span><span>(</span><span>'Card $index'</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

In the previous example, the constructor for the `CustomCard` class uses Dart’s curly brace syntax `{ }` to indicate [named parameters](https://dart.dev/language/functions#named-parameters).

To require these fields, either remove the curly braces from the constructor, or add `required` to the constructor.

The following screenshots show an example of the reusable `CustomCard` class.

![Custom cards on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/custom-cards.png)

Android

![Custom cards on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/custom-cards.png)

iOS

## Project structure and resources

### Where do I start writing the code?

Start with the `lib/main.dart` file. It’s autogenerated when you create a Flutter app.

```
<span>// Dart</span><span>
</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  print</span><span>(</span><span>'Hello, this is the main function.'</span><span>);</span><span>
</span><span>}</span>
```

In Flutter, the entry point file is `{project_name}/lib/main.dart` and execution starts from the `main` function.

### How are files structured in a Flutter app?

When you create a new Flutter project, it builds the following directory structure. You can customize it later, but this is where you start.

```
┬
└ project_name
  ┬
  ├ android      - Contains Android-specific files.
  ├ build        - Stores iOS and Android build files.
  ├ ios          - Contains iOS-specific files.
  ├ lib          - Contains externally accessible Dart source files.
    ┬
    └ src        - Contains additional source files.
    └ main.dart  - The Flutter entry point and the start of a new app.
                   This is generated automatically when you create a Flutter
                    project.
                   It's where you start writing your Dart code.
  ├ test         - Contains automated test files.
  └ pubspec.yaml - Contains the metadata for the Flutter app.
                   This is equivalent to the package.json file in React Native.
```

### Where do I put my resources and assets and how do I use them?

A Flutter resource or asset is a file that is bundled and deployed with your app and is accessible at runtime. Flutter apps can include the following asset types:

-   Static data such as JSON files
-   Configuration files
-   Icons and images (JPEG, PNG, GIF, Animated GIF, WebP, Animated WebP, BMP, and WBMP)

Flutter uses the `pubspec.yaml` file, located at the root of your project, to identify assets required by an app.

```
<span>flutter</span><span>:</span>
  <span>assets</span><span>:</span>
    <span>-</span> <span>assets/my_icon.png</span>
    <span>-</span> <span>assets/background.png</span>
```

The `assets` subsection specifies files that should be included with the app. Each asset is identified by an explicit path relative to the `pubspec.yaml` file, where the asset file is located. The order in which the assets are declared does not matter. The actual directory used (`assets` in this case) does not matter. However, while assets can be placed in any app directory, it’s a best practice to place them in the `assets` directory.

During a build, Flutter places assets into a special archive called the _asset bundle_, which apps read from at runtime. When an asset’s path is specified in the assets’ section of `pubspec.yaml`, the build process looks for any files with the same name in adjacent subdirectories. These files are also included in the asset bundle along with the specified asset. Flutter uses asset variants when choosing resolution-appropriate images for your app.

In React Native, you would add a static image by placing the image file in a source code directory and referencing it.

```
<span>&lt;</span><span>Image</span> <span>source</span><span>=</span><span>{</span><span>require</span><span>(</span><span>'</span><span>./my-icon.png</span><span>'</span><span>)}</span> <span>/</span><span>&gt;
</span><span>// OR</span>
<span>&lt;</span><span>Image</span>
  <span>source</span><span>=</span><span>{{</span>
    <span>url</span><span>:</span> <span>'</span><span>https://reactnative.dev/img/tiny_logo.png</span><span>'</span>
  <span>}}</span>
<span>/</span><span>&gt;
</span>
```

In Flutter, add a static image to your app using the `Image.asset` constructor in a widget’s build method.

```
<span>Image</span><span>.</span><span>asset</span><span>(</span><span>'assets/background.png'</span><span>);</span>
```

For more information, see [Adding Assets and Images in Flutter](https://docs.flutter.dev/ui/assets/assets-and-images).

### How do I load images over a network?

In React Native, you would specify the `uri` in the `source` prop of the `Image` component and also provide the size if needed.

In Flutter, use the `Image.network` constructor to include an image from a URL.

```
<span>Image</span><span>.</span><span>network</span><span>(</span><span>'https://docs.flutter.dev/assets/images/docs/owl.jpg'</span><span>);</span>
```

### How do I install packages and package plugins?

Flutter supports using shared packages contributed by other developers to the Flutter and Dart ecosystems. This allows you to quickly build your app without having to develop everything from scratch. Packages that contain platform-specific code are known as package plugins.

In React Native, you would use `yarn add {package-name}` or `npm install --save {package-name}` to install packages from the command line.

In Flutter, install a package using the following instructions:

1.  To add the `google_sign_in` package as a dependency, run `flutter pub add`:

```
<span>$</span><span> </span>flutter pub add google_sign_in
```

1.  Install the package from the command line by using `flutter pub get`. If using an IDE, it often runs `flutter pub get` for you, or it might prompt you to do so.
2.  Import the package into your app code as shown below:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span>
```

For more information, see [Using Packages](https://docs.flutter.dev/packages-and-plugins/using-packages) and [Developing Packages & Plugins](https://docs.flutter.dev/packages-and-plugins/developing-packages).

You can find many packages shared by Flutter developers in the [Flutter packages](https://pub.dev/flutter/) section of [pub.dev](https://pub.dev/).

In Flutter, you build your UI out of widgets that describe what their view should look like given their current configuration and state.

Widgets are often composed of many small, single-purpose widgets that are nested to produce powerful effects. For example, the `Container` widget consists of several widgets responsible for layout, painting, positioning, and sizing. Specifically, the `Container` widget includes the `LimitedBox`, `ConstrainedBox`, `Align`, `Padding`, `DecoratedBox`, and `Transform` widgets. Rather than subclassing `Container` to produce a customized effect, you can compose these and other simple widgets in new and unique ways.

The `Center` widget is another example of how you can control the layout. To center a widget, wrap it in a `Center` widget and then use layout widgets for alignment, row, columns, and grids. These layout widgets do not have a visual representation of their own. Instead, their sole purpose is to control some aspect of another widget’s layout. To understand why a widget renders in a certain way, it’s often helpful to inspect the neighboring widgets.

For more information, see the [Flutter Technical Overview](https://docs.flutter.dev/resources/architectural-overview).

For more information about the core widgets from the `Widgets` package, see [Flutter Basic Widgets](https://docs.flutter.dev/ui/widgets/basics), the [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets), or the [Flutter Widget Index](https://docs.flutter.dev/reference/widgets).

## Views

### What is the equivalent of the `View` container?

In React Native, `View` is a container that supports layout with `Flexbox`, style, touch handling, and accessibility controls.

In Flutter, you can use the core layout widgets in the `Widgets` library, such as [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html), [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html), [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html), and [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html). For more information, see the [Layout Widgets](https://docs.flutter.dev/ui/widgets/layout) catalog.

### What is the equivalent of `FlatList` or `SectionList`?

A `List` is a scrollable list of components arranged vertically.

In React Native, `FlatList` or `SectionList` are used to render simple or sectioned lists.

```
<span>// React Native</span>
<span>&lt;</span><span>FlatList</span>
  <span>data</span><span>=</span><span>{[</span> <span>...</span> <span>]}</span>
  <span>renderItem</span><span>=</span><span>{({</span> <span>item</span> <span>})</span> <span>=&gt;</span> <span>&lt;</span><span>Text</span><span>&gt;</span><span>{</span><span>item</span><span>.</span><span>key</span><span>}</span><span>&lt;</span><span>/Text&gt;</span><span>}
</span><span>/&gt;</span>
```

[`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) is Flutter’s most commonly used scrolling widget. The default constructor takes an explicit list of children. [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) is most appropriate for a small number of widgets. For a large or infinite list, use `ListView.builder`, which builds its children on demand and only builds those children that are visible.

```
<span>var</span><span> data </span><span>=</span><span> </span><span>[</span><span>
  </span><span>'Hello'</span><span>,</span><span>
  </span><span>'World'</span><span>,</span><span>
</span><span>];</span><span>
</span><span>return</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
  itemCount</span><span>:</span><span> data</span><span>.</span><span>length</span><span>,</span><span>
  itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Text</span><span>(</span><span>data</span><span>[</span><span>index</span><span>]);</span><span>
  </span><span>},</span><span>
</span><span>);</span>
```

![Flat list on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/flatlist.gif)

Android

![Flat list on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/flatlist.gif)

iOS

To learn how to implement an infinite scrolling list, see the official [`infinite_list`](https://github.com/flutter/samples/tree/main/infinite_list) sample.

### How do I use a Canvas to draw or paint?

In React Native, canvas components aren’t present so third party libraries like `react-native-canvas` are used.

```
<span>// React Native</span>
<span>const</span> <span>CanvasComp</span> <span>=</span> <span>()</span> <span>=&gt;</span> <span>{</span>
  <span>const</span> <span>handleCanvas</span> <span>=</span> <span>(</span><span>canvas</span><span>)</span> <span>=&gt;</span> <span>{</span>
    <span>const</span> <span>ctx</span> <span>=</span> <span>canvas</span><span>.</span><span>getContext</span><span>(</span><span>'</span><span>2d</span><span>'</span><span>);</span>
    <span>ctx</span><span>.</span><span>fillStyle</span> <span>=</span> <span>'</span><span>skyblue</span><span>'</span><span>;</span>
    <span>ctx</span><span>.</span><span>beginPath</span><span>();</span>
    <span>ctx</span><span>.</span><span>arc</span><span>(</span><span>75</span><span>,</span> <span>75</span><span>,</span> <span>50</span><span>,</span> <span>0</span><span>,</span> <span>2</span> <span>*</span> <span>Math</span><span>.</span><span>PI</span><span>);</span>
    <span>ctx</span><span>.</span><span>fillRect</span><span>(</span><span>150</span><span>,</span> <span>100</span><span>,</span> <span>300</span><span>,</span> <span>300</span><span>);</span>
    <span>ctx</span><span>.</span><span>stroke</span><span>();</span>
  <span>};</span>

  <span>return </span><span>(</span>
    <span>&lt;</span><span>View</span><span>&gt;</span>
      <span>&lt;</span><span>Canvas</span> <span>ref</span><span>=</span><span>{</span><span>this</span><span>.</span><span>handleCanvas</span><span>}</span> <span>/</span><span>&gt;
</span>    <span>&lt;</span><span>/View</span><span>&gt;
</span>  <span>);</span>
<span>}</span>
```

In Flutter, you can use the [`CustomPaint`](https://api.flutter.dev/flutter/widgets/CustomPaint-class.html) and [`CustomPainter`](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html) classes to draw to the canvas.

The following example shows how to draw during the paint phase using the `CustomPaint` widget. It implements the abstract class, `CustomPainter`, and passes it to `CustomPaint`’s painter property. `CustomPaint` subclasses must implement the `paint()` and `shouldRepaint()` methods.

```
<span>class</span><span> </span><span>MyCanvasPainter</span><span> </span><span>extends</span><span> </span><span>CustomPainter</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyCanvasPainter</span><span>();</span><span>

  @override
  </span><span>void</span><span> paint</span><span>(</span><span>Canvas</span><span> canvas</span><span>,</span><span> </span><span>Size</span><span> size</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>Paint</span><span> paint </span><span>=</span><span> </span><span>Paint</span><span>()..</span><span>color </span><span>=</span><span> </span><span>Colors</span><span>.</span><span>amber</span><span>;</span><span>
    canvas</span><span>.</span><span>drawCircle</span><span>(</span><span>const</span><span> </span><span>Offset</span><span>(</span><span>100</span><span>,</span><span> </span><span>200</span><span>),</span><span> </span><span>40</span><span>,</span><span> paint</span><span>);</span><span>
    </span><span>final</span><span> </span><span>Paint</span><span> paintRect </span><span>=</span><span> </span><span>Paint</span><span>()..</span><span>color </span><span>=</span><span> </span><span>Colors</span><span>.</span><span>lightBlue</span><span>;</span><span>
    </span><span>final</span><span> </span><span>Rect</span><span> rect </span><span>=</span><span> </span><span>Rect</span><span>.</span><span>fromPoints</span><span>(</span><span>
      </span><span>const</span><span> </span><span>Offset</span><span>(</span><span>150</span><span>,</span><span> </span><span>300</span><span>),</span><span>
      </span><span>const</span><span> </span><span>Offset</span><span>(</span><span>300</span><span>,</span><span> </span><span>400</span><span>),</span><span>
    </span><span>);</span><span>
    canvas</span><span>.</span><span>drawRect</span><span>(</span><span>rect</span><span>,</span><span> paintRect</span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>bool</span><span> shouldRepaint</span><span>(</span><span>MyCanvasPainter</span><span> oldDelegate</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>false</span><span>;</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyCanvasWidget</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyCanvasWidget</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>Scaffold</span><span>(</span><span>
      body</span><span>:</span><span> </span><span>CustomPaint</span><span>(</span><span>painter</span><span>:</span><span> </span><span>MyCanvasPainter</span><span>()),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![Canvas on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/canvas.png)

Android

![Canvas on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/canvas.png)

iOS

## Layouts

### How do I use widgets to define layout properties?

In React Native, most of the layout can be done with the props that are passed to a specific component. For example, you could use the `style` prop on the `View` component in order to specify the flexbox properties. To arrange your components in a column, you would specify a prop such as: `flexDirection: 'column'`.

```
<span>// React Native</span>
<span>&lt;</span><span>View</span>
  <span>style</span><span>=</span><span>{{</span>
    <span>flex</span><span>:</span> <span>1</span><span>,</span>
    <span>flexDirection</span><span>:</span> <span>'</span><span>column</span><span>'</span><span>,</span>
    <span>justifyContent</span><span>:</span> <span>'</span><span>space-between</span><span>'</span><span>,</span>
    <span>alignItems</span><span>:</span> <span>'</span><span>center</span><span>'</span>
  <span>}}</span>
<span>&gt;</span>
```

In Flutter, the layout is primarily defined by widgets specifically designed to provide layout, combined with control widgets and their style properties.

For example, the [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) and [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) widgets take an array of children and align them vertically and horizontally respectively. A [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) widget takes a combination of layout and styling properties, and a [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html) widget centers its child widgets.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Center</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
      children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
        </span><span>Container</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>,</span><span>
          width</span><span>:</span><span> </span><span>100</span><span>,</span><span>
          height</span><span>:</span><span> </span><span>100</span><span>,</span><span>
        </span><span>),</span><span>
        </span><span>Container</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>,</span><span>
          width</span><span>:</span><span> </span><span>100</span><span>,</span><span>
          height</span><span>:</span><span> </span><span>100</span><span>,</span><span>
        </span><span>),</span><span>
        </span><span>Container</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>green</span><span>,</span><span>
          width</span><span>:</span><span> </span><span>100</span><span>,</span><span>
          height</span><span>:</span><span> </span><span>100</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>),</span><span>
  </span><span>);</span>
```

Flutter provides a variety of layout widgets in its core widget library. For example, [`Padding`](https://api.flutter.dev/flutter/widgets/Padding-class.html), [`Align`](https://api.flutter.dev/flutter/widgets/Align-class.html), and [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html).

For a complete list, see [Layout Widgets](https://docs.flutter.dev/ui/widgets/layout).

![Layout on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/basic-layout.gif)

Android

![Layout on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/basic-layout.gif)

iOS

### How do I layer widgets?

In React Native, components can be layered using `absolute` positioning.

Flutter uses the [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html) widget to arrange children widgets in layers. The widgets can entirely or partially overlap the base widget.

The `Stack` widget positions its children relative to the edges of its box. This class is useful if you simply want to overlap several children widgets.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Stack</span><span>(</span><span>
    alignment</span><span>:</span><span> </span><span>const</span><span> </span><span>Alignment</span><span>(</span><span>0.6</span><span>,</span><span> </span><span>0.6</span><span>),</span><span>
    children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
      </span><span>const</span><span> </span><span>CircleAvatar</span><span>(</span><span>
        backgroundImage</span><span>:</span><span> </span><span>NetworkImage</span><span>(</span><span>
          </span><span>'https://avatars3.githubusercontent.com/u/14101776?v=4'</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      </span><span>Container</span><span>(</span><span>
        color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>black45</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Flutter'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>);</span>
```

The previous example uses `Stack` to overlay a Container (that displays its `Text` on a translucent black background) on top of a `CircleAvatar`. The Stack offsets the text using the alignment property and `Alignment` coordinates.

![Stack on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/stack.png)

Android

![Stack on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/stack.png)

iOS

For more information, see the [`Stack`](https://api.flutter.dev/flutter/widgets/Stack-class.html) class documentation.

## Styling

### How do I style my components?

In React Native, inline styling and `stylesheets.create` are used to style components.

```
<span>// React Native</span>
<span>&lt;</span><span>View</span> <span>style</span><span>=</span><span>{</span><span>styles</span><span>.</span><span>container</span><span>}</span><span>&gt;</span>
  <span>&lt;</span><span>Text</span> <span>style</span><span>=</span><span>{{</span> <span>fontSize</span><span>:</span> <span>32</span><span>,</span> <span>color</span><span>:</span> <span>'</span><span>cyan</span><span>'</span><span>,</span> <span>fontWeight</span><span>:</span> <span>'</span><span>600</span><span>'</span> <span>}}</span><span>&gt;</span>
    <span>This</span> <span>is</span> <span>a</span> <span>sample</span> <span>text</span>
  <span>&lt;</span><span>/Text</span><span>&gt;
</span><span>&lt;</span><span>/View</span><span>&gt;
</span>
<span>const</span> <span>styles</span> <span>=</span> <span>StyleSheet</span><span>.</span><span>create</span><span>({</span>
  <span>container</span><span>:</span> <span>{</span>
    <span>flex</span><span>:</span> <span>1</span><span>,</span>
    <span>backgroundColor</span><span>:</span> <span>'</span><span>#fff</span><span>'</span><span>,</span>
    <span>alignItems</span><span>:</span> <span>'</span><span>center</span><span>'</span><span>,</span>
    <span>justifyContent</span><span>:</span> <span>'</span><span>center</span><span>'</span>
  <span>}</span>
<span>});</span>
```

In Flutter, a `Text` widget can take a `TextStyle` class for its style property. If you want to use the same text style in multiple places, you can create a [`TextStyle`](https://api.flutter.dev/flutter/dart-ui/TextStyle-class.html) class and use it for multiple `Text` widgets.

```
<span>const</span><span> </span><span>TextStyle</span><span> textStyle </span><span>=</span><span> </span><span>TextStyle</span><span>(</span><span>
  color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>cyan</span><span>,</span><span>
  fontSize</span><span>:</span><span> </span><span>32</span><span>,</span><span>
  fontWeight</span><span>:</span><span> </span><span>FontWeight</span><span>.</span><span>w600</span><span>,</span><span>
</span><span>);</span><span>

</span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
  child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
      </span><span>Text</span><span>(</span><span>'Sample text'</span><span>,</span><span> style</span><span>:</span><span> textStyle</span><span>),</span><span>
      </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>20</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>
          </span><span>Icons</span><span>.</span><span>lightbulb_outline</span><span>,</span><span>
          size</span><span>:</span><span> </span><span>48</span><span>,</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>redAccent</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

![Styling on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/flutterstyling.gif)

Android

![Styling on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/flutterstyling.gif)

iOS

### How do I use `Icons` and `Colors`?

React Native doesn’t include support for icons so third party libraries are used.

In Flutter, importing the Material library also pulls in the rich set of [Material icons](https://api.flutter.dev/flutter/material/Icons-class.html) and [colors](https://api.flutter.dev/flutter/material/Colors-class.html).

```
<span>return</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>lightbulb_outline</span><span>,</span><span> color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>redAccent</span><span>);</span>
```

When using the `Icons` class, make sure to set `uses-material-design: true` in the project’s `pubspec.yaml` file. This ensures that the `MaterialIcons` font, which displays the icons, is included in your app. In general, if you intend to use the Material library, you should include this line.

```
<span>name</span><span>:</span> <span>my_awesome_application</span>
<span>flutter</span><span>:</span>
  <span>uses-material-design</span><span>:</span> <span>true</span>
```

Flutter’s [Cupertino (iOS-style)](https://docs.flutter.dev/ui/widgets/cupertino) package provides high fidelity widgets for the current iOS design language. To use the `CupertinoIcons` font, add a dependency for `cupertino_icons` in your project’s `pubspec.yaml` file.

```
<span>name</span><span>:</span> <span>my_awesome_application</span>
<span>dependencies</span><span>:</span>
  <span>cupertino_icons</span><span>:</span> <span>^1.0.6</span>
```

To globally customize the colors and styles of components, use `ThemeData` to specify default colors for various aspects of the theme. Set the theme property in `MaterialApp` to the `ThemeData` object. The [`Colors`](https://api.flutter.dev/flutter/material/Colors-class.html) class provides colors from the Material Design [color palette](https://m2.material.io/design/color/the-color-system.html#color-theme-creation).

The following example sets the color scheme from seed to `deepPurple` and the text selection to `red`.

```
<span>class</span><span> </span><span>SampleApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SampleApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Sample App'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
          colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
          textSelectionTheme</span><span>:</span><span>
              </span><span>const</span><span> </span><span>TextSelectionThemeData</span><span>(</span><span>selectionColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>red</span><span>)),</span><span>
      home</span><span>:</span><span> </span><span>const</span><span> </span><span>SampleAppPage</span><span>(),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### How do I add style themes?

In React Native, common themes are defined for components in stylesheets and then used in components.

In Flutter, create uniform styling for almost everything by defining the styling in the [`ThemeData`](https://api.flutter.dev/flutter/material/ThemeData-class.html) class and passing it to the theme property in the [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html) widget.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
    theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
      primaryColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>cyan</span><span>,</span><span>
      brightness</span><span>:</span><span> </span><span>Brightness</span><span>.</span><span>dark</span><span>,</span><span>
    </span><span>),</span><span>
    home</span><span>:</span><span> </span><span>const</span><span> </span><span>StylingPage</span><span>(),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

A `Theme` can be applied even without using the `MaterialApp` widget. The [`Theme`](https://api.flutter.dev/flutter/material/Theme-class.html) widget takes a `ThemeData` in its `data` parameter and applies the `ThemeData` to all of its children widgets.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Theme</span><span>(</span><span>
    data</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
      primaryColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>cyan</span><span>,</span><span>
      brightness</span><span>:</span><span> brightness</span><span>,</span><span>
    </span><span>),</span><span>
    child</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
      backgroundColor</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>primaryColor</span><span>,</span><span>
      </span><span>//...</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

## State management

State is information that can be read synchronously when a widget is built or information that might change during the lifetime of a widget. To manage app state in Flutter, use a [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) paired with a State object.

For more information on ways to approach managing state in Flutter, see [State management](https://docs.flutter.dev/data-and-backend/state-mgmt).

### The StatelessWidget

A `StatelessWidget` in Flutter is a widget that doesn’t require a state change— it has no internal state to manage.

Stateless widgets are useful when the part of the user interface you are describing does not depend on anything other than the configuration information in the object itself and the [`BuildContext`](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) in which the widget is inflated.

[`AboutDialog`](https://api.flutter.dev/flutter/material/AboutDialog-class.html), [`CircleAvatar`](https://api.flutter.dev/flutter/material/CircleAvatar-class.html), and [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) are examples of stateless widgets that subclass [`StatelessWidget`](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html).

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>
      </span><span>const</span><span> </span><span>MyStatelessWidget</span><span>(</span><span>
        text</span><span>:</span><span> </span><span>'StatelessWidget Example to show immutable data'</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>

</span><span>class</span><span> </span><span>MyStatelessWidget</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyStatelessWidget</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>text</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> text</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Center</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
        text</span><span>,</span><span>
        textDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The previous example uses the constructor of the `MyStatelessWidget` class to pass the `text`, which is marked as `final`. This class extends `StatelessWidget`—it contains immutable data.

The `build` method of a stateless widget is typically called in only three situations:

-   When the widget is inserted into a tree
-   When the widget’s parent changes its configuration
-   When an [`InheritedWidget`](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html) it depends on, changes

### The StatefulWidget

A [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) is a widget that changes state. Use the `setState` method to manage the state changes for a `StatefulWidget`. A call to `setState()` tells the Flutter framework that something has changed in a state, which causes an app to rerun the `build()` method so that the app can reflect the change.

_State_ is information that can be read synchronously when a widget is built and might change during the lifetime of the widget. It’s the responsibility of the widget implementer to ensure that the state object is promptly notified when the state changes. Use `StatefulWidget` when a widget can change dynamically. For example, the state of the widget changes by typing into a form, or moving a slider. Or, it can change over time—perhaps a data feed updates the UI.

[`Checkbox`](https://api.flutter.dev/flutter/material/Checkbox-class.html), [`Radio`](https://api.flutter.dev/flutter/material/Radio-class.html), [`Slider`](https://api.flutter.dev/flutter/material/Slider-class.html), [`InkWell`](https://api.flutter.dev/flutter/material/InkWell-class.html), [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html), and [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) are examples of stateful widgets that subclass [`StatefulWidget`](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html).

The following example declares a `StatefulWidget` that requires a `createState()` method. This method creates the state object that manages the widget’s state, `_MyStatefulWidgetState`.

```
<span>class</span><span> </span><span>MyStatefulWidget</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyStatefulWidget</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyStatefulWidget</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyStatefulWidgetState</span><span>();</span><span>
</span><span>}</span>
```

The following state class, `_MyStatefulWidgetState`, implements the `build()` method for the widget. When the state changes, for example, when the user toggles the button, `setState()` is called with the new toggle value. This causes the framework to rebuild this widget in the UI.

```
<span>class</span><span> _MyStatefulWidgetState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyStatefulWidget</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>bool</span><span> showText </span><span>=</span><span> </span><span>true</span><span>;</span><span>
  </span><span>bool</span><span> toggleState </span><span>=</span><span> </span><span>true</span><span>;</span><span>
  </span><span>Timer</span><span>?</span><span> t2</span><span>;</span><span>

  </span><span>void</span><span> toggleBlinkState</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      toggleState </span><span>=</span><span> </span><span>!</span><span>toggleState</span><span>;</span><span>
    </span><span>});</span><span>
    </span><span>if</span><span> </span><span>(!</span><span>toggleState</span><span>)</span><span> </span><span>{</span><span>
      t2 </span><span>=</span><span> </span><span>Timer</span><span>.</span><span>periodic</span><span>(</span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>1000</span><span>),</span><span> </span><span>(</span><span>t</span><span>)</span><span> </span><span>{</span><span>
        toggleShowText</span><span>();</span><span>
      </span><span>});</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
      t2</span><span>?.</span><span>cancel</span><span>();</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>void</span><span> toggleShowText</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      showText </span><span>=</span><span> </span><span>!</span><span>showText</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
            </span><span>if</span><span> </span><span>(</span><span>showText</span><span>)</span><span>
              </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
                </span><span>'This execution will be done before you can blink.'</span><span>,</span><span>
              </span><span>),</span><span>
            </span><span>Padding</span><span>(</span><span>
              padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>only</span><span>(</span><span>top</span><span>:</span><span> </span><span>70</span><span>),</span><span>
              child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
                onPressed</span><span>:</span><span> toggleBlinkState</span><span>,</span><span>
                child</span><span>:</span><span> toggleState
                    </span><span>?</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Blink'</span><span>)</span><span>
                    </span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Stop Blinking'</span><span>),</span><span>
              </span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### What are the StatefulWidget and StatelessWidget best practices?

Here are a few things to consider when designing your widget.

1.  Determine whether a widget should be a `StatefulWidget` or a `StatelessWidget`.

In Flutter, widgets are either Stateful or Stateless—depending on whether they depend on a state change.

-   If a widget changes—the user interacts with it or a data feed interrupts the UI, then it’s _Stateful_.
-   If a widget is final or immutable, then it’s _Stateless_.

1.  Determine which object manages the widget’s state (for a `StatefulWidget`).

In Flutter, there are three primary ways to manage state:

-   The widget manages its own state
-   The parent widget manages the widget’s state
-   A mix-and-match approach

When deciding which approach to use, consider the following principles:

-   If the state in question is user data, for example the checked or unchecked mode of a checkbox, or the position of a slider, then the state is best managed by the parent widget.
-   If the state in question is aesthetic, for example an animation, then the widget itself best manages the state.
-   When in doubt, let the parent widget manage the child widget’s state.

1.  Subclass StatefulWidget and State.

The `MyStatefulWidget` class manages its own state—it extends `StatefulWidget`, it overrides the `createState()` method to create the `State` object, and the framework calls `createState()` to build the widget. In this example, `createState()` creates an instance of `_MyStatefulWidgetState`, which is implemented in the next best practice.

```
<span>class</span><span> </span><span>MyStatefulWidget</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyStatefulWidget</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>
  @override
  </span><span>State</span><span>&lt;</span><span>MyStatefulWidget</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyStatefulWidgetState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyStatefulWidgetState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyStatefulWidget</span><span>&gt;</span><span> </span><span>{</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>//...</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

1.  Add the StatefulWidget into the widget tree.

Add your custom `StatefulWidget` to the widget tree in the app’s build method.

```
<span>class</span><span> </span><span>MyStatelessWidget</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>MyStatelessWidget</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Flutter Demo'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>MyStatefulWidget</span><span>(</span><span>title</span><span>:</span><span> </span><span>'State Change Demo'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![State change on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/state-change.gif)

Android

![State change on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/state-change.gif)

iOS

## Props

In React Native, most components can be customized when they are created with different parameters or properties, called `props`. These parameters can be used in a child component using `this.props`.

```
<span>// React Native</span>
<span>const</span> <span>CustomCard</span> <span>=</span> <span>({</span> <span>index</span><span>,</span> <span>onPress</span> <span>})</span> <span>=&gt;</span> <span>{</span>
  <span>return </span><span>(</span>
    <span>&lt;</span><span>View</span><span>&gt;</span>
      <span>&lt;</span><span>Text</span><span>&gt;</span> <span>Card</span> <span>{</span><span>index</span><span>}</span> <span>&lt;</span><span>/Text</span><span>&gt;
</span>      <span>&lt;</span><span>Button</span>
        <span>title</span><span>=</span><span>'</span><span>Press</span><span>'</span>
        <span>onPress</span><span>=</span><span>{()</span> <span>=&gt;</span> <span>onPress</span><span>(</span><span>index</span><span>)}</span>
      <span>/</span><span>&gt;
</span>    <span>&lt;</span><span>/View</span><span>&gt;
</span>  <span>);</span>
<span>};</span>

<span>const</span> <span>App</span> <span>=</span> <span>()</span> <span>=&gt;</span> <span>{</span>
  <span>const</span> <span>onPress</span> <span>=</span> <span>(</span><span>index</span><span>)</span> <span>=&gt;</span> <span>{</span>
    <span>console</span><span>.</span><span>log</span><span>(</span><span>'</span><span>Card </span><span>'</span><span>,</span> <span>index</span><span>);</span>
  <span>};</span>

  <span>return </span><span>(</span>
    <span>&lt;</span><span>View</span><span>&gt;</span>
      <span>&lt;</span><span>FlatList</span>
        <span>data</span><span>=</span><span>{[</span> <span>/* ... */</span> <span>]}</span>
        <span>renderItem</span><span>=</span><span>{({</span> <span>item</span> <span>})</span> <span>=&gt;</span> <span>(</span>
          <span>&lt;</span><span>CustomCard</span> <span>onPress</span><span>=</span><span>{</span><span>onPress</span><span>}</span> <span>index</span><span>=</span><span>{</span><span>item</span><span>.</span><span>key</span><span>}</span> <span>/</span><span>&gt;
</span>        <span>)}</span>
      <span>/</span><span>&gt;
</span>    <span>&lt;</span><span>/View</span><span>&gt;
</span>  <span>);</span>
<span>};</span>
```

In Flutter, you assign a local variable or function marked `final` with the property received in the parameterized constructor.

```
<span>/// Flutter</span><span>
</span><span>class</span><span> </span><span>CustomCard</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>CustomCard</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>index</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>onPress</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>int</span><span> index</span><span>;</span><span>
  </span><span>final</span><span> </span><span>void</span><span> </span><span>Function</span><span>()</span><span> onPress</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Card</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
          </span><span>Text</span><span>(</span><span>'Card $index'</span><span>),</span><span>
          </span><span>TextButton</span><span>(</span><span>
            onPressed</span><span>:</span><span> onPress</span><span>,</span><span>
            child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Press'</span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>UseCard</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>UseCard</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>index</span><span>});</span><span>

  </span><span>final</span><span> </span><span>int</span><span> index</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>/// Usage</span><span>
    </span><span>return</span><span> </span><span>CustomCard</span><span>(</span><span>
      index</span><span>:</span><span> index</span><span>,</span><span>
      onPress</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        print</span><span>(</span><span>'Card $index'</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![Cards on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/modular.png)

Android

![Cards on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/modular.png)

iOS

## Local storage

If you don’t need to store a lot of data, and it doesn’t require structure, you can use `shared_preferences` which allows you to read and write persistent key-value pairs of primitive data types: booleans, floats, ints, longs, and strings.

### How do I store persistent key-value pairs that are global to the app?

In React Native, you use the `setItem` and `getItem` functions of the `AsyncStorage` component to store and retrieve data that is persistent and global to the app.

```
<span>// React Native</span>
<span>const</span> <span>[</span><span>counter</span><span>,</span> <span>setCounter</span><span>]</span> <span>=</span> <span>useState</span><span>(</span><span>0</span><span>)</span>
<span>...</span>
<span>await</span> <span>AsyncStorage</span><span>.</span><span>setItem</span><span>(</span> <span>'</span><span>counterkey</span><span>'</span><span>,</span> <span>json</span><span>.</span><span>stringify</span><span>(</span><span>++</span><span>this</span><span>.</span><span>state</span><span>.</span><span>counter</span><span>));</span>
<span>AsyncStorage</span><span>.</span><span>getItem</span><span>(</span><span>'</span><span>counterkey</span><span>'</span><span>).</span><span>then</span><span>(</span><span>value</span> <span>=&gt;</span> <span>{</span>
  <span>if </span><span>(</span><span>value</span> <span>!=</span> <span>null</span><span>)</span> <span>{</span>
    <span>setCounter</span><span>(</span><span>value</span><span>);</span>
  <span>}</span>
<span>});</span>
```

In Flutter, use the [`shared_preferences`](https://github.com/flutter/packages/tree/main/packages/shared_preferences/shared_preferences) plugin to store and retrieve key-value data that is persistent and global to the app. The `shared_preferences` plugin wraps `NSUserDefaults` on iOS and `SharedPreferences` on Android, providing a persistent store for simple data.

To add the `shared_preferences` package as a dependency, run `flutter pub add`:

```
<span>$</span><span> </span>flutter pub add shared_preferences
```

```
<span>import</span><span> </span><span>'package:shared_preferences/shared_preferences.dart'</span><span>;</span>
```

To implement persistent data, use the setter methods provided by the `SharedPreferences` class. Setter methods are available for various primitive types, such as `setInt`, `setBool`, and `setString`. To read data, use the appropriate getter method provided by the `SharedPreferences` class. For each setter there is a corresponding getter method, for example, `getInt`, `getBool`, and `getString`.

```
<span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> updateCounter</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> prefs </span><span>=</span><span> </span><span>await</span><span> </span><span>SharedPreferences</span><span>.</span><span>getInstance</span><span>();</span><span>
  </span><span>int</span><span>?</span><span> counter </span><span>=</span><span> prefs</span><span>.</span><span>getInt</span><span>(</span><span>'counter'</span><span>);</span><span>
  </span><span>if</span><span> </span><span>(</span><span>counter </span><span>is</span><span> </span><span>int</span><span>)</span><span> </span><span>{</span><span>
    </span><span>await</span><span> prefs</span><span>.</span><span>setInt</span><span>(</span><span>'counter'</span><span>,</span><span> </span><span>++</span><span>counter</span><span>);</span><span>
  </span><span>}</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    _counter </span><span>=</span><span> counter</span><span>;</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

## Routing

Most apps contain several screens for displaying different types of information. For example, you might have a product screen that displays images where users could tap on a product image to get more information about the product on a new screen.

In Android, new screens are new Activities. In iOS, new screens are new ViewControllers. In Flutter, screens are just Widgets! And to navigate to new screens in Flutter, use the Navigator widget.

### How do I navigate between screens?

In React Native, there are three main navigators: StackNavigator, TabNavigator, and DrawerNavigator. Each provides a way to configure and define the screens.

```
<span>// React Native</span>
<span>const</span> <span>MyApp</span> <span>=</span> <span>TabNavigator</span><span>(</span>
  <span>{</span> <span>Home</span><span>:</span> <span>{</span> <span>screen</span><span>:</span> <span>HomeScreen</span> <span>},</span> <span>Notifications</span><span>:</span> <span>{</span> <span>screen</span><span>:</span> <span>tabNavScreen</span> <span>}</span> <span>},</span>
  <span>{</span> <span>tabBarOptions</span><span>:</span> <span>{</span> <span>activeTintColor</span><span>:</span> <span>'</span><span>#e91e63</span><span>'</span> <span>}</span> <span>}</span>
<span>);</span>
<span>const</span> <span>SimpleApp</span> <span>=</span> <span>StackNavigator</span><span>({</span>
  <span>Home</span><span>:</span> <span>{</span> <span>screen</span><span>:</span> <span>MyApp</span> <span>},</span>
  <span>stackScreen</span><span>:</span> <span>{</span> <span>screen</span><span>:</span> <span>StackScreen</span> <span>}</span>
<span>});</span>
<span>export</span> <span>default </span><span>(</span><span>MyApp1</span> <span>=</span> <span>DrawerNavigator</span><span>({</span>
  <span>Home</span><span>:</span> <span>{</span>
    <span>screen</span><span>:</span> <span>SimpleApp</span>
  <span>},</span>
  <span>Screen2</span><span>:</span> <span>{</span>
    <span>screen</span><span>:</span> <span>drawerScreen</span>
  <span>}</span>
<span>}));</span>
```

In Flutter, there are two main widgets used to navigate between screens:

-   A [`Route`](https://api.flutter.dev/flutter/widgets/Route-class.html) is an abstraction for an app screen or page.
-   A [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html) is a widget that manages routes.

A `Navigator` is defined as a widget that manages a set of child widgets with a stack discipline. The navigator manages a stack of `Route` objects and provides methods for managing the stack, like [`Navigator.push`](https://api.flutter.dev/flutter/widgets/Navigator/push.html) and [`Navigator.pop`](https://api.flutter.dev/flutter/widgets/Navigator/pop.html). A list of routes might be specified in the [`MaterialApp`](https://api.flutter.dev/flutter/material/MaterialApp-class.html) widget, or they might be built on the fly, for example, in hero animations. The following example specifies named routes in the `MaterialApp` widget.

```
<span>class</span><span> </span><span>NavigationApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>// This widget is the root of your application.</span><span>
  </span><span>const</span><span> </span><span>NavigationApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      </span><span>//...</span><span>
      routes</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>WidgetBuilder</span><span>&gt;{</span><span>
        </span><span>'/a'</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>UsualNavScreen</span><span>(),</span><span>
        </span><span>'/b'</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>DrawerNavScreen</span><span>(),</span><span>
      </span><span>},</span><span>
      </span><span>//...</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

To navigate to a named route, the [`Navigator.of()`](https://api.flutter.dev/flutter/widgets/Navigator/of.html) method is used to specify the `BuildContext` (a handle to the location of a widget in the widget tree). The name of the route is passed to the `pushNamed` function to navigate to the specified route.

```
<span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/a'</span><span>);</span>
```

You can also use the push method of `Navigator` which adds the given [`Route`](https://api.flutter.dev/flutter/widgets/Route-class.html) to the history of the navigator that most tightly encloses the given [`BuildContext`](https://api.flutter.dev/flutter/widgets/BuildContext-class.html), and transitions to it. In the following example, the [`MaterialPageRoute`](https://api.flutter.dev/flutter/material/MaterialPageRoute-class.html) widget is a modal route that replaces the entire screen with a platform-adaptive transition. It takes a [`WidgetBuilder`](https://api.flutter.dev/flutter/widgets/WidgetBuilder.html) as a required parameter.

```
<span>Navigator</span><span>.</span><span>push</span><span>(</span><span>
  context</span><span>,</span><span>
  </span><span>MaterialPageRoute</span><span>(</span><span>
    builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>UsualNavScreen</span><span>(),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### How do I use tab navigation and drawer navigation?

In Material Design apps, there are two primary options for Flutter navigation: tabs and drawers. When there is insufficient space to support tabs, drawers provide a good alternative.

#### Tab navigation

In React Native, `createBottomTabNavigator` and `TabNavigation` are used to show tabs and for tab navigation.

```
<span>// React Native</span>
<span>import</span> <span>{</span> <span>createBottomTabNavigator</span> <span>}</span> <span>from</span> <span>'</span><span>react-navigation</span><span>'</span><span>;</span>

<span>const</span> <span>MyApp</span> <span>=</span> <span>TabNavigator</span><span>(</span>
  <span>{</span> <span>Home</span><span>:</span> <span>{</span> <span>screen</span><span>:</span> <span>HomeScreen</span> <span>},</span> <span>Notifications</span><span>:</span> <span>{</span> <span>screen</span><span>:</span> <span>tabNavScreen</span> <span>}</span> <span>},</span>
  <span>{</span> <span>tabBarOptions</span><span>:</span> <span>{</span> <span>activeTintColor</span><span>:</span> <span>'</span><span>#e91e63</span><span>'</span> <span>}</span> <span>}</span>
<span>);</span>
```

Flutter provides several specialized widgets for drawer and tab navigation:

[`TabController`](https://api.flutter.dev/flutter/material/TabController-class.html)

Coordinates the tab selection between a `TabBar` and a `TabBarView`.

[`TabBar`](https://api.flutter.dev/flutter/material/TabBar-class.html)

Displays a horizontal row of tabs.

[`Tab`](https://api.flutter.dev/flutter/material/Tab-class.html)

Creates a material design TabBar tab.

[`TabBarView`](https://api.flutter.dev/flutter/material/TabBarView-class.html)

Displays the widget that corresponds to the currently selected tab.

```
<span>class</span><span> _MyAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyApp</span><span>&gt;</span><span> </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>TabController</span><span> controller </span><span>=</span><span> </span><span>TabController</span><span>(</span><span>length</span><span>:</span><span> </span><span>2</span><span>,</span><span> vsync</span><span>:</span><span> </span><span>this</span><span>);</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>TabBar</span><span>(</span><span>
      controller</span><span>:</span><span> controller</span><span>,</span><span>
      tabs</span><span>:</span><span> </span><span>const</span><span> </span><span>&lt;</span><span>Tab</span><span>&gt;[</span><span>
        </span><span>Tab</span><span>(</span><span>icon</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>person</span><span>)),</span><span>
        </span><span>Tab</span><span>(</span><span>icon</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>email</span><span>)),</span><span>
      </span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

A `TabController` is required to coordinate the tab selection between a `TabBar` and a `TabBarView`. The `TabController` constructor `length` argument is the total number of tabs. A `TickerProvider` is required to trigger the notification whenever a frame triggers a state change. The `TickerProvider` is `vsync`. Pass the `vsync: this` argument to the `TabController` constructor whenever you create a new `TabController`.

The [`TickerProvider`](https://api.flutter.dev/flutter/scheduler/TickerProvider-class.html) is an interface implemented by classes that can vend [`Ticker`](https://api.flutter.dev/flutter/scheduler/Ticker-class.html) objects. Tickers can be used by any object that must be notified whenever a frame triggers, but they’re most commonly used indirectly via an [`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html). `AnimationController`s need a `TickerProvider` to obtain their `Ticker`. If you are creating an AnimationController from a State, then you can use the [`TickerProviderStateMixin`](https://api.flutter.dev/flutter/widgets/TickerProviderStateMixin-mixin.html) or [`SingleTickerProviderStateMixin`](https://api.flutter.dev/flutter/widgets/SingleTickerProviderStateMixin-mixin.html) classes to obtain a suitable `TickerProvider`.

The [`Scaffold`](https://api.flutter.dev/flutter/material/Scaffold-class.html) widget wraps a new `TabBar` widget and creates two tabs. The `TabBarView` widget is passed as the `body` parameter of the `Scaffold` widget. All screens corresponding to the `TabBar` widget’s tabs are children to the `TabBarView` widget along with the same `TabController`.

```
<span>class</span><span> _NavigationHomePageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>NavigationHomePage</span><span>&gt;</span><span>
    </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>TabController</span><span> controller </span><span>=</span><span> </span><span>TabController</span><span>(</span><span>length</span><span>:</span><span> </span><span>2</span><span>,</span><span> vsync</span><span>:</span><span> </span><span>this</span><span>);</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
        bottomNavigationBar</span><span>:</span><span> </span><span>Material</span><span>(</span><span>
          color</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>blue</span><span>,</span><span>
          child</span><span>:</span><span> </span><span>TabBar</span><span>(</span><span>
            tabs</span><span>:</span><span> </span><span>const</span><span> </span><span>&lt;</span><span>Tab</span><span>&gt;[</span><span>
              </span><span>Tab</span><span>(</span><span>
                icon</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>person</span><span>),</span><span>
              </span><span>),</span><span>
              </span><span>Tab</span><span>(</span><span>
                icon</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>email</span><span>),</span><span>
              </span><span>),</span><span>
            </span><span>],</span><span>
            controller</span><span>:</span><span> controller</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>TabBarView</span><span>(</span><span>
          controller</span><span>:</span><span> controller</span><span>,</span><span>
          children</span><span>:</span><span> </span><span>const</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>HomeScreen</span><span>(),</span><span> </span><span>TabScreen</span><span>()],</span><span>
        </span><span>));</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

#### Drawer navigation

In React Native, import the needed react-navigation packages and then use `createDrawerNavigator` and `DrawerNavigation`.

```
<span>// React Native</span>
<span>export</span> <span>default </span><span>(</span><span>MyApp1</span> <span>=</span> <span>DrawerNavigator</span><span>({</span>
  <span>Home</span><span>:</span> <span>{</span>
    <span>screen</span><span>:</span> <span>SimpleApp</span>
  <span>},</span>
  <span>Screen2</span><span>:</span> <span>{</span>
    <span>screen</span><span>:</span> <span>drawerScreen</span>
  <span>}</span>
<span>}));</span>
```

In Flutter, we can use the `Drawer` widget in combination with a `Scaffold` to create a layout with a Material Design drawer. To add a `Drawer` to an app, wrap it in a `Scaffold` widget. The `Scaffold` widget provides a consistent visual structure to apps that follow the [Material Design](https://m3.material.io/styles) guidelines. It also supports special Material Design components, such as `Drawers`, `AppBars`, and `SnackBars`.

The `Drawer` widget is a Material Design panel that slides in horizontally from the edge of a `Scaffold` to show navigation links in an application. You can provide a [`ElevatedButton`](https://api.flutter.dev/flutter/material/ElevatedButton-class.html), a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget, or a list of items to display as the child to the `Drawer` widget. In the following example, the [`ListTile`](https://api.flutter.dev/flutter/material/ListTile-class.html) widget provides the navigation on tap.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Drawer</span><span>(</span><span>
    elevation</span><span>:</span><span> </span><span>20</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>ListTile</span><span>(</span><span>
      leading</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>change_history</span><span>),</span><span>
      title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Screen2'</span><span>),</span><span>
      onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        </span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/b'</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The `Scaffold` widget also includes an `AppBar` widget that automatically displays an appropriate IconButton to show the `Drawer` when a Drawer is available in the `Scaffold`. The `Scaffold` automatically handles the edge-swipe gesture to show the `Drawer`.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
    drawer</span><span>:</span><span> </span><span>Drawer</span><span>(</span><span>
      elevation</span><span>:</span><span> </span><span>20</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>ListTile</span><span>(</span><span>
        leading</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>change_history</span><span>),</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Screen2'</span><span>),</span><span>
        onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
          </span><span>Navigator</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>pushNamed</span><span>(</span><span>'/b'</span><span>);</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
    appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Home'</span><span>)),</span><span>
    body</span><span>:</span><span> </span><span>Container</span><span>(),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

![Navigation on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/navigation.gif)

Android

![Navigation on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/navigation.gif)

iOS

## Gesture detection and touch event handling

To listen for and respond to gestures, Flutter supports taps, drags, and scaling. The gesture system in Flutter has two separate layers. The first layer includes raw pointer events, which describe the location and movement of pointers, (such as touches, mice, and styli movements), across the screen. The second layer includes gestures, which describe semantic actions that consist of one or more pointer movements.

### How do I add a click or press listeners to a widget?

In React Native, listeners are added to components using `PanResponder` or the `Touchable` components.

```
<span>// React Native</span>
<span>&lt;</span><span>TouchableOpacity</span>
  <span>onPress</span><span>=</span><span>{()</span> <span>=&gt;</span> <span>{</span>
    <span>console</span><span>.</span><span>log</span><span>(</span><span>'</span><span>Press</span><span>'</span><span>);</span>
  <span>}}</span>
  <span>onLongPress</span><span>=</span><span>{()</span> <span>=&gt;</span> <span>{</span>
    <span>console</span><span>.</span><span>log</span><span>(</span><span>'</span><span>Long Press</span><span>'</span><span>);</span>
  <span>}}</span>
<span>&gt;</span>
  <span>&lt;</span><span>Text</span><span>&gt;</span><span>Tap</span> <span>or</span> <span>Long</span> <span>Press</span><span>&lt;</span><span>/Text</span><span>&gt;
</span><span>&lt;</span><span>/TouchableOpacity</span><span>&gt;
</span>
```

For more complex gestures and combining several touches into a single gesture, [`PanResponder`](https://facebook.github.io/react-native/docs/panresponder.html) is used.

```
<span>// React Native</span>
<span>const</span> <span>App</span> <span>=</span> <span>()</span> <span>=&gt;</span> <span>{</span>
  <span>const</span> <span>panResponderRef</span> <span>=</span> <span>useRef</span><span>(</span><span>null</span><span>);</span>

  <span>useEffect</span><span>(()</span> <span>=&gt;</span> <span>{</span>
    <span>panResponderRef</span><span>.</span><span>current</span> <span>=</span> <span>PanResponder</span><span>.</span><span>create</span><span>({</span>
      <span>onMoveShouldSetPanResponder</span><span>:</span> <span>(</span><span>event</span><span>,</span> <span>gestureState</span><span>)</span> <span>=&gt;</span>
        <span>!!</span><span>getDirection</span><span>(</span><span>gestureState</span><span>),</span>
      <span>onPanResponderMove</span><span>:</span> <span>(</span><span>event</span><span>,</span> <span>gestureState</span><span>)</span> <span>=&gt;</span> <span>true</span><span>,</span>
      <span>onPanResponderRelease</span><span>:</span> <span>(</span><span>event</span><span>,</span> <span>gestureState</span><span>)</span> <span>=&gt;</span> <span>{</span>
        <span>const</span> <span>drag</span> <span>=</span> <span>getDirection</span><span>(</span><span>gestureState</span><span>);</span>
      <span>},</span>
      <span>onPanResponderTerminationRequest</span><span>:</span> <span>(</span><span>event</span><span>,</span> <span>gestureState</span><span>)</span> <span>=&gt;</span> <span>true</span>
    <span>});</span>
  <span>},</span> <span>[]);</span>

  <span>return </span><span>(</span>
    <span>&lt;</span><span>View</span> <span>style</span><span>=</span><span>{</span><span>styles</span><span>.</span><span>container</span><span>}</span> <span>{...</span><span>panResponderRef</span><span>.</span><span>current</span><span>.</span><span>panHandlers</span><span>}</span><span>&gt;</span>
      <span>&lt;</span><span>View</span> <span>style</span><span>=</span><span>{</span><span>styles</span><span>.</span><span>center</span><span>}</span><span>&gt;</span>
        <span>&lt;</span><span>Text</span><span>&gt;</span><span>Swipe</span> <span>Horizontally</span> <span>or</span> <span>Vertically</span><span>&lt;</span><span>/Text</span><span>&gt;
</span>      <span>&lt;</span><span>/View</span><span>&gt;
</span>    <span>&lt;</span><span>/View</span><span>&gt;
</span>  <span>);</span>
<span>};</span>
```

In Flutter, to add a click (or press) listener to a widget, use a button or a touchable widget that has an `onPress: field`. Or, add gesture detection to any widget by wrapping it in a [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html).

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Gestures'</span><span>)),</span><span>
      body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
        children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
          </span><span>Text</span><span>(</span><span>'Tap, Long Press, Swipe Horizontally or Vertically'</span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>)),</span><span>
    </span><span>),</span><span>
    onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
      print</span><span>(</span><span>'Tapped'</span><span>);</span><span>
    </span><span>},</span><span>
    onLongPress</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
      print</span><span>(</span><span>'Long Pressed'</span><span>);</span><span>
    </span><span>},</span><span>
    onVerticalDragEnd</span><span>:</span><span> </span><span>(</span><span>value</span><span>)</span><span> </span><span>{</span><span>
      print</span><span>(</span><span>'Swiped Vertically'</span><span>);</span><span>
    </span><span>},</span><span>
    onHorizontalDragEnd</span><span>:</span><span> </span><span>(</span><span>value</span><span>)</span><span> </span><span>{</span><span>
      print</span><span>(</span><span>'Swiped Horizontally'</span><span>);</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

For more information, including a list of Flutter `GestureDetector` callbacks, see the [GestureDetector class](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html#instance-properties).

![Gestures on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/flutter-gestures.gif)

Android

![Gestures on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/flutter-gestures.gif)

iOS

## Making HTTP network requests

Fetching data from the internet is common for most apps. And in Flutter, the `http` package provides the simplest way to fetch data from the internet.

### How do I fetch data from API calls?

React Native provides the Fetch API for networking—you make a fetch request and then receive the response to get the data.

```
<span>// React Native</span>
<span>const</span> <span>[</span><span>ipAddress</span><span>,</span> <span>setIpAddress</span><span>]</span> <span>=</span> <span>useState</span><span>(</span><span>''</span><span>)</span>

<span>const</span> <span>_getIPAddress</span> <span>=</span> <span>()</span> <span>=&gt;</span> <span>{</span>
  <span>fetch</span><span>(</span><span>'</span><span>https://httpbin.org/ip</span><span>'</span><span>)</span>
    <span>.</span><span>then</span><span>(</span><span>response</span> <span>=&gt;</span> <span>response</span><span>.</span><span>json</span><span>())</span>
    <span>.</span><span>then</span><span>(</span><span>responseJson</span> <span>=&gt;</span> <span>{</span>
      <span>setIpAddress</span><span>(</span><span>responseJson</span><span>.</span><span>origin</span><span>);</span>
    <span>})</span>
    <span>.</span><span>catch</span><span>(</span><span>error</span> <span>=&gt;</span> <span>{</span>
      <span>console</span><span>.</span><span>error</span><span>(</span><span>error</span><span>);</span>
    <span>});</span>
<span>};</span>
```

Flutter uses the `http` package.

To add the `http` package as a dependency, run `flutter pub add`:

Flutter uses the [`dart:io`](https://api.flutter.dev/flutter/dart-io/dart-io-library.html) core HTTP support client. To create an HTTP Client, import `dart:io`.

The client supports the following HTTP operations: GET, POST, PUT, and DELETE.

```
<span>final</span><span> url </span><span>=</span><span> </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://httpbin.org/ip'</span><span>);</span><span>
</span><span>final</span><span> httpClient </span><span>=</span><span> </span><span>HttpClient</span><span>();</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> getIPAddress</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> request </span><span>=</span><span> </span><span>await</span><span> httpClient</span><span>.</span><span>getUrl</span><span>(</span><span>url</span><span>);</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> request</span><span>.</span><span>close</span><span>();</span><span>
  </span><span>final</span><span> responseBody </span><span>=</span><span> </span><span>await</span><span> response</span><span>.</span><span>transform</span><span>(</span><span>utf8</span><span>.</span><span>decoder</span><span>).</span><span>join</span><span>();</span><span>
  </span><span>final</span><span> ip </span><span>=</span><span> jsonDecode</span><span>(</span><span>responseBody</span><span>)[</span><span>'origin'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>;</span><span>
  setState</span><span>(()</span><span> </span><span>{</span><span>
    _ipAddress </span><span>=</span><span> ip</span><span>;</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

![API calls on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/api-calls.gif)

Android

![API calls on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/api-calls.gif)

iOS

## Form input

Text fields allow users to type text into your app so they can be used to build forms, messaging apps, search experiences, and more. Flutter provides two core text field widgets: [`TextField`](https://api.flutter.dev/flutter/material/TextField-class.html) and [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html).

### How do I use text field widgets?

In React Native, to enter text you use a `TextInput` component to show a text input box and then use the callback to store the value in a variable.

```
<span>// React Native</span>
<span>const</span> <span>[</span><span>password</span><span>,</span> <span>setPassword</span><span>]</span> <span>=</span> <span>useState</span><span>(</span><span>''</span><span>)</span>
<span>...</span>
<span>&lt;</span><span>TextInput</span>
  <span>placeholder</span><span>=</span><span>"</span><span>Enter your Password</span><span>"</span>
  <span>onChangeText</span><span>=</span><span>{</span><span>password</span> <span>=&gt;</span> <span>setPassword</span><span>(</span><span>password</span><span>)}</span>
<span>/</span><span>&gt;
</span><span>&lt;</span><span>Button</span> <span>title</span><span>=</span><span>"</span><span>Submit</span><span>"</span> <span>onPress</span><span>=</span><span>{</span><span>this</span><span>.</span><span>validate</span><span>}</span> <span>/</span><span>&gt;
</span>
```

In Flutter, use the [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) class to manage a `TextField` widget. Whenever the text field is modified, the controller notifies its listeners.

Listeners read the text and selection properties to learn what the user typed into the field. You can access the text in `TextField` by the `text` property of the controller.

```
<span>final</span><span> </span><span>TextEditingController</span><span> _controller </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>

@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Column</span><span>(</span><span>children</span><span>:</span><span> </span><span>[</span><span>
    </span><span>TextField</span><span>(</span><span>
      controller</span><span>:</span><span> _controller</span><span>,</span><span>
      decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>InputDecoration</span><span>(</span><span>
        hintText</span><span>:</span><span> </span><span>'Type something'</span><span>,</span><span>
        labelText</span><span>:</span><span> </span><span>'Text Field'</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
    </span><span>ElevatedButton</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Submit'</span><span>),</span><span>
      onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        showDialog</span><span>(</span><span>
            context</span><span>:</span><span> context</span><span>,</span><span>
            builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>{</span><span>
              </span><span>return</span><span> </span><span>AlertDialog</span><span>(</span><span>
                title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Alert'</span><span>),</span><span>
                content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'You typed ${_controller.text}'</span><span>),</span><span>
              </span><span>);</span><span>
            </span><span>});</span><span>
      </span><span>},</span><span>
    </span><span>),</span><span>
  </span><span>]);</span><span>
</span><span>}</span>
```

In this example, when a user clicks on the submit button an alert dialog displays the current text entered in the text field. This is achieved using an [`AlertDialog`](https://api.flutter.dev/flutter/material/AlertDialog-class.html) widget that displays the alert message, and the text from the `TextField` is accessed by the `text` property of the [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html).

### How do I use Form widgets?

In Flutter, use the [`Form`](https://api.flutter.dev/flutter/widgets/Form-class.html) widget where [`TextFormField`](https://api.flutter.dev/flutter/material/TextFormField-class.html) widgets along with the submit button are passed as children. The `TextFormField` widget has a parameter called [`onSaved`](https://api.flutter.dev/flutter/widgets/FormField/onSaved.html) that takes a callback and executes when the form is saved. A `FormState` object is used to save, reset, or validate each `FormField` that is a descendant of this `Form`. To obtain the `FormState`, you can use `Form.of()` with a context whose ancestor is the `Form`, or pass a `GlobalKey` to the `Form` constructor and call `GlobalKey.currentState()`.

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Form</span><span>(</span><span>
    key</span><span>:</span><span> formKey</span><span>,</span><span>
    child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
      children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
        </span><span>TextFormField</span><span>(</span><span>
          validator</span><span>:</span><span> </span><span>(</span><span>value</span><span>)</span><span> </span><span>{</span><span>
            </span><span>if</span><span> </span><span>(</span><span>value </span><span>!=</span><span> </span><span>null</span><span> </span><span>&amp;&amp;</span><span> value</span><span>.</span><span>contains</span><span>(</span><span>'@'</span><span>))</span><span> </span><span>{</span><span>
              </span><span>return</span><span> </span><span>null</span><span>;</span><span>
            </span><span>}</span><span>
            </span><span>return</span><span> </span><span>'Not a valid email.'</span><span>;</span><span>
          </span><span>},</span><span>
          onSaved</span><span>:</span><span> </span><span>(</span><span>val</span><span>)</span><span> </span><span>{</span><span>
            _email </span><span>=</span><span> val</span><span>;</span><span>
          </span><span>},</span><span>
          decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>InputDecoration</span><span>(</span><span>
            hintText</span><span>:</span><span> </span><span>'Enter your email'</span><span>,</span><span>
            labelText</span><span>:</span><span> </span><span>'Email'</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
        </span><span>ElevatedButton</span><span>(</span><span>
          onPressed</span><span>:</span><span> _submit</span><span>,</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Login'</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The following example shows how `Form.save()` and `formKey` (which is a `GlobalKey`), are used to save the form on submit.

```
<span>void</span><span> _submit</span><span>()</span><span> </span><span>{</span><span>
  </span><span>final</span><span> form </span><span>=</span><span> formKey</span><span>.</span><span>currentState</span><span>;</span><span>
  </span><span>if</span><span> </span><span>(</span><span>form </span><span>!=</span><span> </span><span>null</span><span> </span><span>&amp;&amp;</span><span> form</span><span>.</span><span>validate</span><span>())</span><span> </span><span>{</span><span>
    form</span><span>.</span><span>save</span><span>();</span><span>
    showDialog</span><span>(</span><span>
      context</span><span>:</span><span> context</span><span>,</span><span>
      builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>AlertDialog</span><span>(</span><span>
            title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Alert'</span><span>),</span><span>
            content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Email: $_email, password: $_password'</span><span>));</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![Input on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/input-fields.gif)

Android

![Input on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/input-fields.gif)

iOS

## Platform-specific code

When building a cross-platform app, you want to re-use as much code as possible across platforms. However, scenarios might arise where it makes sense for the code to be different depending on the OS. This requires a separate implementation by declaring a specific platform.

In React Native, the following implementation would be used:

```
<span>// React Native</span>
<span>if </span><span>(</span><span>Platform</span><span>.</span><span>OS</span> <span>===</span> <span>'</span><span>ios</span><span>'</span><span>)</span> <span>{</span>
  <span>return</span> <span>'</span><span>iOS</span><span>'</span><span>;</span>
<span>}</span> <span>else</span> <span>if </span><span>(</span><span>Platform</span><span>.</span><span>OS</span> <span>===</span> <span>'</span><span>android</span><span>'</span><span>)</span> <span>{</span>
  <span>return</span> <span>'</span><span>android</span><span>'</span><span>;</span>
<span>}</span> <span>else</span> <span>{</span>
  <span>return</span> <span>'</span><span>not recognised</span><span>'</span><span>;</span>
<span>}</span>
```

In Flutter, use the following implementation:

```
<span>final</span><span> platform </span><span>=</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>platform</span><span>;</span><span>
</span><span>if</span><span> </span><span>(</span><span>platform </span><span>==</span><span> </span><span>TargetPlatform</span><span>.</span><span>iOS</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>'iOS'</span><span>;</span><span>
</span><span>}</span><span>
</span><span>if</span><span> </span><span>(</span><span>platform </span><span>==</span><span> </span><span>TargetPlatform</span><span>.</span><span>android</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>'android'</span><span>;</span><span>
</span><span>}</span><span>
</span><span>if</span><span> </span><span>(</span><span>platform </span><span>==</span><span> </span><span>TargetPlatform</span><span>.</span><span>fuchsia</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>'fuchsia'</span><span>;</span><span>
</span><span>}</span><span>
</span><span>return</span><span> </span><span>'not recognized '</span><span>;</span>
```

## Debugging

### What tools can I use to debug my app in Flutter?

Use the [DevTools](https://docs.flutter.dev/tools/devtools) suite for debugging Flutter or Dart apps.

DevTools includes support for profiling, examining the heap, inspecting the widget tree, logging diagnostics, debugging, observing executed lines of code, debugging memory leaks and memory fragmentation. For more information, see the [DevTools](https://docs.flutter.dev/tools/devtools) documentation.

If you’re using an IDE, you can debug your application using the IDE’s debugger.

### How do I perform a hot reload?

Flutter’s Stateful Hot Reload feature helps you quickly and easily experiment, build UIs, add features, and fix bugs. Instead of recompiling your app every time you make a change, you can hot reload your app instantly. The app is updated to reflect your change, and the current state of the app is preserved.

In React Native, the shortcut is ⌘R for the iOS Simulator and tapping R twice on Android emulators.

In Flutter, If you are using IntelliJ IDE or Android Studio, you can select Save All (⌘s/ctrl-s), or you can click the Hot Reload button on the toolbar. If you are running the app at the command line using `flutter run`, type `r` in the Terminal window. You can also perform a full restart by typing `R` in the Terminal window.

In React Native, the developer menu can be accessed by shaking your device: ⌘D for the iOS Simulator or ⌘M for Android emulator.

In Flutter, if you are using an IDE, you can use the IDE tools. If you start your application using `flutter run` you can also access the menu by typing `h` in the terminal window, or type the following shortcuts:

| Action | Terminal Shortcut | Debug functions and properties |
| --- | --- | --- |
| Widget hierarchy of the app | `w` | debugDumpApp() |
| Rendering tree of the app | `t` | debugDumpRenderTree() |
| Layers | `L` | debugDumpLayerTree() |
| Accessibility | `S` (traversal order) or  
`U` (inverse hit test order) | debugDumpSemantics() |
| To toggle the widget inspector | `i` | WidgetsApp. showWidgetInspectorOverride |
| To toggle the display of construction lines | `p` | debugPaintSizeEnabled |
| To simulate different operating systems | `o` | defaultTargetPlatform |
| To display the performance overlay | `P` | WidgetsApp. showPerformanceOverlay |
| To save a screenshot to flutter. png | `s` |   |
| To quit | `q` |   |

## Animation

Well-designed animation makes a UI feel intuitive, contributes to the look and feel of a polished app, and improves the user experience. Flutter’s animation support makes it easy to implement simple and complex animations. The Flutter SDK includes many Material Design widgets that include standard motion effects, and you can easily customize these effects to personalize your app.

In React Native, Animated APIs are used to create animations.

In Flutter, use the [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html) class and the [`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html) class. `Animation` is an abstract class that understands its current value and its state (completed or dismissed). The `AnimationController` class lets you play an animation forward or in reverse, or stop animation and set the animation to a specific value to customize the motion.

### How do I add a simple fade-in animation?

In the React Native example below, an animated component, `FadeInView` is created using the Animated API. The initial opacity state, final state, and the duration over which the transition occurs are defined. The animation component is added inside the `Animated` component, the opacity state `fadeAnim` is mapped to the opacity of the `Text` component that we want to animate, and then, `start()` is called to start the animation.

```
<span>// React Native</span>
<span>const</span> <span>FadeInView</span> <span>=</span> <span>({</span> <span>style</span><span>,</span> <span>children</span> <span>})</span> <span>=&gt;</span> <span>{</span>
  <span>const</span> <span>fadeAnim</span> <span>=</span> <span>useRef</span><span>(</span><span>new</span> <span>Animated</span><span>.</span><span>Value</span><span>(</span><span>0</span><span>)).</span><span>current</span><span>;</span>

  <span>useEffect</span><span>(()</span> <span>=&gt;</span> <span>{</span>
    <span>Animated</span><span>.</span><span>timing</span><span>(</span><span>fadeAnim</span><span>,</span> <span>{</span>
      <span>toValue</span><span>:</span> <span>1</span><span>,</span>
      <span>duration</span><span>:</span> <span>10000</span>
    <span>}).</span><span>start</span><span>();</span>
  <span>},</span> <span>[]);</span>

  <span>return </span><span>(</span>
    <span>&lt;</span><span>Animated</span><span>.</span><span>View</span> <span>style</span><span>=</span><span>{{</span> <span>...</span><span>style</span><span>,</span> <span>opacity</span><span>:</span> <span>fadeAnim</span> <span>}}</span><span>&gt;</span>
      <span>{</span><span>children</span><span>}</span>
    <span>&lt;</span><span>/Animated.View</span><span>&gt;
</span>  <span>);</span>
<span>};</span>
    <span>...</span>
<span>&lt;</span><span>FadeInView</span><span>&gt;</span>
  <span>&lt;</span><span>Text</span><span>&gt;</span> <span>Fading</span> <span>in</span> <span>&lt;</span><span>/Text</span><span>&gt;
</span><span>&lt;</span><span>/FadeInView</span><span>&gt;
</span>    <span>...</span>
```

To create the same animation in Flutter, create an [`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html) object named `controller` and specify the duration. By default, an `AnimationController` linearly produces values that range from 0.0 to 1.0, during a given duration. The animation controller generates a new value whenever the device running your app is ready to display a new frame. Typically, this rate is around 60 values per second.

When defining an `AnimationController`, you must pass in a `vsync` object. The presence of `vsync` prevents offscreen animations from consuming unnecessary resources. You can use your stateful object as the `vsync` by adding `TickerProviderStateMixin` to the class definition. An `AnimationController` needs a TickerProvider, which is configured using the `vsync` argument on the constructor.

A [`Tween`](https://api.flutter.dev/flutter/animation/Tween-class.html) describes the interpolation between a beginning and ending value or the mapping from an input range to an output range. To use a `Tween` object with an animation, call the `Tween` object’s `animate()` method and pass it the `Animation` object that you want to modify.

For this example, a [`FadeTransition`](https://api.flutter.dev/flutter/widgets/FadeTransition-class.html) widget is used and the `opacity` property is mapped to the `animation` object.

To start the animation, use `controller.forward()`. Other operations can also be performed using the controller such as `fling()` or `repeat()`. For this example, the [`FlutterLogo`](https://api.flutter.dev/flutter/material/FlutterLogo-class.html) widget is used inside the `FadeTransition` widget.

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>LogoFade</span><span>()));</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>LogoFade</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>LogoFade</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>LogoFade</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _LogoFadeState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _LogoFadeState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>LogoFade</span><span>&gt;</span><span>
    </span><span>with</span><span> </span><span>SingleTickerProviderStateMixin</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>Animation</span><span>&lt;</span><span>double</span><span>&gt;</span><span> animation</span><span>;</span><span>
  </span><span>late</span><span> </span><span>AnimationController</span><span> controller</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    controller </span><span>=</span><span> </span><span>AnimationController</span><span>(</span><span>
      duration</span><span>:</span><span> </span><span>const</span><span> </span><span>Duration</span><span>(</span><span>milliseconds</span><span>:</span><span> </span><span>3000</span><span>),</span><span>
      vsync</span><span>:</span><span> </span><span>this</span><span>,</span><span>
    </span><span>);</span><span>
    </span><span>final</span><span> </span><span>CurvedAnimation</span><span> curve </span><span>=</span><span> </span><span>CurvedAnimation</span><span>(</span><span>
      parent</span><span>:</span><span> controller</span><span>,</span><span>
      curve</span><span>:</span><span> </span><span>Curves</span><span>.</span><span>easeIn</span><span>,</span><span>
    </span><span>);</span><span>
    animation </span><span>=</span><span> </span><span>Tween</span><span>(</span><span>begin</span><span>:</span><span> </span><span>0.0</span><span>,</span><span> end</span><span>:</span><span> </span><span>1.0</span><span>).</span><span>animate</span><span>(</span><span>curve</span><span>);</span><span>
    controller</span><span>.</span><span>forward</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    controller</span><span>.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>FadeTransition</span><span>(</span><span>
      opacity</span><span>:</span><span> animation</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>SizedBox</span><span>(</span><span>
        height</span><span>:</span><span> </span><span>300</span><span>,</span><span>
        width</span><span>:</span><span> </span><span>300</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>FlutterLogo</span><span>(),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![Flutter fade on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/flutter-fade.gif)

Android

![Flutter fade on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/flutter-fade.gif)

iOS

### How do I add swipe animation to cards?

In React Native, either the `PanResponder` or third-party libraries are used for swipe animation.

In Flutter, to add a swipe animation, use the [`Dismissible`](https://api.flutter.dev/flutter/widgets/Dismissible-class.html) widget and nest the child widgets.

```
<span>return</span><span> </span><span>Dismissible</span><span>(</span><span>
  key</span><span>:</span><span> </span><span>Key</span><span>(</span><span>widget</span><span>.</span><span>key</span><span>.</span><span>toString</span><span>()),</span><span>
  onDismissed</span><span>:</span><span> </span><span>(</span><span>dismissDirection</span><span>)</span><span> </span><span>{</span><span>
    cards</span><span>.</span><span>removeLast</span><span>();</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
      </span><span>//...</span><span>
      </span><span>),</span><span>
</span><span>);</span>
```

![Card swipe on Android](https://docs.flutter.dev/assets/images/docs/get-started/android/react-native/card-swipe.gif)

Android

![Card swipe on iOS](https://docs.flutter.dev/assets/images/docs/get-started/ios/react-native/card-swipe.gif)

iOS

The following table lists commonly-used React Native components mapped to the corresponding Flutter widget and common widget properties.

| React Native Component | Flutter Widget | Description |
| --- | --- | --- |
| [`Button`](https://facebook.github.io/react-native/docs/button.html) | [`ElevatedButton`](https://api.flutter.dev/flutter/material/ElevatedButton-class.html) | A basic raised button. |
|   | onPressed \[required\] | The callback when the button is tapped or otherwise activated. |
|   | Child | The button’s label. |
|   |   |   |
| [`Button`](https://facebook.github.io/react-native/docs/button.html) | [`TextButton`](https://api.flutter.dev/flutter/material/TextButton-class.html) | A basic flat button. |
|   | onPressed \[required\] | The callback when the button is tapped or otherwise activated. |
|   | Child | The button’s label. |
|   |   |   |
| [`ScrollView`](https://facebook.github.io/react-native/docs/scrollview.html) | [`ListView`](https://api.flutter.dev/flutter/widgets/ListView-class.html) | A scrollable list of widgets arranged linearly. |
|   | children | ( <Widget> \[ \]) List of child widgets to display. |
|   | controller | \[ [`ScrollController`](https://api.flutter.dev/flutter/widgets/ScrollController-class.html) \] An object that can be used to control a scrollable widget. |
|   | itemExtent | \[ double \] If non-null, forces the children to have the given extent in the scroll direction. |
|   | scroll Direction | \[ [`Axis`](https://api.flutter.dev/flutter/painting/Axis.html) \] The axis along which the scroll view scrolls. |
|   |   |   |
| [`FlatList`](https://facebook.github.io/react-native/docs/flatlist.html) | [`ListView.builder`](https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html) | The constructor for a linear array of widgets that are created on demand. |
|   | itemBuilder \[required\] | \[[`IndexedWidgetBuilder`](https://api.flutter.dev/flutter/widgets/IndexedWidgetBuilder.html)\] helps in building the children on demand. This callback is called only with indices greater than or equal to zero and less than the itemCount. |
|   | itemCount | \[ int \] improves the ability of the `ListView` to estimate the maximum scroll extent. |
|   |   |   |
| [`Image`](https://facebook.github.io/react-native/docs/image.html) | [`Image`](https://api.flutter.dev/flutter/widgets/Image-class.html) | A widget that displays an image. |
|   | image \[required\] | The image to display. |
|   | Image. asset | Several constructors are provided for the various ways that an image can be specified. |
|   | width, height, color, alignment | The style and layout for the image. |
|   | fit | Inscribing the image into the space allocated during layout. |
|   |   |   |
| [`Modal`](https://facebook.github.io/react-native/docs/modal.html) | [`ModalRoute`](https://api.flutter.dev/flutter/widgets/ModalRoute-class.html) | A route that blocks interaction with previous routes. |
|   | animation | The animation that drives the route’s transition and the previous route’s forward transition. |
|   |   |   |
| [`ActivityIndicator`](https://facebook.github.io/react-native/docs/activityindicator.html) | [`CircularProgressIndicator`](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html) | A widget that shows progress along a circle. |
|   | strokeWidth | The width of the line used to draw the circle. |
|   | backgroundColor | The progress indicator’s background color. The current theme’s `ThemeData.backgroundColor` by default. |
|   |   |   |
| [`ActivityIndicator`](https://facebook.github.io/react-native/docs/activityindicator.html) | [`LinearProgressIndicator`](https://api.flutter.dev/flutter/material/LinearProgressIndicator-class.html) | A widget that shows progress along a line. |
|   | value | The value of this progress indicator. |
|   |   |   |
| [`RefreshControl`](https://facebook.github.io/react-native/docs/refreshcontrol.html) | [`RefreshIndicator`](https://api.flutter.dev/flutter/material/RefreshIndicator-class.html) | A widget that supports the Material “swipe to refresh” idiom. |
|   | color | The progress indicator’s foreground color. |
|   | onRefresh | A function that’s called when a user drags the refresh indicator far enough to demonstrate that they want the app to refresh. |
|   |   |   |
| [`View`](https://facebook.github.io/react-native/docs/view.html) | [`Container`](https://api.flutter.dev/flutter/widgets/Container-class.html) | A widget that surrounds a child widget. |
|   |   |   |
| [`View`](https://facebook.github.io/react-native/docs/view.html) | [`Column`](https://api.flutter.dev/flutter/widgets/Column-class.html) | A widget that displays its children in a vertical array. |
|   |   |   |
| [`View`](https://facebook.github.io/react-native/docs/view.html) | [`Row`](https://api.flutter.dev/flutter/widgets/Row-class.html) | A widget that displays its children in a horizontal array. |
|   |   |   |
| [`View`](https://facebook.github.io/react-native/docs/view.html) | [`Center`](https://api.flutter.dev/flutter/widgets/Center-class.html) | A widget that centers its child within itself. |
|   |   |   |
| [`View`](https://facebook.github.io/react-native/docs/view.html) | [`Padding`](https://api.flutter.dev/flutter/widgets/Padding-class.html) | A widget that insets its child by the given padding. |
|   | padding \[required\] | \[ EdgeInsets \] The amount of space to inset the child. |
|   |   |   |
| [`TouchableOpacity`](https://facebook.github.io/react-native/docs/touchableopacity.html) | [`GestureDetector`](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) | A widget that detects gestures. |
|   | onTap | A callback when a tap occurs. |
|   | onDoubleTap | A callback when a tap occurs at the same location twice in quick succession. |
|   |   |   |
| [`TextInput`](https://facebook.github.io/react-native/docs/textinput.html) | [`TextInput`](https://api.flutter.dev/flutter/services/TextInput-class.html) | The interface to the system’s text input control. |
|   | controller | \[ [`TextEditingController`](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) \] used to access and modify text. |
|   |   |   |
| [`Text`](https://facebook.github.io/react-native/docs/text.html) | [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) | The Text widget that displays a string of text with a single style. |
|   | data | \[ String \] The text to display. |
|   | textDirection | \[ [`TextAlign`](https://api.flutter.dev/flutter/dart-ui/TextAlign.html) \] The direction in which the text flows. |
|   |   |   |
| [`Switch`](https://facebook.github.io/react-native/docs/switch.html) | [`Switch`](https://api.flutter.dev/flutter/material/Switch-class.html) | A material design switch. |
|   | value \[required\] | \[ boolean \] Whether this switch is on or off. |
|   | onChanged \[required\] | \[ callback \] Called when the user toggles the switch on or off. |
|   |   |   |
| [`Slider`](https://facebook.github.io/react-native/docs/slider.html) | [`Slider`](https://api.flutter.dev/flutter/material/Slider-class.html) | Used to select from a range of values. |
|   | value \[required\] | \[ double \] The current value of the slider. |
|   | onChanged \[required\] | Called when the user selects a new value for the slider. |