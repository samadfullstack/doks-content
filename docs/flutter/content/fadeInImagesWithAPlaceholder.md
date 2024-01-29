1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Images](https://docs.flutter.dev/cookbook/images)
3.  [Fade in images with a placeholder](https://docs.flutter.dev/cookbook/images/fading-in-images)

When displaying images using the default `Image` widget, you might notice they simply pop onto the screen as they’re loaded. This might feel visually jarring to your users.

Instead, wouldn’t it be nice to display a placeholder at first, and images would fade in as they’re loaded? Use the [`FadeInImage`](https://api.flutter.dev/flutter/widgets/FadeInImage-class.html) widget for exactly this purpose.

`FadeInImage` works with images of any type: in-memory, local assets, or images from the internet.

## In-Memory

In this example, use the [`transparent_image`](https://pub.dev/packages/transparent_image) package for a simple transparent placeholder.

```
<span>FadeInImage</span><span>.</span><span>memoryNetwork</span><span>(</span><span>
  placeholder</span><span>:</span><span> kTransparentImage</span><span>,</span><span>
  image</span><span>:</span><span> </span><span>'https://picsum.photos/250?image=9'</span><span>,</span><span>
</span><span>),</span>
```

### Complete example

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:transparent_image/transparent_image.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>const</span><span> title </span><span>=</span><span> </span><span>'Fade in images'</span><span>;</span><span>

    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> title</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>title</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Stack</span><span>(</span><span>
          children</span><span>:</span><span> </span><span>&lt;</span><span>Widget</span><span>&gt;[</span><span>
            </span><span>const</span><span> </span><span>Center</span><span>(</span><span>child</span><span>:</span><span> </span><span>CircularProgressIndicator</span><span>()),</span><span>
            </span><span>Center</span><span>(</span><span>
              child</span><span>:</span><span> </span><span>FadeInImage</span><span>.</span><span>memoryNetwork</span><span>(</span><span>
                placeholder</span><span>:</span><span> kTransparentImage</span><span>,</span><span>
                image</span><span>:</span><span> </span><span>'https://picsum.photos/250?image=9'</span><span>,</span><span>
              </span><span>),</span><span>
            </span><span>),</span><span>
          </span><span>],</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![Fading In Image Demo](https://docs.flutter.dev/assets/images/docs/cookbook/fading-in-images.gif)

## From asset bundle

You can also consider using local assets for placeholders. First, add the asset to the project’s `pubspec.yaml` file (for more details, see [Adding assets and images](https://docs.flutter.dev/ui/assets/assets-and-images)):

```
 flutter:
   assets:
<span>+    - assets/loading.gif
</span>
```

Then, use the [`FadeInImage.assetNetwork()`](https://api.flutter.dev/flutter/widgets/FadeInImage/FadeInImage.assetNetwork.html) constructor:

```
<span>FadeInImage</span><span>.</span><span>assetNetwork</span><span>(</span><span>
  placeholder</span><span>:</span><span> </span><span>'assets/loading.gif'</span><span>,</span><span>
  image</span><span>:</span><span> </span><span>'https://picsum.photos/250?image=9'</span><span>,</span><span>
</span><span>),</span>
```

### Complete example

```
<span>import</span><span> </span><span>'package:flutter/material.dart'</span><span>;</span><span>

</span><span>void</span><span> main</span><span>()</span><span> </span><span>{</span><span>
  runApp</span><span>(</span><span>const</span><span> </span><span>MyApp</span><span>());</span><span>
</span><span>}</span><span>

</span><span>class</span><span> </span><span>MyApp</span><span> </span><span>extends</span><span> </span><span>StatelessWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>MyApp</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>const</span><span> title </span><span>=</span><span> </span><span>'Fade in images'</span><span>;</span><span>

    </span><span>return</span><span> </span><span>MaterialApp</span><span>(</span><span>
      title</span><span>:</span><span> title</span><span>,</span><span>
      home</span><span>:</span><span> </span><span>Scaffold</span><span>(</span><span>
        appBar</span><span>:</span><span> </span><span>AppBar</span><span>(</span><span>
          title</span><span>:</span><span> </span><span>const</span><span> </span><span>Text</span><span>(</span><span>title</span><span>),</span><span>
        </span><span>),</span><span>
        body</span><span>:</span><span> </span><span>Center</span><span>(</span><span>
          child</span><span>:</span><span> </span><span>FadeInImage</span><span>.</span><span>assetNetwork</span><span>(</span><span>
            placeholder</span><span>:</span><span> </span><span>'assets/loading.gif'</span><span>,</span><span>
            image</span><span>:</span><span> </span><span>'https://picsum.photos/250?image=9'</span><span>,</span><span>
          </span><span>),</span><span>
        </span><span>),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

![Asset fade-in](https://docs.flutter.dev/assets/images/docs/cookbook/fading-in-asset-demo.gif)