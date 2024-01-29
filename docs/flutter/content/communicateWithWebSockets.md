1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Networking](https://docs.flutter.dev/cookbook/networking)
3.  [Communicate with WebSockets](https://docs.flutter.dev/cookbook/networking/web-sockets)

In addition to normal HTTP requests, you can connect to servers using `WebSockets`. `WebSockets` allow for two-way communication with a server without polling.

In this example, connect to a [test WebSocket server sponsored by Lob.com](https://www.lob.com/blog/websocket-org-is-down-here-is-an-alternative). The server sends back the same message you send to it. This recipe uses the following steps:

1.  Connect to a WebSocket server.
2.  Listen for messages from the server.
3.  Send data to the server.
4.  Close the WebSocket connection.

## 1\. Connect to a WebSocket server

The [`web_socket_channel`](https://pub.dev/packages/web_socket_channel) package provides the tools you need to connect to a WebSocket server.

The package provides a `WebSocketChannel` that allows you to both listen for messages from the server and push messages to the server.

In Flutter, use the following line to create a `WebSocketChannel` that connects to a server:

```
<span>final</span><span> channel </span><span>=</span><span> </span><span>WebSocketChannel</span><span>.</span><span>connect</span><span>(</span><span>
  </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'wss://echo.websocket.events'</span><span>),</span><span>
</span><span>);</span>
```

## 2\. Listen for messages from the server

Now that you’ve established a connection, listen to messages from the server.

After sending a message to the test server, it sends the same message back.

In this example, use a [`StreamBuilder`](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html) widget to listen for new messages, and a [`Text`](https://api.flutter.dev/flutter/widgets/Text-class.html) widget to display them.

```
<span>StreamBuilder</span><span>(</span><span>
  stream</span><span>:</span><span> channel</span><span>.</span><span>stream</span><span>,</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Text</span><span>(</span><span>snapshot</span><span>.</span><span>hasData </span><span>?</span><span> </span><span>'${snapshot.data}'</span><span> </span><span>:</span><span> </span><span>''</span><span>);</span><span>
  </span><span>},</span><span>
</span><span>)</span>
```

### How this works

The `WebSocketChannel` provides a [`Stream`](https://api.flutter.dev/flutter/dart-async/Stream-class.html) of messages from the server.

The `Stream` class is a fundamental part of the `dart:async` package. It provides a way to listen to async events from a data source. Unlike `Future`, which returns a single async response, the `Stream` class can deliver many events over time.

The [`StreamBuilder`](https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html) widget connects to a `Stream` and asks Flutter to rebuild every time it receives an event using the given `builder()` function.

## 3\. Send data to the server

To send data to the server, `add()` messages to the `sink` provided by the `WebSocketChannel`.

```
<span>channel</span><span>.</span><span>sink</span><span>.</span><span>add</span><span>(</span><span>'Hello!'</span><span>);</span>
```

### How this works

The `WebSocketChannel` provides a [`StreamSink`](https://api.flutter.dev/flutter/dart-async/StreamSink-class.html) to push messages to the server.

The `StreamSink` class provides a general way to add sync or async events to a data source.

## 4\. Close the WebSocket connection

After you’re done using the WebSocket, close the connection:

## Complete example

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:web_socket_channel/web_socket_channel.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>=&gt;</span><span> runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>const</span><span> title </span><span>=</span><span> </span><span>'WebSocket Demo'</span><span>;</span><span>
    </span><span>return</span><span> </span><span>const</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> title</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>MyHomePage</span><span>(</span><span>
        title</span><span>:</span><span> title</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyHomePage</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyHomePage</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>required</span><span> </span><span>this</span><span>.</span><span>title</span><span>,</span><span>
  </span><span>});</span><span>

  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyHomePageState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyHomePageState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyHomePage</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>TextEditingController</span><span> _controller </span><span>=</span><span> </span><span>TextEditingController</span><span>();</span><span>
  </span><span>final</span><span> _channel </span><span>=</span><span> </span><span>WebSocketChannel</span><span>.</span><span>connect</span><span>(</span><span>
    </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>'wss://echo.websocket.events'</span><span>),</span><span>
  </span><span>);</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>widget</span><span>.</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>20</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          crossAxisAlignment</span><span>:</span><span> </span><span>CrossAxisAlignment</span><span>.</span><span>start</span><span>,</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>Form</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>TextFormField</span><span>(</span><span>
                controller</span><span>:</span><span> _controller</span><span>,</span><span>
                decoration</span><span>:</span><span> </span><span>const</span><span> </span><span>InputDecoration</span><span>(</span><span>labelText</span><span>:</span><span> </span><span>'Send a message'</span><span>),</span><span>
              </span><span>),</span><span>
            </span><span>),</span><span>
            </span><span>const</span><span> </span><span>SizedBox</span><span>(</span><span>height</span><span>:</span><span> </span><span>24</span><span>),</span><span>
            </span><span>StreamBuilder</span><span>(</span><span>
              stream</span><span>:</span><span> _channel</span><span>.</span><span>stream</span><span>,</span><span>
              builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
                </span><span>return</span><span> </span><span>Text</span><span>(</span><span>snapshot</span><span>.</span><span>hasData </span><span>?</span><span> </span><span>'${snapshot.data}'</span><span> </span><span>:</span><span> </span><span>''</span><span>);</span><span>
              </span><span>},</span><span>
            </span><span>)</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
      floatingActionButton</span><span>:</span><span> </span><span>FloatingActionButton</span><span>(</span><span>
        onPressed</span><span>:</span><span> _sendMessage</span><span>,</span><span>
        tooltip</span><span>:</span><span> </span><span>'Send message'</span><span>,</span><span>
        child</span><span>:</span><span> </span><span>const</span><span> </span><span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>send</span><span>),</span><span>
      </span><span>),</span><span> </span><span>// This trailing comma makes auto-formatting nicer for build methods.</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>void</span><span> _sendMessage</span><span>()</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>_controller</span><span>.</span><span>text</span><span>.</span><span>isNotEmpty</span><span>)</span><span> </span><span>{</span><span>
      _channel</span><span>.</span><span>sink</span><span>.</span><span>add</span><span>(</span><span>_controller</span><span>.</span><span>text</span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    _channel</span><span>.</span><span>sink</span><span>.</span><span>close</span><span>();</span><span>
    _controller</span><span>.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![Web sockets demo](https://docs.flutter.dev/assets/images/docs/cookbook/web-sockets.gif)