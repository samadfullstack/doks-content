1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Navigation](https://docs.flutter.dev/cookbook/navigation)
3.  [Set up app links for Android](https://docs.flutter.dev/cookbook/navigation/set-up-app-links)

Deep linking is a mechanism for launching an app with a URI. This URI contains scheme, host, and path, and opens the app to a specific screen.

A _app link_ is a type of deep link that uses `http` or `https` and is exclusive to Android devices.

Setting up app links requires one to own a web domain. Otherwise, consider using [Firebase Hosting](https://firebase.google.com/docs/hosting) or [GitHub Pages](https://pages.github.com/) as a temporary solution.

## 1\. Customize a Flutter application

Write a Flutter app that can handle an incoming URL. This example uses the [go\_router](https://pub.dev/packages/go_router) package to handle the routing. The Flutter team maintains the `go_router` package. It provides a simple API to handle complex routing scenarios.

1.  To create a new application, type `flutter create <app-name>`:
    
    ```
     <span>$ </span>flutter create deeplink_cookbook
    ```
    
2.  To include `go_router` package in your app, add a dependency for `go_router` to the project:
    
    To add the `go_router` package as a dependency, run `flutter pub add`:
    
    ```
    <span> $</span><span> </span>flutter pub add go_router
    ```
    
3.  To handle the routing, create a `GoRouter` object in the `main.dart` file:
    

## 2\. Modify AndroidManifest.xml

1.  Open the Flutter project with VS Code or Android Studio.
2.  Navigate to `android/app/src/main/AndroidManifest.xml` file.
3.  Add the following metadata tag and intent filter inside the `<activity>` tag with `.MainActivity`.
    
    Replace `example.com` with your own web domain.
    
    ```
     &lt;meta-data android:name="flutter_deeplinking_enabled" android:value="true" /&gt;
     &lt;intent-filter android:autoVerify="true"&gt;
         &lt;action android:name="android.intent.action.VIEW" /&gt;
         &lt;category android:name="android.intent.category.DEFAULT" /&gt;
         &lt;category android:name="android.intent.category.BROWSABLE" /&gt;
         &lt;data android:scheme="http" android:host="example.com" /&gt;
         &lt;data android:scheme="https" /&gt;
     &lt;/intent-filter&gt;
    ```
    

## 3\. Hosting assetlinks.json file

Host an `assetlinks.json` file in using a web server with a domain that you own. This file tells the mobile browser which Android application to open instead of the browser. To create the file, get the package name of the Flutter app you created in the previous step and the sha256 fingerprint of the signing key you will be using to build the APK.

### Package name

Locate the package name in `AndroidManifest.xml`, the `package` property under `<manifest>` tag. Package names are usually in the format of `com.example.*`.

### sha256 fingerprint

The process might differ depending on how the apk is signed.

#### Using google play app signing

You can find the sha256 fingerprint directly from play developer console. Open your app in the play console, under **Release> Setup > App Integrity> App Signing tab**:

![Screenshot of sha256 fingerprint in play developer console](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-app-links-pdc-signing-key.png)

#### Using local keystore

If you are storing the key locally, you can generate sha256 using the following command:

```
keytool -list -v -keystore &lt;path-to-keystore&gt;
```

### assetlinks.json

The hosted file should look similar to this:

```
<span>[{</span><span>
  </span><span>"relation"</span><span>:</span><span> </span><span>[</span><span>"delegate_permission/common.handle_all_urls"</span><span>],</span><span>
  </span><span>"target"</span><span>:</span><span> </span><span>{</span><span>
    </span><span>"namespace"</span><span>:</span><span> </span><span>"android_app"</span><span>,</span><span>
    </span><span>"package_name"</span><span>:</span><span> </span><span>"com.example.deeplink_cookbook"</span><span>,</span><span>
    </span><span>"sha256_cert_fingerprints"</span><span>:</span><span>
    </span><span>[</span><span>"FF:2A:CF:7B:DD:CC:F1:03:3E:E8:B2:27:7C:A2:E3:3C:DE:13:DB:AC:8E:EB:3A:B9:72:A1:0E:26:8A:F5:EC:AF"</span><span>]</span><span>
  </span><span>}</span><span>
</span><span>}]</span><span>
</span>
```

1.  Set the `package_name` value to your Android application ID.
    
2.  Set sha256\_cert\_fingerprints to the value you got from the previous step.
    
3.  Host the file at a URL that resembles the following: `<webdomain>/.well-known/assetlinks.json`
    
4.  Verify that your browser can access this file.
    

## Testing

You can use a real device or the Emulator to test an app link, but first make sure you have executed `flutter run` at least once on the devices. This ensures that the Flutter application is installed.

![Emulator screenshot](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-app-links-emulator-installed.png)

To test **only** the app setup, use the adb command:

```
adb shell 'am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "http://&lt;web-domain&gt;/details"' \
    &lt;package name&gt;
```

To test **both** web and app setup, you must click a link directly through web browser or another app. One way is to create a Google Doc, add the link, and tap on it.

If everything is set up correctly, the Flutter application launches and displays the details screen:

![Deeplinked Emulator screenshot](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-app-links-emulator-deeplinked.png)

## Appendix

Source code: [deeplink\_cookbook](https://github.com/flutter/codelabs/tree/main/deeplink_cookbook)