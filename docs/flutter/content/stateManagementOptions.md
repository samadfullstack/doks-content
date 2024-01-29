-   [Simple app state management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple)

1.  [Data & backend](https://docs.flutter.dev/data-and-backend)
2.  [State management](https://docs.flutter.dev/data-and-backend/state-mgmt)
3.  [List of state management approaches](https://docs.flutter.dev/data-and-backend/state-mgmt/options)

State management is a complex topic. If you feel that some of your questions haven’t been answered, or that the approach described on these pages is not viable for your use cases, you are probably right.

Learn more at the following links, many of which have been contributed by the Flutter community:

## General overview

Things to review before selecting an approach.

-   [Introduction to state management](https://docs.flutter.dev/data-and-backend/state-mgmt/intro), which is the beginning of this very section (for those of you who arrived directly to this _Options_ page and missed the previous pages)
-   [Pragmatic State Management in Flutter](https://www.youtube.com/watch?v=d_m5csmrf7I), a video from Google I/O 2019
-   [Flutter Architecture Samples](https://fluttersamples.com/), by Brian Egan

## Provider

-   [Simple app state management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple), the previous page in this section
-   [Provider package](https://pub.dev/packages/provider)

## Riverpod

Riverpod works in a similar fashion to Provider. It offers compile safety and testing without depending on the Flutter SDK.

-   [Riverpod](https://riverpod.dev/) homepage
-   [Getting started with Riverpod](https://riverpod.dev/docs/introduction/getting_started)

## setState

The low-level approach to use for widget-specific, ephemeral state.

-   [Adding interactivity to your Flutter app](https://docs.flutter.dev/ui/interactivity), a Flutter tutorial
-   [Basic state management in Google Flutter](https://medium.com/@agungsurya/basic-state-management-in-google-flutter-6ee73608f96d), by Agung Surya

The low-level approach used to communicate between ancestors and children in the widget tree. This is what `provider` and many other approaches use under the hood.

The following instructor-led video workshop covers how to use `InheritedWidget`:

<iframe width="560" height="315" src="https://www.youtube.com/embed/LFcGPS6cGrY?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="How to manage application states using inherited widgets | Workshop" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="886271026" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

Other useful docs include:

-   [InheritedWidget docs](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html)
-   [Managing Flutter Application State With InheritedWidgets](https://medium.com/flutter/managing-flutter-application-state-with-inheritedwidgets-1140452befe1), by Hans Muller
-   [Inheriting Widgets](https://medium.com/@mehmetf_71205/inheriting-widgets-b7ac56dbbeb1), by Mehmet Fidanboylu
-   [Using Flutter Inherited Widgets Effectively](https://ericwindmill.com/articles/inherited_widget/), by Eric Windmill
-   [Widget - State - Context - InheritedWidget](https://www.didierboelens.com/2018/06/widget---state---context---inheritedwidget/), by Didier Bolelens

## Redux

A state container approach familiar to many web developers.

-   [Animation Management with Redux and Flutter](https://www.youtube.com/watch?v=9ZkLtr0Fbgk), a video from DartConf 2018 [Accompanying article on Medium](https://medium.com/flutter/animation-management-with-flutter-and-flux-redux-94729e6585fa)
-   [Flutter Redux package](https://pub.dev/packages/flutter_redux)
-   [Redux Saga Middleware Dart and Flutter](https://pub.dev/packages/redux_saga), by Bilal Uslu
-   [Introduction to Redux in Flutter](https://blog.novoda.com/introduction-to-redux-in-flutter/), by Xavi Rigau
-   [Flutter + Redux—How to make a shopping list app](https://hackernoon.com/flutter-redux-how-to-make-shopping-list-app-1cd315e79b65), by Paulina Szklarska on Hackernoon
-   [Building a TODO application (CRUD) in Flutter with Redux—Part 1](https://www.youtube.com/watch?v=Wj216eSBBWs), a video by Tensor Programming
-   [Flutter Redux Thunk, an example](https://medium.com/flutterpub/flutter-redux-thunk-27c2f2b80a3b), by Jack Wong
-   [Building a (large) Flutter app with Redux](https://hillelcoren.com/2018/06/01/building-a-large-flutter-app-with-redux/), by Hillel Coren
-   [Fish-Redux–An assembled flutter application framework based on Redux](https://github.com/alibaba/fish-redux/), by Alibaba
-   [Async Redux–Redux without boilerplate. Allows for both sync and async reducers](https://pub.dev/packages/async_redux), by Marcelo Glasberg
-   [Flutter meets Redux: The Redux way of managing Flutter applications state](https://medium.com/@thisisamir98/flutter-meets-redux-the-redux-way-of-managing-flutter-applications-state-f60ef693b509), by Amir Ghezelbash
-   [Redux and epics for better-organized code in Flutter apps](https://medium.com/upday-devs/reduce-duplication-achieve-flexibility-means-success-for-the-flutter-app-e5e432839e61), by Nihad Delic
-   [Flutter\_Redux\_Gen - VS Code Plugin to generate boiler plate code](https://marketplace.visualstudio.com/items?itemName=BalaDhruv.flutter-redux-gen), by Balamurugan Muthusamy (BalaDhruv)

## Fish-Redux

Fish Redux is an assembled flutter application framework based on Redux state management. It is suitable for building medium and large applications.

-   [Fish-Redux-Library](https://pub.dev/packages/fish_redux) package, by Alibaba
-   [Fish-Redux-Source](https://github.com/alibaba/fish-redux), project code
-   [Flutter-Movie](https://github.com/o1298098/Flutter-Movie), A non-trivial example demonstrating how to use Fish Redux, with more than 30 screens, graphql, payment api, and media player.

## BLoC / Rx

A family of stream/observable based patterns.

-   [Architect your Flutter project using BLoC pattern](https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1), by Sagar Suri
-   [BloC Library](https://felangel.github.io/bloc), by Felix Angelov
-   [Reactive Programming - Streams - BLoC - Practical Use Cases](https://www.didierboelens.com/2018/12/reactive-programming---streams---bloc---practical-use-cases), by Didier Boelens

## GetIt

A service locator based state management approach that doesn’t need a `BuildContext`.

-   [GetIt package](https://pub.dev/packages/get_it), the service locator. It can also be used together with BloCs.
-   [GetIt Mixin package](https://pub.dev/packages/get_it_mixin), a mixin that completes `GetIt` to a full state management solution.
-   [GetIt Hooks package](https://pub.dev/packages/get_it_hooks), same as the mixin in case you already use `flutter_hooks`.
-   [Flutter state management for minimalists](https://medium.com/flutter-community/flutter-state-management-for-minimalists-4c71a2f2f0c1?sk=6f9cedfb550ca9cc7f88317e2e7055a0), by Suragch

## MobX

A popular library based on observables and reactions.

-   [MobX.dart, Hassle free state-management for your Dart and Flutter apps](https://github.com/mobxjs/mobx.dart)
-   [Getting started with MobX.dart](https://mobx.netlify.com/getting-started)
-   [Flutter: State Management with Mobx](https://www.youtube.com/watch?v=p-MUBLOEkCs), a video by Paul Halliday

## Flutter Commands

Reactive state management that uses the Command Pattern and is based on `ValueNotifiers`. Best in combination with [GetIt](https://docs.flutter.dev/data-and-backend/state-mgmt/options#getit), but can be used with `Provider` or other locators too.

-   [Flutter Command package](https://pub.dev/packages/flutter_command)
-   [RxCommand package](https://pub.dev/packages/rx_command), `Stream` based implementation.

## Binder

A state management package that uses `InheritedWidget` at its core. Inspired in part by recoil. This package promotes the separation of concerns.

-   [Binder package](https://pub.dev/packages/binder)
-   [Binder examples](https://github.com/letsar/binder/tree/main/examples)
-   [Binder snippets](https://marketplace.visualstudio.com/items?itemName=romain-rastel.flutter-binder-snippets), vscode snippets to be even more productive with Binder

## GetX

A simplified reactive state management solution.

-   [GetX package](https://pub.dev/packages/get)
-   [GetX Flutter Firebase Auth Example](https://medium.com/@jeffmcmorris/getx-flutter-firebase-auth-example-b383c1dd1de2), by Jeff McMorris

## states\_rebuilder

An approach that combines state management with a dependency injection solution and an integrated router. For more information, see the following info:

-   [States Rebuilder](https://github.com/GIfatahTH/states_rebuilder) project code
-   [States Rebuilder documentation](https://github.com/GIfatahTH/states_rebuilder/wiki)

## Triple Pattern (Segmented State Pattern)

Triple is a pattern for state management that uses `Streams` or `ValueNotifier`. This mechanism (nicknamed _triple_ because the stream always uses three values: `Error`, `Loading`, and `State`), is based on the [Segmented State pattern](https://triple.flutterando.com.br/docs/intro/overview#-segmented-state-pattern-ssp).

For more information, refer to the following resources:

-   [Triple documentation](https://triple.flutterando.com.br/)
-   [Flutter Triple package](https://pub.dev/packages/flutter_triple)
-   [Triple Pattern: A new pattern for state management in Flutter](https://blog.flutterando.com.br/triple-pattern-um-novo-padr%C3%A3o-para-ger%C3%AAncia-de-estado-no-flutter-2e693a0f4c3e) (blog post written in Portuguese but can be auto-translated)
-   [VIDEO: Flutter Triple Pattern by Kevlin Ossada](https://www.youtube.com/watch?v=dXc3tR15AoA) (recorded in English)

## solidart

A simple but powerful state management solution inspired by SolidJS.

-   [Official Documentation](https://docs.page/nank1ro/solidart)
-   [solidart package](https://pub.dev/packages/solidart)
-   [flutter\_solidart package](https://pub.dev/packages/flutter_solidart)

## flutter\_reactive\_value

The `flutter_reactive_value` library might offer the least complex solution for state management in Flutter. It might help Flutter newcomers add reactivity to their UI, without the complexity of the mechanisms described before. The `flutter_reactive_value` library defines the `reactiveValue(BuildContext)` extension method on `ValueNotifier`. This extension allows a `Widget` to fetch the current value of the `ValueNotifier` and subscribe the `Widget` to changes in the value of the `ValueNotifier`. If the value of the `ValueNotifier` changes, `Widget` rebuilds.

-   [`flutter_reactive_value`](https://github.com/lukehutch/flutter_reactive_value) source and documentation

-   [Simple app state management](https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple)