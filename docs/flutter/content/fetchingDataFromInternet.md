1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Networking](https://docs.flutter.dev/cookbook/networking)
3.  [Fetch data from the internet](https://docs.flutter.dev/cookbook/networking/fetch-data)

Fetching data from the internet is necessary for most apps. Luckily, Dart and Flutter provide tools, such as the `http` package, for this type of work.

This recipe uses the following steps:

1.  Add the `http` package.
2.  Make a network request using the `http` package.
3.  Convert the response into a custom Dart object.
4.  Fetch and display the data with Flutter.

## 1\. Add the `http` package

The [`http`](https://pub.dev/packages/http) package provides the simplest way to fetch data from the internet.

To add the `http` package as a dependency, run `flutter pub add`:

Import the http package.

```
<span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span>
```

If you are deploying to Android, edit your `AndroidManifest.xml` file to add the Internet permission.

```
<span>&lt;!-- Required to fetch data from the internet. --&gt;</span>
<span>&lt;uses-permission</span> <span>android:name=</span><span>"android.permission.INTERNET"</span> <span>/&gt;</span>
```

Likewise, if you are deploying to macOS, edit your `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements` files to include the network client entitlement.

```
<span>&lt;!-- Required to fetch data from the internet. --&gt;</span>
<span>&lt;key&gt;</span>com.apple.security.network.client<span>&lt;/key&gt;</span>
<span>&lt;true/&gt;</span>
```

## 2\. Make a network request

This recipe covers how to fetch a sample album from the [JSONPlaceholder](https://jsonplaceholder.typicode.com/) using the [`http.get()`](https://pub.dev/documentation/http/latest/http/get.html) method.

```
<span>Future</span><span>&lt;</span><span>http</span><span>.</span><span>Response</span><span>&gt;</span><span> fetchAlbum</span><span>()</span><span> </span><span>{</span><span>
  </span><span>return</span><span> http</span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>));</span><span>
</span><span>}</span>
```

The `http.get()` method returns a `Future` that contains a `Response`.

-   [`Future`](https://api.flutter.dev/flutter/dart-async/Future-class.html) is a core Dart class for working with async operations. A Future object represents a potential value or error that will be available at some time in the future.
-   The `http.Response` class contains the data received from a successful http call.

## 3\. Convert the response into a custom Dart object

While it’s easy to make a network request, working with a raw `Future<http.Response>` isn’t very convenient. To make your life easier, convert the `http.Response` into a Dart object.

### Create an `Album` class

First, create an `Album` class that contains the data from the network request. It includes a factory constructor that creates an `Album` from JSON.

Converting JSON using [pattern matching](https://dart.dev/language/patterns) is only one option. For more information, see the full article on [JSON and serialization](https://docs.flutter.dev/data-and-backend/serialization/json).

```
<span>class</span><span> </span><span>Album</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> userId</span><span>;</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Album</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>userId</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>factory</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> json</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>switch</span><span> </span><span>(</span><span>json</span><span>)</span><span> </span><span>{</span><span>
      </span><span>{</span><span>
        </span><span>'userId'</span><span>:</span><span> </span><span>int</span><span> userId</span><span>,</span><span>
        </span><span>'id'</span><span>:</span><span> </span><span>int</span><span> id</span><span>,</span><span>
        </span><span>'title'</span><span>:</span><span> </span><span>String</span><span> title</span><span>,</span><span>
      </span><span>}</span><span> </span><span>=&gt;</span><span>
        </span><span>Album</span><span>(</span><span>
          userId</span><span>:</span><span> userId</span><span>,</span><span>
          id</span><span>:</span><span> id</span><span>,</span><span>
          title</span><span>:</span><span> title</span><span>,</span><span>
        </span><span>),</span><span>
      _ </span><span>=&gt;</span><span> </span><span>throw</span><span> </span><span>const</span><span> </span><span>FormatException</span><span>(</span><span>'Failed to load album.'</span><span>),</span><span>
    </span><span>};</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Convert the `http.Response` to an `Album`

Now, use the following steps to update the `fetchAlbum()` function to return a `Future<Album>`:

1.  Convert the response body into a JSON `Map` with the `dart:convert` package.
2.  If the server does return an OK response with a status code of 200, then convert the JSON `Map` into an `Album` using the `fromJson()` factory method.
3.  If the server does not return an OK response with a status code of 200, then throw an exception. (Even in the case of a “404 Not Found” server response, throw an exception. Do not return `null`. This is important when examining the data in `snapshot`, as shown below.)

```
<span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> fetchAlbum</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> http
      </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>));</span><span>

  </span><span>if</span><span> </span><span>(</span><span>response</span><span>.</span><span>statusCode </span><span>==</span><span> </span><span>200</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// If the server did return a 200 OK response,</span><span>
    </span><span>// then parse the JSON.</span><span>
    </span><span>return</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;);</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    </span><span>// If the server did not return a 200 OK response,</span><span>
    </span><span>// then throw an exception.</span><span>
    </span><span>throw</span><span> </span><span>Exception</span><span>(</span><span>'Failed to load album'</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

Hooray! Now you’ve got a function that fetches an album from the internet.

## 4\. Fetch the data

Call the `fetchAlbum()` method in either the [`initState()`](https://api.flutter.dev/flutter/widgets/State/initState.html) or [`didChangeDependencies()`](https://api.flutter.dev/flutter/widgets/State/didChangeDependencies.html) methods.

The `initState()` method is called exactly once and then never again. If you want to have the option of reloading the API in response to an [`InheritedWidget`](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html) changing, put the call into the `didChangeDependencies()` method. See [`State`](https://api.flutter.dev/flutter/widgets/State-class.html) for more details.

```
<span>class</span><span> _MyAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyApp</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> futureAlbum</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    futureAlbum </span><span>=</span><span> fetchAlbum</span><span>();</span><span>
  </span><span>}</span><span>
  </span><span>// ···</span><span>
</span><span>}</span>
```

This Future is used in the next step.

## 5\. Display the data

To display the data on screen, use the [`FutureBuilder`](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) widget. The `FutureBuilder` widget comes with Flutter and makes it easy to work with asynchronous data sources.

You must provide two parameters:

1.  The `Future` you want to work with. In this case, the future returned from the `fetchAlbum()` function.
2.  A `builder` function that tells Flutter what to render, depending on the state of the `Future`: loading, success, or error.

Note that `snapshot.hasData` only returns `true` when the snapshot contains a non-null data value.

Because `fetchAlbum` can only return non-null values, the function should throw an exception even in the case of a “404 Not Found” server response. Throwing an exception sets the `snapshot.hasError` to `true` which can be used to display an error message.

Otherwise, the spinner will be displayed.

```
<span>FutureBuilder</span><span>&lt;</span><span>Album</span><span>&gt;(</span><span>
  future</span><span>:</span><span> futureAlbum</span><span>,</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasData</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>Text</span><span>(</span><span>snapshot</span><span>.</span><span>data</span><span>!.</span><span>title</span><span>);</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasError</span><span>)</span><span> </span><span>{</span><span>
      </span><span>return</span><span> </span><span>Text</span><span>(</span><span>'${snapshot.error}'</span><span>);</span><span>
    </span><span>}</span><span>

    </span><span>// By default, show a loading spinner.</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>CircularProgressIndicator</span><span>();</span><span>
  </span><span>},</span><span>
</span><span>)</span>
```

## Why is fetchAlbum() called in initState()?

Although it’s convenient, it’s not recommended to put an API call in a `build()` method.

Flutter calls the `build()` method every time it needs to change anything in the view, and this happens surprisingly often. The `fetchAlbum()` method, if placed inside `build()`, is repeatedly called on each rebuild causing the app to slow down.

Storing the `fetchAlbum()` result in a state variable ensures that the `Future` is executed only once and then cached for subsequent rebuilds.

## Testing

For information on how to test this functionality, see the following recipes:

-   [Introduction to unit testing](https://docs.flutter.dev/cookbook/testing/unit/introduction)
-   [Mock dependencies using Mockito](https://docs.flutter.dev/cookbook/testing/unit/mocking)

## Complete example

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> fetchAlbum</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> http
      </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>));</span><span>

  </span><span>if</span><span> </span><span>(</span><span>response</span><span>.</span><span>statusCode </span><span>==</span><span> </span><span>200</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// If the server did return a 200 OK response,</span><span>
    </span><span>// then parse the JSON.</span><span>
    </span><span>return</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;);</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    </span><span>// If the server did not return a 200 OK response,</span><span>
    </span><span>// then throw an exception.</span><span>
    </span><span>throw</span><span> </span><span>Exception</span><span>(</span><span>'Failed to load album'</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>Album</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>int</span><span> userId</span><span>;</span><span>
  </span><span>final</span><span> </span><span>int</span><span> id</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Album</span><span>({</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>userId</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>factory</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> json</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>switch</span><span> </span><span>(</span><span>json</span><span>)</span><span> </span><span>{</span><span>
      </span><span>{</span><span>
        </span><span>'userId'</span><span>:</span><span> </span><span>int</span><span> userId</span><span>,</span><span>
        </span><span>'id'</span><span>:</span><span> </span><span>int</span><span> id</span><span>,</span><span>
        </span><span>'title'</span><span>:</span><span> </span><span>String</span><span> title</span><span>,</span><span>
      </span><span>}</span><span> </span><span>=&gt;</span><span>
        </span><span>Album</span><span>(</span><span>
          userId</span><span>:</span><span> userId</span><span>,</span><span>
          id</span><span>:</span><span> id</span><span>,</span><span>
          title</span><span>:</span><span> title</span><span>,</span><span>
        </span><span>),</span><span>
      _ </span><span>=&gt;</span><span> </span><span>throw</span><span> </span><span>const</span><span> </span><span>FormatException</span><span>(</span><span>'Failed to load album.'</span><span>),</span><span>
    </span><span>};</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyApp</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyAppState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyApp</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> futureAlbum</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    futureAlbum </span><span>=</span><span> fetchAlbum</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Fetch Data Example'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Fetch Data Example'</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>FutureBuilder</span><span>&lt;</span><span>Album</span><span>&gt;(</span><span>
            future</span><span>:</span><span> futureAlbum</span><span>,</span><span>
            builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
              </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasData</span><span>)</span><span> </span><span>{</span><span>
                </span><span>return</span><span> </span><span>Text</span><span>(</span><span>snapshot</span><span>.</span><span>data</span><span>!.</span><span>title</span><span>);</span><span>
              </span><span>}</span><span> </span><span>else</span><span> </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasError</span><span>)</span><span> </span><span>{</span><span>
                </span><span>return</span><span> </span><span>Text</span><span>(</span><span>'${snapshot.error}'</span><span>);</span><span>
              </span><span>}</span><span>

              </span><span>// By default, show a loading spinner.</span><span>
              </span><span>return</span><span> </span><span>const</span><span> </span><span>CircularProgressIndicator</span><span>();</span><span>
            </span><span>},</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```