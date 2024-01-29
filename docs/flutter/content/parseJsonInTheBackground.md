1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Networking](https://docs.flutter.dev/cookbook/networking)
3.  [Parse JSON in the background](https://docs.flutter.dev/cookbook/networking/background-parsing)

By default, Dart apps do all of their work on a single thread. In many cases, this model simplifies coding and is fast enough that it does not result in poor app performance or stuttering animations, often called “jank.”

However, you might need to perform an expensive computation, such as parsing a very large JSON document. If this work takes more than 16 milliseconds, your users experience jank.

To avoid jank, you need to perform expensive computations like this in the background. On Android, this means scheduling work on a different thread. In Flutter, you can use a separate [Isolate](https://api.flutter.dev/flutter/dart-isolate/Isolate-class.html). This recipe uses the following steps:

1.  Add the `http` package.
2.  Make a network request using the `http` package.
3.  Convert the response into a list of photos.
4.  Move this work to a separate isolate.

## 1\. Add the `http` package

First, add the [`http`](https://pub.dev/packages/http) package to your project. The `http` package makes it easier to perform network requests, such as fetching data from a JSON endpoint.

To add the `http` package as a dependency, run `flutter pub add`:

## 2\. Make a network request

This example covers how to fetch a large JSON document that contains a list of 5000 photo objects from the [JSONPlaceholder REST API](https://jsonplaceholder.typicode.com/), using the [`http.get()`](https://pub.dev/documentation/http/latest/http/get.html) method.

```
<span>Future</span><span>&lt;</span><span>http</span><span>.</span><span>Response</span><span>&gt;</span><span> fetchPhotos</span><span>(</span><span>http</span><span>.</span><span>Client</span><span> client</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>return</span><span> client</span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/photos'</span><span>));</span><span>
</span><span>}</span>
```

## 3\. Parse and convert the JSON into a list of photos

Next, following the guidance from the [Fetch data from the internet](https://docs.flutter.dev/cookbook/networking/fetch-data) recipe, convert the `http.Response` into a list of Dart objects. This makes the data easier to work with.

### Create a `Photo` class

First, create a `Photo` class that contains data about a photo. Include a `fromJson()` factory method to make it easy to create a `Photo` starting with a JSON object.

```
<span>class</span><span> </span><span>Photo</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> albumId</span><span>;</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> url</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> thumbnailUrl</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Photo</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>albumId</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>url</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>thumbnailUrl</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>factory</span><span> </span><span>Photo</span><span>.</span><span>fromJson</span><span>(</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> json</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Photo</span><span>(</span><span>
      albumId</span><span>:</span><span> json</span><span>[</span><span>'albumId'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
      id</span><span>:</span><span> json</span><span>[</span><span>'id'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
      title</span><span>:</span><span> json</span><span>[</span><span>'title'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
      url</span><span>:</span><span> json</span><span>[</span><span>'url'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
      thumbnailUrl</span><span>:</span><span> json</span><span>[</span><span>'thumbnailUrl'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Convert the response into a list of photos

Now, use the following instructions to update the `fetchPhotos()` function so that it returns a `Future<List<Photo>>`:

1.  Create a `parsePhotos()` function that converts the response body into a `List<Photo>`.
2.  Use the `parsePhotos()` function in the `fetchPhotos()` function.

```
<span>// A function that converts a response body into a List&lt;Photo&gt;.</span><span>
</span><span>List</span><span>&lt;</span><span>Photo</span><span>&gt;</span><span> parsePhotos</span><span>(</span><span>String</span><span> responseBody</span><span>)</span><span> </span><span>{</span><span>
  </span><span>final</span><span> parsed </span><span>=</span><span>
      </span><span>(</span><span>jsonDecode</span><span>(</span><span>responseBody</span><span>)</span><span> </span><span>as</span><span> </span><span>List</span><span>).</span><span>cast</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;();</span><span>

  </span><span>return</span><span> parsed</span><span>.</span><span>map</span><span>&lt;</span><span>Photo</span><span>&gt;((</span><span>json</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Photo</span><span>.</span><span>fromJson</span><span>(</span><span>json</span><span>)).</span><span>toList</span><span>();</span><span>
</span><span>}</span><span>

</span><span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Photo</span><span>&gt;&gt;</span><span> fetchPhotos</span><span>(</span><span>http</span><span>.</span><span>Client</span><span> client</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> client
      </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/photos'</span><span>));</span><span>

  </span><span>// Synchronously run parsePhotos in the main isolate.</span><span>
  </span><span>return</span><span> parsePhotos</span><span>(</span><span>response</span><span>.</span><span>body</span><span>);</span><span>
</span><span>}</span>
```

## 4\. Move this work to a separate isolate

If you run the `fetchPhotos()` function on a slower device, you might notice the app freezes for a brief moment as it parses and converts the JSON. This is jank, and you want to get rid of it.

You can remove the jank by moving the parsing and conversion to a background isolate using the [`compute()`](https://api.flutter.dev/flutter/foundation/compute.html) function provided by Flutter. The `compute()` function runs expensive functions in a background isolate and returns the result. In this case, run the `parsePhotos()` function in the background.

```
<span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Photo</span><span>&gt;&gt;</span><span> fetchPhotos</span><span>(</span><span>http</span><span>.</span><span>Client</span><span> client</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> client
      </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/photos'</span><span>));</span><span>

  </span><span>// Use the compute function to run parsePhotos in a separate isolate.</span><span>
  </span><span>return</span><span> compute</span><span>(</span><span>parsePhotos</span><span>,</span><span> response</span><span>.</span><span>body</span><span>);</span><span>
</span><span>}</span>
```

## Notes on working with isolates

Isolates communicate by passing messages back and forth. These messages can be primitive values, such as `null`, `num`, `bool`, `double`, or `String`, or simple objects such as the `List<Photo>` in this example.

You might experience errors if you try to pass more complex objects, such as a `Future` or `http.Response` between isolates.

As an alternate solution, check out the [`worker_manager`](https://pub.dev/packages/worker_manager) or [`workmanager`](https://pub.dev/packages/workmanager) packages for background processing.

## Complete example

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/foundation.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Photo</span><span>&gt;&gt;</span><span> fetchPhotos</span><span>(</span><span>http</span><span>.</span><span>Client</span><span> client</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> client
      </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/photos'</span><span>));</span><span>

  </span><span>// Use the compute function to run parsePhotos in a separate isolate.</span><span>
  </span><span>return</span><span> compute</span><span>(</span><span>parsePhotos</span><span>,</span><span> response</span><span>.</span><span>body</span><span>);</span><span>
</span><span>}</span><span>

</span><span>// A function that converts a response body into a List&lt;Photo&gt;.</span><span>
</span><span>List</span><span>&lt;</span><span>Photo</span><span>&gt;</span><span> parsePhotos</span><span>(</span><span>String</span><span> responseBody</span><span>)</span><span> </span><span>{</span><span>
  </span><span>final</span><span> parsed </span><span>=</span><span>
      </span><span>(</span><span>jsonDecode</span><span>(</span><span>responseBody</span><span>)</span><span> </span><span>as</span><span> </span><span>List</span><span>).</span><span>cast</span><span>&lt;</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;&gt;();</span><span>

  </span><span>return</span><span> parsed</span><span>.</span><span>map</span><span>&lt;</span><span>Photo</span><span>&gt;((</span><span>json</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Photo</span><span>.</span><span>fromJson</span><span>(</span><span>json</span><span>)).</span><span>toList</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>Photo</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> albumId</span><span>;</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> url</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> thumbnailUrl</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Photo</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>albumId</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>url</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>thumbnailUrl</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>factory</span><span> </span><span>Photo</span><span>.</span><span>fromJson</span><span>(</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> json</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Photo</span><span>(</span><span>
      albumId</span><span>:</span><span> json</span><span>[</span><span>'albumId'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
      id</span><span>:</span><span> json</span><span>[</span><span>'id'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
      title</span><span>:</span><span> json</span><span>[</span><span>'title'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
      url</span><span>:</span><span> json</span><span>[</span><span>'url'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
      thumbnailUrl</span><span>:</span><span> json</span><span>[</span><span>'thumbnailUrl'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>const</span><span> appTitle </span><span>=</span><span> </span><span>'Isolate Demo'</span><span>;</span><span>

    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> appTitle</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>MyHomePage</span><span>(</span><span>title</span><span>:</span><span> appTitle</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyHomePage</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyHomePage</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>FutureBuilder</span><span>&lt;</span><span>List</span><span>&lt;</span><span>Photo</span><span>&gt;&gt;(</span><span>
        future</span><span>:</span><span> fetchPhotos</span><span>(</span><span>http</span><span>.</span><span>Client</span><span>()),</span><span>
        builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
          </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasError</span><span>)</span><span> </span><span>{</span><span>
            </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'An error has occurred!'</span><span>),</span><span>
            </span><span>);</span><span>
          </span><span>}</span><span> </span><span>else</span><span> </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasData</span><span>)</span><span> </span><span>{</span><span>
            </span><span>return</span><span> </span><span>PhotosList</span><span>(</span><span>photos</span><span>:</span><span> snapshot</span><span>.</span><span>data</span><span>!);</span><span>
          </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
            </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>CircularProgressIndicator</span><span>(),</span><span>
            </span><span>);</span><span>
          </span><span>}</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>PhotosList</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>PhotosList</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>photos</span><span>});</span><span>

  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Photo</span><span>&gt;</span><span> photos</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>GridView</span><span>.</span><span>builder</span><span>(</span><span>
      gridDelegate</span><span>:</span><span> </span><span>const</span><span> </span><span>SliverGridDelegateWithFixedCrossAxisCount</span><span>(</span><span>
        crossAxisCount</span><span>:</span><span> </span><span>2</span><span>,</span><span>
      </span><span>),</span><span>
      itemCount</span><span>:</span><span> photos</span><span>.</span><span>length</span><span>,</span><span>
      itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
        </span><span>return</span><span> </span><span>Image</span><span>.</span><span>network</span><span>(</span><span>photos</span><span>[</span><span>index</span><span>].</span><span>thumbnailUrl</span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![Isolate demo](https://docs.flutter.dev/assets/images/docs/cookbook/isolate.gif)