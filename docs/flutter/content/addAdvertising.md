1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Plugins](https://docs.flutter.dev/cookbook/plugins)
3.  [Show ads](https://docs.flutter.dev/cookbook/plugins/google-mobile-ads)

Many developers use advertising to monetize their mobile apps and games. This allows their app to be downloaded free of charge, which improves the app’s popularity.

![An illustration of a smartphone showing an ad](https://docs.flutter.dev/assets/images/docs/cookbook/ads-device.jpg)

To add ads to your Flutter project, use [AdMob](https://admob.google.com/home/), Google’s mobile advertising platform. This recipe demonstrates how to use the [`google_mobile_ads`](https://pub.dev/packages/google_mobile_ads) package to add a banner ad to your app or game.

## 1\. Get AdMob App IDs

1.  Go to [AdMob](https://admob.google.com/) and set up an account. This could take some time because you need to provide banking information, sign contracts, and so on.
    
2.  With the AdMob account ready, create two _Apps_ in AdMob: one for Android and one for iOS.
    
3.  Open the **App settings** section.
    
4.  Get the AdMob _App IDs_ for both the Android app and the iOS app. They resemble `ca-app-pub-1234567890123456~1234567890`. Note the tilde (`~`) between the two numbers.
    
    ![Screenshot from AdMob showing the location of the App ID](https://docs.flutter.dev/assets/images/docs/cookbook/ads-app-id.png)
    

## 2\. Platform-specific setup

Update your Android and iOS configurations to include your App IDs.

### Android

Add your AdMob app ID to your Android app.

1.  Open the app’s `android/app/src/main/AndroidManifest.xml` file.
    
2.  Add a new `<meta-data>` tag.
    
3.  Set the `android:name` element with a value of `com.google.android.gms.ads.APPLICATION_ID`.
    
4.  Set the `android:value` element with the value to your own AdMob app ID that you got in the previous step. Include them in quotes as shown:
    
    ```
    <span>&lt;manifest&gt;</span>
        <span>&lt;application&gt;</span>
            ...
        
            <span>&lt;!-- Sample AdMob app ID: ca-app-pub-3940256099942544~3347511713 --&gt;</span>
            <span>&lt;meta-data</span>
                <span>android:name=</span><span>"com.google.android.gms.ads.APPLICATION_ID"</span>
                <span>android:value=</span><span>"ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"</span><span>/&gt;</span>
        <span>&lt;/application&gt;</span>
    <span>&lt;/manifest&gt;</span>
    ```
    

### iOS

Add your AdMob app ID to your iOS app.

1.  Open your app’s `ios/Runner/Info.plist` file.
    
2.  Enclose `GADApplicationIdentifier` with a `key` tag.
    
3.  Enclose your AdMob app ID with a `string` tag. You created this AdMob App ID in [step 1](https://docs.flutter.dev/cookbook/plugins/google-mobile-ads#1-get-admob-app-ids).
    
    ```
    <span>&lt;key&gt;</span>GADApplicationIdentifier<span>&lt;/key&gt;</span>
    <span>&lt;string&gt;</span>ca-app-pub-################~##########<span>&lt;/string&gt;</span>
    ```
    

## 3\. Add the `google_mobile_ads` plugin

To add the `google_mobile_ads` plugin as a dependency, run `flutter pub add`:

```
<span>$</span><span> </span>flutter pub add google_mobile_ads
```

## 4\. Initialize the Mobile Ads SDK

You need to initialize the Mobile Ads SDK before loading ads.

1.  Call `MobileAds.instance.initialize()` to initialize the Mobile Ads SDK.
    
    ```
    <span>void</span><span> main</span><span>()</span><span> </span><span>async</span><span> </span><span>{</span><span>
      </span><span>WidgetsFlutterBinding</span><span>.</span><span>ensureInitialized</span><span>();</span><span>
      unawaited</span><span>(</span><span>MobileAds</span><span>.</span><span>instance</span><span>.</span><span>initialize</span><span>());</span><span>
    
      runApp</span><span>(</span><span>MyApp</span><span>());</span><span>
    </span><span>}</span>
    ```
    

Run the initialization step at startup, as shown above, so that the AdMob SDK has enough time to initialize before it is needed.

To show an ad, you need to request it from AdMob.

To load a banner ad, construct a `BannerAd` instance, and call `load()` on it.

```
<span>/// Loads a banner ad.</span><span>
</span><span>void</span><span> _loadAd</span><span>()</span><span> </span><span>{</span><span>
  </span><span>final</span><span> bannerAd </span><span>=</span><span> </span><span>BannerAd</span><span>(</span><span>
    size</span><span>:</span><span> widget</span><span>.</span><span>adSize</span><span>,</span><span>
    adUnitId</span><span>:</span><span> widget</span><span>.</span><span>adUnitId</span><span>,</span><span>
    request</span><span>:</span><span> </span><span>const</span><span> </span><span>AdRequest</span><span>(),</span><span>
    listener</span><span>:</span><span> </span><span>BannerAdListener</span><span>(</span><span>
      </span><span>// Called when an ad is successfully received.</span><span>
      onAdLoaded</span><span>:</span><span> </span><span>(</span><span>ad</span><span>)</span><span> </span><span>{</span><span>
        </span><span>if</span><span> </span><span>(!</span><span>mounted</span><span>)</span><span> </span><span>{</span><span>
          ad</span><span>.</span><span>dispose</span><span>();</span><span>
          </span><span>return</span><span>;</span><span>
        </span><span>}</span><span>
        setState</span><span>(()</span><span> </span><span>{</span><span>
          _bannerAd </span><span>=</span><span> ad </span><span>as</span><span> </span><span>BannerAd</span><span>;</span><span>
        </span><span>});</span><span>
      </span><span>},</span><span>
      </span><span>// Called when an ad request failed.</span><span>
      onAdFailedToLoad</span><span>:</span><span> </span><span>(</span><span>ad</span><span>,</span><span> error</span><span>)</span><span> </span><span>{</span><span>
        debugPrint</span><span>(</span><span>'BannerAd failed to load: $error'</span><span>);</span><span>
        ad</span><span>.</span><span>dispose</span><span>();</span><span>
      </span><span>},</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>

  </span><span>// Start loading.</span><span>
  bannerAd</span><span>.</span><span>load</span><span>();</span><span>
</span><span>}</span>
```

To view a complete example, check out the last step of this recipe.

Once you have a loaded instance of `BannerAd`, use `AdWidget` to show it.

It’s a good idea to wrap the widget in a `SafeArea` (so that no part of the ad is obstructed by device notches) and a `SizedBox` (so that it has its specified, constant size before and after loading).

```
<span>@override
</span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
  </span><span>return</span><span> </span><span>SafeArea</span><span>(</span><span>
    child</span><span>:</span><span> </span><span>SizedBox</span><span>(</span><span>
      width</span><span>:</span><span> widget</span><span>.</span><span>adSize</span><span>.</span><span>width</span><span>.</span><span>toDouble</span><span>(),</span><span>
      height</span><span>:</span><span> widget</span><span>.</span><span>adSize</span><span>.</span><span>height</span><span>.</span><span>toDouble</span><span>(),</span><span>
      child</span><span>:</span><span> _bannerAd </span><span>==</span><span> </span><span>null</span><span>
      </span><span>// Nothing to render yet.</span><span>
          </span><span>?</span><span> </span><span>SizedBox</span><span>()</span><span>
      </span><span>// The actual ad.</span><span>
          </span><span>:</span><span> </span><span>AdWidget</span><span>(</span><span>ad</span><span>:</span><span> _bannerAd</span><span>!),</span><span>
    </span><span>),</span><span>
  </span><span>);</span><span>
</span><span>}</span>
```

You must dispose of an ad when you no longer need to access it. The best practice for when to call `dispose()` is either after the `AdWidget` is removed from the widget tree or in the `BannerAdListener.onAdFailedToLoad()` callback.

## 7\. Configure ads

To show anything beyond test ads, you have to register ad units.

1.  Open [AdMob](https://admob.google.com/).
    
2.  Create an _Ad unit_ for each of the AdMob apps.
    
    This asks for the Ad unit’s format. AdMob provides many formats beyond banner ads — interstitials, rewarded ads, app open ads, and so on. The API for those is similar, and documented in the [AdMob documentation](https://developers.google.com/admob/flutter/quick-start) and through [official samples](https://github.com/googleads/googleads-mobile-flutter/tree/main/samples/admob).
    
3.  Choose banner ads.
    
4.  Get the _Ad unit IDs_ for both the Android app and the iOS app. You can find these in the **Ad units** section. They look something like `ca-app-pub-1234567890123456/1234567890`. The format resembles the _App ID_ but with a slash (`/`) between the two numbers. This distinguishes an _Ad unit ID_ from an _App ID_.
    
    ![Screenshot of an Ad Unit ID in AdMob web UI](https://docs.flutter.dev/assets/images/docs/cookbook/ads-ad-unit-id.png)
    
5.  Add these _Ad unit IDs_ to the constructor of `BannerAd`, depending on the target app platform.
    
    ```
    <span>final</span><span> </span><span>String</span><span> adUnitId </span><span>=</span><span> </span><span>Platform</span><span>.</span><span>isAndroid
        </span><span>// Use this ad unit on Android...</span><span>
        </span><span>?</span><span> </span><span>'ca-app-pub-3940256099942544/6300978111'</span><span>
        </span><span>// ... or this one on iOS.</span><span>
        </span><span>:</span><span> </span><span>'ca-app-pub-3940256099942544/2934735716'</span><span>;</span>
    ```
    

## 8\. Final touches

To display the ads in a published app or game (as opposed to debug or testing scenarios), your app must meet additional requirements:

1.  Your app must be reviewed and approved before it can fully serve ads. Follow AdMob’s [app readiness guidelines](https://support.google.com/admob/answer/10564477). For example, your app must be listed on at least one of the supported stores such as Google Play Store or Apple App Store.
    
2.  You must [create an `app-ads.txt`](https://support.google.com/admob/answer/9363762) file and publish it on your developer website.
    

![An illustration of a smartphone showing an ad](https://docs.flutter.dev/assets/images/docs/cookbook/ads-device.jpg)

To learn more about app and game monetization, visit the official sites of [AdMob](https://admob.google.com/) and [Ad Manager](https://admanager.google.com/).

## 9\. Complete example

The following code implements a simple stateful widget that loads a banner ad and shows it.

```
<span>import</span><span> </span><span>'dart:io'</span><span>;</span><span>

</span><span>import</span><span> </span><span>'package:flutter/widgets.dart'</span><span>;</span><span>
</span><span>import</span><span> </span><span>'package:google_mobile_ads/google_mobile_ads.dart'</span><span>;</span><span>

</span><span>class</span><span> </span><span>MyBannerAdWidget</span><span> </span><span>extends</span><span> </span><span>StatefulWidget</span><span> </span><span>{</span><span>
  </span><span>/// The requested size of the banner. Defaults to [AdSize.banner].</span><span>
  </span><span>final</span><span> </span><span>AdSize</span><span> adSize</span><span>;</span><span>

  </span><span>/// The AdMob ad unit to show.</span><span>
  </span><span>///</span><span>
  </span><span>/// TODO: replace this test ad unit with your own ad unit</span><span>
  </span><span>final</span><span> </span><span>String</span><span> adUnitId </span><span>=</span><span> </span><span>Platform</span><span>.</span><span>isAndroid
      </span><span>// Use this ad unit on Android...</span><span>
      </span><span>?</span><span> </span><span>'ca-app-pub-3940256099942544/6300978111'</span><span>
      </span><span>// ... or this one on iOS.</span><span>
      </span><span>:</span><span> </span><span>'ca-app-pub-3940256099942544/2934735716'</span><span>;</span><span>

  </span><span>MyBannerAdWidget</span><span>({</span><span>
    </span><span>super</span><span>.</span><span>key</span><span>,</span><span>
    </span><span>this</span><span>.</span><span>adSize </span><span>=</span><span> </span><span>AdSize</span><span>.</span><span>banner</span><span>,</span><span>
  </span><span>});</span><span>

  @override
  </span><span>State</span><span>&lt;</span><span>MyBannerAdWidget</span><span>&gt;</span><span> createState</span><span>()</span><span> </span><span>=&gt;</span><span> _MyBannerAdWidgetState</span><span>();</span><span>
</span><span>}</span><span>

</span><span>class</span><span> _MyBannerAdWidgetState </span><span>extends</span><span> </span><span>State</span><span>&lt;</span><span>MyBannerAdWidget</span><span>&gt;</span><span> </span><span>{</span><span>
  </span><span>/// The banner ad to show. This is `null` until the ad is actually loaded.</span><span>
  </span><span>BannerAd</span><span>?</span><span> _bannerAd</span><span>;</span><span>

  @override
  </span><span>Widget</span><span> build</span><span>(</span><span>BuildContext</span><span> context</span><span>)</span><span> </span><span>{</span><span>
    </span><span>return</span><span> </span><span>SafeArea</span><span>(</span><span>
      child</span><span>:</span><span> </span><span>SizedBox</span><span>(</span><span>
        width</span><span>:</span><span> widget</span><span>.</span><span>adSize</span><span>.</span><span>width</span><span>.</span><span>toDouble</span><span>(),</span><span>
        height</span><span>:</span><span> widget</span><span>.</span><span>adSize</span><span>.</span><span>height</span><span>.</span><span>toDouble</span><span>(),</span><span>
        child</span><span>:</span><span> _bannerAd </span><span>==</span><span> </span><span>null</span><span>
        </span><span>// Nothing to render yet.</span><span>
            </span><span>?</span><span> </span><span>SizedBox</span><span>()</span><span>
        </span><span>// The actual ad.</span><span>
            </span><span>:</span><span> </span><span>AdWidget</span><span>(</span><span>ad</span><span>:</span><span> _bannerAd</span><span>!),</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> initState</span><span>()</span><span> </span><span>{</span><span>
    </span><span>super</span><span>.</span><span>initState</span><span>();</span><span>
    _loadAd</span><span>();</span><span>
  </span><span>}</span><span>

  @override
  </span><span>void</span><span> dispose</span><span>()</span><span> </span><span>{</span><span>
    _bannerAd</span><span>?.</span><span>dispose</span><span>();</span><span>
    </span><span>super</span><span>.</span><span>dispose</span><span>();</span><span>
  </span><span>}</span><span>

  </span><span>/// Loads a banner ad.</span><span>
  </span><span>void</span><span> _loadAd</span><span>()</span><span> </span><span>{</span><span>
    </span><span>final</span><span> bannerAd </span><span>=</span><span> </span><span>BannerAd</span><span>(</span><span>
      size</span><span>:</span><span> widget</span><span>.</span><span>adSize</span><span>,</span><span>
      adUnitId</span><span>:</span><span> widget</span><span>.</span><span>adUnitId</span><span>,</span><span>
      request</span><span>:</span><span> </span><span>const</span><span> </span><span>AdRequest</span><span>(),</span><span>
      listener</span><span>:</span><span> </span><span>BannerAdListener</span><span>(</span><span>
        </span><span>// Called when an ad is successfully received.</span><span>
        onAdLoaded</span><span>:</span><span> </span><span>(</span><span>ad</span><span>)</span><span> </span><span>{</span><span>
          </span><span>if</span><span> </span><span>(!</span><span>mounted</span><span>)</span><span> </span><span>{</span><span>
            ad</span><span>.</span><span>dispose</span><span>();</span><span>
            </span><span>return</span><span>;</span><span>
          </span><span>}</span><span>
          setState</span><span>(()</span><span> </span><span>{</span><span>
            _bannerAd </span><span>=</span><span> ad </span><span>as</span><span> </span><span>BannerAd</span><span>;</span><span>
          </span><span>});</span><span>
        </span><span>},</span><span>
        </span><span>// Called when an ad request failed.</span><span>
        onAdFailedToLoad</span><span>:</span><span> </span><span>(</span><span>ad</span><span>,</span><span> error</span><span>)</span><span> </span><span>{</span><span>
          debugPrint</span><span>(</span><span>'BannerAd failed to load: $error'</span><span>);</span><span>
          ad</span><span>.</span><span>dispose</span><span>();</span><span>
        </span><span>},</span><span>
      </span><span>),</span><span>
    </span><span>);</span><span>

    </span><span>// Start loading.</span><span>
    bannerAd</span><span>.</span><span>load</span><span>();</span><span>
  </span><span>}</span><span>

</span><span>}</span>
```