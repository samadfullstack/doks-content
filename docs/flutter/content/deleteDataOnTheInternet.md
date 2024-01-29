1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Networking](https://docs.flutter.dev/cookbook/networking)
3.  [Delete data on the internet](https://docs.flutter.dev/cookbook/networking/delete-data)

This recipe covers how to delete data over the internet using the `http` package.

This recipe uses the following steps:

1.  Add the `http` package.
2.  Delete data on the server.
3.  Update the screen.

## 1\. Add the `http` package

To add the `http` package as a dependency, run `flutter pub add`:

Import the `http` package.

```
<span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span>
```

## 2\. Delete data on the server

This recipe covers how to delete an album from the [JSONPlaceholder](https://jsonplaceholder.typicode.com/) using the `http.delete()` method. Note that this requires the `id` of the album that you want to delete. For this example, use something you already know, for example `id = 1`.

```
<span>Future</span><span>&lt;</span><span>http</span><span>.</span><span>Response</span><span>&gt;</span><span> deleteAlbum</span><span>(</span><span>String</span><span> id</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>delete</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/$id'</span><span>),</span><span>
    headers</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'Content-Type'</span><span>:</span><span> </span><span>'application/json; charset=UTF-8'</span><span>,</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>

  </span><span>return</span><span> response</span><span>;</span><span>
</span><span>}</span>
```

The `http.delete()` method returns a `Future` that contains a `Response`.

-   [`Future`](https://api.flutter.dev/flutter/dart-async/Future-class.html) is a core Dart class for working with async operations. A Future object represents a potential value or error that will be available at some time in the future.
-   The `http.Response` class contains the data received from a successful http call.
-   The `deleteAlbum()` method takes an `id` argument that is needed to identify the data to be deleted from the server.

## 3\. Update the screen

In order to check whether the data has been deleted or not, first fetch the data from the [JSONPlaceholder](https://jsonplaceholder.typicode.com/) using the `http.get()` method, and display it in the screen. (See the [Fetch Data](https://docs.flutter.dev/cookbook/networking/fetch-data) recipe for a complete example.) You should now have a **Delete Data** button that, when pressed, calls the `deleteAlbum()` method.

```
<span>Column</span><span>(</span><span>
  mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
  children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
    </span><span>Text</span><span>(</span><span>snapshot</span><span>.</span><span>data</span><span>?.</span><span>title </span><span>??</span><span> </span><span>'Deleted'</span><span>),</span><span>
    </span><span>ElevatedButton</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Delete Data'</span><span>),</span><span>
      onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          _futureAlbum </span><span>=</span><span>
              deleteAlbum</span><span>(</span><span>snapshot</span><span>.</span><span>data</span><span>!.</span><span>id</span><span>.</span><span>toString</span><span>());</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
    </span><span>),</span><span>
  </span><span>],</span><span>
</span><span>);</span>
```

Now, when you click on the **_Delete Data_** button, the `deleteAlbum()` method is called and the id you are passing is the id of the data that you retrieved from the internet. This means you are going to delete the same data that you fetched from the internet.

### Returning a response from the deleteAlbum() method

Once the delete request has been made, you can return a response from the `deleteAlbum()` method to notify our screen that the data has been deleted.

```
<span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> deleteAlbum</span><span>(</span><span>String</span><span> id</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>delete</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/$id'</span><span>),</span><span>
    headers</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'Content-Type'</span><span>:</span><span> </span><span>'application/json; charset=UTF-8'</span><span>,</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>

  </span><span>if</span><span> </span><span>(</span><span>response</span><span>.</span><span>statusCode </span><span>==</span><span> </span><span>200</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// If the server did return a 200 OK response,</span><span>
    </span><span>// then parse the JSON. After deleting,</span><span>
    </span><span>// you'll get an empty JSON `{}` response.</span><span>
    </span><span>// Don't return `null`, otherwise `snapshot.hasData`</span><span>
    </span><span>// will always return false on `FutureBuilder`.</span><span>
    </span><span>return</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;);</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    </span><span>// If the server did not return a "200 OK response",</span><span>
    </span><span>// then throw an exception.</span><span>
    </span><span>throw</span><span> </span><span>Exception</span><span>(</span><span>'Failed to delete album.'</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

`FutureBuilder()` now rebuilds when it receives a response. Since the response won’t have any data in its body if the request was successful, the `Album.fromJson()` method creates an instance of the `Album` object with a default value (`null` in our case). This behavior can be altered in any way you wish.

That’s all! Now you’ve got a function that deletes the data from the internet.

## Complete example

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> fetchAlbum</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>),</span><span>
  </span><span>);</span><span>

  </span><span>if</span><span> </span><span>(</span><span>response</span><span>.</span><span>statusCode </span><span>==</span><span> </span><span>200</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// If the server did return a 200 OK response, then parse the JSON.</span><span>
    </span><span>return</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;);</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    </span><span>// If the server did not return a 200 OK response, then throw an exception.</span><span>
    </span><span>throw</span><span> </span><span>Exception</span><span>(</span><span>'Failed to load album'</span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> deleteAlbum</span><span>(</span><span>String</span><span> id</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> http</span><span>.</span><span>Response</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>delete</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/$id'</span><span>),</span><span>
    headers</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>String</span><span>&gt;{</span><span>
      </span><span>'Content-Type'</span><span>:</span><span> </span><span>'application/json; charset=UTF-8'</span><span>,</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>

  </span><span>if</span><span> </span><span>(</span><span>response</span><span>.</span><span>statusCode </span><span>==</span><span> </span><span>200</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// If the server did return a 200 OK response,</span><span>
    </span><span>// then parse the JSON. After deleting,</span><span>
    </span><span>// you'll get an empty JSON `{}` response.</span><span>
    </span><span>// Don't return `null`, otherwise `snapshot.hasData`</span><span>
    </span><span>// will always return false on `FutureBuilder`.</span><span>
    </span><span>return</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;);</span><span>
  </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
    </span><span>// If the server did not return a "200 OK response",</span><span>
    </span><span>// then throw an exception.</span><span>
    </span><span>throw</span><span> </span><span>Exception</span><span>(</span><span>'Failed to delete album.'</span><span>);</span><span>
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
  </span><span>late</span><span> </span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> _futureAlbum</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    _futureAlbum </span><span>=</span><span> fetchAlbum</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Delete Data Example'</span><span>,</span><span>
      theme</span><span>:</span><span> </span><span>ThemeData</span><span>(</span><span>
        colorScheme</span><span>:</span><span> </span><span>ColorScheme</span><span>.</span><span>fromSeed</span><span>(</span><span>seedColor</span><span>:</span><span> </span><span>Colors</span><span>.</span><span>deepPurple</span><span>),</span><span>
      </span><span>),</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Delete Data Example'</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>FutureBuilder</span><span>&lt;</span><span>Album</span><span>&gt;(</span><span>
            future</span><span>:</span><span> _futureAlbum</span><span>,</span><span>
            builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
              </span><span>// If the connection is done,</span><span>
              </span><span>// check for response data or an error.</span><span>
              </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>connectionState </span><span>==</span><span> </span><span>ConnectionState</span><span>.</span><span>done</span><span>)</span><span> </span><span>{</span><span>
                </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasData</span><span>)</span><span> </span><span>{</span><span>
                  </span><span>return</span><span> </span><span>Column</span><span>(</span><span>
                    mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
                    children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
                      </span><span>Text</span><span>(</span><span>snapshot</span><span>.</span><span>data</span><span>?.</span><span>title </span><span>??</span><span> </span><span>'Deleted'</span><span>),</span><span>
                      </span><span>ElevatedButton</span><span>(</span><span>
                        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Delete Data'</span><span>),</span><span>
                        onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
                          setState</span><span>(()</span><span> </span><span>{</span><span>
                            _futureAlbum </span><span>=</span><span>
                                deleteAlbum</span><span>(</span><span>snapshot</span><span>.</span><span>data</span><span>!.</span><span>id</span><span>.</span><span>toString</span><span>());</span><span>
                          </span><span>});</span><span>
                        </span><span>},</span><span>
                      </span><span>),</span><span>
                    </span><span>],</span><span>
                  </span><span>);</span><span>
                </span><span>}</span><span> </span><span>else</span><span> </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>hasError</span><span>)</span><span> </span><span>{</span><span>
                  </span><span>return</span><span> </span><span>Text</span><span>(</span><span>'${snapshot.error}'</span><span>);</span><span>
                </span><span>}</span><span>
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