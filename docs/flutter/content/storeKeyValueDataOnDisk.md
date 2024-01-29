1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Persistence](https://docs.flutter.dev/cookbook/persistence)
3.  [Store key-value data on disk](https://docs.flutter.dev/cookbook/persistence/key-value)

If you have a relatively small collection of key-values to save, you can use the [`shared_preferences`](https://pub.dev/packages/shared_preferences) plugin.

Normally, you would have to write native platform integrations for storing data on each platform. Fortunately, the [`shared_preferences`](https://pub.dev/packages/shared_preferences) plugin can be used to persist key-value data to disk on each platform Flutter supports.

This recipe uses the following steps:

1.  Add the dependency.
2.  Save data.
3.  Read data.
4.  Remove data.

## 1\. Add the dependency

Before starting, add the [`shared_preferences`](https://pub.dev/packages/shared_preferences) package as a dependency.

To add the `shared_preferences` package as a dependency, run `flutter pub add`:

```
<span>flutter pub add shared_preferences
</span>
```

## 2\. Save data

To persist data, use the setter methods provided by the `SharedPreferences` class. Setter methods are available for various primitive types, such as `setInt`, `setBool`, and `setString`.

Setter methods do two things: First, synchronously update the key-value pair in memory. Then, persist the data to disk.

```
<span>// Load and obtain the shared preferences for this app.</span><span>
</span><span>final</span><span> prefs </span><span>=</span><span> </span><span>await</span><span> </span><span>SharedPreferences</span><span>.</span><span>getInstance</span><span>();</span><span>

</span><span>// Save the counter value to persistent storage under the 'counter' key.</span><span>
</span><span>await</span><span> prefs</span><span>.</span><span>setInt</span><span>(</span><span>'counter'</span><span>,</span><span> counter</span><span>);</span>
```

## 3\. Read data

To read data, use the appropriate getter method provided by the `SharedPreferences` class. For each setter there is a corresponding getter. For example, you can use the `getInt`, `getBool`, and `getString` methods.

```
<span>final</span><span> prefs </span><span>=</span><span> </span><span>await</span><span> </span><span>SharedPreferences</span><span>.</span><span>getInstance</span><span>();</span><span>

</span><span>// Try reading the counter value from persistent storage.</span><span>
</span><span>// If not present, null is returned, so default to 0.</span><span>
</span><span>final</span><span> counter </span><span>=</span><span> prefs</span><span>.</span><span>getInt</span><span>(</span><span>'counter'</span><span>)</span><span> </span><span>??</span><span> </span><span>0</span><span>;</span>
```

Note that the getter methods throw an exception if the persisted value has a different type than the getter method expects.

## 4\. Remove data

To delete data, use the `remove()` method.

```
<span>final</span><span> prefs </span><span>=</span><span> </span><span>await</span><span> </span><span>SharedPreferences</span><span>.</span><span>getInstance</span><span>();</span><span>

</span><span>// Remove the counter key-value pair from persistent storage.</span><span>
</span><span>await</span><span> prefs</span><span>.</span><span>remove</span><span>(</span><span>'counter'</span><span>);</span>
```

## Supported types

Although the key-value storage provided by `shared_preferences` is easy and convenient to use, it has limitations:

-   Only primitive types can be used: `int`, `double`, `bool`, `String`, and `List<String>`.
-   It’s not designed to store large amounts of data.
-   There is no guarantee that data will be persisted across app restarts.

## Testing support

It’s a good idea to test code that persists data using `shared_preferences`. To enable this, the package provides an in-memory mock implementation of the preference store.

To set up your tests to use the mock implementation, call the `setMockInitialValues` static method in a `setUpAll()` method in your test files. Pass in a map of key-value pairs to use as the initial values.

```
<span>SharedPreferences</span><span>.</span><span>setMockInitialValues</span><span>(&lt;</span><span>String</span><span>,</span><span> </span><span>Object</span><span>&gt;{</span><span>
  </span><span>'counter'</span><span>:</span><span> </span><span>2</span><span>,</span><span>
</span><span>});</span>
```

## Complete example

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:shared_preferences/shared_preferences.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Shared preferences demo'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>MyHomePage</span><span>(</span><span>title</span><span>:</span><span> </span><span>'Shared preferences demo'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyHomePage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyHomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyHomePageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyHomePageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>int</span><span> _counter </span><span>=</span><span> </span><span>0</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    _loadCounter</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>/// Load the initial counter value from persistent storage on start,</span><span>
  </span><span>/// or fallback to 0 if it doesn't exist.</span><span>
  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _loadCounter</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> prefs </span><span>=</span><span> </span><span>await</span><span> </span><span>SharedPreferences</span><span>.</span><span>getInstance</span><span>();</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _counter </span><span>=</span><span> prefs</span><span>.</span><span>getInt</span><span>(</span><span>'counter'</span><span>)</span><span> </span><span>??</span><span> </span><span>0</span><span>;</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>/// After a click, increment the counter state and</span><span>
  </span><span>/// asynchronously save it to persistent storage.</span><span>
  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _incrementCounter</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> prefs </span><span>=</span><span> </span><span>await</span><span> </span><span>SharedPreferences</span><span>.</span><span>getInstance</span><span>();</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _counter </span><span>=</span><span> </span><span>(</span><span>prefs</span><span>.</span><span>getInt</span><span>(</span><span>'counter'</span><span>)</span><span> </span><span>??</span><span> </span><span>0</span><span>)</span><span> </span><span>+</span><span> </span><span>1</span><span>;</span><span>
      prefs</span><span>.</span><span>setInt</span><span>(</span><span>'counter'</span><span>,</span><span> _counter</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>widget</span><span>.</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>const</span><span> </span><span>Text</span><span>(</span><span>
              </span><span>'You have pushed the button this many times: '</span><span>,</span><span>
            </span><span>),</span><span>
            </span><span>Text</span><span>(</span><span>
              </span><span>'$_counter'</span><span>,</span><span>
              style</span><span>:</span><span> </span><span>Theme</span><span>.</span><span>of</span><span>(</span><span>context</span><span>).</span><span>textTheme</span><span>.</span><span>headlineMedium</span><span>,</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> _incrementCounter</span><span>,</span><span>
        tooltip</span><span>:</span><span> </span><span>'Increment'</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>add</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```