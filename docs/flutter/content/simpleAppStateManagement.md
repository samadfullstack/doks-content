-   [Ephemeral versus app state](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app)
-   [List of approaches](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options)

1.  [Data & backend](https://docs.flutter.dev/data-and-backend)
2.  [State management](https://docs.flutter.dev/data-and-backend/state-mgmt)
3.  [Simple app state management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple)

Now that you know about [declarative UI programming](https://docs.flutter.dev/data-and-backend/state-mgmt/declarative) and the difference between [ephemeral and app state](https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app), you are ready to learn about simple app state management.

On this page, we are going to be using the `provider` package. If you are new to Flutter and you don’t have a strong reason to choose another approach (Redux, Rx, hooks, etc.), this is probably the approach you should start with. The `provider` package is easy to understand and it doesn’t use much code. It also uses concepts that are applicable in every other approach.

That said, if you have a strong background in state management from other reactive frameworks, you can find packages and tutorials listed on the [options page](https://docs.flutter.dev/data-and-backend/state-mgmt/options).

## Our example

![An animated gif showing a Flutter app in use. It starts with the user on a login screen. They log in and are taken to the catalog screen, with a list of items. The click on several items, and as they do so, the items are marked as "added". The user clicks on a button and gets taken to the cart view. They see the items there. They go back to the catalog, and the items they bought still show "added". End of animation.](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/model-shopper-screencast.gif)

For illustration, consider the following simple app.

The app has two separate screens: a catalog, and a cart (represented by the `MyCatalog`, and `MyCart` widgets, respectively). It could be a shopping app, but you can imagine the same structure in a simple social networking app (replace catalog for “wall” and cart for “favorites”).

The catalog screen includes a custom app bar (`MyAppBar`) and a scrolling view of many list items (`MyListItems`).

Here’s the app visualized as a widget tree.

![A widget tree with MyApp at the top, and  MyCatalog and MyCart below it. MyCart area leaf nodes, but MyCatalog have two children: MyAppBar and a list of MyListItems.](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/simple-widget-tree.png)

So we have at least 5 subclasses of `Widget`. Many of them need access to state that “belongs” elsewhere. For example, each `MyListItem` needs to be able to add itself to the cart. It might also want to see whether the currently displayed item is already in the cart.

This takes us to our first question: where should we put the current state of the cart?

## Lifting state up

In Flutter, it makes sense to keep the state above the widgets that use it.

Why? In declarative frameworks like Flutter, if you want to change the UI, you have to rebuild it. There is no easy way to have `MyCart.updateWith(somethingNew)`. In other words, it’s hard to imperatively change a widget from outside, by calling a method on it. And even if you could make this work, you would be fighting the framework instead of letting it help you.

```
<span>// BAD: DO NOT DO THIS</span>
<span>void</span> <span>myTapHandler</span><span>()</span> <span>{</span>
  <span>var</span> <span>cartWidget</span> <span>=</span> <span>somehowGetMyCartWidget</span><span>();</span>
  <span>cartWidget</span><span>.</span><span>updateWith</span><span>(</span><span>item</span><span>);</span>
<span>}</span>
```

Even if you get the above code to work, you would then have to deal with the following in the `MyCart` widget:

```
<span>// BAD: DO NOT DO THIS</span>
<span>Widget</span> <span>build</span><span>(</span><span>BuildContext</span> <span>context</span><span>)</span> <span>{</span>
  <span>return</span> <span>SomeWidget</span><span>(</span>
    <span>// The initial state of the cart.</span>
  <span>);</span>
<span>}</span>

<span>void</span> <span>updateWith</span><span>(</span><span>Item</span> <span>item</span><span>)</span> <span>{</span>
  <span>// Somehow you need to change the UI from here.</span>
<span>}</span>
```

You would need to take into consideration the current state of the UI and apply the new data to it. It’s hard to avoid bugs this way.

In Flutter, you construct a new widget every time its contents change. Instead of `MyCart.updateWith(somethingNew)` (a method call) you use `MyCart(contents)` (a constructor). Because you can only construct new widgets in the build methods of their parents, if you want to change `contents`, it needs to live in `MyCart`’s parent or above.

```
<span>// GOOD</span><span>
</span><span>void</span><span> myTapHandler</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>var</span><span> cartModel </span><span>=</span><span> somehowGetMyCartModel</span><span>(</span><span>context</span><span>);</span><span>
  cartModel</span><span>.</span><span>add</span><span>(</span><span>item</span><span>);</span><span>
</span><span>}</span>
```

Now `MyCart` has only one code path for building any version of the UI.

```
<span>// GOOD</span><span>
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>var</span><span> cartModel </span><span>=</span><span> somehowGetMyCartModel</span><span>(</span><span>context</span><span>);</span><span>
  </span><span>return</span><span> </span><span>SomeWidget</span><span>(</span><span>
    </span><span>// Just construct the UI once, using the current state of the cart.</span><span>
    </span><span>// ···</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

In our example, `contents` needs to live in `MyApp`. Whenever it changes, it rebuilds `MyCart` from above (more on that later). Because of this, `MyCart` doesn’t need to worry about lifecycle—it just declares what to show for any given `contents`. When that changes, the old `MyCart` widget disappears and is completely replaced by the new one.

![Same widget tree as above, but now we show a small 'cart' badge next to MyApp, and there are two arrows here. One comes from one of the MyListItems to the 'cart', and another one goes from the 'cart' to the MyCart widget.](https://docs.flutter.dev/assets/images/docs/development/data-and-backend/state-mgmt/simple-widget-tree-with-cart.png)

This is what we mean when we say that widgets are immutable. They don’t change—they get replaced.

Now that we know where to put the state of the cart, let’s see how to access it.

## Accessing the state

When a user clicks on one of the items in the catalog, it’s added to the cart. But since the cart lives above `MyListItem`, how do we do that?

A simple option is to provide a callback that `MyListItem` can call when it is clicked. Dart’s functions are first class objects, so you can pass them around any way you want. So, inside `MyCatalog` you can define the following:

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>SomeWidget</span><span>(</span><span>
    </span><span>// Construct the widget, passing it a reference to the method above.</span><span>
    </span><span>MyListItem</span><span>(</span><span>myTapCallback</span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span><span>

</span><span>void</span><span> myTapCallback</span><span>(</span><span>Item</span><span> item</span><span>)</span><span> </span><span>{</span><span>
  print</span><span>(</span><span>'user tapped on $item'</span><span>);</span><span>
</span><span>}</span>
```

This works okay, but for an app state that you need to modify from many different places, you’d have to pass around a lot of callbacks—which gets old pretty quickly.

Fortunately, Flutter has mechanisms for widgets to provide data and services to their descendants (in other words, not just their children, but any widgets below them). As you would expect from Flutter, where _Everything is a Widget™_, these mechanisms are just special kinds of widgets—`InheritedWidget`, `InheritedNotifier`, `InheritedModel`, and more. We won’t be covering those here, because they are a bit low-level for what we’re trying to do.

Instead, we are going to use a package that works with the low-level widgets but is simple to use. It’s called `provider`.

Before working with `provider`, don’t forget to add the dependency on it to your `pubspec.yaml`.

To add the `provider` package as a dependency, run `flutter pub add`:

```
<span>$</span><span> </span>flutter pub add provider
```

Now you can `import 'package:provider/provider.dart';` and start building.

With `provider`, you don’t need to worry about callbacks or `InheritedWidgets`. But you do need to understand 3 concepts:

-   ChangeNotifier
-   ChangeNotifierProvider
-   Consumer

## ChangeNotifier

`ChangeNotifier` is a simple class included in the Flutter SDK which provides change notification to its listeners. In other words, if something is a `ChangeNotifier`, you can subscribe to its changes. (It is a form of Observable, for those familiar with the term.)

In `provider`, `ChangeNotifier` is one way to encapsulate your application state. For very simple apps, you get by with a single `ChangeNotifier`. In complex ones, you’ll have several models, and therefore several `ChangeNotifiers`. (You don’t need to use `ChangeNotifier` with `provider` at all, but it’s an easy class to work with.)

In our shopping app example, we want to manage the state of the cart in a `ChangeNotifier`. We create a new class that extends it, like so:

```
<span>class</span><span> </span><span>CartModel</span><span> </span><span>extends</span><span> </span><span><span>ChangeNotifier</span></span><span> </span><span>{</span><span>
  </span><span>/// Internal, private state of the cart.</span><span>
  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Item</span><span>&gt;</span><span> _items </span><span>=</span><span> </span><span>[];</span><span>

  </span><span>/// An unmodifiable view of the items in the cart.</span><span>
  </span><span>UnmodifiableListView</span><span>&lt;</span><span>Item</span><span>&gt;</span><span> </span><span>get</span><span> items </span><span>=&gt;</span><span> </span><span>UnmodifiableListView</span><span>(</span><span>_items</span><span>);</span><span>

  </span><span>/// The current total price of all items (assuming all items cost $42).</span><span>
  </span><span>int</span><span> </span><span>get</span><span> totalPrice </span><span>=&gt;</span><span> _items</span><span>.</span><span>length </span><span>*</span><span> </span><span>42</span><span>;</span><span>

  </span><span>/// Adds [item] to cart. This and [removeAll] are the only ways to modify the</span><span>
  </span><span>/// cart from the outside.</span><span>
  </span><span>void</span><span> add</span><span>(</span><span>Item</span><span> item</span><span>)</span><span> </span><span>{</span><span>
    _items</span><span>.</span><span>add</span><span>(</span><span>item</span><span>);</span><span>
    </span><span>// This call tells the widgets that are listening to this model to rebuild.</span><span>
    </span><span><span>notifyListeners</span></span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>/// Removes all items from the cart.</span><span>
  </span><span>void</span><span> removeAll</span><span>()</span><span> </span><span>{</span><span>
    _items</span><span>.</span><span>clear</span><span>();</span><span>
    </span><span>// This call tells the widgets that are listening to this model to rebuild.</span><span>
    </span><span><span>notifyListeners</span></span><span>();</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The only code that is specific to `ChangeNotifier` is the call to `notifyListeners()`. Call this method any time the model changes in a way that might change your app’s UI. Everything else in `CartModel` is the model itself and its business logic.

`ChangeNotifier` is part of `flutter:foundation` and doesn’t depend on any higher-level classes in Flutter. It’s easily testable (you don’t even need to use [widget testing](https://docs.flutter.dev/testing/overview#widget-tests) for it). For example, here’s a simple unit test of `CartModel`:

```
<span>test</span><span>(</span><span>'adding item increases total cost'</span><span>,</span><span> </span><span>()</span><span> </span><span>{</span><span>
  </span><span>final</span><span> cart </span><span>=</span><span> </span><span>CartModel</span><span>();</span><span>
  </span><span>final</span><span> startingPrice </span><span>=</span><span> cart</span><span>.</span><span>totalPrice</span><span>;</span><span>
  </span><span>var</span><span> i </span><span>=</span><span> </span><span>0</span><span>;</span><span>
  cart</span><span>.</span><span>addListener</span><span>(()</span><span> </span><span>{</span><span>
    expect</span><span>(</span><span>cart</span><span>.</span><span>totalPrice</span><span>,</span><span> greaterThan</span><span>(</span><span>startingPrice</span><span>));</span><span>
    i</span><span>++;</span><span>
  </span><span>});</span><span>
  cart</span><span>.</span><span>add</span><span>(</span><span>Item</span><span>(</span><span>'Dash'</span><span>));</span><span>
  expect</span><span>(</span><span>i</span><span>,</span><span> </span><span>1</span><span>);</span><span>
</span><span>});</span>
```

## ChangeNotifierProvider

`ChangeNotifierProvider` is the widget that provides an instance of a `ChangeNotifier` to its descendants. It comes from the `provider` package.

We already know where to put `ChangeNotifierProvider`: above the widgets that need to access it. In the case of `CartModel`, that means somewhere above both `MyCart` and `MyCatalog`.

You don’t want to place `ChangeNotifierProvider` higher than necessary (because you don’t want to pollute the scope). But in our case, the only widget that is on top of both `MyCart` and `MyCatalog` is `MyApp`.

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span><span>ChangeNotifierProvider</span></span><span>(</span><span>
      create</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>CartModel</span><span>(),</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>MyApp</span><span>(),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

Note that we’re defining a builder that creates a new instance of `CartModel`. `ChangeNotifierProvider` is smart enough _not_ to rebuild `CartModel` unless absolutely necessary. It also automatically calls `dispose()` on `CartModel` when the instance is no longer needed.

If you want to provide more than one class, you can use `MultiProvider`:

```
<span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span><span>MultiProvider</span></span><span>(</span><span>
      providers</span><span>:</span><span> </span><span>[</span><span>
        </span><span>ChangeNotifierProvider</span><span>(</span><span>create</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>CartModel</span><span>()),</span><span>
        </span><span>Provider</span><span>(</span><span>create</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>SomeOtherClass</span><span>()),</span><span>
      </span><span>],</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>MyApp</span><span>(),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

## Consumer

Now that `CartModel` is provided to widgets in our app through the `ChangeNotifierProvider` declaration at the top, we can start using it.

This is done through the `Consumer` widget.

```
<span>return</span><span> </span><span><span>Consumer</span></span><span>&lt;</span><span>CartModel</span><span>&gt;(</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> cart</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Text</span><span>(</span><span>'Total price: ${cart.totalPrice}'</span><span>);</span><span>
  </span><span>},</span><span>
</span><span>);</span>
```

We must specify the type of the model that we want to access. In this case, we want `CartModel`, so we write `Consumer<CartModel>`. If you don’t specify the generic (`<CartModel>`), the `provider` package won’t be able to help you. `provider` is based on types, and without the type, it doesn’t know what you want.

The only required argument of the `Consumer` widget is the builder. Builder is a function that is called whenever the `ChangeNotifier` changes. (In other words, when you call `notifyListeners()` in your model, all the builder methods of all the corresponding `Consumer` widgets are called.)

The builder is called with three arguments. The first one is `context`, which you also get in every build method.

The second argument of the builder function is the instance of the `ChangeNotifier`. It’s what we were asking for in the first place. You can use the data in the model to define what the UI should look like at any given point.

The third argument is `child`, which is there for optimization. If you have a large widget subtree under your `Consumer` that _doesn’t_ change when the model changes, you can construct it once and get it through the builder.

```
<span>return</span><span> </span><span>Consumer</span><span>&lt;</span><span>CartModel</span><span>&gt;(</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> cart</span><span>,</span><span> </span><span><span>child</span></span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Stack</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>[</span><span>
      </span><span>// Use SomeExpensiveWidget here, without rebuilding every time.</span><span>
      </span><span>if</span><span> </span><span>(</span><span><span>child</span></span><span> </span><span>!=</span><span> </span><span>null</span><span>)</span><span> </span><span><span>child</span></span><span>,</span><span>
      </span><span>Text</span><span>(</span><span>'Total price: ${cart.totalPrice}'</span><span>),</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
  </span><span>// Build the expensive widget here.</span><span>
  </span><span><span>child</span></span><span>:</span><span> </span><span>const</span><span> </span><span>SomeExpensiveWidget</span><span>(),</span><span>
</span><span>);</span>
```

It is best practice to put your `Consumer` widgets as deep in the tree as possible. You don’t want to rebuild large portions of the UI just because some detail somewhere changed.

```
<span>// DON'T DO THIS</span><span>
</span><span>return</span><span> </span><span>Consumer</span><span>&lt;</span><span>CartModel</span><span>&gt;(</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> cart</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>HumongousWidget</span><span>(</span><span>
      </span><span>// ...</span><span>
      child</span><span>:</span><span> </span><span>AnotherMonstrousWidget</span><span>(</span><span>
        </span><span>// ...</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Total price: ${cart.totalPrice}'</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
</span><span>);</span>
```

Instead:

```
<span>// DO THIS</span><span>
</span><span>return</span><span> </span><span>HumongousWidget</span><span>(</span><span>
  </span><span>// ...</span><span>
  child</span><span>:</span><span> </span><span>AnotherMonstrousWidget</span><span>(</span><span>
    </span><span>// ...</span><span>
    child</span><span>:</span><span> </span><span>Consumer</span><span>&lt;</span><span>CartModel</span><span>&gt;(</span><span>
      builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> cart</span><span>,</span><span> child</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>Text</span><span>(</span><span>'Total price: ${cart.totalPrice}'</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>),</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Provider.of

Sometimes, you don’t really need the _data_ in the model to change the UI but you still need to access it. For example, a `ClearCart` button wants to allow the user to remove everything from the cart. It doesn’t need to display the contents of the cart, it just needs to call the `clear()` method.

We could use `Consumer<CartModel>` for this, but that would be wasteful. We’d be asking the framework to rebuild a widget that doesn’t need to be rebuilt.

For this use case, we can use `Provider.of`, with the `listen` parameter set to `false`.

```
<span>Provider</span><span>.</span><span>of</span><span>&lt;</span><span>CartModel</span><span>&gt;(</span><span>context</span><span>,</span><span> </span><span><span>listen</span><span>:</span><span> </span><span>false</span></span><span>).</span><span>removeAll</span><span>();</span>
```

Using the above line in a build method won’t cause this widget to rebuild when `notifyListeners` is called.

## Putting it all together

You can [check out the example](https://github.com/flutter/samples/tree/main/provider_shopper) covered in this article. If you want something simpler, see what the simple Counter app looks like when [built with `provider`](https://github.com/flutter/samples/tree/main/provider_counter).

By following along with these articles, you’ve greatly improved your ability to create state-based applications. Try building an application with `provider` yourself to master these skills.

-   [Ephemeral versus app state](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app)
-   [List of approaches](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options)