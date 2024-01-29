1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Networking](https://docs.flutter.dev/cookbook/networking)
3.  [Send data to the internet](https://docs.flutter.dev/cookbook/networking/send-data)

Sending data to the internet is necessary for most apps. The `http` package has got that covered, too.

This recipe uses the following steps:

1.  Add the `http` package.
2.  Send data to a server using the `http` package.
3.  Convert the response into a custom Dart object.
4.  Get a `title` from user input.
5.  Display the response on screen.

## 1\. Add the `http` package

To add the `http` package as a dependency, run `flutter pub add`:

Import the `http` package.

```
<span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span>
```

If you develop for android, add the following permission inside the manifest tag in the `AndroidManifest.xml` file located at `android/app/src/main`.

```
<span>&lt;uses-permission</span> <span>android:name=</span><span>"android.permission.INTERNET"</span><span>/&gt;</span>
```

## 2\. Sending data to server

This recipe covers how to create an `Album` by sending an album title to the [JSONPlaceholder](https://jsonplaceholder.typicode.com/) using the [`http.post()`](https://pub.dev/documentation/http/latest/http/post.html) method.

Import `dart:convert` for access to `jsonEncode` to encode the data:

Use the `http.post()` method to send the encoded data:

```
<span>Future</span><span>&lt;</span><span>http</span><span>.</span><span>Response</span><span>&gt;</span><span> createAlbum</span><span>(</span><span>String</span><span> title</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> http</span><span>.</span><span>post</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums'</span><span>),</span><span>
    headers</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'Content-Type'</span><span>:</span><span> </span><span>'application/json; charset=UTF-8'</span><span>,</span><span>
    </span><span>},</span><span>
    body</span><span>:</span><span> jsonEncode</span><span>(&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'title'</span><span>:</span><span> title</span><span>,</span><span>
    </span><span>}),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

The `http.post()` method returns a `Future` that contains a `Response`.

-   [`Future`](https://api.flutter.dev/flutter/dart-async/Future-class.html) is a core Dart class for working with asynchronous operations. A Future object represents a potential value or error that will be available at some time in the future.
-   The `http.Response` class contains the data received from a successful http call.
-   The `createAlbum()` method takes an argument `title` that is sent to the server to create an `Album`.

## 3\. Convert the `http.Response` to a custom Dart object

While it’s easy to make a network request, working with a raw `Future<http.Response>` isn’t very convenient. To make your life easier, convert the `http.Response` into a Dart object.

### Create an Album class

First, create an `Album` class that contains the data from the network request. It includes a factory constructor that creates an `Album` from JSON.

Converting JSON with [pattern matching](https://dart.dev/language/patterns) is only one option. For more information, see the full article on [JSON and serialization](https://docs.flutter.dev/data-and-backend/serialization/json).

```
<span>class</span><span> </span><span>Album</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Album</span><span>({</span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>factory</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> json</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>switch</span><span> </span><span>(</span><span>json</span><span>)</span><span> </span><span>{</span><span>
      </span><span>{</span><span>
        </span><span>'id'</span><span>:</span><span> </span><span>int</span><span> id</span><span>,</span><span>
        </span><span>'title'</span><span>:</span><span> </span><span>String</span><span> title</span><span>,</span><span>
      </span><span>}</span><span> </span><span>=&gt;</span><span>
        </span><span>Album</span><span>(</span><span>
          id</span><span>:</span><span> id</span><span>,</span><span>
          title</span><span>:</span><span> title</span><span>,</span><span>
        </span><span>),</span><span>
      _ </span><span>=&gt;</span><span> </span><span>throw</span><span> </span><span>const</span><span> </span><span>FormatException</span><span>(</span><span>'Failed to load album.'</span><span>),</span><span>
    </span><span>};</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Convert the `http.Response` to an `Album`

Use the following steps to update the `createAlbum()` function to return a `Future<Album>`:

1.  Convert the response body into a JSON `Map` with the `dart:convert` package.
2.  If the server returns a `CREATED` response with a status code of 201, then convert the JSON `Map` into an `Album` using the `fromJson()` factory method.
3.  If the server doesn’t return a `CREATED` response with a status code of 201, then throw an exception. (Even in the case of a “404 Not Found” server response, throw an exception. Do not return `null`. This is important when examining the data in `snapshot`, as shown below.)

```
<span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> createAlbum</span><span>(</span><span>String</span><span> title</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>post</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums'</span><span>),</span><span>
    headers</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'Content-Type'</span><span>:</span><span> </span><span>'application/json; charset=UTF-8'</span><span>,</span><span>
    </span><span>},</span><span>
    body</span><span>:</span><span> jsonEncode</span><span>(&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'title'</span><span>:</span><span> title</span><span>,</span><span>
    </span><span>}),</span><span>
  </span><span>);</span><span>

  </span><span>if</span><span> </span><span>(</span><span>response</span><span>.</span><span>statusCode </span><span>==</span><span> </span><span>201</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// If the server did return a 201 CREATED response,</span><span>
    </span><span>// then parse the JSON.</span><span>
    </span><span>return</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;);</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    </span><span>// If the server did not return a 201 CREATED response,</span><span>
    </span><span>// then throw an exception.</span><span>
    </span><span>throw</span><span> </span><span>Exception</span><span>(</span><span>'Failed to create album.'</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Hooray! Now you’ve got a function that sends the title to a server to create an album.

## 4\. Get a title from user input

Next, create a `TextField` to enter a title and a `ElevatedButton` to send data to server. Also define a `TextEditingController` to read the user input from a `TextField`.

When the `ElevatedButton` is pressed, the `_futureAlbum` is set to the value returned by `createAlbum()` method.

```
<span>Column</span><span>(</span><span>
  mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
    </span><span>TextField</span><span>(</span><span>
      controller</span><span>:</span><span> _controller</span><span>,</span><span>
      decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>InputDecoration</span><span>(</span><span>hintText</span><span>:</span><span> </span><span>'Enter Title'</span><span>),</span><span>
    </span><span>),</span><span>
    </span><span>ElevatedButton</span><span>(</span><span>
      onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          _futureAlbum </span><span>=</span><span> createAlbum</span><span>(</span><span>_controller</span><span>.</span><span>text</span><span>);</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Create Data'</span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>],</span><span>
</span><span>)</span>
```

On pressing the **Create Data** button, make the network request, which sends the data in the `TextField` to the server as a `POST` request. The Future, `_futureAlbum`, is used in the next step.

## 5\. Display the response on screen

To display the data on screen, use the [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) widget. The `FutureBuilder` widget comes with Flutter and makes it easy to work with asynchronous data sources. You must provide two parameters:

1.  The `Future` you want to work with. In this case, the future returned from the `createAlbum()` function.
2.  A `builder` function that tells Flutter what to render, depending on the state of the `Future`: loading, success, or error.

Note that `snapshot.hasData` only returns `true` when the snapshot contains a non-null data value. This is why the `createAlbum()` function should throw an exception even in the case of a “404 Not Found” server response. If `createAlbum()` returns `null`, then `CircularProgressIndicator` displays indefinitely.

```
<span>FutureBuilder</span><span>&lt;</span><span>Album</span><span>&gt;(</span><span>
  future</span><span>:</span><span> _futureAlbum</span><span>,</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasData</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>Text</span><span>(</span><span>snapshot</span><span>.</span><span>data</span><span>!.</span><span>title</span><span>);</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasError</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>Text</span><span>(</span><span>'${snapshot.error}'</span><span>);</span><span>
    </span><span>}</span><span>

    </span><span>return</span><span> </span><span>const</span><span> </span><span>CircularProgressIndicator</span><span>();</span><span>
  </span><span>},</span><span>
</span><span>)</span>
```

## Complete example

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> createAlbum</span><span>(</span><span>String</span><span> title</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>post</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums'</span><span>),</span><span>
    headers</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'Content-Type'</span><span>:</span><span> </span><span>'application/json; charset=UTF-8'</span><span>,</span><span>
    </span><span>},</span><span>
    body</span><span>:</span><span> jsonEncode</span><span>(&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'title'</span><span>:</span><span> title</span><span>,</span><span>
    </span><span>}),</span><span>
  </span><span>);</span><span>

  </span><span>if</span><span> </span><span>(</span><span>response</span><span>.</span><span>statusCode </span><span>==</span><span> </span><span>201</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// If the server did return a 201 CREATED response,</span><span>
    </span><span>// then parse the JSON.</span><span>
    </span><span>return</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;);</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    </span><span>// If the server did not return a 201 CREATED response,</span><span>
    </span><span>// then throw an exception.</span><span>
    </span><span>throw</span><span> </span><span>Exception</span><span>(</span><span>'Failed to create album.'</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>Album</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Album</span><span>({</span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>factory</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> json</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>switch</span><span> </span><span>(</span><span>json</span><span>)</span><span> </span><span>{</span><span>
      </span><span>{</span><span>
        </span><span>'id'</span><span>:</span><span> </span><span>int</span><span> id</span><span>,</span><span>
        </span><span>'title'</span><span>:</span><span> </span><span>String</span><span> title</span><span>,</span><span>
      </span><span>}</span><span> </span><span>=&gt;</span><span>
        </span><span>Album</span><span>(</span><span>
          id</span><span>:</span><span> id</span><span>,</span><span>
          title</span><span>:</span><span> title</span><span>,</span><span>
        </span><span>),</span><span>
      _ </span><span>=&gt;</span><span> </span><span>throw</span><span> </span><span>const</span><span> </span><span>FormatException</span><span>(</span><span>'Failed to load album.'</span><span>),</span><span>
    </span><span>};</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyApp</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> _MyAppState</span><span>();</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyApp</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>TextEditingController</span><span> _controller </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>
  </span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;?</span><span> _futureAlbum</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Create Data Example'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Create Data Example'</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Container</span><span>(</span><span>
          alignment</span><span>:</span><span> </span><span>Alignment</span><span>.</span><span>center</span><span>,</span><span>
          padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>8</span><span>),</span><span>
          child</span><span>:</span><span> </span><span>(</span><span>_futureAlbum </span><span>==</span><span> </span><span>null</span><span>)</span><span> </span><span>?</span><span> buildColumn</span><span>()</span><span> </span><span>:</span><span> buildFutureBuilder</span><span>(),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Column</span><span> buildColumn</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Column</span><span>(</span><span>
      mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
      children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
        </span><span>TextField</span><span>(</span><span>
          controller</span><span>:</span><span> _controller</span><span>,</span><span>
          decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>InputDecoration</span><span>(</span><span>hintText</span><span>:</span><span> </span><span>'Enter Title'</span><span>),</span><span>
        </span><span>),</span><span>
        </span><span>ElevatedButton</span><span>(</span><span>
          onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
            setState</span><span>(()</span><span> </span><span>{</span><span>
              _futureAlbum </span><span>=</span><span> createAlbum</span><span>(</span><span>_controller</span><span>.</span><span>text</span><span>);</span><span>
            </span><span>});</span><span>
          </span><span>},</span><span>
          child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Create Data'</span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>],</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>FutureBuilder</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> buildFutureBuilder</span><span>()</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>FutureBuilder</span><span>&lt;</span><span>Album</span><span>&gt;(</span><span>
      future</span><span>:</span><span> _futureAlbum</span><span>,</span><span>
      builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
        </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasData</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> </span><span>Text</span><span>(</span><span>snapshot</span><span>.</span><span>data</span><span>!.</span><span>title</span><span>);</span><span>
        </span><span>}</span><span> </span><span>else</span><span> </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasError</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> </span><span>Text</span><span>(</span><span>'${snapshot.error}'</span><span>);</span><span>
        </span><span>}</span><span>

        </span><span>return</span><span> </span><span>const</span><span> </span><span>CircularProgressIndicator</span><span>();</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```