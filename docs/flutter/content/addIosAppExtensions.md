1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [iOS](https://docs.flutter.dev/platform-integration/ios)
3.  [Adding iOS app extensions](https://docs.flutter.dev/platform-integration/ios/app-extensions)

iOS app extensions allow you to expand functionality outside your app. Your app could appear as a home screen widget, or you can make portions of your app available within other apps.

To learn more about app extensions, check out [Apple’s documentation](https://developer.apple.com/app-extensions/).

## How do you add an app extension to your Flutter app?

To add an app extension to your Flutter app, add the extension point _target_ to your Xcode project.

1.  Open the default Xcode workspace in your project by running `open ios/Runner.xcworkspace` in a terminal window from your Flutter project directory.
2.  In Xcode, select **File -> New -> Target** from the menu bar.
    
    ![](https://docs.flutter.dev/assets/images/docs/development/platform-integration/app-extensions/xcode-new-target.png)
    
3.  Select the app extension you intend to add. This selection generates extension-specific code within a new folder in your project. To learn more about the generated code and the SDKs for each extension point, check out the resources in [Apple’s documentation](https://developer.apple.com/app-extensions/).

To learn how to add a home screen widget to your iOS device, check out the [Adding a Home Screen Widget to your Flutter app](https://codelabs.developers.google.com/flutter-home-screen-widgets) codelab.

## How do Flutter apps interact with App Extensions?

Flutter apps interact with app extensions using the same techniques as UIKit or SwiftUI apps. The containing app and the app extension don’t communicate directly. The containing app might not be running while the device user interacts with the extension. The app and your extension can read and write to shared resources or use higher-level APIs to communicate with each other.

### Using higher-level APIs

Some extensions have APIs. For example, the [Core Spotlight](https://developer.apple.com/documentation/corespotlight) framework indexes your app, allowing users to search from Spotlight and Safari. The [WidgetKit](https://developer.apple.com/documentation/widgetkit) framework can trigger an update of your home screen widget.

To simplify how your app communicates with extensions, Flutter plugins wrap these APIs. To find plugins that wrap extension APIs, check out [Leveraging Apple’s System APIs and Frameworks](https://docs.flutter.dev/platform-integration/ios/apple-frameworks) or search [pub.dev](https://pub.dev/packages).

### Sharing resources

To share resources between your Flutter app and your app extension, put the `Runner` app target and the extension target in the same [App Group](https://developer.apple.com/documentation/xcode/configuring-app-groups).

To add a target to an App Group:

1.  Open the target settings in Xcode.
2.  Navigate to the **Signing & Capabilities** tab.
3.  Select **\+ Capability** then **App Groups**.
4.  Choose which App Group you want to add the target from one of two options:
    
    1.  Select an App Group from the list.
    2.  Click **+** to add a new App Group.

![](https://docs.flutter.dev/assets/images/docs/development/platform-integration/app-extensions/xcode-app-groups.png)

When two targets belong to the same App Group, they can read from and write to the same source. Choose one of the following sources for your data.

-   **Key/value:** Use the [`shared_preference_app_group`](https://pub.dev/packages/shared_preference_app_group) plugin to read or write to `UserDefaults` within the same App Group.
-   **File:** Use the App Group container path from the [`path_provider`](https://pub.dev/packages/path_provider) plugin to [read and write files](https://docs.flutter.dev/cookbook/persistence/reading-writing-files).
-   **Database:** Use the App Group container path from the [`path_provider`](https://pub.dev/packages/path_provider) plugin to create a database with the [`sqflite`](https://pub.dev/packages/sqflite) plugin.

### Background updates

Background tasks provide a means to update your extension through code regardless of the status of your app.

To schedule background work from your Flutter app, use the [`workmanager`](https://pub.dev/packages/workmanager) plugin.

### Deep linking

You might want to direct users from an app extension to a specific page in your Flutter app. To open a specific route in your app, you can use [Deep Linking](https://docs.flutter.dev/ui/navigation/deep-linking).

## Creating app extension UIs with Flutter

Some app extensions display a user interface.

For example, share extensions allow users to conveniently share content with other apps, such as sharing a picture to create a new post on a social media app.

![](https://docs.flutter.dev/assets/images/docs/development/platform-integration/app-extensions/share-extension.png)

As of the 3.16 release, you can build Flutter UI for an app extension, though you must use an extension-safe `Flutter.xcframework` and embed the `FlutterViewController` as described in the following section.

1.  Locate the extension-safe `Flutter.xcframework` file, at `<path_to_flutter_sdk>/bin/cache/artifacts/engine/ios/extension_safe/Flutter.xcframework`.
    
    -   To build for release or profile modes, find the framework file under the `ios-release` or `ios-profile` folder, respectively.
2.  Drag and drop the `Flutter.xcframework` file into your share extension’s frameworks and libraries list. Make sure the embed column says “Embed & Sign”.
    
    ![](https://docs.flutter.dev/assets/images/docs/development/platform-integration/app-extensions/embed-framework.png)
    
3.  Open the Flutter app project settings in Xcode to share build configurations.
    
    1.  Navigate to the **Info** tab.
    2.  Expand the **Configurations** group.
    3.  Expand the **Debug**, **Profile**, and **Release** entries.
    4.  For each of these configurations, make sure the value in the **Based on configuration file** drop-down menu for your extension matches the one selected for the normal app target.
    
    ![](https://docs.flutter.dev/assets/images/docs/development/platform-integration/app-extensions/xcode-configurations.png)
    
4.  (Optional) Replace any storyboard files with an extension class, if needed.
    
    1.  In the `Info.plist` file, delete the **NSExtensionMainStoryboard** property.
    2.  Add the **NSExtensionPrincipalClass** property.
    3.  Set the value for this property to the entry point of the extension. For example, for share extensions, it’s usually `<YourShareExtensionTargetName>.ShareViewController`. If you use Objective-C to implement the extension, you should omit the `<YourShareExtensionTargetName>.` portion.  
        
    
    ![](https://docs.flutter.dev/assets/images/docs/development/platform-integration/app-extensions/share-extension-info.png)
    
5.  Embed the `FlutterViewController` as described in [Adding a Flutter Screen](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen?tab=vc-uikit-swift-tab#alternatively---create-a-flutterviewcontroller-with-an-implicit-flutterengine). For example, you can display a specific route in your Flutter app within a share extension.
    
    ```
     <span>import</span> <span>UIKit</span>
     <span>import</span> <span>Flutter</span>
    
     <span>class</span> <span>ShareViewController</span><span>:</span> <span>UIViewController</span> <span>{</span>
         <span>override</span> <span>func</span> <span>viewDidLoad</span><span>()</span> <span>{</span>
             <span>super</span><span>.</span><span>viewDidLoad</span><span>()</span>
             <span>showFlutter</span><span>()</span>
         <span>}</span>
    
         <span>func</span> <span>showFlutter</span><span>()</span> <span>{</span>
             <span>let</span> <span>flutterViewController</span> <span>=</span> <span>FlutterViewController</span><span>(</span><span>project</span><span>:</span> <span>nil</span><span>,</span> <span>nibName</span><span>:</span> <span>nil</span><span>,</span> <span>bundle</span><span>:</span> <span>nil</span><span>)</span>
             <span>addChild</span><span>(</span><span>flutterViewController</span><span>)</span>
             <span>view</span><span>.</span><span>addSubview</span><span>(</span><span>flutterViewController</span><span>.</span><span>view</span><span>)</span>
             <span>flutterViewController</span><span>.</span><span>view</span><span>.</span><span>frame</span> <span>=</span> <span>view</span><span>.</span><span>bounds</span>
         <span>}</span>
     <span>}</span>
    ```
    

## Test extensions

Testing extensions on simulators and physical devices have slightly different procedures.

### Test on a simulator

1.  Build and run the main application target.
2.  After the app is launched on the simulator, press Cmd + Shift + H to minimize the app, which switches to the home screen.
3.  Launch an app that supports the share extension, such as the Photos app.
4.  Select a photo, tap the share button, then tap on the share extension icon of your app.

### Test on a physical device

You can use the following procedure or the [Testing on simulators](https://docs.flutter.dev/platform-integration/ios/app-extensions#test-on-a-simulator) instructions to test on physical devices.

1.  Launch the share extension target.
2.  In the popup window that says “Choose an app to run”, select an app that can be used to test share extension, such as the Photos app.
3.  Select a photo, tap the share button, then tap on the share extension icon of your app.

## Tutorials

For step-by-step instruction for using app extensions with your Flutter iOS app, check out the [Adding a Home Screen Widget to your Flutter app](https://codelabs.developers.google.com/flutter-home-screen-widgets) codelab.