1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Games](https://docs.flutter.dev/cookbook/games)
3.  [Add achievements and leaderboards to your mobile game](https://docs.flutter.dev/cookbook/games/achievements-leaderboard)

Gamers have various motivations for playing games. In broad strokes, there are four major motivations: [immersion, achievement, cooperation, and competition](https://meditations.metavert.io/p/game-player-motivations). No matter the game you build, some players want to _achieve_ in it. This could be trophies won or secrets unlocked. Some players want to _compete_ in it. This could be hitting high scores or accomplishing speedruns. These two ideas map to the concepts of _achievements_ and _leaderboards_.

![A simple graphic representing the four types of motivation explained above](https://docs.flutter.dev/assets/images/docs/cookbook/types-of-gamer-motivations.png)

Ecosystems such as the App Store and Google Play provide centralized services for achievements and leaderboards. Players can view achievements from all their games in one place and developers don’t need to re-implement them for every game.

This recipe demonstrates how to use the [`games_services` package](https://pub.dev/packages/games_services) to add achievements and leaderboard functionality to your mobile game.

## 1\. Enable platform services

To enable games services, set up _Game Center_ on iOS and _Google Play Games Services_ on Android.

### iOS

To enable Game Center (GameKit) on iOS:

1.  Open your Flutter project in Xcode. Open `ios/Runner.xcworkspace`
    
2.  Select the root **Runner** project.
    
3.  Go to the **Signing & Capabilities** tab.
    
4.  Click the `+` button to add **Game Center** as a capability.
    
5.  Close Xcode.
    
6.  If you haven’t already, register your game in [App Store Connect](https://appstoreconnect.apple.com/) and from the **My App** section press the `+` icon.
    
    ![Screenshot of the + button in App Store Connect](https://docs.flutter.dev/assets/images/docs/cookbook/app-store-add-app-button.png)
    
7.  Still in App Store Connect, look for the _Game Center_ section. You can find it in **Services** as of this writing. On the **Game Center** page, you might want to set up a leaderboard and several achievements, depending on your game. Take note of the IDs of the leaderboards and achievements you create.
    

### Android

To enable _Play Games Services_ on Android:

1.  If you haven’t already, go to [Google Play Console](https://play.google.com/console/) and register your game there.
    
    ![Screenshot of the 'Create app' button in Google Play Console](https://docs.flutter.dev/assets/images/docs/cookbook/google-play-create-app.png)
    
2.  Still in Google Play Console, select _Play Games Services_ → _Setup and management_ → _Configuration_ from the navigation menu and follow their instructions.
    
    -   This takes a significant amount of time and patience. Among other things, you’ll need to set up an OAuth consent screen in Google Cloud Console. If at any point you feel lost, consult the official [Play Games Services guide](https://developers.google.com/games/services/console/enabling).
        
        ![Screenshot showing the Games Services section in Google Play Console](https://docs.flutter.dev/assets/images/docs/cookbook/play-console-play-games-services.png)
        
3.  When done, you can start adding leaderboards and achievements in **Play Games Services** → **Setup and management**. Create the exact same set as you did on the iOS side. Make note of IDs.
    
4.  Go to **Play Games Services → Setup and management → Publishing**.
    
5.  Click **Publish**. Don’t worry, this doesn’t actually publish your game. It only publishes the achievements and leaderboard. Once a leaderboard, for example, is published this way, it cannot be unpublished.
    
6.  Go to **Play Games Services** **→ Setup and management → Configuration → Credentials**.
    
7.  Find the **Get resources** button. It returns an XML file with the Play Games Services IDs.
    
    ```
    <span>&lt;!-- THIS IS JUST AN EXAMPLE --&gt;</span>
    <span>&lt;?xml version="1.0" encoding="utf-8"?&gt;</span>
    <span>&lt;resources&gt;</span>
        <span>&lt;!--app_id--&gt;</span>
        <span>&lt;string</span> <span>name=</span><span>"app_id"</span> <span>translatable=</span><span>"false"</span><span>&gt;</span>424242424242<span>&lt;/string&gt;</span>
        <span>&lt;!--package_name--&gt;</span>
        <span>&lt;string</span> <span>name=</span><span>"package_name"</span> <span>translatable=</span><span>"false"</span><span>&gt;</span>dev.flutter.tictactoe<span>&lt;/string&gt;</span>
        <span>&lt;!--achievement First win--&gt;</span>
        <span>&lt;string</span> <span>name=</span><span>"achievement_first_win"</span> <span>translatable=</span><span>"false"</span><span>&gt;</span>sOmEiDsTrInG<span>&lt;/string&gt;</span>
        <span>&lt;!--leaderboard Highest Score--&gt;</span>
        <span>&lt;string</span> <span>name=</span><span>"leaderboard_highest_score"</span> <span>translatable=</span><span>"false"</span><span>&gt;</span>sOmEiDsTrInG<span>&lt;/string&gt;</span>
    <span>&lt;/resources&gt;</span>
    ```
    
8.  Add a file at `android/app/src/main/res/values/games-ids.xml` containing the XML you received in the previous step.
    

## 2\. Sign in to the game service

Now that you have set up _Game Center_ and _Play Games Services_, and have your achievement & leaderboard IDs ready, it’s finally Dart time.

1.  Add a dependency on the [`games_services` package](https://pub.dev/packages/games_services).
    
    ```
    <span>$</span><span> </span>flutter pub add games_services
    ```
    
2.  Before you can do anything else, you have to sign the player into the game service.
    
    ```
    <span>try</span><span> </span><span>{</span><span>
      </span><span>await</span><span> </span><span>GamesServices</span><span>.</span><span>signIn</span><span>();</span><span>
    </span><span>}</span><span> </span><span>on</span><span> </span><span>PlatformException</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
      </span><span>// ... deal with failures ...</span><span>
    </span><span>}</span>
    ```
    

The sign in happens in the background. It takes several seconds, so don’t call `signIn()` before `runApp()` or the players will be forced to stare at a blank screen every time they start your game.

The API calls to the `games_services` API can fail for a multitude of reasons. Therefore, every call should be wrapped in a try-catch block as in the previous example. The rest of this recipe omits exception handling for clarity.

## 3\. Unlock achievements

1.  Register achievements in Google Play Console and App Store Connect, and take note of their IDs. Now you can award any of those achievements from your Dart code:
    
    ```
    <span>await</span><span> </span><span>GamesServices</span><span>.</span><span>unlock</span><span>(</span><span>
      achievement</span><span>:</span><span> </span><span>Achievement</span><span>(</span><span>
        androidID</span><span>:</span><span> </span><span>'your android id'</span><span>,</span><span>
        iOSID</span><span>:</span><span> </span><span>'your ios id'</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span>
    ```
    
    The player’s account on Google Play Games or Apple Game Center now lists the achievement.
    
2.  To display the achievements UI from your game, call the `games_services` API:
    
    ```
    <span>await</span><span> </span><span>GamesServices</span><span>.</span><span>showAchievements</span><span>();</span>
    ```
    
    This displays the platform achievements UI as an overlay on your game.
    
3.  To display the achievements in your own UI, use [`GamesServices.loadAchievements()`](https://pub.dev/documentation/games_services/latest/games_services/GamesServices/loadAchievements.html).
    

## 4\. Submit scores

When the player finishes a play-through, your game can submit the result of that play session into one or more leaderboards.

For example, a platformer game like Super Mario can submit both the final score and the time taken to complete the level, to two separate leaderboards.

1.  In the first step, you registered a leaderboard in Google Play Console and App Store Connect, and took note of its ID. Using this ID, you can submit new scores for the player:
    
    ```
    <span>await</span><span> </span><span>GamesServices</span><span>.</span><span>submitScore</span><span>(</span><span>
      score</span><span>:</span><span> </span><span>Score</span><span>(</span><span>
        iOSLeaderboardID</span><span>:</span><span> </span><span>'some_id_from_app_store'</span><span>,</span><span>
        androidLeaderboardID</span><span>:</span><span> </span><span>'sOmE_iD_fRoM_gPlAy'</span><span>,</span><span>
        value</span><span>:</span><span> </span><span>100</span><span>,</span><span>
      </span><span>),</span><span>
    </span><span>);</span>
    ```
    
    You don’t need to check whether the new score is the player’s highest. The platform game services handle that for you.
    
2.  To display the leaderboard as an overlay over your game, make the following call:
    
    ```
    <span>await</span><span> </span><span>GamesServices</span><span>.</span><span>showLeaderboards</span><span>(</span><span>
      iOSLeaderboardID</span><span>:</span><span> </span><span>'some_id_from_app_store'</span><span>,</span><span>
      androidLeaderboardID</span><span>:</span><span> </span><span>'sOmE_iD_fRoM_gPlAy'</span><span>,</span><span>
    </span><span>);</span>
    ```
    
3.  If you want to display the leaderboard scores in your own UI, you can fetch them with [`GamesServices.loadLeaderboardScores()`](https://pub.dev/documentation/games_services/latest/games_services/GamesServices/loadLeaderboardScores.html).
    

## 5\. Next steps

There’s more to the `games_services` plugin. With this plugin, you can:

-   Get the player’s icon, name or unique ID
-   Save and load game states
-   Sign out of the game service

Some achievements can be incremental. For example: “You have collected all 10 pieces of the McGuffin.”

Each game has different needs from game services.

To start, you might want to create this controller in order to keep all achievements & leaderboards logic in one place:

```
<span>import</span><span> </span><span>'dart:async'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:games_services/games_services.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:logging/logging.dart'</span><span>;</span><span>

</span><span>/// Allows awarding achievements and leaderboard scores,</span><span>
</span><span>/// and also showing the platforms' UI overlays for achievements</span><span>
</span><span>/// and leaderboards.</span><span>
</span><span>///</span><span>
</span><span>/// A facade of `package:games_services`.</span><span>
</span><span>class</span><span> </span><span>GamesServicesController</span><span> </span><span>{</span><span>
  </span><span>static</span><span> </span><span>final</span><span> </span><span>Logger</span><span> _log </span><span>=</span><span> </span><span>Logger</span><span>(</span><span>'GamesServicesController'</span><span>);</span><span>

  </span><span>final</span><span> </span><span>Completer</span><span>&lt;</span><span>bool</span><span>&gt;</span><span> _signedInCompleter </span><span>=</span><span> </span><span>Completer</span><span>();</span><span>

  </span><span>Future</span><span>&lt;</span><span>bool</span><span>&gt;</span><span> </span><span>get</span><span> signedIn </span><span>=&gt;</span><span> _signedInCompleter</span><span>.</span><span>future</span><span>;</span><span>

  </span><span>/// Unlocks an achievement on Game Center / Play Games.</span><span>
  </span><span>///</span><span>
  </span><span>/// You must provide the achievement ids via the [iOS] and [android]</span><span>
  </span><span>/// parameters.</span><span>
  </span><span>///</span><span>
  </span><span>/// Does nothing when the game isn't signed into the underlying</span><span>
  </span><span>/// games service.</span><span>
  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> awardAchievement</span><span>(</span><span>
      </span><span>{</span><span>required</span><span> </span><span>String</span><span> iOS</span><span>,</span><span> </span><span>required</span><span> </span><span>String</span><span> android</span><span>})</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(!</span><span>await</span><span> signedIn</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>warning</span><span>(</span><span>'Trying to award achievement when not logged in.'</span><span>);</span><span>
      </span><span>return</span><span>;</span><span>
    </span><span>}</span><span>

    </span><span>try</span><span> </span><span>{</span><span>
      </span><span>await</span><span> </span><span>GamesServices</span><span>.</span><span>unlock</span><span>(</span><span>
        achievement</span><span>:</span><span> </span><span>Achievement</span><span>(</span><span>
          androidID</span><span>:</span><span> android</span><span>,</span><span>
          iOSID</span><span>:</span><span> iOS</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>severe</span><span>(</span><span>'Cannot award achievement: $e'</span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>/// Signs into the underlying games service.</span><span>
  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> initialize</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>try</span><span> </span><span>{</span><span>
      </span><span>await</span><span> </span><span>GamesServices</span><span>.</span><span>signIn</span><span>();</span><span>
      </span><span>// The API is unclear so we're checking to be sure. The above call</span><span>
      </span><span>// returns a String, not a boolean, and there's no documentation</span><span>
      </span><span>// as to whether every non-error result means we're safely signed in.</span><span>
      </span><span>final</span><span> signedIn </span><span>=</span><span> </span><span>await</span><span> </span><span>GamesServices</span><span>.</span><span>isSignedIn</span><span>;</span><span>
      _signedInCompleter</span><span>.</span><span>complete</span><span>(</span><span>signedIn</span><span>);</span><span>
    </span><span>}</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>severe</span><span>(</span><span>'Cannot log into GamesServices: $e'</span><span>);</span><span>
      _signedInCompleter</span><span>.</span><span>complete</span><span>(</span><span>false</span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>/// Launches the platform's UI overlay with achievements.</span><span>
  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> showAchievements</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(!</span><span>await</span><span> signedIn</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>severe</span><span>(</span><span>'Trying to show achievements when not logged in.'</span><span>);</span><span>
      </span><span>return</span><span>;</span><span>
    </span><span>}</span><span>

    </span><span>try</span><span> </span><span>{</span><span>
      </span><span>await</span><span> </span><span>GamesServices</span><span>.</span><span>showAchievements</span><span>();</span><span>
    </span><span>}</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>severe</span><span>(</span><span>'Cannot show achievements: $e'</span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>/// Launches the platform's UI overlay with leaderboard(s).</span><span>
  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> showLeaderboard</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(!</span><span>await</span><span> signedIn</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>severe</span><span>(</span><span>'Trying to show leaderboard when not logged in.'</span><span>);</span><span>
      </span><span>return</span><span>;</span><span>
    </span><span>}</span><span>

    </span><span>try</span><span> </span><span>{</span><span>
      </span><span>await</span><span> </span><span>GamesServices</span><span>.</span><span>showLeaderboards</span><span>(</span><span>
        </span><span>// TODO: When ready, change both these leaderboard IDs.</span><span>
        iOSLeaderboardID</span><span>:</span><span> </span><span>'some_id_from_app_store'</span><span>,</span><span>
        androidLeaderboardID</span><span>:</span><span> </span><span>'sOmE_iD_fRoM_gPlAy'</span><span>,</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>severe</span><span>(</span><span>'Cannot show leaderboard: $e'</span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>

  </span><span>/// Submits [score] to the leaderboard.</span><span>
  </span><span>Future</span><span>&lt;</span><span>void</span><span>&gt;</span><span> submitLeaderboardScore</span><span>(</span><span>int</span><span> score</span><span>)</span><span> </span><span>async</span><span> </span><span>{</span><span>
    </span><span>if</span><span> </span><span>(!</span><span>await</span><span> signedIn</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>warning</span><span>(</span><span>'Trying to submit leaderboard when not logged in.'</span><span>);</span><span>
      </span><span>return</span><span>;</span><span>
    </span><span>}</span><span>

    _log</span><span>.</span><span>info</span><span>(</span><span>'Submitting $score to leaderboard.'</span><span>);</span><span>

    </span><span>try</span><span> </span><span>{</span><span>
      </span><span>await</span><span> </span><span>GamesServices</span><span>.</span><span>submitScore</span><span>(</span><span>
        score</span><span>:</span><span> </span><span>Score</span><span>(</span><span>
          </span><span>// TODO: When ready, change these leaderboard IDs.</span><span>
          iOSLeaderboardID</span><span>:</span><span> </span><span>'some_id_from_app_store'</span><span>,</span><span>
          androidLeaderboardID</span><span>:</span><span> </span><span>'sOmE_iD_fRoM_gPlAy'</span><span>,</span><span>
          value</span><span>:</span><span> score</span><span>,</span><span>
        </span><span>),</span><span>
      </span><span>);</span><span>
    </span><span>}</span><span> </span><span>catch</span><span> </span><span>(</span><span>e</span><span>)</span><span> </span><span>{</span><span>
      _log</span><span>.</span><span>severe</span><span>(</span><span>'Cannot submit leaderboard score: $e'</span><span>);</span><span>
    </span><span>}</span><span>
  </span><span>}</span><span>
</span><span>}</span>
```

## More information

The Flutter Casual Games Toolkit includes the following templates:

-   [basic](https://github.com/flutter/games/tree/main/templates/basic#readme): basic starter game
-   [card](https://github.com/flutter/games/tree/main/templates/card#readme): starter card game
-   [endless runner](https://github.com/flutter/games/tree/main/templates/endless_runner#readme): starter game (using Flame) where the player endlessly runs, avoiding pitfalls and gaining rewards