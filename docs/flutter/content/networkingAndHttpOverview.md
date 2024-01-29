1.  [Data & backend](https://docs.flutter.dev/data-and-backend)
2.  [Networking](https://docs.flutter.dev/data-and-backend/networking)

## Cross-platform http networking

The [`http`](https://pub.dev/packages/http) package provides the simplest way to issue http requests. This package is supported on Android, iOS, macOS, Windows, Linux and the web.

## Platform notes

Some platforms require additional steps, as detailed below.

### Android

Android apps must [declare their use of the internet](https://developer.android.com/training/basics/network-ops/connecting) in the Android manifest (`AndroidManifest.xml`):

```
&lt;manifest xmlns:android...&gt;
 ...
 &lt;uses-permission android:name="android.permission.INTERNET" /&gt;
 &lt;application ...
&lt;/manifest&gt;
```

### macOS

macOS apps must allow network access in the relevant `*.entitlements` files.

```
&lt;key&gt;com.apple.security.network.client&lt;/key&gt;
&lt;true/&gt;
```

Learn more about [setting up entitlements](https://docs.flutter.dev/platform-integration/macos/building#setting-up-entitlements).

## Samples

For a practical sample of various networking tasks (incl. fetching data, WebSockets, and parsing data in the background) see the [networking cookbook](https://docs.flutter.dev/cookbook#networking).