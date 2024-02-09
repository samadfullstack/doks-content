1.  [Tools](https://docs.flutter.dev/tools)
2.  [Hot reload](https://docs.flutter.dev/tools/hot-reload)

Flutter’s hot reload feature helps you quickly and easily experiment, build UIs, add features, and fix bugs. Hot reload works by injecting updated source code files into the running [Dart Virtual Machine (VM)](https://dart.dev/overview#platform). After the VM updates classes with the new versions of fields and functions, the Flutter framework automatically rebuilds the widget tree, allowing you to quickly view the effects of your changes.

## How to perform a hot reload

To hot reload a Flutter app:

1.  Run the app from a supported [Flutter editor](https://docs.flutter.dev/get-started/editor) or a terminal window. Either a physical or virtual device can be the target. **Only Flutter apps in debug mode can be hot reloaded or hot restarted.**
2.  Modify one of the Dart files in your project. Most types of code changes can be hot reloaded; for a list of changes that require a hot restart, see [Special cases](https://docs.flutter.dev/tools/hot-reload#special-cases).
3.  If you’re working in an IDE/editor that supports Flutter’s IDE tools, select **Save All** (`cmd-s`/`ctrl-s`), or click the hot reload button on the toolbar.
    
    If you’re running the app at the command line using `flutter run`, enter `r` in the terminal window.
    

After a successful hot reload operation, you’ll see a message in the console similar to:

```
Performing hot reload...
Reloaded 1 of 448 libraries in 978ms.
```

The app updates to reflect your change, and the current state of the app is preserved. Your app continues to execute from where it was prior to run the hot reload command. The code updates and execution continues.

![Android Studio UI](https://docs.flutter.dev/assets/images/docs/development/tools/android-studio-run-controls.png)  
Controls for run, run debug, hot reload, and hot restart in Android Studio

A code change has a visible effect only if the modified Dart code is run again after the change. Specifically, a hot reload causes all the existing widgets to rebuild. Only code involved in the rebuilding of the widgets is automatically re-executed. The `main()` and `initState()` functions, for example, are not run again.

## Special cases

The next sections describe specific scenarios that involve hot reload. In some cases, small changes to the Dart code enable you to continue using hot reload for your app. In other cases, a hot restart, or a full restart is needed.

### An app is killed

Hot reload can break when the app is killed. For example, if the app was in the background for too long.

### Compilation errors

When a code change introduces a compilation error, hot reload generates an error message similar to:

```nocode
Hot reload was rejected: '/path/to/project/lib/main.dart': warning: line 16 pos 38: unbalanced '{' opens here Widget build(BuildContext context) { ^ '/path/to/project/lib/main.dart': error: line 33 pos 5: unbalanced ')' ); ^
```

In this situation, simply correct the errors on the specified lines of Dart code to keep using hot reload.

### CupertinoTabView’s builder

Hot reload won’t apply changes made to a `builder` of a `CupertinoTabView`. For more information, see [Issue 43574](https://github.com/flutter/flutter/issues/43574).

### Enumerated types

Hot reload doesn’t work when enumerated types are changed to regular classes or regular classes are changed to enumerated types.

For example:

Before the change:

```
<span>enum</span><span> </span><span>Color</span><span> </span><span>{</span><span>
  red</span><span>,</span><span>
  green</span><span>,</span><span>
  blue</span><span>,</span><span>
</span><span>}</span>
```

After the change:

```
<span>class</span><span> </span><span>Color</span><span> </span><span>{</span><span>
  </span><span>Color</span><span>(</span><span>this</span><span>.</span><span>i</span><span>,</span><span> </span><span>this</span><span>.</span><span>j</span><span>);</span><span>
  </span><span>final</span><span> </span><span>int</span><span> i</span><span>;</span><span>
  </span><span>final</span><span> </span><span>int</span><span> j</span><span>;</span><span>
</span><span>}</span>
```

### Generic types

Hot reload won’t work when generic type declarations are modified. For example, the following won’t work:

Before the change:

After the change:

```
<span>class</span><span> </span><span>A</span><span>&lt;</span><span>T</span><span>,</span><span> </span><span>V</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>T</span><span>?</span><span> i</span><span>;</span><span>
  </span><span>V</span><span>?</span><span> v</span><span>;</span><span>
</span><span>}</span>
```

### Native code

If you’ve changed native code (such as Kotlin, Java, Swift, or Objective-C), you must perform a full restart (stop and restart the app) to see the changes take effect.

### Previous state is combined with new code

Flutter’s stateful hot reload preserves the state of your app. This approach enables you to view the effect of the most recent change only, without throwing away the current state. For example, if your app requires a user to log in, you can modify and hot reload a page several levels down in the navigation hierarchy, without re-entering your login credentials. State is kept, which is usually the desired behavior.

If code changes affect the state of your app (or its dependencies), the data your app has to work with might not be fully consistent with the data it would have if it executed from scratch. The result might be different behavior after a hot reload versus a hot restart.

### Recent code change is included but app state is excluded

In Dart, [static fields are lazily initialized](https://dart.dev/language/classes#static-variables). This means that the first time you run a Flutter app and a static field is read, it’s set to whatever value its initializer was evaluated to. Global variables and static fields are treated as state, and are therefore not reinitialized during hot reload.

If you change initializers of global variables and static fields, a hot restart or restart the state where the initializers are hold is necessary to see the changes. For example, consider the following code:

```
<span>final</span><span> sampleTable </span><span>=</span><span> </span><span>[</span><span>
  </span><span>Table</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>TableRow</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'T1'</span><span>)],</span><span>
      </span><span>)</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
  </span><span>Table</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>TableRow</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'T2'</span><span>)],</span><span>
      </span><span>)</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
  </span><span>Table</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>TableRow</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'T3'</span><span>)],</span><span>
      </span><span>)</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
  </span><span>Table</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>TableRow</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'T4'</span><span>)],</span><span>
      </span><span>)</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>];</span>
```

After running the app, you make the following change:

```
<span>final</span><span> sampleTable </span><span>=</span><span> </span><span>[</span><span>
  </span><span>Table</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>TableRow</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'T1'</span><span>)],</span><span>
      </span><span>)</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
  </span><span>Table</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>TableRow</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'T2'</span><span>)],</span><span>
      </span><span>)</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
  </span><span>Table</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>TableRow</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'T3'</span><span>)],</span><span>
      </span><span>)</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
  </span><span>Table</span><span>(</span><span>
    children</span><span>:</span><span> </span><span>const</span><span> </span><span>[</span><span>
      </span><span>TableRow</span><span>(</span><span>
        children</span><span>:</span><span> </span><span>[</span><span>Text</span><span>(</span><span>'T10'</span><span>)],</span><span> </span><span>// modified</span><span>
      </span><span>)</span><span>
    </span><span>],</span><span>
  </span><span>),</span><span>
</span><span>];</span>
```

You hot reload, but the change is not reflected.

Conversely, in the following example:

```
<span>const</span><span> foo </span><span>=</span><span> </span><span>1</span><span>;</span><span>
</span><span>final</span><span> bar </span><span>=</span><span> foo</span><span>;</span><span>
</span><span>void</span><span> onClick</span><span>()</span><span> </span><span>{</span><span>
  print</span><span>(</span><span>foo</span><span>);</span><span>
  print</span><span>(</span><span>bar</span><span>);</span><span>
</span><span>}</span>
```

Running the app for the first time prints `1` and `1`. Then, you make the following change:

```
<span>const</span><span> foo </span><span>=</span><span> </span><span>2</span><span>;</span><span> </span><span>// modified</span><span>
</span><span>final</span><span> bar </span><span>=</span><span> foo</span><span>;</span><span>
</span><span>void</span><span> onClick</span><span>()</span><span> </span><span>{</span><span>
  print</span><span>(</span><span>foo</span><span>);</span><span>
  print</span><span>(</span><span>bar</span><span>);</span><span>
</span><span>}</span>
```

While changes to `const` field values are always hot reloaded, the static field initializer is not rerun. Conceptually, `const` fields are treated like aliases instead of state.

The Dart VM detects initializer changes and flags when a set of changes needs a hot restart to take effect. The flagging mechanism is triggered for most of the initialization work in the above example, but not for cases like the following:

To update `foo` and view the change after hot reload, consider redefining the field as `const` or using a getter to return the value, rather than using `final`. For example, either of the following solutions work:

```
<span>const</span><span> foo </span><span>=</span><span> </span><span>1</span><span>;</span><span>
</span><span>const</span><span> bar </span><span>=</span><span> foo</span><span>;</span><span> </span><span>// Convert foo to a const...</span><span>
</span><span>void</span><span> onClick</span><span>()</span><span> </span><span>{</span><span>
  print</span><span>(</span><span>foo</span><span>);</span><span>
  print</span><span>(</span><span>bar</span><span>);</span><span>
</span><span>}</span>
```

```
<span>const</span><span> foo </span><span>=</span><span> </span><span>1</span><span>;</span><span>
</span><span>int</span><span> </span><span>get</span><span> bar </span><span>=&gt;</span><span> foo</span><span>;</span><span> </span><span>// ...or provide a getter.</span><span>
</span><span>void</span><span> onClick</span><span>()</span><span> </span><span>{</span><span>
  print</span><span>(</span><span>foo</span><span>);</span><span>
  print</span><span>(</span><span>bar</span><span>);</span><span>
</span><span>}</span>
```

For more information, read about the [differences between the `const` and `final` keywords](https://dart.dev/language/variables#final-and-const) in Dart.

### Recent UI change is excluded

Even when a hot reload operation appears successful and generates no exceptions, some code changes might not be visible in the refreshed UI. This behavior is common after changes to the app’s `main()` or `initState()` methods.

As a general rule, if the modified code is downstream of the root widget’s `build()` method, then hot reload behaves as expected. However, if the modified code won’t be re-executed as a result of rebuilding the widget tree, then you won’t see its effects after hot reload.

For example, consider the following code:

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>MyApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GestureDetector</span><span>(</span><span>onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> print</span><span>(</span><span>'tapped'</span><span>));</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

After running this app, change the code as follows:

```
<span>import</span><span> </span><span>'package:flutter/widgets.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'Hello'</span><span>,</span><span> textDirection</span><span>:</span><span> </span><span>TextDirection</span><span>.</span><span>ltr</span><span>)));</span><span>
</span><span>}</span>
```

With a hot restart, the program starts from the beginning, executes the new version of `main()`, and builds a widget tree that displays the text `Hello`.

However, if you hot reload the app after this change, `main()` and `initState()` are not re-executed, and the widget tree is rebuilt with the unchanged instance of `MyApp` as the root widget. This results in no visible change after hot reload.

## How it works

When hot reload is invoked, the host machine looks at the edited code since the last compilation. The following libraries are recompiled:

-   Any libraries with changed code
-   The application’s main library
-   The libraries from the main library leading to affected libraries

The source code from those libraries is compiled into [kernel files](https://github.com/dart-lang/sdk/tree/main/pkg/kernel) and sent to the mobile device’s Dart VM.

The Dart VM re-loads all libraries from the new kernel file. So far no code is re-executed.

The hot reload mechanism then causes the Flutter framework to trigger a rebuild/re-layout/repaint of all existing widgets and render objects.