1.  [Data & backend](https://docs.flutter.dev/data-and-backend)
2.  [Google APIs](https://docs.flutter.dev/data-and-backend/google-apis)

The [Google APIs package](https://pub.dev/packages/googleapis) exposes dozens of Google services that you can use from Dart projects.

This page describes how to use APIs that interact with end-user data by using Google authentication.

Examples of user-data APIs include [Calendar](https://pub.dev/documentation/googleapis/latest/calendar_v3/calendar_v3-library.html), [Gmail](https://pub.dev/documentation/googleapis/latest/gmail_v1/gmail_v1-library.html), [YouTube](https://pub.dev/documentation/googleapis/latest/youtube_v3/youtube_v3-library.html), and Firebase.

To add authentication to Firebase explicitly, check out the [Add a user authentication flow to a Flutter app using FirebaseUI](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps) codelab and the [Get Started with Firebase Authentication on Flutter](https://firebase.google.com/docs/auth/flutter/start) docs.

## Overview

To use Google APIs, follow these steps:

1.  Pick the desired API
2.  Enable the API
3.  Authenticate user with the required scopes
4.  Obtain an authenticated HTTP client
5.  Create and use the desired API class

## 1\. Pick the desired API

The documentation for [package:googleapis](https://pub.dev/documentation/googleapis) lists each API as a separate Dart library&emdash;in a `name_version` format. Check out [`youtube_v3`](https://pub.dev/documentation/googleapis/latest/youtube_v3/youtube_v3-library.html) as an example.

Each library might provide many types, but there is one _root_ class that ends in `Api`. For YouTube, it’s [`YouTubeApi`](https://pub.dev/documentation/googleapis/latest/youtube_v3/YouTubeApi-class.html).

Not only is the `Api` class the one you need to instantiate (see step 3), but it also exposes the scopes that represent the permissions needed to use the API. For example, the [Constants section](https://pub.dev/documentation/googleapis/latest/youtube_v3/YouTubeApi-class.html#constants) of the `YouTubeApi` class lists the available scopes. To request access to read (but not write) an end-users YouTube data, authenticate the user with [`youtubeReadonlyScope`](https://pub.dev/documentation/googleapis/latest/youtube_v3/YouTubeApi/youtubeReadonlyScope-constant.html).

```
<span>/// Provides the `YouTubeApi` class.</span><span>
</span><span>import</span><span> </span><span>'package:googleapis/youtube/v3.dart'</span><span>;</span>
```

## 2\. Enable the API

To use Google APIs you must have a Google account and a Google project. You also need to enable your desired API.

This example enables [YouTube Data API v3](https://console.cloud.google.com/apis/library/youtube.googleapis.com). For details, see the [getting started instructions](https://cloud.google.com/apis/docs/getting-started).

## 3\. Authenticate the user with the required scopes

Use the [google\_sign\_in](https://pub.dev/packages/google_sign_in) package to authenticate users with their Google identity. Configure signin for each platform you want to support.

```
<span>/// Provides the `GoogleSignIn` class</span><span>
</span><span>import</span><span> </span><span>'package:google_sign_in/google_sign_in.dart'</span><span>;</span>
```

When instantiating the [`GoogleSignIn`](https://pub.dev/documentation/google_sign_in/latest/google_sign_in/GoogleSignIn-class.html) class, provide the desired scopes as discussed in the previous section.

```
<span>final</span><span> _googleSignIn </span><span>=</span><span> </span><span>GoogleSignIn</span><span>(</span><span>
  scopes</span><span>:</span><span> </span><span>&lt;</span><span>String</span><span>&gt;[</span><span>YouTubeApi</span><span>.</span><span>youtubeReadonlyScope</span><span>],</span><span>
</span><span>);</span>
```

Follow the instructions provided by [`package:google_sign_in`](https://pub.dev/packages/google_sign_in) to allow a user to authenticate.

Once authenticated, you must obtain an authenticated HTTP client.

## 4\. Obtain an authenticated HTTP client

The [extension\_google\_sign\_in\_as\_googleapis\_auth](https://pub.dev/packages/extension_google_sign_in_as_googleapis_auth) package provides an [extension method](https://dart.dev/guides/language/extension-methods) on `GoogleSignIn` called [`authenticatedClient`](https://pub.dev/documentation/extension_google_sign_in_as_googleapis_auth/latest/extension_google_sign_in_as_googleapis_auth/GoogleApisGoogleSignInAuth/authenticatedClient.html).

```
<span>import</span><span> </span><span>'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart'</span><span>;</span>
```

Add a listener to [`onCurrentUserChanged`](https://pub.dev/documentation/google_sign_in/latest/google_sign_in/GoogleSignIn/onCurrentUserChanged.html) and when the event value isn’t `null`, you can create an authenticated client.

```
<span>var</span><span> httpClient </span><span>=</span><span> </span><span>(</span><span>await</span><span> _googleSignIn</span><span>.</span><span>authenticatedClient</span><span>())!;</span>
```

This [`Client`](https://pub.dev/documentation/http/latest/http/Client-class.html) instance includes the necessary credentials when invoking Google API classes.

## 5\. Create and use the desired API class

Use the API to create the desired API type and call methods. For instance:

```
<span>var</span><span> youTubeApi </span><span>=</span><span> </span><span>YouTubeApi</span><span>(</span><span>httpClient</span><span>);</span><span>

</span><span>var</span><span> favorites </span><span>=</span><span> </span><span>await</span><span> youTubeApi</span><span>.</span><span>playlistItems</span><span>.</span><span>list</span><span>(</span><span>
  </span><span>[</span><span>'snippet'</span><span>],</span><span>
  playlistId</span><span>:</span><span> </span><span>'LL'</span><span>,</span><span> </span><span>// Liked List</span><span>
</span><span>);</span>
```

## More information

You might want to check out the following:

-   The [`extension_google_sign_in_as_googleapis_auth` example](https://pub.dev/packages/extension_google_sign_in_as_googleapis_auth/example) is a working implementation of the concepts described on this page.