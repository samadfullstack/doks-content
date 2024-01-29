1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Navigation](https://docs.flutter.dev/cookbook/navigation)
3.  [Send data to a new screen](https://docs.flutter.dev/cookbook/navigation/passing-data)

Often, you not only want to navigate to a new screen, but also pass data to the screen as well. For example, you might want to pass information about the item that’s been tapped.

Remember: Screens are just widgets. In this example, create a list of todos. When a todo is tapped, navigate to a new screen (widget) that displays information about the todo. This recipe uses the following steps:

1.  Define a todo class.
2.  Display a list of todos.
3.  Create a detail screen that can display information about a todo.
4.  Navigate and pass data to the detail screen.

## 1\. Define a todo class

First, you need a simple way to represent todos. For this example, create a class that contains two pieces of data: the title and description.

```
<span>class</span><span> </span><span>Todo</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> description</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Todo</span><span>(</span><span>this</span><span>.</span><span>title</span><span>,</span><span> </span><span>this</span><span>.</span><span>description</span><span>);</span><span>
</span><span>}</span>
```

## 2\. Create a list of todos

Second, display a list of todos. In this example, generate 20 todos and show them using a ListView. For more information on working with lists, see the [Use lists](https://docs.flutter.dev/cookbook/lists/basic-list) recipe.

### Generate the list of todos

```
<span>final</span><span> todos </span><span>=</span><span> </span><span>List</span><span>.</span><span>generate</span><span>(</span><span>
  </span><span>20</span><span>,</span><span>
  </span><span>(</span><span>i</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Todo</span><span>(</span><span>
    </span><span>'Todo $i'</span><span>,</span><span>
    </span><span>'A description of what needs to be done for Todo $i'</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>);</span>
```

### Display the list of todos using a ListView

```
<span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
  itemCount</span><span>:</span><span> todos</span><span>.</span><span>length</span><span>,</span><span>
  itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todos</span><span>[</span><span>index</span><span>].</span><span>title</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
</span><span>),</span>
```

So far, so good. This generates 20 todos and displays them in a ListView.

## 3\. Create a Todo screen to display the list

For this, we create a `StatelessWidget`. We call it `TodosScreen`. Since the contents of this page won’t change during runtime, we’ll have to require the list of todos within the scope of this widget.

We pass in our `ListView.builder` as body of the widget we’re returning to `build()`. This’ll render the list on to the screen for you to get going!

```
<span>class</span><span> </span><span>TodosScreen</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>// Requiring the list of todos.</span><span>
  </span><span>const</span><span> </span><span>TodosScreen</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>todos</span><span>});</span><span>

  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Todo</span><span>&gt;</span><span> todos</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Todos'</span><span>),</span><span>
      </span><span>),</span><span>
      </span><span>//passing in the ListView.builder</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
        itemCount</span><span>:</span><span> todos</span><span>.</span><span>length</span><span>,</span><span>
        itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
            title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todos</span><span>[</span><span>index</span><span>].</span><span>title</span><span>),</span><span>
          </span><span>);</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

With Flutter’s default styling, you’re good to go without sweating about things that you’d like to do later on!

## 4\. Create a detail screen to display information about a todo

Now, create the second screen. The title of the screen contains the title of the todo, and the body of the screen shows the description.

Since the detail screen is a normal `StatelessWidget`, require the user to enter a `Todo` in the UI. Then, build the UI using the given todo.

```
<span>class</span><span> </span><span>DetailScreen</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>// In the constructor, require a Todo.</span><span>
  </span><span>const</span><span> </span><span>DetailScreen</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>todo</span><span>});</span><span>

  </span><span>// Declare a field that holds the Todo.</span><span>
  </span><span>final</span><span> </span><span>Todo</span><span> todo</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Use the Todo to create the UI.</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todo</span><span>.</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todo</span><span>.</span><span>description</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 5\. Navigate and pass data to the detail screen

With a `DetailScreen` in place, you’re ready to perform the Navigation. In this example, navigate to the `DetailScreen` when a user taps a todo in the list. Pass the todo to the `DetailScreen`.

To capture the user’s tap in the `TodosScreen`, write an [`onTap()`](https://api.flutter.dev/flutter/material/ListTile/onTap.html) callback for the `ListTile` widget. Within the `onTap()` callback, use the [`Navigator.push()`](https://api.flutter.dev/flutter/widgets/Navigator/push.html) method.

```
<span>body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
  itemCount</span><span>:</span><span> todos</span><span>.</span><span>length</span><span>,</span><span>
  itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todos</span><span>[</span><span>index</span><span>].</span><span>title</span><span>),</span><span>
      </span><span>// When a user taps the ListTile, navigate to the DetailScreen.</span><span>
      </span><span>// Notice that you're not only creating a DetailScreen, you're</span><span>
      </span><span>// also passing the current todo through to it.</span><span>
      onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        </span><span>Navigator</span><span>.</span><span>push</span><span>(</span><span>
          context</span><span>,</span><span>
          </span><span>MaterialPageRoute</span><span>(</span><span>
            builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>DetailScreen</span><span>(</span><span>todo</span><span>:</span><span> todos</span><span>[</span><span>index</span><span>]),</span><span>
          </span><span>),</span><span>
        </span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
</span><span>),</span>
```

### Interactive example

## Alternatively, pass the arguments using RouteSettings

Repeat the first two steps.

Next, create a detail screen that extracts and displays the title and description from the `Todo`. To access the `Todo`, use the [`ModalRoute.of()`](https://api.flutter.dev/flutter/widgets/ModalRoute/of.html) method. This method returns the current route with the arguments.

```
<span>class</span><span> </span><span>DetailScreen</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>DetailScreen</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> todo </span><span>=</span><span> </span><span>ModalRoute</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>settings</span><span>.</span><span>arguments </span><span>as</span><span> </span><span>Todo</span><span>;</span><span>

    </span><span>// Use the Todo to create the UI.</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todo</span><span>.</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todo</span><span>.</span><span>description</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

### Navigate and pass the arguments to the detail screen

Finally, navigate to the `DetailScreen` when a user taps a `ListTile` widget using `Navigator.push()`. Pass the arguments as part of the [`RouteSettings`](https://api.flutter.dev/flutter/widgets/RouteSettings-class.html). The `DetailScreen` extracts these arguments.

```
<span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
  itemCount</span><span>:</span><span> todos</span><span>.</span><span>length</span><span>,</span><span>
  itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todos</span><span>[</span><span>index</span><span>].</span><span>title</span><span>),</span><span>
      </span><span>// When a user taps the ListTile, navigate to the DetailScreen.</span><span>
      </span><span>// Notice that you're not only creating a DetailScreen, you're</span><span>
      </span><span>// also passing the current todo through to it.</span><span>
      onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        </span><span>Navigator</span><span>.</span><span>push</span><span>(</span><span>
          context</span><span>,</span><span>
          </span><span>MaterialPageRoute</span><span>(</span><span>
            builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>DetailScreen</span><span>(),</span><span>
            </span><span>// Pass the arguments as part of the RouteSettings. The</span><span>
            </span><span>// DetailScreen reads the arguments from these settings.</span><span>
            settings</span><span>:</span><span> </span><span>RouteSettings</span><span>(</span><span>
              arguments</span><span>:</span><span> todos</span><span>[</span><span>index</span><span>],</span><span>
            </span><span>),</span><span>
          </span><span>),</span><span>
        </span><span>);</span><span>
      </span><span>},</span><span>
    </span><span>);</span><span>
  </span><span>},</span><span>
</span><span>)</span>
```

### Complete example

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>class</span><span> </span><span>Todo</span><span> </span><span>{</span><span>
  </span><span>final</span><span> </span><span>String</span><span> title</span><span>;</span><span>
  </span><span>final</span><span> </span><span>String</span><span> description</span><span>;</span><span>

  </span><span>const</span><span> </span><span>Todo</span><span>(</span><span>this</span><span>.</span><span>title</span><span>,</span><span> </span><span>this</span><span>.</span><span>description</span><span>);</span><span>
</span><span>}</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>
    </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> </span><span>'Passing Data'</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>TodosScreen</span><span>(</span><span>
        todos</span><span>:</span><span> </span><span>List</span><span>.</span><span>generate</span><span>(</span><span>
          </span><span>20</span><span>,</span><span>
          </span><span>(</span><span>i</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>Todo</span><span>(</span><span>
            </span><span>'Todo $i'</span><span>,</span><span>
            </span><span>'A description of what needs to be done for Todo $i'</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>TodosScreen</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>TodosScreen</span><span>({</span><span>super</span><span>.</span><span>key</span><span>,</span><span> </span><span>required</span><span> </span><span>this</span><span>.</span><span>todos</span><span>});</span><span>

  </span><span>final</span><span> </span><span>List</span><span>&lt;</span><span>Todo</span><span>&gt;</span><span> todos</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Todos'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>ListView</span><span>.</span><span>builder</span><span>(</span><span>
        itemCount</span><span>:</span><span> todos</span><span>.</span><span>length</span><span>,</span><span>
        itemBuilder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> index</span><span>)</span><span> </span><span>{</span><span>
          </span><span>return</span><span> </span><span>ListTile</span><span>(</span><span>
            title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todos</span><span>[</span><span>index</span><span>].</span><span>title</span><span>),</span><span>
            </span><span>// When a user taps the ListTile, navigate to the DetailScreen.</span><span>
            </span><span>// Notice that you're not only creating a DetailScreen, you're</span><span>
            </span><span>// also passing the current todo through to it.</span><span>
            onTap</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
              </span><span>Navigator</span><span>.</span><span>push</span><span>(</span><span>
                context</span><span>,</span><span>
                </span><span>MaterialPageRoute</span><span>(</span><span>
                  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>DetailScreen</span><span>(),</span><span>
                  </span><span>// Pass the arguments as part of the RouteSettings. The</span><span>
                  </span><span>// DetailScreen reads the arguments from these settings.</span><span>
                  settings</span><span>:</span><span> </span><span>RouteSettings</span><span>(</span><span>
                    arguments</span><span>:</span><span> todos</span><span>[</span><span>index</span><span>],</span><span>
                  </span><span>),</span><span>
                </span><span>),</span><span>
              </span><span>);</span><span>
            </span><span>},</span><span>
          </span><span>);</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>DetailScreen</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>DetailScreen</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>final</span><span> todo </span><span>=</span><span> </span><span>ModalRoute</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)!.</span><span>settings</span><span>.</span><span>arguments </span><span>as</span><span> </span><span>Todo</span><span>;</span><span>

    </span><span>// Use the Todo to create the UI.</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todo</span><span>.</span><span>title</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Padding</span><span>(</span><span>
        padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>16</span><span>),</span><span>
        child</span><span>:</span><span> </span><span>Text</span><span>(</span><span>todo</span><span>.</span><span>description</span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```