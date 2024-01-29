1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Testing](https://docs.flutter.dev/cookbook/testing)
3.  [Integration](https://docs.flutter.dev/cookbook/testing/integration)
4.  [Performance profiling](https://docs.flutter.dev/cookbook/testing/integration/profiling)

When it comes to mobile apps, performance is critical to user experience. Users expect apps to have smooth scrolling and meaningful animations free of stuttering or skipped frames, known as “jank.” How to ensure that your app is free of jank on a wide variety of devices?

There are two options: first, manually test the app on different devices. While that approach might work for a smaller app, it becomes more cumbersome as an app grows in size. Alternatively, run an integration test that performs a specific task and records a performance timeline. Then, examine the results to determine whether a specific section of the app needs to be improved.

In this recipe, learn how to write a test that records a performance timeline while performing a specific task and saves a summary of the results to a local file.

This recipe uses the following steps:

1.  Write a test that scrolls through a list of items.
2.  Record the performance of the app.
3.  Save the results to disk.
4.  Run the test.
5.  Review the results.

### 1\. Write a test that scrolls through a list of items

In this recipe, record the performance of an app as it scrolls through a list of items. To focus on performance profiling, this recipe builds on the [Scrolling](https://docs.flutter.dev/cookbook/testing/widget/scrolling) recipe in widget tests.

Follow the instructions in that recipe to create an app and write a test to verify that everything works as expected.

### 2\. Record the performance of the app

Next, record the performance of the app as it scrolls through the list. Perform this task using the [`traceAction()`](https://api.flutter.dev/flutter/flutter_driver/FlutterDriver/traceAction.html) method provided by the [`IntegrationTestWidgetsFlutterBinding`](https://api.flutter.dev/flutter/package-integration_test_integration_test/IntegrationTestWidgetsFlutterBinding-class.html) class.

This method runs the provided function and records a [`Timeline`](https://api.flutter.dev/flutter/flutter_driver/Timeline-class.html) with detailed information about the performance of the app. This example provides a function that scrolls through the list of items, ensuring that a specific item is displayed. When the function completes, the `traceAction()` creates a report data `Map` that contains the `Timeline`.

Specify the `reportKey` when running more than one `traceAction`. By default all `Timelines` are stored with the key `timeline`, in this example the `reportKey` is changed to `scrolling_timeline`.

```
<span>await</span><span> binding</span><span>.</span><span>traceAction</span><span>(</span><span>
  </span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Scroll until the item to be found appears.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>scrollUntilVisible</span><span>(</span><span>
      itemFinder</span><span>,</span><span>
      </span><span>500.0</span><span>,</span><span>
      scrollable</span><span>:</span><span> listFinder</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
  reportKey</span><span>:</span><span> </span><span>'scrolling_timeline'</span><span>,</span><span>
</span><span>);</span>
```

### 3\. Save the results to disk

Now that you’ve captured a performance timeline, you need a way to review it. The `Timeline` object provides detailed information about all of the events that took place, but it doesn’t provide a convenient way to review the results.

Therefore, convert the `Timeline` into a [`TimelineSummary`](https://api.flutter.dev/flutter/flutter_driver/TimelineSummary-class.html). The `TimelineSummary` can perform two tasks that make it easier to review the results:

1.  Writing a json document on disk that summarizes the data contained within the `Timeline`. This summary includes information about the number of skipped frames, slowest build times, and more.
2.  Saving the complete `Timeline` as a json file on disk. This file can be opened with the Chrome browser’s tracing tools found at `chrome://tracing`.

To capture the results, create a file named `perf_driver.dart` in the `test_driver` folder and add the following code:

```
<span>import</span><span> </span><span>'package:flutter_driver/flutter_driver.dart'</span><span> </span><span>as</span><span> driver</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:integration_test/integration_test_driver.dart'</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> integrationDriver</span><span>(</span><span>
    responseDataCallback</span><span>:</span><span> </span><span>(</span><span>data</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
      </span><span>if</span><span> </span><span>(</span><span>data </span><span>!=</span><span> </span><span>null</span><span>)</span><span> </span><span>{</span><span>
        </span><span>final</span><span> timeline </span><span>=</span><span> driver</span><span>.</span><span>Timeline</span><span>.</span><span>fromJson</span><span>(</span><span>
          data</span><span>[</span><span>'scrolling_timeline'</span><span>]</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;,</span><span>
        </span><span>);</span><span>

        </span><span>// Convert the Timeline into a TimelineSummary that's easier to</span><span>
        </span><span>// read and understand.</span><span>
        </span><span>final</span><span> summary </span><span>=</span><span> driver</span><span>.</span><span>TimelineSummary</span><span>.</span><span>summarize</span><span>(</span><span>timeline</span><span>);</span><span>

        </span><span>// Then, write the entire timeline to disk in a json format.</span><span>
        </span><span>// This file can be opened in the Chrome browser's tracing tools</span><span>
        </span><span>// found by navigating to chrome://tracing.</span><span>
        </span><span>// Optionally, save the summary to disk by setting includeSummary</span><span>
        </span><span>// to true</span><span>
        </span><span>await</span><span> summary</span><span>.</span><span>writeTimelineToFile</span><span>(</span><span>
          </span><span>'scrolling_timeline'</span><span>,</span><span>
          pretty</span><span>:</span><span> </span><span>true</span><span>,</span><span>
          includeSummary</span><span>:</span><span> </span><span>true</span><span>,</span><span>
        </span><span>);</span><span>
      </span><span>}</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The `integrationDriver` function has a `responseDataCallback` which you can customize. By default, it writes the results to the `integration_response_data.json` file, but you can customize it to generate a summary like in this example.

### 4\. Run the test

After configuring the test to capture a performance `Timeline` and save a summary of the results to disk, run the test with the following command:

```
flutter drive \
  --driver=test_driver/perf_driver.dart \
  --target=integration_test/scrolling_test.dart \
  --profile
```

The `--profile` option means to compile the app for the “profile mode” rather than the “debug mode”, so that the benchmark result is closer to what will be experienced by end users.

### 5\. Review the results

After the test completes successfully, the `build` directory at the root of the project contains two files:

1.  `scrolling_summary.timeline_summary.json` contains the summary. Open the file with any text editor to review the information contained within. With a more advanced setup, you could save a summary every time the test runs and create a graph of the results.
2.  `scrolling_timeline.timeline.json` contains the complete timeline data. Open the file using the Chrome browser’s tracing tools found at `chrome://tracing`. The tracing tools provide a convenient interface for inspecting the timeline data to discover the source of a performance issue.

#### Summary example

```
<span>{</span><span>
  </span><span>"average_frame_build_time_millis"</span><span>:</span><span> </span><span>4.2592592592592595</span><span>,</span><span>
  </span><span>"worst_frame_build_time_millis"</span><span>:</span><span> </span><span>21.0</span><span>,</span><span>
  </span><span>"missed_frame_build_budget_count"</span><span>:</span><span> </span><span>2</span><span>,</span><span>
  </span><span>"average_frame_rasterizer_time_millis"</span><span>:</span><span> </span><span>5.518518518518518</span><span>,</span><span>
  </span><span>"worst_frame_rasterizer_time_millis"</span><span>:</span><span> </span><span>51.0</span><span>,</span><span>
  </span><span>"missed_frame_rasterizer_budget_count"</span><span>:</span><span> </span><span>10</span><span>,</span><span>
  </span><span>"frame_count"</span><span>:</span><span> </span><span>54</span><span>,</span><span>
  </span><span>"frame_build_times"</span><span>:</span><span> </span><span>[</span><span>
    </span><span>6874</span><span>,</span><span>
    </span><span>5019</span><span>,</span><span>
    </span><span>3638</span><span>
  </span><span>],</span><span>
  </span><span>"frame_rasterizer_times"</span><span>:</span><span> </span><span>[</span><span>
    </span><span>51955</span><span>,</span><span>
    </span><span>8468</span><span>,</span><span>
    </span><span>3129</span><span>
  </span><span>]</span><span>
</span><span>}</span><span>
</span>
```

### Complete example

**integration\_test/scrolling\_test.dart**

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:integration_test/integration_test.dart'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:scrolling/main.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>final</span><span> binding </span><span>=</span><span> </span><span>IntegrationTestWidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span>

  testWidgets</span><span>(</span><span>'Counter increments smoke test'</span><span>,</span><span> </span><span>(</span><span>tester</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Build our app and trigger a frame.</span><span>
    </span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>MyApp</span><span>(</span><span>
      items</span><span>:</span><span> </span><span>List</span><span>&lt;</span><span>String</span><span>&gt;.</span><span>generate</span><span>(</span><span>10000</span><span>,</span><span> </span><span>(</span><span>i</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>'Item $i'</span><span>),</span><span>
    </span><span>));</span><span>

    </span><span>final</span><span> listFinder </span><span>=</span><span> find</span><span>.</span><span>byType</span><span>(</span><span>Scrollable</span><span>);</span><span>
    </span><span>final</span><span> itemFinder </span><span>=</span><span> find</span><span>.</span><span>byKey</span><span>(</span><span>const</span><span> </span><span>ValueKey</span><span>(</span><span>'item_50_text'</span><span>));</span><span>

    </span><span>await</span><span> binding</span><span>.</span><span>traceAction</span><span>(</span><span>
      </span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
        </span><span>// Scroll until the item to be found appears.</span><span>
        </span><span>await</span><span> tester</span><span>.</span><span>scrollUntilVisible</span><span>(</span><span>
          itemFinder</span><span>,</span><span>
          </span><span>500.0</span><span>,</span><span>
          scrollable</span><span>:</span><span> listFinder</span><span>,</span><span>
        </span><span>);</span><span>
      </span><span>},</span><span>
      reportKey</span><span>:</span><span> </span><span>'scrolling_timeline'</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

**test\_driver/perf\_driver.dart**

```
<span>import</span><span> </span><span>'package:flutter_driver/flutter_driver.dart'</span><span> </span><span>as</span><span> driver</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:integration_test/integration_test_driver.dart'</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> integrationDriver</span><span>(</span><span>
    responseDataCallback</span><span>:</span><span> </span><span>(</span><span>data</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
      </span><span>if</span><span> </span><span>(</span><span>data </span><span>!=</span><span> </span><span>null</span><span>)</span><span> </span><span>{</span><span>
        </span><span>final</span><span> timeline </span><span>=</span><span> driver</span><span>.</span><span>Timeline</span><span>.</span><span>fromJson</span><span>(</span><span>
          data</span><span>[</span><span>'scrolling_timeline'</span><span>]</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;,</span><span>
        </span><span>);</span><span>

        </span><span>// Convert the Timeline into a TimelineSummary that's easier to</span><span>
        </span><span>// read and understand.</span><span>
        </span><span>final</span><span> summary </span><span>=</span><span> driver</span><span>.</span><span>TimelineSummary</span><span>.</span><span>summarize</span><span>(</span><span>timeline</span><span>);</span><span>

        </span><span>// Then, write the entire timeline to disk in a json format.</span><span>
        </span><span>// This file can be opened in the Chrome browser's tracing tools</span><span>
        </span><span>// found by navigating to chrome://tracing.</span><span>
        </span><span>// Optionally, save the summary to disk by setting includeSummary</span><span>
        </span><span>// to true</span><span>
        </span><span>await</span><span> summary</span><span>.</span><span>writeTimelineToFile</span><span>(</span><span>
          </span><span>'scrolling_timeline'</span><span>,</span><span>
          pretty</span><span>:</span><span> </span><span>true</span><span>,</span><span>
          includeSummary</span><span>:</span><span> </span><span>true</span><span>,</span><span>
        </span><span>);</span><span>
      </span><span>}</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```