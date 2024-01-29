1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [iOS](https://docs.flutter.dev/platform-integration/ios)
3.  [Launch screen](https://docs.flutter.dev/platform-integration/ios/launch-screen)

[Launch screens](https://developer.apple.com/design/human-interface-guidelines/launching#Launch-screens) provide a simple initial experience while your iOS app loads. They set the stage for your application, while allowing time for the app engine to load and your app to initialize.

All apps submitted to the Apple App Store [must provide a launch screen](https://developer.apple.com/documentation/xcode/specifying-your-apps-launch-screen) with an Xcode storyboard.

## Customize the launch screen

The default Flutter template includes an Xcode storyboard named `LaunchScreen.storyboard` that can be customized your own assets. By default, the storyboard displays a blank image, but you can change this. To do so, open the Flutter app’s Xcode project by typing `open ios/Runner.xcworkspace` from the root of your app directory. Then select `Runner/Assets.xcassets` from the Project Navigator and drop in the desired images to the `LaunchImage` image set.

Apple provides detailed guidance for launch screens as part of the [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/patterns/launching#launch-screens).