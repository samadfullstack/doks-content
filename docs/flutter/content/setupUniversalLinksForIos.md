1.  [Cookbook](https://docs.flutter.dev/cookbook)
2.  [Navigation](https://docs.flutter.dev/cookbook/navigation)
3.  [Set up universal links for iOS](https://docs.flutter.dev/cookbook/navigation/set-up-universal-links)

Deep linking is a mechanism for launching an app with a URI. This URI contains scheme, host, and path, and opens the app to a specific screen.

A _universal link_ is a type of deep link that uses `http` or `https` and is exclusive to Apple devices.

Setting up universal links requires one to own a web domain. Otherwise, consider using [Firebase Hosting](https://firebase.google.com/docs/hosting) or [GitHub Pages](https://pages.github.com/) as a temporary solution.

## 1\. Customize a Flutter application

Write a Flutter app that can handle an incoming URL. This example uses the [go\_router](https://pub.dev/packages/go_router) package to handle the routing. The Flutter team maintains the `go_router` package. It provides a simple API to handle complex routing scenarios.

1.  To create a new application, type `flutter create <app-name>`.
    
    ```
     <span>$ </span>flutter create deeplink_cookbook
    ```
    
2.  To include the `go_router` package as a dependency, run `flutter pub add`:
    
    ```
    <span> $</span><span> </span>flutter pub add go_router
    ```
    
3.  To handle the routing, create a `GoRouter` object in the `main.dart` file:
    

## 2\. Adjust iOS build settings

1.  Launch Xcode.
2.  Open the `ios/Runner.xcworkspace` file inside the project’s `ios` folder.
3.  Navigate to the `Info` Plist file in the `ios/Runner` folder.
    
    ![Xcode info.Plist screenshot](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-universal-links-info-plist.png)
    
4.  In the `Info` property list, control-click at the list to add a row.
5.  Control-click the newly added row and turn on the **Raw Keys and Values** mode
6.  Update the key to `FlutterDeepLinkingEnabled` with a `Boolean` value set to `YES`.
    
    ![flutter deeplinking enabled screenshot](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-universal-links-flutterdeeplinkingenabled.png)
    
7.  Click the top-level **Runner**.
8.  Click **Signing & Capabilities**.
9.  Click **\+ Capability** to add a new domain.
10.  Click **Associated Domains**.
    
    ![Xcode associated domains screenshot](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-universal-links-associated-domains.png)
    
11.  In the **Associated Domains** section, click **+**.
12.  Enter `applinks:<web domain>`. Replace `<web domain>` with your own domain name.
    
    ![Xcode add associated domains screenshot](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-universal-links-add-associated-domains.png)
    

You have finished configuring the application for deep linking.

## 3\. Hosting apple-app-site-association file

You need to host an `apple-app-site-association` file in the web domain. This file tells the mobile browser which iOS application to open instead of the browser. To create the file, get the app ID of the Flutter app you created in the previous step.

### App ID

Apple formats the app ID as `<team id>.<bundle id>`.

-   Locate the bundle ID in the Xcode project.
-   Locate the team ID in the [developer account](https://developer.apple.com/account).

**For example:** Given a team ID of `S8QB4VV633` and a bundle ID of `com.example.deeplinkCookbook`, The app ID is `S8QB4VV633.com.example.deeplinkCookbook`.

### apple-app-site-association

The hosted file should have the following content:

```
<span>{</span><span>
  </span><span>"applinks"</span><span>:</span><span> </span><span>{</span><span>
      </span><span>"apps"</span><span>:</span><span> </span><span>[],</span><span>
      </span><span>"details"</span><span>:</span><span> </span><span>[</span><span>
      </span><span>{</span><span>
        </span><span>"appID"</span><span>:</span><span> </span><span>"S8QB4VV633.com.example.deeplinkCookbook"</span><span>,</span><span>
        </span><span>"paths"</span><span>:</span><span> </span><span>[</span><span>"*"</span><span>]</span><span>
      </span><span>}</span><span>
    </span><span>]</span><span>
  </span><span>}</span><span>
</span><span>}</span><span>
</span>
```

1.  Set the `appID` value to `<team id>.<bundle id>`.
    
2.  Set the `paths` value to `["*"]`. The `paths` field specifies the allowed universal links. Using the asterisk, `*` redirects every path to the Flutter application. If needed, change the `paths` value to a setting more appropriate to your app.
    
3.  Host the file at a URL that resembles the following: `<webdomain>/.well-known/apple-app-site-association`
    
4.  Verify that your browser can access this file.
    

## Testing

You can use a real device or the Simulator to test a universal link, but first make sure you have executed `flutter run` at least once on the devices. This ensures that the Flutter application is installed.

![Simulator screenshot](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-universal-links-simulator.png)

If using the Simulator, test using the Xcode CLI:

```
<span>$</span><span> </span>xcrun simctl openurl booted https://&lt;web domain&gt;/details
```

Otherwise, type the URL in the **Note** app and click it.

If everything is set up correctly, the Flutter application launches and displays the details screen:

![Deeplinked Simulator screenshot](https://docs.flutter.dev/assets/images/docs/cookbook/set-up-universal-links-simulator-deeplinked.png)

## Appendix

Source code: [deeplink\_cookbook](https://github.com/flutter/codelabs/tree/main/deeplink_cookbook)