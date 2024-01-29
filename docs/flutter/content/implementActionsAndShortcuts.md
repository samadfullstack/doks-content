1.  [UI](https://docs.flutter.dev/ui)
2.  [Interactivity](https://docs.flutter.dev/ui/interactivity)
3.  [Using Actions and Shortcuts](https://docs.flutter.dev/ui/interactivity/actions-and-shortcuts)

This page describes how to bind physical keyboard events to actions in the user interface. For instance, to define keyboard shortcuts in your application, this page is for you.

## Overview

For a GUI application to do anything, it has to have actions: users want to tell the application to _do_ something. Actions are often simple functions that directly perform the action (such as set a value or save a file). In a larger application, however, things are more complex: the code for invoking the action, and the code for the action itself might need to be in different places. Shortcuts (key bindings) might need definition at a level that knows nothing about the actions they invoke.

That’s where Flutter’s actions and shortcuts system comes in. It allows developers to define actions that fulfill intents bound to them. In this context, an intent is a generic action that the user wishes to perform, and an [`Intent`](https://api.flutter.dev/flutter/widgets/Intent-class.html) class instance represents these user intents in Flutter. An `Intent` can be general purpose, fulfilled by different actions in different contexts. An [`Action`](https://api.flutter.dev/flutter/widgets/Action-class.html) can be a simple callback (as in the case of the [`CallbackAction`](https://api.flutter.dev/flutter/widgets/CallbackAction-class.html)) or something more complex that integrates with entire undo/redo architectures (for example) or other logic.

![Using Shortcuts Diagram](https://docs.flutter.dev/assets/images/docs/using_shortcuts.png)

[`Shortcuts`](https://api.flutter.dev/flutter/widgets/Shortcuts-class.html) are key bindings that activate by pressing a key or combination of keys. The key combinations reside in a table with their bound intent. When the `Shortcuts` widget invokes them, it sends their matching intent to the actions subsystem for fulfillment.

To illustrate the concepts in actions and shortcuts, this article creates a simple app that allows a user to select and copy text in a text field using both buttons and shortcuts.

### Why separate Actions from Intents?

You might wonder: why not just map a key combination directly to an action? Why have intents at all? This is because it is useful to have a separation of concerns between where the key mapping definitions are (often at a high level), and where the action definitions are (often at a low level), and because it is important to be able to have a single key combination map to an intended operation in an app, and have it adapt automatically to whichever action fulfills that intended operation for the focused context.

For instance, Flutter has an `ActivateIntent` widget that maps each type of control to its corresponding version of an `ActivateAction` (and that executes the code that activates the control). This code often needs fairly private access to do its work. If the extra layer of indirection that `Intent`s provide didn’t exist, it would be necessary to elevate the definition of the actions to where the defining instance of the `Shortcuts` widget could see them, causing the shortcuts to have more knowledge than necessary about which action to invoke, and to have access to or provide state that it wouldn’t necessarily have or need otherwise. This allows your code to separate the two concerns to be more independent.

Intents configure an action so that the same action can serve multiple uses. An example of this is `DirectionalFocusIntent`, which takes a direction to move the focus in, allowing the `DirectionalFocusAction` to know which direction to move the focus. Just be careful: don’t pass state in the `Intent` that applies to all invocations of an `Action`: that kind of state should be passed to the constructor of the `Action` itself, to keep the `Intent` from needing to know too much.

### Why not use callbacks?

You also might wonder: why not just use a callback instead of an `Action` object? The main reason is that it’s useful for actions to decide whether they are enabled by implementing `isEnabled`. Also, it is often helpful if the key bindings, and the implementation of those bindings, are in different places.

If all you need are callbacks without the flexibility of `Actions` and `Shortcuts`, you can use the [`CallbackShortcuts`](https://api.flutter.dev/flutter/widgets/CallbackShortcuts-class.html) widget:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>CallbackShortcuts</span><span>(</span><span>
    bindings</span><span>:</span><span> </span><span>&lt;</span><span>ShortcutActivator</span><span>,</span><span> </span><span>VoidCallback</span><span>&gt;{</span><span>
      </span><span>const</span><span> </span><span>SingleActivator</span><span>(</span><span>LogicalKeyboardKey</span><span>.</span><span>arrowUp</span><span>):</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>=&gt;</span><span> count </span><span>=</span><span> count </span><span>+</span><span> </span><span>1</span><span>);</span><span>
      </span><span>},</span><span>
      </span><span>const</span><span> </span><span>SingleActivator</span><span>(</span><span>LogicalKeyboardKey</span><span>.</span><span>arrowDown</span><span>):</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>=&gt;</span><span> count </span><span>=</span><span> count </span><span>-</span><span> </span><span>1</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>},</span><span>
    child</span><span>:</span><span> </span><span>Focus</span><span>(</span><span>
      autofocus</span><span>:</span><span> </span><span>true</span><span>,</span><span>
      child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
          </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Press the up arrow key to add to the counter'</span><span>),</span><span>
          </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Press the down arrow key to subtract from the counter'</span><span>),</span><span>
          </span><span>Text</span><span>(</span><span>'count: $count'</span><span>),</span><span>
        </span><span>],</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

## Shortcuts

As you’ll see below, actions are useful on their own, but the most common use case involves binding them to a keyboard shortcut. This is what the `Shortcuts` widget is for.

It is inserted into the widget hierarchy to define key combinations that represent the user’s intent when that key combination is pressed. To convert that intended purpose for the key combination into a concrete action, the `Actions` widget used to map the `Intent` to an `Action`. For instance, you can define a `SelectAllIntent`, and bind it to your own `SelectAllAction` or to your `CanvasSelectAllAction`, and from that one key binding, the system invokes either one, depending on which part of your application has focus. Let’s see how the key binding part works:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Shortcuts</span><span>(</span><span>
    shortcuts</span><span>:</span><span> </span><span>&lt;</span><span>LogicalKeySet</span><span>,</span><span> </span><span>Intent</span><span>&gt;{</span><span>
      </span><span>LogicalKeySet</span><span>(</span><span>LogicalKeyboardKey</span><span>.</span><span>control</span><span>,</span><span> </span><span>LogicalKeyboardKey</span><span>.</span><span>keyA</span><span>):</span><span>
          </span><span>const</span><span> </span><span>SelectAllIntent</span><span>(),</span><span>
    </span><span>},</span><span>
    child</span><span>:</span><span> </span><span>Actions</span><span>(</span><span>
      dispatcher</span><span>:</span><span> </span><span>LoggingActionDispatcher</span><span>(),</span><span>
      actions</span><span>:</span><span> </span><span>&lt;</span><span>Type</span><span>,</span><span> </span><span>Action</span><span>&lt;</span><span>Intent</span><span>&gt;&gt;{</span><span>
        </span><span>SelectAllIntent</span><span>:</span><span> </span><span>SelectAllAction</span><span>(</span><span>model</span><span>),</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>Builder</span><span>(</span><span>
        builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>TextButton</span><span>(</span><span>
          onPressed</span><span>:</span><span> </span><span>Actions</span><span>.</span><span>handler</span><span>&lt;</span><span>SelectAllIntent</span><span>&gt;(</span><span>
            context</span><span>,</span><span>
            </span><span>const</span><span> </span><span>SelectAllIntent</span><span>(),</span><span>
          </span><span>),</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'SELECT ALL'</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The map given to a `Shortcuts` widget maps a `LogicalKeySet` (or a `ShortcutActivator`, see note below) to an `Intent` instance. The logical key set defines a set of one or more keys, and the intent indicates the intended purpose of the keypress. The `Shortcuts` widget looks up keypresses in the map, to find an `Intent` instance, which it gives to the action’s `invoke()` method.

### The ShortcutManager

The shortcut manager, a longer-lived object than the `Shortcuts` widget, passes on key events when it receives them. It contains the logic for deciding how to handle the keys, the logic for walking up the tree to find other shortcut mappings, and maintains a map of key combinations to intents.

While the default behavior of the `ShortcutManager` is usually desirable, the `Shortcuts` widget takes a `ShortcutManager` that you can subclass to customize its functionality.

For example, if you wanted to log each key that a `Shortcuts` widget handled, you could make a `LoggingShortcutManager`:

```
<span>class</span><span> </span><span>LoggingShortcutManager</span><span> </span><span>extends</span><span> </span><span>ShortcutManager</span><span> </span><span>{</span><span>
  @override
  </span><span>KeyEventResult</span><span> handleKeypress</span><span>(</span><span>BuildContext</span><span> context</span><span>,</span><span> </span><span>RawKeyEvent</span><span> event</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> </span><span>KeyEventResult</span><span> result </span><span>=</span><span> </span><span>super</span><span>.</span><span>handleKeypress</span><span>(</span><span>context</span><span>,</span><span> event</span><span>);</span><span>
    </span><span>if</span><span> </span><span>(</span><span>result </span><span>==</span><span> </span><span>KeyEventResult</span><span>.</span><span>handled</span><span>)</span><span> </span><span>{</span><span>
      print</span><span>(</span><span>'Handled shortcut $event in $context'</span><span>);</span><span>
    </span><span>}</span><span>
    </span><span>return</span><span> result</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Now, every time the `Shortcuts` widget handles a shortcut, it prints out the key event and relevant context.

## Actions

`Actions` allow for the definition of operations that the application can perform by invoking them with an `Intent`. Actions can be enabled or disabled, and receive the intent instance that invoked them as an argument to allow configuration by the intent.

### Defining actions

Actions, in their simplest form, are just subclasses of `Action<Intent>` with an `invoke()` method. Here’s a simple action that simply invokes a function on the provided model:

```
<span>class</span><span> </span><span>SelectAllAction</span><span> </span><span>extends</span><span> </span><span>Action</span><span>&lt;</span><span>SelectAllIntent</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>SelectAllAction</span><span>(</span><span>this</span><span>.</span><span>model</span><span>);</span><span>

  </span><span>final</span><span> </span><span>Model</span><span> model</span><span>;</span><span>

  @override
  </span><span>void</span><span> invoke</span><span>(</span><span>covariant</span><span> </span><span>SelectAllIntent</span><span> intent</span><span>)</span><span> </span><span>=&gt;</span><span> model</span><span>.</span><span>selectAll</span><span>();</span><span>
</span><span>}</span>
```

Or, if it’s too much of a bother to create a new class, use a `CallbackAction`:

```
<span>CallbackAction</span><span>(</span><span>onInvoke</span><span>:</span><span> </span><span>(</span><span>intent</span><span>)</span><span> </span><span>=&gt;</span><span> model</span><span>.</span><span>selectAll</span><span>());</span>
```

Once you have an action, you add it to your application using the [`Actions`](https://api.flutter.dev/flutter/widgets/Actions-class.html) widget, which takes a map of `Intent` types to `Action`s:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Actions</span><span>(</span><span>
    actions</span><span>:</span><span> </span><span>&lt;</span><span>Type</span><span>,</span><span> </span><span>Action</span><span>&lt;</span><span>Intent</span><span>&gt;&gt;{</span><span>
      </span><span>SelectAllIntent</span><span>:</span><span> </span><span>SelectAllAction</span><span>(</span><span>model</span><span>),</span><span>
    </span><span>},</span><span>
    child</span><span>:</span><span> child</span><span>,</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The `Shortcuts` widget uses the `Focus` widget’s context and `Actions.invoke` to find which action to invoke. If the `Shortcuts` widget doesn’t find a matching intent type in the first `Actions` widget encountered, it considers the next ancestor `Actions` widget, and so on, until it reaches the root of the widget tree, or finds a matching intent type and invokes the corresponding action.

### Invoking Actions

The actions system has several ways to invoke actions. By far the most common way is through the use of a `Shortcuts` widget covered in the previous section, but there are other ways to interrogate the actions subsystem and invoke an action. It’s possible to invoke actions that are not bound to keys.

For instance, to find an action associated with an intent, you can use:

```
<span>Action</span><span>&lt;</span><span>SelectAllIntent</span><span>&gt;?</span><span> selectAll </span><span>=</span><span>
    </span><span>Actions</span><span>.</span><span>maybeFind</span><span>&lt;</span><span>SelectAllIntent</span><span>&gt;(</span><span>context</span><span>);</span>
```

This returns an `Action` associated with the `SelectAllIntent` type if one is available in the given `context`. If one isn’t available, it returns null. If an associated `Action` should always be available, then use `find` instead of `maybeFind`, which throws an exception when it doesn’t find a matching `Intent` type.

To invoke the action (if it exists), call:

```
<span>Object</span><span>?</span><span> result</span><span>;</span><span>
</span><span>if</span><span> </span><span>(</span><span>selectAll </span><span>!=</span><span> </span><span>null</span><span>)</span><span> </span><span>{</span><span>
  result </span><span>=</span><span>
      </span><span>Actions</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>invokeAction</span><span>(</span><span>selectAll</span><span>,</span><span> </span><span>const</span><span> </span><span>SelectAllIntent</span><span>());</span><span>
</span><span>}</span>
```

Combine that into one call with the following:

```
<span>Object</span><span>?</span><span> result </span><span>=</span><span>
    </span><span>Actions</span><span>.</span><span>maybeInvoke</span><span>&lt;</span><span>SelectAllIntent</span><span>&gt;(</span><span>context</span><span>,</span><span> </span><span>const</span><span> </span><span>SelectAllIntent</span><span>());</span>
```

Sometimes you want to invoke an action as a result of pressing a button or another control. Do this with the `Actions.handler` function, which creates a handler closure if the intent has a mapping to an enabled action, and returns null if it doesn’t, so that the button is disabled if there is no matching enabled action in the context:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Actions</span><span>(</span><span>
    actions</span><span>:</span><span> </span><span>&lt;</span><span>Type</span><span>,</span><span> </span><span>Action</span><span>&lt;</span><span>Intent</span><span>&gt;&gt;{</span><span>
      </span><span>SelectAllIntent</span><span>:</span><span> </span><span>SelectAllAction</span><span>(</span><span>model</span><span>),</span><span>
    </span><span>},</span><span>
    child</span><span>:</span><span> </span><span>Builder</span><span>(</span><span>
      builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>TextButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> </span><span>Actions</span><span>.</span><span>handler</span><span>&lt;</span><span>SelectAllIntent</span><span>&gt;(</span><span>
          context</span><span>,</span><span>
          </span><span>SelectAllIntent</span><span>(</span><span>controller</span><span>:</span><span> controller</span><span>),</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'SELECT ALL'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The `Actions` widget only invokes actions when `isEnabled(Intent intent)` returns true, allowing the action to decide if the dispatcher should consider it for invocation. If the action isn’t enabled, then the `Actions` widget gives another enabled action higher in the widget hierarchy (if it exists) a chance to execute.

The previous example uses a `Builder` because `Actions.handler` and `Actions.invoke` (for example) only finds actions in the provided `context`, and if the example passes the `context` given to the `build` function, the framework starts looking _above_ the current widget. Using a `Builder` allows the framework to find the actions defined in the same `build` function.

You can invoke an action without needing a `BuildContext`, but since the `Actions` widget requires a context to find an enabled action to invoke, you need to provide one, either by creating your own `Action` instance, or by finding one in an appropriate context with `Actions.find`.

To invoke the action, pass the action to the `invoke` method on an `ActionDispatcher`, either one you created yourself, or one retrieved from an existing `Actions` widget using the `Actions.of(context)` method. Check whether the action is enabled before calling `invoke`. Of course, you can also just call `invoke` on the action itself, passing an `Intent`, but then you opt out of any services that an action dispatcher might provide (like logging, undo/redo, and so on).

### Action dispatchers

Most of the time, you just want to invoke an action, have it do its thing, and forget about it. Sometimes, however, you might want to log the executed actions.

This is where replacing the default `ActionDispatcher` with a custom dispatcher comes in. You pass your `ActionDispatcher` to the `Actions` widget, and it invokes actions from any `Actions` widgets below that one that doesn’t set a dispatcher of its own.

The first thing `Actions` does when invoking an action is look up the `ActionDispatcher` and pass the action to it for invocation. If there is none, it creates a default `ActionDispatcher` that simply invokes the action.

If you want a log of all the actions invoked, however, you can create your own `LoggingActionDispatcher` to do the job:

```
<span>class</span><span> </span><span>LoggingActionDispatcher</span><span> </span><span>extends</span><span> </span><span>ActionDispatcher</span><span> </span><span>{</span><span>
  @override
  </span><span>Object</span><span>?</span><span> invokeAction</span><span>(</span><span>
    </span><span>covariant</span><span> </span><span>Action</span><span>&lt;</span><span>Intent</span><span>&gt;</span><span> action</span><span>,</span><span>
    </span><span>covariant</span><span> </span><span>Intent</span><span> intent</span><span>,</span><span> </span><span>[</span><span>
    </span><span>BuildContext</span><span>?</span><span> context</span><span>,</span><span>
  </span><span>])</span><span> </span><span>{</span><span>
    print</span><span>(</span><span>'Action invoked: $action($intent) from $context'</span><span>);</span><span>
    </span><span>super</span><span>.</span><span>invokeAction</span><span>(</span><span>action</span><span>,</span><span> intent</span><span>,</span><span> context</span><span>);</span><span>

    </span><span>return</span><span> </span><span>null</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Then you pass that to your top-level `Actions` widget:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>Actions</span><span>(</span><span>
    dispatcher</span><span>:</span><span> </span><span>LoggingActionDispatcher</span><span>(),</span><span>
    actions</span><span>:</span><span> </span><span>&lt;</span><span>Type</span><span>,</span><span> </span><span>Action</span><span>&lt;</span><span>Intent</span><span>&gt;&gt;{</span><span>
      </span><span>SelectAllIntent</span><span>:</span><span> </span><span>SelectAllAction</span><span>(</span><span>model</span><span>),</span><span>
    </span><span>},</span><span>
    child</span><span>:</span><span> </span><span>Builder</span><span>(</span><span>
      builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>TextButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> </span><span>Actions</span><span>.</span><span>handler</span><span>&lt;</span><span>SelectAllIntent</span><span>&gt;(</span><span>
          context</span><span>,</span><span>
          </span><span>const</span><span> </span><span>SelectAllIntent</span><span>(),</span><span>
        </span><span>),</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'SELECT ALL'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

This logs every action as it executes, like so:

```
flutter: Action invoked: SelectAllAction#906fc(SelectAllIntent#a98e3) from Builder(dependencies: _[ActionsMarker])
```

## Putting it together

The combination of `Actions` and `Shortcuts` is powerful: you can define generic intents that map to specific actions at the widget level. Here’s a simple app that illustrates the concepts described above. The app creates a text field that also has “select all” and “copy to clipboard” buttons next to it. The buttons invoke actions to accomplish their work. All the invoked actions and shortcuts are logged.