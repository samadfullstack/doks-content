-   [Intro](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
-   [Ephemeral versus app state](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app)

1.  [Data & backend](https://docs.flutter.dev/data-and-backend)
2.  [State management](https://docs.flutter.dev/data-and-backend/state-mgmt)
3.  [Start thinking declaratively](https://docs.flutter.dev/data-and-backend/state-mgmt/declarative)

If you’re coming to Flutter from an imperative framework (such as Android SDK or iOS UIKit), you need to start thinking about app development from a new perspective.

Many assumptions that you might have don’t apply to Flutter. For example, in Flutter it’s okay to rebuild parts of your UI from scratch instead of modifying it. Flutter is fast enough to do that, even on every frame if needed.

Flutter is _declarative_. This means that Flutter builds its user interface to reflect the current state of your app:

![A mathematical formula of UI = f(state). 'UI' is the layout on the screen. 'f' is your build methods. 'state' is the application state.](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/ui-equals-function-of-state.png)

When the state of your app changes (for example, the user flips a switch in the settings screen), you change the state, and that triggers a redraw of the user interface. There is no imperative changing of the UI itself (like `widget.setText`)—you change the state, and the UI rebuilds from scratch.

Read more about the declarative approach to UI programming in the [get started guide](https://docs.flutter.dev/get-started/flutter-for/declarative).

The declarative style of UI programming has many benefits. Remarkably, there is only one code path for any state of the UI. You describe what the UI should look like for any given state, once—and that is it.

At first, this style of programming might not seem as intuitive as the imperative style. This is why this section is here. Read on.

-   [Intro](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
-   [Ephemeral versus app state](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app)