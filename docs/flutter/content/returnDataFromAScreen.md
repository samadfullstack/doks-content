1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Navigation](https://docs.flutter.dev/cookbook/navigation)
3.  [Return data from a screen](https://docs.flutter.dev/cookbook/navigation/returning-data)

In some cases, you might want to return data from a new screen. For example, say you push a new screen that presents two options to a user. When the user taps an option, you want to inform the first screen of the user’s selection so that it can act on that information.

You can do this with the [`Navigator.pop()`](https://api.flutter.dev/flutter/widgets/Navigator/pop.html) method using the following steps:

1.  Define the home screen
2.  Add a button that launches the selection screen
3.  Show the selection screen with two buttons
4.  When a button is tapped, close the selection screen
5.  Show a snackbar on the home screen with the selection

## 1\. Define the home screen

The home screen displays a button. When tapped, it launches the selection screen.

```
<span>class</span><span> </span><span>HomeScreen</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>HomeScreen</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Returning Data Demo'</span><span>),</span><span>
      </span><span>),</span><span>
      </span><span>// Create the SelectionButton widget in the next step.</span><span>
      body</span><span>:</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>SelectionButton</span><span>(),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 2\. Add a button that launches the selection screen

Now, create the SelectionButton, which does the following:

-   Launches the SelectionScreen when it’s tapped.
-   Waits for the SelectionScreen to return a result.

```
<span>class</span><span> </span><span>SelectionButton</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SelectionButton</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>SelectionButton</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _SelectionButtonState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _SelectionButtonState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>SelectionButton</span><span>&gt;</span><span> </span><span>{</span><span>
  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>ElevatedButton</span><span>(</span><span>
      onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
        _navigateAndDisplaySelection</span><span>(</span><span>context</span><span>);</span><span>
      </span><span>},</span><span>
      child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Pick an option, any option!'</span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _navigateAndDisplaySelection</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>// Navigator.push returns a Future that completes after calling</span><span>
    </span><span>// Navigator.pop on the Selection Screen.</span><span>
    </span><span>final</span><span> result </span><span>=</span><span> </span><span>await</span><span> </span><span>Navigator</span><span>.</span><span>push</span><span>(</span><span>
      context</span><span>,</span><span>
      </span><span>// Create the SelectionScreen in the next step.</span><span>
      </span><span>MaterialPageRoute</span><span>(</span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>SelectionScreen</span><span>()),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 3\. Show the selection screen with two buttons

Now, build a selection screen that contains two buttons. When a user taps a button, that app closes the selection screen and lets the home screen know which button was tapped.

This step defines the UI. The next step adds code to return data.

```
<span>class</span><span> </span><span>SelectionScreen</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>SelectionScreen</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>Scaffold</span><span>(</span><span>
      appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
        title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Pick an option'</span><span>),</span><span>
      </span><span>),</span><span>
      body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>Column</span><span>(</span><span>
          mainAxisAlignment</span><span>:</span><span> </span><span>MainAxisAlignment</span><span>.</span><span>center</span><span>,</span><span>
          children</span><span>:</span><span> </span><span>[</span><span>
            </span><span>Padding</span><span>(</span><span>
              padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>8</span><span>),</span><span>
              child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
                onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
                  </span><span>// Pop here with "Yep"...</span><span>
                </span><span>},</span><span>
                child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Yep!'</span><span>),</span><span>
              </span><span>),</span><span>
            </span><span>),</span><span>
            </span><span>Padding</span><span>(</span><span>
              padding</span><span>:</span><span> </span><span>const</span><span> </span><span>EdgeInsets</span><span>.</span><span>all</span><span>(</span><span>8</span><span>),</span><span>
              child</span><span>:</span><span> </span><span>ElevatedButton</span><span>(</span><span>
                onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
                  </span><span>// Pop here with "Nope"...</span><span>
                </span><span>},</span><span>
                child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Nope.'</span><span>),</span><span>
              </span><span>),</span><span>
            </span><span>)</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 4\. When a button is tapped, close the selection screen

Now, update the `onPressed()` callback for both of the buttons. To return data to the first screen, use the [`Navigator.pop()`](https://api.flutter.dev/flutter/widgets/Navigator/pop.html) method, which accepts an optional second argument called `result`. Any result is returned to the `Future` in the SelectionButton.

### Yep button

```
<span>ElevatedButton</span><span>(</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Close the screen and return "Yep!" as the result.</span><span>
    </span><span>Navigator</span><span>.</span><span>pop</span><span>(</span><span>context</span><span>,</span><span> </span><span>'Yep!'</span><span>);</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Yep!'</span><span>),</span><span>
</span><span>)</span>
```

### Nope button

```
<span>ElevatedButton</span><span>(</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Close the screen and return "Nope." as the result.</span><span>
    </span><span>Navigator</span><span>.</span><span>pop</span><span>(</span><span>context</span><span>,</span><span> </span><span>'Nope.'</span><span>);</span><span>
  </span><span>},</span><span>
  child</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>'Nope.'</span><span>),</span><span>
</span><span>)</span>
```

## 5\. Show a snackbar on the home screen with the selection

Now that you’re launching a selection screen and awaiting the result, you’ll want to do something with the information that’s returned.

In this case, show a snackbar displaying the result by using the `_navigateAndDisplaySelection()` method in `SelectionButton`:

```
<span>// A method that launches the SelectionScreen and awaits the result from</span><span>
</span><span>// Navigator.pop.</span><span>
</span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _navigateAndDisplaySelection</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
  </span><span>// Navigator.push returns a Future that completes after calling</span><span>
  </span><span>// Navigator.pop on the Selection Screen.</span><span>
  </span><span>final</span><span> result </span><span>=</span><span> </span><span>await</span><span> </span><span>Navigator</span><span>.</span><span>push</span><span>(</span><span>
    context</span><span>,</span><span>
    </span><span>MaterialPageRoute</span><span>(</span><span>builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>const</span><span> </span><span>SelectionScreen</span><span>()),</span><span>
  </span><span>);</span><span>

  </span><span>// When a BuildContext is used from a StatefulWidget, the mounted property</span><span>
  </span><span>// must be checked after an asynchronous gap.</span><span>
  </span><span>if</span><span> </span><span>(!</span><span>mounted</span><span>)</span><span> </span><span>return</span><span>;</span><span>

  </span><span>// After the Selection Screen returns a result, hide any previous snackbars</span><span>
  </span><span>// and show the new result.</span><span>
  </span><span>ScaffoldMessenger</span><span>.</span><span>of</span><span>(</span><span>context</span><span>)</span><span>
    </span><span>..</span><span>removeCurrentSnackBar</span><span>()</span><span>
    </span><span>..</span><span>showSnackBar</span><span>(</span><span>SnackBar</span><span>(</span><span>content</span><span>:</span><span> </span><span>Text</span><span>(</span><span>'$result'</span><span>)));</span><span>
</span><span>}</span>
```

## Interactive example