1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Persistence](https://docs.flutter.dev/cookbook/persistence)
3.  [Read and write files](https://docs.flutter.dev/cookbook/persistence/reading-writing-files)

In some cases, you need to read and write files to disk. For example, you might need to persist data across app launches, or download data from the internet and save it for later offline use.

To save files to disk on mobile or desktop apps, combine the [`path_provider`](https://pub.dev/packages/path_provider) plugin with the [`dart:io`](https://api.flutter.dev/flutter/dart-io/dart-io-library.html) library.

This recipe uses the following steps:

1.  Find the correct local path.
2.  Create a reference to the file location.
3.  Write data to the file.
4.  Read data from the file.

To learn more, watch this Package of the Week video on the `path_provider` package:

<iframe src="https://www.youtube.com/embed/Ci4t-NkOY3I?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="path_provider (Package of the Week)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-9257802_51="true" id="626291853" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true" data-gtm-yt-inspected-6="true"></iframe>

## 1\. Find the correct local path

This example displays a counter. When the counter changes, write data on disk so you can read it again when the app loads. Where should you store this data?

The [`path_provider`](https://pub.dev/packages/path_provider) package provides a platform-agnostic way to access commonly used locations on the device’s file system. The plugin currently supports access to two file system locations:

_Temporary directory_

A temporary directory (cache) that the system can clear at any time. On iOS, this corresponds to the [`NSCachesDirectory`](https://developer.apple.com/documentation/foundation/nssearchpathdirectory/nscachesdirectory). On Android, this is the value that [`getCacheDir()`](https://developer.android.com/reference/android/content/Context#getCacheDir()) returns.

_Documents directory_

A directory for the app to store files that only it can access. The system clears the directory only when the app is deleted. On iOS, this corresponds to the `NSDocumentDirectory`. On Android, this is the `AppData` directory.

This example stores information in the documents directory. You can find the path to the documents directory as follows:

```
<span>Future</span><span>&lt;</span><span>String</span><span>&gt;</span><span> </span><span>get</span><span> _localPath </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> directory </span><span>=</span><span> </span><span>await</span><span> getApplicationDocumentsDirectory</span><span>();</span><span>

  </span><span>return</span><span> directory</span><span>.</span><span>path</span><span>;</span><span>
</span><span>}</span>
```

## 2\. Create a reference to the file location

Once you know where to store the file, create a reference to the file’s full location. You can use the [`File`](https://api.flutter.dev/flutter/dart-io/File-class.html) class from the [`dart:io`](https://api.flutter.dev/flutter/dart-io/dart-io-library.html) library to achieve this.

```
<span>Future</span><span>&lt;</span><span>File</span><span>&gt;</span><span> </span><span>get</span><span> _localFile </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> path </span><span>=</span><span> </span><span>await</span><span> _localPath</span><span>;</span><span>
  </span><span>return</span><span> </span><span>File</span><span>(</span><span>'$path/counter.txt'</span><span>);</span><span>
</span><span>}</span>
```

## 3\. Write data to the file

Now that you have a `File` to work with, use it to read and write data. First, write some data to the file. The counter is an integer, but is written to the file as a string using the `'$counter'` syntax.

```
<span>Future</span><span>&lt;</span><span>File</span><span>&gt;</span><span> writeCounter</span><span>(</span><span>int</span><span> counter</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> file </span><span>=</span><span> </span><span>await</span><span> _localFile</span><span>;</span><span>

  </span><span>// Write the file</span><span>
  </span><span>return</span><span> file</span><span>.</span><span>writeAsString</span><span>(</span><span>'$counter'</span><span>);</span><span>
</span><span>}</span>
```

## 4\. Read data from the file

Now that you have some data on disk, you can read it. Once again, use the `File` class.

```
<span>Future</span><span>&lt;</span><span>int</span><span>&gt;</span><span> readCounter</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>try</span><span> </span><span>{</span><span>
    </span><span>final</span><span> file </span><span>=</span><span> </span><span>await</span><span> _localFile</span><span>;</span><span>

    </span><span>// Read the file</span><span>
    </span><span>final</span><span> contents </span><span>=</span><span> </span><span>await</span><span> file</span><span>.</span><span>readAsString</span><span>();</span><span>

    </span><span>return</span><span> </span><span>int</span><span>.</span><span>parse</span><span>(</span><span>contents</span><span>);</span><span>
  </span><span>}</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// If encountering an error, return 0</span><span>
    </span><span>return</span><span> </span><span>0</span><span>;</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## Complete example

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:io'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:path_provider/path_provider.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Reading and Writing Files'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>FlutterDemo</span><span>(</span><span>storage</span><span>:</span><span> </span><span>CounterStorage</span><span>()),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>CounterStorage</span><span> </span><span>{</span><span>
  </span><span>Future</span><span>&lt;</span><span>String</span><span>&gt;</span><span> </span><span>get</span><span> _localPath </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> directory </span><span>=</span><span> </span><span>await</span><span> getApplicationDocumentsDirectory</span><span>();</span><span>

    </span><span>return</span><span> directory</span><span>.</span><span>path</span><span>;</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>File</span><span>&gt;</span><span> </span><span>get</span><span> _localFile </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> path </span><span>=</span><span> </span><span>await</span><span> _localPath</span><span>;</span><span>
    </span><span>return</span><span> </span><span>File</span><span>(</span><span>'$path/counter.txt'</span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>int</span><span>&gt;</span><span> readCounter</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>try</span><span> </span><span>{</span><span>
      </span><span>final</span><span> file </span><span>=</span><span> </span><span>await</span><span> _localFile</span><span>;</span><span>

      </span><span>// Read the file</span><span>
      </span><span>final</span><span> contents </span><span>=</span><span> </span><span>await</span><span> file</span><span>.</span><span>readAsString</span><span>();</span><span>

      </span><span>return</span><span> </span><span>int</span><span>.</span><span>parse</span><span>(</span><span>contents</span><span>);</span><span>
    </span><span>}</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// If encountering an error, return 0</span><span>
      </span><span>return</span><span> </span><span>0</span><span>;</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>File</span><span>&gt;</span><span> writeCounter</span><span>(</span><span>int</span><span> counter</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>final</span><span> file </span><span>=</span><span> </span><span>await</span><span> _localFile</span><span>;</span><span>

    </span><span>// Write the file</span><span>
    </span><span>return</span><span> file</span><span>.</span><span>writeAsString</span><span>(</span><span>'$counter'</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>FlutterDemo</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>FlutterDemo</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>storage</span><span>});</span><span>

  </span><span>final</span><span> </span><span>CounterStorage</span><span> storage</span><span>;</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>FlutterDemo</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _FlutterDemoState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _FlutterDemoState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>FlutterDemo</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>int</span><span> _counter </span><span>=</span><span> </span><span>0</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    widget</span><span>.</span><span>storage</span><span>.</span><span>readCounter</span><span>().</span><span>then</span><span>((</span><span>value</span><span>)</span><span> </span><span>{</span><span>
      setState</span><span>(()</span><span> </span><span>{</span><span>
        _counter </span><span>=</span><span> value</span><span>;</span><span>
      </span><span>});</span><span>
    </span><span>});</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>File</span><span>&gt;</span><span> _incrementCounter</span><span>()</span><span> </span><span>{</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      _counter</span><span>++;</span><span>
    </span><span>});</span><span>

    </span><span>// Write the variable as a string to the file.</span><span>
    </span><span>return</span><span> widget</span><span>.</span><span>storage</span><span>.</span><span>writeCounter</span><span>(</span><span>_counter</span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Reading and Writing Files'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>
          </span><span>'Button tapped $_counter time${_counter == 1 ? '' : '</span><span>s</span><span>'}.'</span><span>,</span><span>
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