Both Dart and Swift support concurrent programming. This guide should help you understand how concurrency works in Dart and how it compares to Swift. With this understanding, you can create high-performing iOS apps.

When developing in the Apple ecosystem, some tasks might take a long time to complete. These tasks include fetching or processing large amounts of data. iOS developers typically use Grand Central Dispatch (GCD) to schedule tasks using a shared thread pool. With GCD, developers add tasks to dispatch queues and GCD decides on which thread to execute them.

But, GCD spins up threads to handle remaining work items. This means you can end up with a large number of threads and the system can become over committed. With Swift, the structured concurrency model reduced the number of threads and context switches. Now, each core has only one thread.

Dart has a single-threaded execution model, with support for `Isolates`, an event loop, and asynchronous code. An `Isolate` is Dart’s implementation of a lightweight thread. Unless you spawn an `Isolate`, your Dart code runs in the main UI thread driven by an event loop. Flutter’s event loop is equivalent to the iOS main loop—in other words, the Looper attached to the main thread.

Dart’s single-threaded model doesn’t mean you are required to run everything as a blocking operation that causes the UI to freeze. Instead, use the asynchronous features that the Dart language provides, such as `async`/`await`.

### Asynchronous Programming

An asynchronous operation allows other operations to execute before it completes. Both Dart and Swift support asynchronous functions using the `async` and `await` keywords. In both cases, `async` marks that a function performs asynchronous work, and `await` tells the system to await a result from function. This means that the Dart VM _could_ suspend the function, if necessary. For more details on asynchronous programming, check out [Concurrency in Dart](https://dart.dev/guides/language/concurrency).

### Leveraging the main thread/isolate

For Apple operating systems, the primary (also called the main) thread is where the application begins running. Rendering the user interface always happens on the main thread. One difference between Swift and Dart is that  
Swift might use different threads for different tasks, and Swift doesn’t guarantee which thread is used. So, when dispatching UI updates in Swift, you might need to ensure that the work occurs on the main thread.

Say you want to write a function that fetches the weather asynchronously and displays the results.

In GCD, to manually dispatch a process to the main thread, you might do something like the following.

First, define the `Weather` `enum`:

```
<span>// 1 second delay is used in mocked API call. </span>
<span>extension</span> <span>UInt64</span> <span>{</span>
  <span>static</span> <span>let</span> <span>oneSecond</span> <span>=</span> <span>UInt64</span><span>(</span><span>1_000_000_000</span><span>)</span>
<span>}</span> 

<span>enum</span> <span>Weather</span><span>:</span> <span>String</span> <span>{</span>
    <span>case</span> <span>rainy</span><span>,</span> <span>sunny</span>
<span>}</span>
```

Next, define the view model and mark it as an `ObservableObject` so that it can return a value of type `Weather?`. Use GCD create to a `DispatchQueue` to send the work to the pool of threads

```
<span>class</span> <span>ContentViewModel</span><span>:</span> <span>ObservableObject</span> <span>{</span>
    <span>@Published</span> <span>private(set)</span> <span>var</span> <span>result</span><span>:</span> <span>Weather</span><span>?</span>

    <span>private</span> <span>let</span> <span>queue</span> <span>=</span> <span>DispatchQueue</span><span>(</span><span>label</span><span>:</span> <span>"weather_io_queue"</span><span>)</span>
    <span>func</span> <span>load</span><span>()</span> <span>{</span>
        <span>// Mimic 1 sec delay.</span>
        <span>queue</span><span>.</span><span>asyncAfter</span><span>(</span><span>deadline</span><span>:</span> <span>.</span><span>now</span><span>()</span> <span>+</span> <span>1</span><span>)</span> <span>{</span> <span>[</span><span>weak</span> <span>self</span><span>]</span> <span>in</span>
            <span>DispatchQueue</span><span>.</span><span>main</span><span>.</span><span>async</span> <span>{</span>
                <span>self</span><span>?</span><span>.</span><span>result</span> <span>=</span> <span>.</span><span>sunny</span>
            <span>}</span>
        <span>}</span>
    <span>}</span>
<span>}</span>
```

Finally, display the results:

```
<span>struct</span> <span>ContentView</span><span>:</span> <span>View</span> <span>{</span>
    <span>@StateObject</span> <span>var</span> <span>viewModel</span> <span>=</span> <span>ContentViewModel</span><span>()</span>
    <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>View</span> <span>{</span>
        <span>Text</span><span>(</span><span>viewModel</span><span>.</span><span>result</span><span>?</span><span>.</span><span>rawValue</span> <span>??</span> <span>"Loading"</span><span>)</span>
            <span>.</span><span>onAppear</span> <span>{</span>
                <span>viewModel</span><span>.</span><span>load</span><span>()</span>
        <span>}</span>
    <span>}</span>
<span>}</span>
```

More recently, Swift introduced _actors_ to support synchronization for shared, mutable state. To ensure that work is performed on the main thread, define a view model class that is marked as a `@MainActor`, with a `load()` function that internally calls an asynchronous function using `Task`.

```
<span>@MainActor</span> <span>class</span> <span>ContentViewModel</span><span>:</span> <span>ObservableObject</span> <span>{</span>
  <span>@Published</span> <span>private(set)</span> <span>var</span> <span>result</span><span>:</span> <span>Weather</span><span>?</span>
  
  <span>func</span> <span>load</span><span>()</span> <span>async</span> <span>{</span>
    <span>try</span><span>?</span> <span>await</span> <span>Task</span><span>.</span><span>sleep</span><span>(</span><span>nanoseconds</span><span>:</span> <span>.</span><span>oneSecond</span><span>)</span>
    <span>self</span><span>.</span><span>result</span> <span>=</span> <span>.</span><span>sunny</span>
  <span>}</span>
<span>}</span>
```

Next, define the view model as a state object using `@StateObject`, with a `load()` function that can be called by the view model:

```
<span>struct</span> <span>ContentView</span><span>:</span> <span>View</span> <span>{</span>
  <span>@StateObject</span> <span>var</span> <span>viewModel</span> <span>=</span> <span>ContentViewModel</span><span>()</span>
  <span>var</span> <span>body</span><span>:</span> <span>some</span> <span>View</span> <span>{</span>
    <span>Text</span><span>(</span><span>viewModel</span><span>.</span><span>result</span><span>?</span><span>.</span><span>rawValue</span> <span>??</span> <span>"Loading..."</span><span>)</span>
      <span>.</span><span>task</span> <span>{</span>
        <span>await</span> <span>viewModel</span><span>.</span><span>load</span><span>()</span>
      <span>}</span>
  <span>}</span>
<span>}</span>
```

In Dart, all work runs on the main isolate by default. To implement the same example in Dart, first, create the `Weather` `enum`:

```
<span>enum</span><span> </span><span>Weather</span><span> </span><span>{</span><span>
  rainy</span><span>,</span><span>
  windy</span><span>,</span><span>
  sunny</span><span>,</span><span>
</span><span>}</span>
```

Then, define a simple view model (similar to what was created in SwiftUI), to fetch the weather. In Dart, a `Future` object represents a value to be provided in the future. A `Future` is similar to Swift’s `ObservableObject`. In this example, a function within the view model returns a `Future<Weather>` object:

```
<span>@immutable
</span><span>class</span><span> </span><span>HomePageViewModel</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>HomePageViewModel</span><span>();</span><span>
  </span><span>Future</span><span>&lt;</span><span>Weather</span><span>&gt;</span><span> load</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>await</span><span> </span><span>Future</span><span>.</span><span>delayed</span><span>(</span><span>const</span><span> </span><span>Duration</span><span>(</span><span>seconds</span><span>:</span><span> </span><span>1</span><span>));</span><span>
    </span><span>return</span><span> </span><span>Weather</span><span>.</span><span>sunny</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

The `load()` function in this example shares similarities with the Swift code. The Dart function is marked as `async` because it uses the `await` keyword.

Additionally, a Dart function marked as `async` automatically returns a `Future`. In other words, you don’t have to create a `Future` instance manually inside functions marked as `async`.

For the last step, display the weather value. In Flutter, [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) and [`StreamBuilder`](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html)  
widgets are used to display the results of a Future in the UI. The following example uses a `FutureBuilder`:

```
<span>class</span><span> </span><span>HomePage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>HomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  </span><span>final</span><span> </span><span>HomePageViewModel</span><span> viewModel </span><span>=</span><span> </span><span>const</span><span> </span><span>HomePageViewModel</span><span>();</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>CupertinoPageScaffold</span><span>(</span><span>
      </span><span>// Feed a FutureBuilder to your widget tree.</span><span>
      child</span><span>:</span><span> </span><span>FutureBuilder</span><span>&lt;</span><span>Weather</span><span>&gt;(</span><span>
        </span><span>// Specify the Future that you want to track.</span><span>
        future</span><span>:</span><span> viewModel</span><span>.</span><span>load</span><span>(),</span><span>
        builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
          </span><span>// A snapshot is of type `AsyncSnapshot` and contains the</span><span>
          </span><span>// state of the Future. By looking if the snapshot contains</span><span>
          </span><span>// an error or if the data is null, you can decide what to</span><span>
          </span><span>// show to the user.</span><span>
          </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasData</span><span>)</span><span> </span><span>{</span><span>
            </span><span>return</span><span> </span><span>Center</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
                snapshot</span><span>.</span><span>data</span><span>.</span><span>toString</span><span>(),</span><span>
              </span><span>),</span><span>
            </span><span>);</span><span>
          </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
            </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>CupertinoActivityIndicator</span><span>(),</span><span>
            </span><span>);</span><span>
          </span><span>}</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

For the complete example, check out the [async\_weather](https://github.com/flutter/website/examples/resources/lib/async_weather.dart) file on GitHub.

### Leveraging a background thread/isolate

Flutter apps can run on a variety of multi-core hardware, including devices running macOS and iOS. To improve the performance of these applications, you must sometimes run tasks on different cores concurrently. This is especially important to avoid blocking UI rendering with long-running operations.

In Swift, you can leverage GCD to run tasks on global queues with different quality of service class (qos) properties. This indicates the task’s priority.

```
<span>func</span> <span>parse</span><span>(</span><span>string</span><span>:</span> <span>String</span><span>,</span> <span>completion</span><span>:</span> <span>@escaping</span> <span>([</span><span>String</span><span>:</span><span>Any</span><span>])</span> <span>-&gt;</span> <span>Void</span><span>)</span> <span>{</span>
  <span>// Mimic 1 sec delay.</span>
  <span>DispatchQueue</span><span>(</span><span>label</span><span>:</span> <span>"data_processing_queue"</span><span>,</span> <span>qos</span><span>:</span> <span>.</span><span>userInitiated</span><span>)</span>
    <span>.</span><span>asyncAfter</span><span>(</span><span>deadline</span><span>:</span> <span>.</span><span>now</span><span>()</span> <span>+</span> <span>1</span><span>)</span> <span>{</span>
      <span>let</span> <span>result</span><span>:</span> <span>[</span><span>String</span><span>:</span><span>Any</span><span>]</span> <span>=</span> <span>[</span><span>"foo"</span><span>:</span> <span>123</span><span>]</span>
      <span>completion</span><span>(</span><span>result</span><span>)</span>
    <span>}</span>
  <span>}</span>
<span>}</span>
```

In Dart, you can offload computation to a worker isolate, often called a background worker. A common scenario spawns a simple worker isolate and returns the results in a message when the worker exits. As of Dart 2.19, you can use `Isolate.run()` to spawn an isolate and run computations:

```
<span>void</span> <span>main</span><span>()</span> <span>async</span> <span>{</span>
  <span>// Read some data.</span>
  <span>final</span> <span>jsonData</span> <span>=</span> <span>await</span> <span>Isolate</span><span>.</span><span>run</span><span>(()</span> <span>=</span><span>&gt;</span> <span>jsonDecode</span><span>(</span><span>jsonString</span><span>)</span> <span>as</span> <span>Map</span><span>&lt;</span><span>String</span><span>,</span> <span>dynamic</span><span>&gt;);</span><span>`</span>

  <span>// Use that data.</span>
  <span>print</span><span>(</span><span>'Number of JSON keys: </span><span>${jsonData.length}</span><span>'</span><span>);</span>
<span>}</span>
```

In Flutter, you can also use the `compute` function to spin up an isolate to run a callback function:

```
<span>final</span> <span>jsonData</span> <span>=</span> <span>await</span> <span>compute</span><span>(</span><span>getNumberOfKeys</span><span>,</span> <span>jsonString</span><span>);</span>
```

In this case, the callback function is a top-level function as shown below:

```
<span>Map</span><span>&lt;</span><span>String</span><span>,</span> <span>dynamic</span><span>&gt;</span> <span>getNumberOfKeys</span><span>(</span><span>String</span> <span>jsonString</span><span>)</span> <span>{</span>
 <span>return</span> <span>jsonDecode</span><span>(</span><span>jsonString</span><span>);</span>
<span>}</span>
```

You can find more information on Dart at [Learning Dart as a Swift developer](https://dart.dev/guides/language/coming-from/swift-to-dart), and more information on Flutter at [Flutter for SwiftUI developers](https://docs.flutter.dev/get-started/flutter-for/swiftui-devs) or [Flutter for UIKit developers](https://docs.flutter.dev/get-started/flutter-for/uikit-devs).