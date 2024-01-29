1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Testing](https://docs.flutter.dev/cookbook/testing)
3.  [Unit](https://docs.flutter.dev/cookbook/testing/unit)
4.  [Mocking](https://docs.flutter.dev/cookbook/testing/unit/mocking)

Sometimes, unit tests might depend on classes that fetch data from live web services or databases. This is inconvenient for a few reasons:

-   Calling live services or databases slows down test execution.
-   A passing test might start failing if a web service or database returns unexpected results. This is known as a “flaky test.”
-   It is difficult to test all possible success and failure scenarios by using a live web service or database.

Therefore, rather than relying on a live web service or database, you can “mock” these dependencies. Mocks allow emulating a live web service or database and return specific results depending on the situation.

Generally speaking, you can mock dependencies by creating an alternative implementation of a class. Write these alternative implementations by hand or make use of the [Mockito package](https://pub.dev/packages/mockito) as a shortcut.

This recipe demonstrates the basics of mocking with the Mockito package using the following steps:

1.  Add the package dependencies.
2.  Create a function to test.
3.  Create a test file with a mock `http.Client`.
4.  Write a test for each condition.
5.  Run the tests.

For more information, see the [Mockito package](https://pub.dev/packages/mockito) documentation.

## 1\. Add the package dependencies

To use the `mockito` package, add it to the `pubspec.yaml` file along with the `flutter_test` dependency in the `dev_dependencies` section.

This example also uses the `http` package, so define that dependency in the `dependencies` section.

`mockito: 5.0.0` supports Dart’s null safety thanks to code generation. To run the required code generation, add the `build_runner` dependency in the `dev_dependencies` section.

To add the dependencies, run `flutter pub add`:

```
<span>$</span><span> </span>flutter pub add http dev:mockito dev:build_runner
```

## 2\. Create a function to test

In this example, unit test the `fetchAlbum` function from the [Fetch data from the internet](https://docs.flutter.dev/cookbook/networking/fetch-data) recipe. To test this function, make two changes:

1.  Provide an `http.Client` to the function. This allows providing the correct `http.Client` depending on the situation. For Flutter and server-side projects, provide an `http.IOClient`. For Browser apps, provide an `http.BrowserClient`. For tests, provide a mock `http.Client`.
2.  Use the provided `client` to fetch data from the internet, rather than the static `http.get()` method, which is difficult to mock.

The function should now look like this:

```
<span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> fetchAlbum</span><span>(</span><span>http</span><span>.</span><span>Client</span><span> client</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> client
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

In your app code, you can provide an `http.Client` to the `fetchAlbum` method directly with `fetchAlbum(http.Client())`. `http.Client()` creates a default `http.Client`.

## 3\. Create a test file with a mock `http.Client`

Next, create a test file.

Following the advice in the [Introduction to unit testing](https://docs.flutter.dev/cookbook/testing/unit/introduction) recipe, create a file called `fetch_album_test.dart` in the root `test` folder.

Add the annotation `@GenerateMocks([http.Client])` to the main function to generate a `MockClient` class with `mockito`.

The generated `MockClient` class implements the `http.Client` class. This allows you to pass the `MockClient` to the `fetchAlbum` function, and return different http responses in each test.

The generated mocks will be located in `fetch_album_test.mocks.dart`. Import this file to use them.

```
<span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:mocking/main.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:mockito/annotations.dart'</span><span>;</span><span>

</span><span>// Generate a MockClient using the Mockito package.</span><span>
</span><span>// Create new instances of this class in each test.</span><span>
@</span><span>GenerateMocks</span><span>([</span><span>http</span><span>.</span><span>Client</span><span>])</span><span>
</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
</span><span>}</span>
```

Next, generate the mocks running the following command:

```
<span>$</span><span> </span>dart run build_runner build
```

## 4\. Write a test for each condition

The `fetchAlbum()` function does one of two things:

1.  Returns an `Album` if the http call succeeds
2.  Throws an `Exception` if the http call fails

Therefore, you want to test these two conditions. Use the `MockClient` class to return an “Ok” response for the success test, and an error response for the unsuccessful test. Test these conditions using the `when()` function provided by Mockito:

```
<span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:mocking/main.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:mockito/annotations.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:mockito/mockito.dart'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'fetch_album_test.mocks.dart'</span><span>;</span><span>

</span><span>// Generate a MockClient using the Mockito package.</span><span>
</span><span>// Create new instances of this class in each test.</span><span>
@</span><span>GenerateMocks</span><span>([</span><span>http</span><span>.</span><span>Client</span><span>])</span><span>
</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  group</span><span>(</span><span>'fetchAlbum'</span><span>,</span><span> </span><span>()</span><span> </span><span>{</span><span>
    test</span><span>(</span><span>'returns an Album if the http call completes successfully'</span><span>,</span><span> </span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
      </span><span>final</span><span> client </span><span>=</span><span> </span><span>MockClient</span><span>();</span><span>

      </span><span>// Use Mockito to return a successful response when it calls the</span><span>
      </span><span>// provided http.Client.</span><span>
      </span><span>when</span><span>(</span><span>client
              </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>)))</span><span>
          </span><span>.</span><span>thenAnswer</span><span>((</span><span>_</span><span>)</span><span> </span><span>async</span><span> </span><span>=&gt;</span><span>
              http</span><span>.</span><span>Response</span><span>(</span><span>'{"userId": 1, "id": 2, "title": "mock"}'</span><span>,</span><span> </span><span>200</span><span>));</span><span>

      expect</span><span>(</span><span>await</span><span> fetchAlbum</span><span>(</span><span>client</span><span>),</span><span> isA</span><span>&lt;</span><span>Album</span><span>&gt;());</span><span>
    </span><span>});</span><span>

    test</span><span>(</span><span>'throws an exception if the http call completes with an error'</span><span>,</span><span> </span><span>()</span><span> </span><span>{</span><span>
      </span><span>final</span><span> client </span><span>=</span><span> </span><span>MockClient</span><span>();</span><span>

      </span><span>// Use Mockito to return an unsuccessful response when it calls the</span><span>
      </span><span>// provided http.Client.</span><span>
      </span><span>when</span><span>(</span><span>client
              </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>)))</span><span>
          </span><span>.</span><span>thenAnswer</span><span>((</span><span>_</span><span>)</span><span> </span><span>async</span><span> </span><span>=&gt;</span><span> http</span><span>.</span><span>Response</span><span>(</span><span>'Not Found'</span><span>,</span><span> </span><span>404</span><span>));</span><span>

      expect</span><span>(</span><span>fetchAlbum</span><span>(</span><span>client</span><span>),</span><span> throwsException</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

## 5\. Run the tests

Now that you have a `fetchAlbum()` function with tests in place, run the tests.

```
<span>$</span><span> </span>flutter <span>test test</span>/fetch_album_test.dart
```

You can also run tests inside your favorite editor by following the instructions in the [Introduction to unit testing](https://docs.flutter.dev/cookbook/testing/unit/introduction) recipe.

## Complete example

##### lib/main.dart

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> fetchAlbum</span><span>(</span><span>http</span><span>.</span><span>Client</span><span> client</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> client
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

  </span><span>const</span><span> </span><span>Album</span><span>({</span><span>required</span><span> </span><span>this</span><span>.</span><span>userId</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>id</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>});</span><span>

  </span><span>factory</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;</span><span> json</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Album</span><span>(</span><span>
      userId</span><span>:</span><span> json</span><span>[</span><span>'userId'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
      id</span><span>:</span><span> json</span><span>[</span><span>'id'</span><span>]</span><span> </span><span>as</span><span> </span><span>int</span><span>,</span><span>
      title</span><span>:</span><span> json</span><span>[</span><span>'title'</span><span>]</span><span> </span><span>as</span><span> </span><span>String</span><span>,</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyApp</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyAppState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyAppState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyApp</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>final</span><span> </span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> futureAlbum</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    futureAlbum </span><span>=</span><span> fetchAlbum</span><span>(</span><span>http</span><span>.</span><span>Client</span><span>());</span><span>
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

##### test/fetch\_album\_test.dart

```
<span>import</span><span> </span><span>'package:flutter_test/flutter_test.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:mocking/main.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:mockito/annotations.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:mockito/mockito.dart'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'fetch_album_test.mocks.dart'</span><span>;</span><span>

</span><span>// Generate a MockClient using the Mockito package.</span><span>
</span><span>// Create new instances of this class in each test.</span><span>
@</span><span>GenerateMocks</span><span>([</span><span>http</span><span>.</span><span>Client</span><span>])</span><span>
</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  group</span><span>(</span><span>'fetchAlbum'</span><span>,</span><span> </span><span>()</span><span> </span><span>{</span><span>
    test</span><span>(</span><span>'returns an Album if the http call completes successfully'</span><span>,</span><span> </span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
      </span><span>final</span><span> client </span><span>=</span><span> </span><span>MockClient</span><span>();</span><span>

      </span><span>// Use Mockito to return a successful response when it calls the</span><span>
      </span><span>// provided http.Client.</span><span>
      </span><span>when</span><span>(</span><span>client
              </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>)))</span><span>
          </span><span>.</span><span>thenAnswer</span><span>((</span><span>_</span><span>)</span><span> </span><span>async</span><span> </span><span>=&gt;</span><span>
              http</span><span>.</span><span>Response</span><span>(</span><span>'{"userId": 1, "id": 2, "title": "mock"}'</span><span>,</span><span> </span><span>200</span><span>));</span><span>

      expect</span><span>(</span><span>await</span><span> fetchAlbum</span><span>(</span><span>client</span><span>),</span><span> isA</span><span>&lt;</span><span>Album</span><span>&gt;());</span><span>
    </span><span>});</span><span>

    test</span><span>(</span><span>'throws an exception if the http call completes with an error'</span><span>,</span><span> </span><span>()</span><span> </span><span>{</span><span>
      </span><span>final</span><span> client </span><span>=</span><span> </span><span>MockClient</span><span>();</span><span>

      </span><span>// Use Mockito to return an unsuccessful response when it calls the</span><span>
      </span><span>// provided http.Client.</span><span>
      </span><span>when</span><span>(</span><span>client
              </span><span>.</span><span>get</span><span>(</span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>)))</span><span>
          </span><span>.</span><span>thenAnswer</span><span>((</span><span>_</span><span>)</span><span> </span><span>async</span><span> </span><span>=&gt;</span><span> http</span><span>.</span><span>Response</span><span>(</span><span>'Not Found'</span><span>,</span><span> </span><span>404</span><span>));</span><span>

      expect</span><span>(</span><span>fetchAlbum</span><span>(</span><span>client</span><span>),</span><span> throwsException</span><span>);</span><span>
    </span><span>});</span><span>
  </span><span>});</span><span>
</span><span>}</span>
```

## Summary

In this example, you’ve learned how to use Mockito to test functions or classes that depend on web services or databases. This is only a short introduction to the Mockito library and the concept of mocking. For more information, see the documentation provided by the [Mockito package](https://pub.dev/packages/mockito).