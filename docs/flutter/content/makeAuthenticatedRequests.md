1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Networking](https://docs.flutter.dev/cookbook/networking)
3.  [Make authenticated requests](https://docs.flutter.dev/cookbook/networking/authenticated-requests)

To fetch data from most web services, you need to provide authorization. There are many ways to do this, but perhaps the most common uses the `Authorization` HTTP header.

The [`http`](https://pub.dev/packages/http) package provides a convenient way to add headers to your requests. Alternatively, use the [`HttpHeaders`](https://api.dart.dev/stable/dart-io/HttpHeaders-class.html) class from the `dart:io` library.

```
<span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>
  </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>),</span><span>
  </span><span>// Send authorization headers to the backend.</span><span>
  headers</span><span>:</span><span> </span><span>{</span><span>
    </span><span>HttpHeaders</span><span>.</span><span>authorizationHeader</span><span>:</span><span> </span><span>'Basic your_api_token_here'</span><span>,</span><span>
  </span><span>},</span><span>
</span><span>);</span>
```

## Complete example

This example builds upon the [Fetching data from the internet](https://docs.flutter.dev/cookbook/networking/fetch-data) recipe.

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:convert'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'dart:io'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:http/http.dart'</span><span> </span><span>as</span><span> http</span><span>;</span><span>

</span><span>Future</span><span>&lt;</span><span>Album</span><span>&gt;</span><span> fetchAlbum</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>final</span><span> response </span><span>=</span><span> </span><span>await</span><span> http</span><span>.</span><span>get</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'https://jsonplaceholder.typicode.com/albums/1'</span><span>),</span><span>
    </span><span>// Send authorization headers to the backend.</span><span>
    headers</span><span>:</span><span> </span><span>{</span><span>
      </span><span>HttpHeaders</span><span>.</span><span>authorizationHeader</span><span>:</span><span> </span><span>'Basic your_api_token_here'</span><span>,</span><span>
    </span><span>},</span><span>
  </span><span>);</span><span>
  </span><span>final</span><span> responseJson </span><span>=</span><span> jsonDecode</span><span>(</span><span>response</span><span>.</span><span>body</span><span>)</span><span> </span><span>as</span><span> </span><span>Map</span><span>&lt;</span><span>String</span><span>,</span><span> </span><span>dynamic</span><span>&gt;;</span><span>

  </span><span>return</span><span> </span><span>Album</span><span>.</span><span>fromJson</span><span>(</span><span>responseJson</span><span>);</span><span>
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
</span><span>}</span>
```