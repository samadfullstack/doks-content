1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Plugins](https://docs.flutter.dev/cookbook/plugins)
3.  [Play and pause a video](https://docs.flutter.dev/cookbook/plugins/play-video)

Playing videos is a common task in app development, and Flutter apps are no exception. To play videos, the Flutter team provides the [`video_player`](https://pub.dev/packages/video_player) plugin. You can use the `video_player` plugin to play videos stored on the file system, as an asset, or from the internet.

On iOS, the `video_player` plugin makes use of [`AVPlayer`](https://developer.apple.com/documentation/avfoundation/avplayer) to handle playback. On Android, it uses [`ExoPlayer`](https://google.github.io/ExoPlayer/).

This recipe demonstrates how to use the `video_player` package to stream a video from the internet with basic play and pause controls using the following steps:

1.  Add the `video_player` dependency.
2.  Add permissions to your app.
3.  Create and initialize a `VideoPlayerController`.
4.  Display the video player.
5.  Play and pause the video.

## 1\. Add the `video_player` dependency

This recipe depends on one Flutter plugin: `video_player`. First, add this dependency to your project.

To add the `video_player` package as a dependency, run `flutter pub add`:

```
<span>$</span><span> </span>flutter pub add video_player
```

## 2\. Add permissions to your app

Next, update your `android` and `ios` configurations to ensure that your app has the correct permissions to stream videos from the internet.

### Android

Add the following permission to the `AndroidManifest.xml` file just after the `<application>` definition. The `AndroidManifest.xml` file is found at `<project root>/android/app/src/main/AndroidManifest.xml`.

```
<span>&lt;manifest</span> <span>xmlns:android=</span><span>"http://schemas.android.com/apk/res/android"</span><span>&gt;</span>
    <span>&lt;application</span> <span>...</span><span>&gt;</span>

    <span>&lt;/application&gt;</span>

    <span>&lt;uses-permission</span> <span>android:name=</span><span>"android.permission.INTERNET"</span><span>/&gt;</span>
<span>&lt;/manifest&gt;</span>
```

### iOS

For iOS, add the following to the `Info.plist` file found at `<project root>/ios/Runner/Info.plist`.

```
<span>&lt;key&gt;</span>NSAppTransportSecurity<span>&lt;/key&gt;</span>
<span>&lt;dict&gt;</span>
  <span>&lt;key&gt;</span>NSAllowsArbitraryLoads<span>&lt;/key&gt;</span>
  <span>&lt;true/&gt;</span>
<span>&lt;/dict&gt;</span>
```

## 3\. Create and initialize a `VideoPlayerController`

Now that you have the `video_player` plugin installed with the correct permissions, create a `VideoPlayerController`. The `VideoPlayerController` class allows you to connect to different types of videos and control playback.

Before you can play videos, you must also `initialize` the controller. This establishes the connection to the video and prepare the controller for playback.

To create and initialize the `VideoPlayerController` do the following:

1.  Create a `StatefulWidget` with a companion `State` class
2.  Add a variable to the `State` class to store the `VideoPlayerController`
3.  Add a variable to the `State` class to store the `Future` returned from `VideoPlayerController.initialize`
4.  Create and initialize the controller in the `initState` method
5.  Dispose of the controller in the `dispose` method

```
<span>class</span><span> </span><span>VideoPlayerScreen</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>const</span><span> </span><span>VideoPlayerScreen</span><span>({</span><span>super</span><span>.</span><span>key</span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>VideoPlayerScreen</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _VideoPlayerScreenState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _VideoPlayerScreenState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>VideoPlayerScreen</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>late</span><span> </span><span>VideoPlayerController</span><span> _controller</span><span>;</span><span>
  </span><span>late</span><span> </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> _initializeVideoPlayerFuture</span><span>;</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>

    </span><span>// Create and store the VideoPlayerController. The VideoPlayerController</span><span>
    </span><span>// offers several different constructors to play videos from assets, files,</span><span>
    </span><span>// or the internet.</span><span>
    _controller </span><span>=</span><span> </span><span>VideoPlayerController</span><span>.</span><span>networkUrl</span><span>(</span><span>
      </span><span>Uri</span><span>.</span><span>parse</span><span>(</span><span>
        </span><span>'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>

    _initializeVideoPlayerFuture </span><span>=</span><span> _controller</span><span>.</span><span>initialize</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Ensure disposing of the VideoPlayerController to free up resources.</span><span>
    _controller</span><span>.</span><span>dispose</span><span>();</span><span>

    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>// Complete the code in the next step.</span><span>
    </span><span>return</span><span> </span><span>Container</span><span>();</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## 4\. Display the video player

Now, display the video. The `video_player` plugin provides the [`VideoPlayer`](https://pub.dev/documentation/video_player/latest/video_player/VideoPlayer-class.html) widget to display the video initialized by the `VideoPlayerController`. By default, the `VideoPlayer` widget takes up as much space as possible. This often isn’t ideal for videos because they are meant to be displayed in a specific aspect ratio, such as 16x9 or 4x3.

Therefore, wrap the `VideoPlayer` widget in an [`AspectRatio`](https://api.flutter.dev/flutter/widgets/AspectRatio-class.html) widget to ensure that the video has the correct proportions.

Furthermore, you must display the `VideoPlayer` widget after the `_initializeVideoPlayerFuture()` completes. Use `FutureBuilder` to display a loading spinner until the controller finishes initializing. Note: initializing the controller does not begin playback.

```
<span>// Use a FutureBuilder to display a loading spinner while waiting for the</span><span>
</span><span>// VideoPlayerController to finish initializing.</span><span>
</span><span>FutureBuilder</span><span>(</span><span>
  future</span><span>:</span><span> _initializeVideoPlayerFuture</span><span>,</span><span>
  builder</span><span>:</span><span> </span><span>(</span><span>context</span><span>,</span><span> snapshot</span><span>)</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(</span><span>snapshot</span><span>.</span><span>connectionState </span><span>==</span><span> </span><span>ConnectionState</span><span>.</span><span>done</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// If the VideoPlayerController has finished initialization, use</span><span>
      </span><span>// the data it provides to limit the aspect ratio of the video.</span><span>
      </span><span>return</span><span> </span><span>AspectRatio</span><span>(</span><span>
        aspectRatio</span><span>:</span><span> _controller</span><span>.</span><span>value</span><span>.</span><span>aspectRatio</span><span>,</span><span>
        </span><span>// Use the VideoPlayer widget to display the video.</span><span>
        child</span><span>:</span><span> </span><span>VideoPlayer</span><span>(</span><span>_controller</span><span>),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
      </span><span>// If the VideoPlayerController is still initializing, show a</span><span>
      </span><span>// loading spinner.</span><span>
      </span><span>return</span><span> </span><span>const</span><span> </span><span>Center</span><span>(</span><span>
        child</span><span>:</span><span> </span><span>CircularProgressIndicator</span><span>(),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>},</span><span>
</span><span>)</span>
```

## 5\. Play and pause the video

By default, the video starts in a paused state. To begin playback, call the [`play()`](https://pub.dev/documentation/video_player/latest/video_player/VideoPlayerController/play.html) method provided by the `VideoPlayerController`. To pause playback, call the [`pause()`](https://pub.dev/documentation/video_player/latest/video_player/VideoPlayerController/pause.html) method.

For this example, add a `FloatingActionButton` to your app that displays a play or pause icon depending on the situation. When the user taps the button, play the video if it’s currently paused, or pause the video if it’s playing.

```
<span>FloatingActionButton</span><span>(</span><span>
  onPressed</span><span>:</span><span> </span><span>()</span><span> </span><span>{</span><span>
    </span><span>// Wrap the play or pause in a call to `setState`. This ensures the</span><span>
    </span><span>// correct icon is shown.</span><span>
    setState</span><span>(()</span><span> </span><span>{</span><span>
      </span><span>// If the video is playing, pause it.</span><span>
      </span><span>if</span><span> </span><span>(</span><span>_controller</span><span>.</span><span>value</span><span>.</span><span>isPlaying</span><span>)</span><span> </span><span>{</span><span>
        _controller</span><span>.</span><span>pause</span><span>();</span><span>
      </span><span>}</span><span> </span><span>else</span><span> </span><span>{</span><span>
        </span><span>// If the video is paused, play it.</span><span>
        _controller</span><span>.</span><span>play</span><span>();</span><span>
      </span><span>}</span><span>
    </span><span>});</span><span>
  </span><span>},</span><span>
  </span><span>// Display the correct icon depending on the state of the player.</span><span>
  child</span><span>:</span><span> </span><span>Icon</span><span>(</span><span>
    _controller</span><span>.</span><span>value</span><span>.</span><span>isPlaying </span><span>?</span><span> </span><span>Icons</span><span>.</span><span>pause </span><span>:</span><span> </span><span>Icons</span><span>.</span><span>play_arrow</span><span>,</span><span>
  </span><span>),</span><span>
</span><span>)</span>
```

## Complete example