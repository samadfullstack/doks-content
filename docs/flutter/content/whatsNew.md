1.  [Stay up to date](https://docs.flutter.dev/release)
2.  [What's new](https://docs.flutter.dev/release/whats-new)

This page contains current and previous announcements of what’s new on the Flutter website and blog. For details about what’s new in the Flutter releases, see the [release notes](https://docs.flutter.dev/release/release-notes) page.

To stay on top of Flutter announcements including breaking changes, join the [flutter-announce](https://groups.google.com/forum/#!forum/flutter-announce) Google group.

For Dart, you can join the [Dart Announce](https://groups.google.com/a/dartlang.org/g/announce) Google group, and review the [Dart changelog](https://github.com/dart-lang/sdk/blob/main/CHANGELOG.md).

## 15 November 2023: 3.16 release

Flutter 3.16 is live! For more information, check out the [Flutter 3.16 blog post](https://medium.com/flutter/flutter-3-16-dart-3-2-high-level-umbrella-post-b9218b17f0f7) and the technical [What’s new in Flutter 3.16](https://medium.com/flutter/whats-new-in-flutter-3-16-dba6cb1015d1) blog post.

You might also check out [Dart 3.2 release](https://medium.com/dartlang/dart-3-2-c8de8fe1b91f).

### Docs updated or added since the 3.13 release

-   As of this release, the **default theme for Material Flutter apps is Material 3**. Unless you explicitly specify Material 2 (with `useMaterial3: false`) in your app’s theme, your app _will_ look different once you’ve updated.
-   While the Flutter Casual Games Toolkit isn’t technically _part_ of the 3.16 release, we’ve release a significant update of the toolkit _alongside_ the 3.16 release. This update includes three completely new games code templates, three new games cookbook recipes, and a general reorganization of our games toolkit docs. For more information, check out [Casual Games Toolkit](https://docs.flutter.dev/resources/games-toolkit) and make sure to look at the side nav!
-   The Impeller runtime is now **available for Android on Vulkan devices** behind the `--enable-impeller` flag. For more information, check out the [Impeller rendering engine](https://docs.flutter.dev/perf/impeller) page.
-   You can now add Apple iOS app extensions to your Flutter app when running on iOS. To learn more, check out [Adding iOS app extensions](https://docs.flutter.dev/platform-integration/ios/app-extensions).

Articles\*\*

The following articles were published on the [Flutter Medium](https://medium.com/flutter) publication since Flutter 3.13:

-   [How IBM is creating a Flutter Center of Excellence](https://medium.com/flutter/how-ibm-is-creating-a-flutter-center-of-excellence-3c6a3c025441)
-   [Introducing the Flutter Consulting Directory](https://medium.com/flutter/introducing-the-flutter-consulting-directory-f6fc4c1d2ba3)
-   [Developing Flutter apps for large screens](https://medium.com/flutter/developing-flutter-apps-for-large-screens-53b7b0e17f10)
-   [Dart & Flutter DevTools Extensions](https://medium.com/flutter/dart-flutter-devtools-extensions-c8bc1aaf8e5f)
-   [Building your next casual game with Flutter](https://medium.com/flutter/building-your-next-casual-game-with-flutter-716ef457e440)

## 16 August 2023: 3.13 release

Flutter 3.13 is live! For more information, check out the [Flutter 3.13 blog post](https://medium.com/flutter/whats-new-in-flutter-3-13-479d9b11df4d).

You might also check out [Dart 3.1 & a retrospective on functional style programming in Dart 3](https://medium.com/dartlang/dart-3-1-a-retrospective-on-functional-style-programming-in-dart-3-a1f4b3a7cdda).

In addition to new docs since the last release, we have been incrementally releasing a revamped version of the docs.flutter.dev website. Specifically, we have reorganized (flattened) the information architecture (IA) and have incorporated some of our most popular cookbook recipes into the sidenav. [Let us know what you think!](https://github.com/flutter/website/issues)

### Docs updated or added since the 3.10 release

-   A rewrite and rename that completes the [Use a native language debugger](https://docs.flutter.dev/testing/native-debugging?tab=from-vscode-to-xcode-ios) page. This page covers how to connect both a native debugger and a Dart debugger to your app for Android _and_ iOS. (The previous version of this page was out of date and didn’t cover iOS.)
-   A new [Layout/Scrolling](https://docs.flutter.dev/ui/layout/scrolling) overview page. (In fact, scrolling is also a new section of the IA.)
-   We have sunsetted the Happy Paths recommendations in favor of the [Flutter Favorites program](https://docs.flutter.dev/packages-and-plugins/favorites). Look for additions to Flutter Favorites very soon!
-   The Impeller runtime is now available for macOS behind a flag. For more information, check out the [Impeller rendering engine](https://docs.flutter.dev/perf/impeller) page.
-   As always, this release includes a few [breaking changes](https://docs.flutter.dev/release/breaking-changes). The following links have more information, including info on how to migrate to the new APIs:
    -   [Removing the `ignoreSemantics` property from `IgnorePointer`, `AbsorbPointer`, and `SliverIgnorePointer`](https://docs.flutter.dev/release/breaking-changes/ignoringsemantics-migration)
    -   [The `Editable.onCaretChanged` callback is removed](https://docs.flutter.dev/release/breaking-changes/editable-text-scroll-into-view)
    -   Also check out the [deprecated APIs since 3.10](https://docs.flutter.dev/release/breaking-changes/3-10-deprecations)

**Codelabs and workshops**

The following codelab has been published since Flutter 3.10:

-   [Adding a Home Screen widget to your Flutter app](https://codelabs.developers.google.com/flutter-home-screen-widgets)

Articles\*\*

The following articles were published on the [Flutter Medium](https://medium.com/flutter) publication since Flutter 3.10:

-   [The Future of iOS development with Flutter](https://medium.com/flutter/the-future-of-ios-development-with-flutter-833aa9779fac)
-   [How it’s made: I/O Flip](https://medium.com/flutter/how-its-made-i-o-flip-da9d8184ef57)
-   [Flutter 2023 Q1 survey results](https://medium.com/flutter/flutter-2023-q1-survey-api-breaking-changes-deep-linking-and-more-7ff692f974e0)

**What’s coming**

Things that are coming soon-ish to a stable release:

**Material 3**

You’ve probably heard by now that [Material 3](https://m3.material.io/) is coming. It’s been available on Flutter for some time now, by setting `useMaterial3: true` in your code. By the next stable release in Q4, Material 3 will be enabled by default. Now would be a good time to start migrating your code. Most all of the example code on this website has been updated to use Material 3.

For more information, check out the following resources:

-   [Flutter 3.13 blog post](https://medium.com/flutter/whats-new-in-flutter-3-13-479d9b11df4d#4c90)
-   [Material Design for Flutter](https://docs.flutter.dev/ui/design/material) page

**Impeller for Android**

Progress continues on Impeller for Android. For more information, check out the [Flutter 3.13 blog post](https://medium.com/flutter/whats-new-in-flutter-3-13-479d9b11df4d#a7be).

**New scrolling APIs**

We have been working on updating our scrolling APIs. The rework will eventually result in 2D scrolling support for trees and tables, even diagonal scrolling! Flutter 3.13 also provides new Sliver classes for fancy scrolling. For more information, check out the [Flutter 3.13 blog post](https://medium.com/flutter/whats-new-in-flutter-3-13-479d9b11df4d#02dc).

**Updates to the Games toolkit**

We are working on updates to the Flutter Games toolkit, including the sample code, additional docs, and a new video. The Games toolkit is developed independently of the Flutter SDK, so stay tuned for updates as they are ready. For more information, check out the [Flutter 3.13 blog post](https://medium.com/flutter/whats-new-in-flutter-3-13-479d9b11df4d#30b2).

___

## 10 May 2023: Google I/O 2023: 3.10 release

Flutter 3.10 is live! This release contains many updates and improvements. This page lists the documentation changes, but you can also check out the [3.10 blog post](https://medium.com/flutter/whats-new-in-flutter-3-10-b21db2c38c73) and the [3.10 release notes](https://docs.flutter.dev/release/release-notes/release-notes-3.10.0).

You might also check out [Introducing Dart 3](https://medium.com/dartlang/announcing-dart-3-53f065a10635).

### Docs updated or added since the 3.7 release

-   Added section on [wireless debugging](https://docs.flutter.dev/add-to-app/debugging) for iOS or Android to the add-to-app module guide. You can debug your iOS or Android app on a physical device over Wi-Fi.
-   Updated the [Material Widget Catalog](https://docs.flutter.dev/ui/widgets/material) to cover Material 3.
-   Added the new [canvasKitVariant runtime configuration](https://docs.flutter.dev/platform-integration/web/initialization#initializing-the-engine) setting. This web initialization option lets you configure which version of CanvasKit to download.
-   Updated the [Impeller](https://docs.flutter.dev/perf/impeller) reference. iOS apps now default to the Impeller renderer.
-   Added the [Android Java Gradle migration](https://docs.flutter.dev/release/breaking-changes/android-java-gradle-migration-guide) guide on resolving an incompatibility between Java 17 and Gradle releases prior to 7.3.
-   Updated the [DevTools](https://docs.flutter.dev/tools/devtools/overview) reference material.
-   Updated the [WebAssembly support](https://docs.flutter.dev/platform-integration/web/wasm) reference with guidelines on trying out preview support.
-   Added guide on [adding iOS app extensions](https://docs.flutter.dev/platform-integration/ios/app-extensions) to Flutter apps. This release enables using native iOS app extensions with your Flutter apps.
-   Added guide on [testing Flutter plugins](https://docs.flutter.dev/testing/testing-plugins).
-   Added guide on [fonts and typography](https://docs.flutter.dev/ui/design/text/typography).
-   Added guide on restoring state on [Android](https://docs.flutter.dev/platform-integration/android/restore-state-android) and [iOS](https://docs.flutter.dev/platform-integration/ios/restore-state-ios) Flutter apps.
-   Added a section about [sharing iOS and macOS plugin implementations](https://docs.flutter.dev/packages-and-plugins/developing-packages#shared-ios-and-macos-implementations).
-   Added a guide on adapting the Material [alert dialog](https://docs.flutter.dev/platform-integration/platform-adaptations#alert-dialog), [top app bar and navigation bar](https://docs.flutter.dev/platform-integration/platform-adaptations#top-app-bar-and-navigation-bar), and [bottom navigation bar](https://docs.flutter.dev/platform-integration/platform-adaptations#bottom-navigation-bars) widgets to the current platform as a start of UI component platform adaptation guidelines.
-   Introduced the [Anatomy of an app](https://docs.flutter.dev/resources/architectural-overview#anatomy-of-an-app) section in the Architectural overview.
-   Added provenance information per SLSA to all downloads in the [SDK archive page](https://docs.flutter.dev/release/archive). Provenance guarantees that the built artifact comes from the expected source.

### Codelabs

The following codelabs have been published since Flutter 3.7:

-   [Records and Patterns in Dart 3](https://codelabs.developers.google.com/codelabs/dart-patterns-records)  
    Discover Dart 3’s new records and patterns features. Learn how you can use them in a Flutter app to help you write more readable and maintainable Dart code.
-   [Building next generation UIs in Flutter](https://codelabs.developers.google.com/codelabs/flutter-next-gen-uis#0)  
    Learn how to build a Flutter app that uses the power of `flutter_animate`, fragment shaders, and particle fields. You will craft a user interface that evokes those science fiction movies and TV shows we all love watching when we aren’t coding.
-   [Create haikus about Google products with the PaLM API and Flutter](https://codelabs.developers.google.com/haiku-generator)  
    **NEW** Learn how to build an app that uses the PaLM API to generate haikus based on Google product names. The PaLM API gives you access to Google’s state-of-the-art large language models.

Articles\*\*

The Flutter team published the following articles on the [Flutter Medium](https://medium.com/flutter) publication since Flutter 3.7:

-   [Flutter in 2023: strategy and roadmap](https://medium.com/flutter/flutter-in-2023-strategy-and-roadmap-60efc8d8b0c7)
-   [Wonderous nominated for Webby Award](https://medium.com/flutter/wonderous-nominated-for-webby-award-8e00e2a648c2)

## 25 Jan 2023: Flutter Forward: 3.7 release

Flutter 3.7 is live! This release contains many updates and improvements. This page lists the documentation changes, but you can also check out the [3.7 blog post](https://medium.com/flutter/whats-new-in-flutter-3-7-38cbea71133c) and the [3.7 release notes](https://docs.flutter.dev/release/release-notes/release-notes-3.7.0).

You might also check out [What’s next for Flutter](https://medium.com/flutter/whats-next-for-flutter-b94ce089f49c) and [Introducing Dart 3 alpha](https://medium.com/dartlang/dart-3-alpha-f1458fb9d232).

### Docs updated or added since the 3.3 release

-   You can now pass configuration information to the engine in the `initializeEngine` method. For more information, check out [Customizing web app initialization](https://docs.flutter.dev/platform-integration/web/initialization).
-   [Creating Flavors for Flutter](https://docs.flutter.dev/deployment/flavors) Learn how to create a flavor in Flutter (also known as a _build configuration_ in iOS).
-   Internationalization support has been revamped and the [Internationalizing Flutter apps](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization) page is updated.
-   The DevTools memory debugging tool has been completely overhauled and the corresponding page, [Using the memory view](https://docs.flutter.dev/tools/devtools/memory), is rewritten.
-   This release includes numerous improvements to Flutter’s support for custom fragment shaders. For more information, see the new [Writing and using fragment shaders](https://docs.flutter.dev/ui/design/graphics/fragment-shaders) page.
-   Some security tools falsely report security vulnerabilities in Flutter apps. The new [Security false positives](https://docs.flutter.dev/reference/security-false-positives) page lists the known false positives and why you can ignore them.
-   You can now invoke a platform channel from any isolate, including background isolates. For more information, check out [Writing custom platform-specific code](https://docs.flutter.dev/platform-integration/platform-channels) and the [Introducing isolate background channels](https://medium.com/flutter/introducing-background-isolate-channels-7a299609cad8) article on Medium.
-   We’ve updated our Swift documentation. New and updated pages include:
    -   [Flutter for SwiftUI developers](https://docs.flutter.dev/get-started/flutter-for/swiftui-devs) - updated
    -   [Add a Flutter screen to an iOS app](https://docs.flutter.dev/add-to-app/ios/add-flutter-screen) - updated for SwiftUI
    -   [Flutter concurrency for Swift developers](https://docs.flutter.dev/get-started/flutter-for/dart-swift-concurrency) - new
    -   [Learning Dart as a Swift developer](https://dart.dev/guides/language/coming-from/swift-to-dart) on dart.dev - new
-   As of Xcode 14, Apple no longer supports bitcode. Two of our pages, [Adding an iOS clip target](https://docs.flutter.dev/platform-integration/ios/ios-app-clip) and the [Flutter FAQ](https://docs.flutter.dev/resources/faq), are updated to reflect this fact.
-   For developers who enjoy living on the bleeding edge, you might want to try Flutter’s future rendering engine, Impeller. Because Impeller isn’t yet ready for a stable release, you can find more information on our [Flutter GitHub wiki](https://docs.flutter.dev/perf/impeller).

**Codelabs and workshops**

We have new codelabs since the last stable release:

-   [Your first Flutter app](https://codelabs.developers.google.com/codelabs/flutter-codelab-first)  
    Learn about Flutter as you build an application that generates cool-sounding names, such as “newstay”, “lightstream”, “mainbrake”, or “graypine”. The user can ask for the next name, favorite the current one, and review the list of favorited names on a separate page. The final app is responsive to different screen sizes. (Note that this codelab replaces the previous “Write your first Flutter codelab for mobile, part 1 and part 2.”)
-   [Using FFI in a Flutter plugin](https://codelabs.developers.google.com/codelabs/flutter-ffigen)  
    Dart’s FFI (foreign function interface) allows Flutter apps to use of existing native libraries that expose a C API. Dart supports FFI on Android, iOS, Windows, macOS, and Linux.
-   [Building a game with Flutter and Flame](https://codelabs.developers.google.com/codelabs/flutter-flame-game)  
    Learn how to build a platformer game with Flutter and Flame! In the Doodle Dash game, inspired by Doodle Jump, you play as either Dash (the Flutter mascot), or her best friend Sparky (the Firebase mascot), and try to reach as high as possible by jumping on platforms.
-   [Add a user authentication flow to a Flutter app using FirebaseUI](https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps)  
    Learn how to add Firebase Authentication to your Flutter app using the FlutterFire UI package. You’ll add both email/password and Google Sign In authorization to a Flutter app. You’ll also learn how to set up a Firebase project, and use the FlutterFire CLI to initialize Firebase in your Flutter app.
-   [Local development for your Flutter apps using the Firebase Emulator Suite](https://firebase.google.com/codelabs/get-started-firebase-emulators-and-flutter)  
    Learn how to use the Firebase Emulator Suite with Flutter during local development, including how to use email-password authentication with the Emulator Suite, and how to read and write data to the Firestore emulator. Also, you’ll import and export data from the emulators, to work with the same faked data each time you return to development.

In addition, we’ve updated all of our existing codelabs to support multiplatform. The [codelabs & workshops](https://docs.flutter.dev/codelabs) page is updated to reflect the latest available codelabs.

Articles\*\*

We’ve published the following articles on the [Flutter Medium](https://medium.com/flutter) publication since the last stable release:

-   [What’s next for Flutter](https://medium.com/flutter/whats-next-for-flutter-b94ce089f49c)
-   [Adapting Wonderous to larger device formats](https://medium.com/flutter/adapting-wonderous-to-larger-device-formats-ac51e1c00bc0)
-   [What’s new in Flutter 3.7](https://medium.com/flutter/whats-new-in-flutter-3-7-38cbea71133c)
-   [Announcing the Flutter News Toolkit](https://medium.com/flutter/announcing-the-flutter-news-toolkit-180a0d32c012)
-   [How it’s made: Holobooth](https://medium.com/flutter/how-its-made-holobooth-6473f3d018dd)
-   [Playful typography with Flutter](https://medium.com/flutter/playful-typography-with-flutter-f030385058b4)
-   [Material 3 for Flutter](https://medium.com/flutter/material-3-for-flutter-d417a8a65564)
-   [Introducing background isolate channels](https://medium.com/flutter/introducing-background-isolate-channels-7a299609cad8)
-   [How can we improve the Flutter experience for desktop?](https://medium.com/flutter/how-can-we-improve-the-flutter-experience-for-desktop-70b34bff9392)
-   [What we learned from the Flutter Q3 2022 survey](https://medium.com/flutter/what-we-learned-from-the-flutter-q3-2022-survey-9b78803accd2)
-   [Supporting six platforms with two keyboards](https://medium.com/flutter/what-we-learned-from-the-flutter-q3-2022-survey-9b78803accd2)
-   [Studying developer’s usage of IDEs for Flutter development](https://medium.com/flutter/studying-developers-usage-of-ides-for-flutter-development-4c0a648a48)

## 31 Aug 2022: Flutter Vikings: 3.3 release

Flutter 3.3 is live! For more information, see

[What’s new in Flutter 3.3](https://medium.com/flutter/whats-new-in-flutter-3-3-893c7b9af1ff), and [Dart 2.18: Objective-C & Swift interop](https://medium.com/dartlang/dart-2-18-f4b3101f146c) (free articles on Medium), and the [Flutter 3.3 release notes](https://docs.flutter.dev/release/release-notes/release-notes-3.3.0).

### Docs updated or added since the 3.0 release

-   The [navigation and routing overview](https://docs.flutter.dev/ui/navigation) page has been rewritten with more guidance on using `Navigator` and `Router` together, named routes, and using a routing package.
-   The [URL strategies](https://docs.flutter.dev/ui/navigation/url-strategies) page has also been updated to reflect a more streamlined API.
-   For apps not published to the Microsoft Store, you can now set the app’s executable’s file and product versions in the pubspec file. For more information, see [Build and release a Windows desktop app](https://docs.flutter.dev/deployment/windows).
-   If you are developing software for iOS 16 and higher, you must enable [Developer mode](https://developer.apple.com/documentation/xcode/enabling-developer-mode-on-a-device). The [macOS install](https://docs.flutter.dev/get-started/install/macos/mobile-ios#configure-xcode) page is updated with this information.
-   As described in the [3.3 release notes](https://docs.flutter.dev/release/release-notes/release-notes-3.3.0), you should catch all errors and exceptions in your app by setting the `PlatformDispatcher.onError` callback, instead of using a custom `Zone`. The [Handling errors in Flutter](https://docs.flutter.dev/testing/errors) page has been updated with this advice.

## 11 May 2022: Google I/O 2022: Flutter 3 release

Flutter 3 is live!!! For more information, see [Introducing Flutter 3](https://medium.com/flutter/introducing-flutter-3-5eb69151622f), [What’s new in Flutter 3](https://medium.com/flutter/whats-new-in-flutter-3-8c74a5bc32d0), and [Dart 2.17: Productivity and integration](https://medium.com/dartlang/dart-2-17-b216bfc80c5d) (free articles on Medium), and the [Flutter 3 release notes](https://docs.flutter.dev/release/release-notes/release-notes-3.0.0).

### Docs updated or added since the 2.10 release

-   We have launched the Casual Games Toolkit to help you build games with Flutter. Learn more on the [Games page](https://flutter.dev/games) and the [Games doc page](https://docs.flutter.dev/resources/games-toolkit).
-   Are you struggling to level up as a Flutter developer? We have created the Happy paths project to help. Learn more on the Happy paths page. (Note, this program has been discontinued in favor of the [Flutter Favorite Program](https://docs.flutter.dev/packages-and-plugins/favorites).)
-   Are you a web developer who would like more control over your app’s launch process? Check out the new page, [Customizing web app initialization](https://docs.flutter.dev/platform-integration/web/initialization), which has been added to the newly updated and collected web docs under `/platform-integration/web`.
-   Flutter 3 supports Apple Silicon processors. We’ve updated the [macOS install page](https://docs.flutter.dev/get-started/install/macos) to offer an Apple Silicon download button.
-   In Flutter 3, the macOS and Linux platforms have reached stable, in addition to Windows. You can now develop your app to run on any or all of these platforms. As a result, the [Desktop](https://docs.flutter.dev/platform-integration/desktop) (and related) pages are updated.
-   The [Performance best practices](https://docs.flutter.dev/perf/best-practices) page has largely been rewritten and moved to be more visible. The changes include additional advice on avoiding jank, including how to minimize layout passes caused by intrinsics, and techniques to minimize calls to `saveLayer()`.
-   Firebase’s Flutter docs have been overhauled. Check out the newly updated [Flutter Firebase get started guide](https://firebase.google.com/docs/flutter/setup).
-   The [dart.dev](https://dart.dev/) site has its own [what’s new](https://dart.dev/guides/whats-new) page, but one new page of note is the guide, [Learning Dart as a JavaScript developer](https://dart.dev/guides/language/coming-from/js-to-dart). Stay tuned for similar articles on Swift and C#.

**Codelabs and workshops**

We have a new codelab since the last stable release:

-   [Take your Flutter app from boring to beautiful](https://codelabs.developers.google.com/codelabs/flutter-boring-to-beautiful) Learn how to use features in Material 3 to make your more beautiful _and_ more responsive.

Also, check out the workshops written by our GDEs and available on the [Flutter community blog](https://medium.com/@flutter_community/622b52f70173).

**Videos**

Google I/O 2022 is over, but you can still check out the Flutter-specific updates and talks from Google I/O on the [videos](https://docs.flutter.dev/resources/videos) page.

___

## 03 Feb 2022: Windows Support: 2.10 release

Desktop support for Microsoft Windows (a central feature of the 2.10 release) is live! For more information, see [Announcing Flutter for Windows](https://medium.com/flutter/announcing-flutter-for-windows-6979d0d01fed) and [What’s new in Flutter 2.10](https://medium.com/flutter/whats-new-in-flutter-2-10-5aafb0314b12), free articles on Medium.

<iframe width="560" height="315" src="https://www.youtube.com/embed/g-0B_Vfc9qM?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn how Flutter can develop Windows native apps" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy"></iframe>

___

## 08 Dec 2021: 2.8 release

Flutter 2.8 is live! For details, see [Announcing Flutter 2.8](https://medium.com/flutter/announcing-flutter-2-8-31d2cb7e19f5) and [What’s new in Flutter 2.8](https://medium.com/flutter/whats-new-in-flutter-2-8-d085b763d181).

## 08 Sep 2021: 2.5 release

Flutter 2.5 is live! For details, see [What’s new in Flutter 2.5](https://medium.com/flutter/whats-new-in-flutter-2-5-6f080c3f3dc).

We’ve made significant changes to flutter/website repo to make it easier to use and maintain. If you contribute to this repo, see the [README](https://github.com/flutter/website/#flutter-website) file for more information.

### Docs updated or added since the 2.2 release

-   A new page on [Using Actions and Shortcuts](https://docs.flutter.dev/ui/interactivity/actions-and-shortcuts).

### Articles

We’ve published the following articles on the [Flutter Medium](https://medium.com/flutter) publication since the last stable release:

-   [Raster thread performance optimization tips](https://medium.com/flutter/raster-thread-performance-optimization-tips-e949b9dbcf06)
-   [Writing a good code sample](https://medium.com/flutter/writing-a-good-code-sample-323358edd9f3)
-   [GSoC’21: Creating a desktop sample for Flutter](https://medium.com/flutter/gsoc-21-creating-a-desktop-sample-for-flutter-7d77e74812d6)
-   [Flutter Hot Reload](https://medium.com/flutter/flutter-hot-reload-f3c5994e2cee)
-   [What can we do to better improve Flutter?](https://medium.com/flutter/what-can-we-do-better-to-improve-flutter-q2-2021-user-survey-results-1037fb8f057b)
-   [Adding Flutter to your existing iOS and Android codebases](https://medium.com/flutter/adding-flutter-to-your-existing-ios-and-android-codebases-3e2c5a4797c1)
-   [Google I/O Spotlight: Flutter in action at ByteDance](https://medium.com/flutter/google-i-o-spotlight-flutter-in-action-at-bytedance-c22f4b6dc9ef)
-   [Improving Platform Channel Performance in Flutter](https://medium.com/flutter/improving-platform-channel-performance-in-flutter-e5b4e5df04af)

___

## 18 May 2021: Google I/O 2021: 2.2 release

Flutter 2.2 is live! For details, see [Announcing Flutter 2.2](https://medium.com/flutter/announcing-flutter-2-2-at-google-i-o-2021-92f0fcbd7ef9) and [What’s New in Flutter 2.2](https://medium.com/flutter/whats-new-in-flutter-2-2-fd00c65e2039).

We continue migrating code on the website to use null safety, but that work is not yet completed.

### Docs updated or added since the 2.0 release

-   A new page on [Building adaptive apps](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps).
-   A new page describing how to use [Google APIs](https://docs.flutter.dev/data-and-backend/google-apis) with Flutter.
-   A new landing page for [Embedded Support for Flutter](https://docs.flutter.dev/embedded).
-   A new page on setting up and using [Deferred components](https://docs.flutter.dev/perf/deferred-components) on Android.
-   Significant updates to the DevTools [Memory view page](https://docs.flutter.dev/tools/devtools/memory).
-   The [desktop](https://docs.flutter.dev/platform-integration/desktop) page is updated to reflect the progress on desktop support, particularly the new support for Windows UWP.

### Codelabs

New codelabs since the last stable release:

-   [Adding in-app purchases to your Flutter app](https://codelabs.developers.google.com/codelabs/flutter-in-app-purchases)
-   [Build Voice Bots for Android with Dialogflow Essentials & Flutter](https://codelabs.developers.google.com/codelabs/dialogflow-flutter)
-   [Get to know Firebase for Flutter](https://firebase.google.com/codelabs/firebase-get-to-know-flutter#0)

### Workshops

For Google I/O 2021, we have added a new Flutter/Dart learning tool that is based on DartPad: **Workshops!** These workshops are designed to be instructor led. The instructor-led videos are available on the Flutter and Firebase YouTube channels:

-   [Building your first Flutter app](https://www.youtube.com/watch?v=Z6KZ3cTGBWw)
-   [Firebase for Flutter](https://www.youtube.com/watch?v=4wunbF29Kkg)
-   [Flutter and Dialogflow voice bots](https://www.youtube.com/watch?v=O7JfSF3CJ84)
-   [Inherited widgets](https://www.youtube.com/watch?v=LFcGPS6cGrY)
-   [Null safety](https://www.youtube.com/watch?v=HdKwuHQvArY)
-   [Slivers](https://www.youtube.com/watch?v=YY-_yrZdjGc)

To see the event list of “all things Flutter” at I/O, see the [Google 2021 I/O Flutter](https://events.google.com/io/program/content?4=topic_flutter) page.

You can author your own DartPad workshops! If you are interested, check out the following resources:

-   [DartPad Workshop Authoring Guide](https://github.com/dart-lang/dart-pad/wiki/Workshop-Authoring-Guide)
-   [DartPad Sharing Guide (using a Gist file)](https://github.com/dart-lang/dart-pad/wiki/Sharing-Guide)
-   [Embedding DartPad in your web page](https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide)

Articles\*\*

We’ve published the following articles on the [Flutter Medium](https://medium.com/flutter) publication since the last stable release:

-   [How It’s Made: I/O Photo Booth](https://medium.com/flutter/how-its-made-i-o-photo-booth-3b8355d35883)
-   [Which factors affected users’ decisions to adopt Flutter? - Q1 2021 user survey results](https://medium.com/flutter/which-factors-affected-users-decisions-to-adopt-flutter-q1-2021-user-survey-results-563e61fc68c9)

___

## 03 Mar 2021: Flutter Engage: 2.0 release

Flutter 2 is live!!! For more information, see [Announcing Flutter 2](https://developers.googleblog.com/2021/03/announcing-flutter-2.html), [What’s new in Flutter 2](https://medium.com/flutter/whats-new-in-flutter-2-0-fe8e95ecc65), [Flutter web support hits the stable milestone](https://medium.com/flutter/flutter-web-support-hits-the-stable-milestone-d6b84e83b425), [Announcing Dart 2.12](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87), and the [Flutter 2 release notes](https://docs.flutter.dev/release/release-notes/release-notes-2.0.0).

### Docs updated or added since the 1.22 release

-   A new [Who is Dash?](https://docs.flutter.dev/dash) page!
-   Information about monetizing your apps has been collected in the new [Flutter Ads](https://flutter.dev/monetization) landing page.
-   Added a new page explaining the [Flutter Fix](https://docs.flutter.dev/tools/flutter-fix) feature and how to use it.
-   New and updated web pages, including:
    -   [Web support for Flutter](https://docs.flutter.dev/platform-integration/web)
    -   [Configuring the URL strategy on the web](https://docs.flutter.dev/ui/navigation/url-strategies)
    -   [Web FAQ](https://docs.flutter.dev/platform-integration/web/faq)
-   The [Desktop support for Flutter](https://docs.flutter.dev/platform-integration/desktop) page is updated, as well as other pages on the site that discuss desktop support.
-   The [DevTools](https://docs.flutter.dev/tools/devtools/overview) docs have been updated. The most significant updates are to the following page:
    -   [Flutter inspector](https://docs.flutter.dev/tools/devtools/inspector)
-   Added a page on how to [implement deep linking](https://docs.flutter.dev/ui/navigation/deep-linking) for mobile and web.
-   Updated the [Creating responsive and adaptive apps](https://docs.flutter.dev/ui/layout/responsive/adaptive-responsive) page.
-   Many pages (including all codelabs on flutter.dev) and examples are updated to be null safe.
-   Added two new add to app pages:
    -   [Using multiple Flutter instances](https://docs.flutter.dev/add-to-app/multiple-flutters)
    -   [Adding a Flutter view to an Android app](https://docs.flutter.dev/add-to-app/android/add-flutter-view)
-   Added a page on how to [write integration tests using the integration\_test package](https://docs.flutter.dev/testing/integration-tests).
-   Significant updates to the [internationalization](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization) page.
-   New and updated [performance](https://docs.flutter.dev/perf) pages, including:
    -   [Performance metrics](https://docs.flutter.dev/perf/metrics)
    -   [Performance faq](https://docs.flutter.dev/perf/faq)
    -   [More thoughts about performance](https://docs.flutter.dev/perf/appendix)

### Codelabs

Many of our codelabs have been updated to null safety. We’ve also added a new codelab since the last stable release:

-   [Adding AdMob banner and native inline ads to a Flutter app](https://codelabs.developers.google.com/codelabs/admob-inline-ads-in-flutter)

For a complete list, see [Flutter codelabs](https://docs.flutter.dev/codelabs).

Articles\*\*

We’ve published the following articles on the [Flutter Medium](https://medium.com/flutter) publication since the last stable release:

-   [Flutter performance updates in the first half of 2020](https://medium.com/flutter/flutter-performance-updates-in-the-first-half-of-2020-5c597168b6bb)
-   [Are you happy with Flutter? - Q4 2020 user survey results](https://medium.com/flutter/are-you-happy-with-flutter-q4-2020-user-survey-results-41cdd90aaa48)
-   [Join us for #30DaysOfFlutter](https://medium.com/flutter/join-us-for-30daysofflutter-9993e3ec847b)
-   [Providing operating system compatibility on a large scale](https://medium.com/flutter/providing-operating-system-compatibility-on-a-large-scale-374cc2fb0dad)
-   [Updates on Flutter Testing](https://medium.com/flutter/updates-on-flutter-testing-f54aa9f74c7e)
-   [Announcing Dart null safety beta](https://medium.com/flutter/announcing-dart-null-safety-beta-4491da22077a)
-   [Deprecation Lifetime in Flutter](https://medium.com/flutter/deprecation-lifetime-in-flutter-e4d76ee738ad)
-   [New ad formats for Flutter](https://medium.com/flutter/new-ads-beta-inline-banner-and-native-support-for-the-flutter-mobile-ads-plugin-e48a7e9a0e64)
-   [Accessible expression with Material Icons and Flutter](https://medium.com/flutter/accessible-expression-with-material-icons-and-flutter-e3f3f622200b)
-   [Dart sound null safety: technical preview 2](https://medium.com/flutter/null-safety-flutter-tech-preview-cb5c98aba187)
-   [Flutter on the web, slivers, and platform-specific issues: user survey results from Q3 2020](https://medium.com/flutter/flutter-on-the-web-slivers-and-platform-specific-issues-user-survey-results-from-q3-2020-f8034236b2a8)
-   [Testable Flutter and Cloud Firestore](https://medium.com/flutter/flutter/testable-flutter-and-cloud-firestore-1cf2fbbce97b)
-   [Performance testing on the web](https://medium.com/flutter/performance-testing-on-the-web-25323252de69)

___

## 01 Oct 2020: 1.22 release

Flutter 1.22 is live! For details, see [Announcing Flutter 1.22](https://medium.com/flutter/announcing-flutter-1-22-44f146009e5f).

### Docs updated or added to flutter.dev since the 1.20 release

-   Updated the [Developing for iOS 14](https://docs.flutter.dev/platform-integration/ios/ios-debugging) page with details about targeting iOS 14 with Flutter, including some Add-to-App, deep linking, and notification considerations.
-   Added a page on how to [add an iOS App Clip](https://docs.flutter.dev/platform-integration/ios/ios-app-clip), a new iOS 14 feature that supports running lightweight, no-install apps under 10 MB.
-   Added a page that describes how to [migrate your app to use the new icon glyphs available in `CupertinoIcons`](https://docs.flutter.dev/release/breaking-changes/cupertino-icons-1.0.0).
-   Added a page that describes the new implementation for Platform Views and how to use them to host native [Android views](https://docs.flutter.dev/platform-integration/android/platform-views) and [iOS views](https://docs.flutter.dev/platform-integration/ios/platform-views) in your Flutter app platform-views. This feature has enabled the [google\_maps\_flutter](https://pub.dev/packages/google_maps_flutter) and [webview\_flutter](https://pub.dev/packages/webview_flutter) plugins to be updated to production-ready release 1.0.
-   Added a page that describes how to use the new [App Size tool](https://docs.flutter.dev/tools/devtools/app-size) in Dart DevTools.

### Codelabs

We’ve added a new codelab since the last stable release:

-   [Building Beautiful Transitions with Material Motion for Flutter](https://codelabs.developers.google.com/codelabs/material-motion-flutter)  
    Learn how to use the Material [animations](https://pub.dev/packages/animations) package to add prebuilt transitions to a Material app called Reply.

For a complete list, see [Flutter codelabs](https://docs.flutter.dev/codelabs).

Articles\*\*

We’ve published the following articles on the [Flutter Medium](https://medium.com/flutter) publication since the last stable release:

-   [Learning Flutter’s new navigation and routing](https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade)
-   [Integration testing with flutter\_driver](https://medium.com/flutter/integration-testing-with-flutter-driver-36f66ede5cf2)
-   [Announcing Flutter Windows Alpha](https://medium.com/flutter/announcing-flutter-windows-alpha-33982cd0f433)
-   [Handling web gestures in Flutter](https://medium.com/flutter/handling-web-gestures-in-flutter-e16946a04745)
-   [Supporting iOS 14 and Xcode 12 with Flutter](https://medium.com/flutter/supporting-ios-14-and-xcode-12-with-flutter-15fe0062e98b)
-   [Learn testing with the new Flutter sample](https://medium.com/flutter/learn-testing-with-the-new-flutter-sample-gsoc20-work-product-e872c7f6492a)
-   [Platform channel examples](https://medium.com/flutter/platform-channel-examples-7edeaeba4a66)
-   [Updates on Flutter and Firebase](https://medium.com/flutter/updates-on-flutter-and-firebase-8076f70bc90e)

## 05 Aug 2020: 1.20 release

Flutter 1.20 is live! For details, see [Announcing Flutter 1.20](https://medium.com/flutter/announcing-flutter-1-20-2aaf68c89c75).

### Docs updated or added to flutter.dev

-   [Flutter architectural overview](https://docs.flutter.dev/resources/architectural-overview), a deep dive into Flutter’s architecture, was added to the site just a few days after the 1.20 release.
-   [Reducing shader compilation jank on mobile](https://docs.flutter.dev/perf/shader) is added to the performance docs.
-   [Developing for iOS 14 beta](https://docs.flutter.dev/platform-integration/ios/ios-debugging) outlines some issues you might run into if developing for devices running iOS 14 beta.
-   New instructions for [installing Flutter on Linux using snapd.](https://docs.flutter.dev/get-started/install/linux)
-   Updated the [Desktop support](https://docs.flutter.dev/platform-integration/desktop) page to reflect that Linux desktop apps (as well as macOS) are available as alpha.
-   Several new Flutter books have been published. The [Flutter books](https://docs.flutter.dev/resources/books) page is updated.
-   The [codelabs landing](https://docs.flutter.dev/codelabs) page has been updated.

A deep dive into null safety has been added to dart.dev:

-   [Understanding null safety](https://dart.dev/null-safety/understanding-null-safety)

### Codelabs

[Flutter Day](https://events.withgoogle.com/flutter-day/) was held on 6/25/2020. In preparation for the event, we wrote new codelabs and updated existing codelabs. New codelabs include:

-   [Adding Admob Ads to a Flutter app](https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter/)
-   [How to write a Flutter plugin](https://codelabs.developers.google.com/codelabs/write-flutter-plugin)
-   [Multi-platform Firestore Flutter](https://codelabs.developers.google.com/codelabs/friendlyeats-flutter/)
-   [Using a plugin with a Flutter web app](https://codelabs.developers.google.com/codelabs/web-url-launcher/)
-   [Write a Flutter desktop application](https://codelabs.developers.google.com/codelabs/flutter-github-graphql-client/)

For a complete list, see [Flutter codelabs](https://docs.flutter.dev/codelabs).

Articles\*\*

We’ve published the following articles on the [Flutter Medium](https://medium.com/flutter) publication since the last stable release:

-   [Announcing Adobe XD support for Flutter](https://medium.com/flutter/announcing-adobe-xd-support-for-flutter-4b3dd55ff40e)
-   [What are the important & difficult tasks for Flutter devs? - Q1 2020 survey results](https://medium.com/flutter/what-are-the-important-difficult-tasks-for-flutter-devs-q1-2020-survey-results-a5ef2305429b)
-   [Optimizing performance in Flutter web apps with tree shaking and deferred loading](https://medium.com/flutter/optimizing-performance-in-flutter-web-apps-with-tree-shaking-and-deferred-loading-535fbe3cd674)
-   [Flutter Package Ecosystem Update](https://medium.com/flutter/flutter-package-ecosystem-update-d50645f2d7bc)
-   [Improving perceived performance with image placeholders, precaching, and disabled navigation transitions](https://medium.com/flutter/improving-perceived-performance-with-image-placeholders-precaching-and-disabled-navigation-6b3601087a2b)
-   [Two Months of #FlutterGoodNewsWednesday](https://medium.com/flutter/two-months-of-fluttergoodnewswednesday-a12e60bab782)
-   [Handling 404: Page not found error in Flutter](https://medium.com/flutter/handling-404-page-not-found-error-in-flutter-731f5a9fba29)
-   [Flutter and Desktop apps](https://medium.com/flutter/flutter-and-desktop-3a0dd0f8353e)
-   [What’s new with the Slider widget?](https://medium.com/flutter/whats-new-with-the-slider-widget-ce48a22611a3)
-   [New tools for Flutter developers, built in Flutter](https://medium.com/flutter/new-tools-for-flutter-developers-built-in-flutter-a122cb4eec86)
-   [Canonical enables Linux desktop app support with Flutter](https://medium.com/flutter/announcing-flutter-linux-alpha-with-canonical-19eb824590a9)
-   [Enums with Extensions in Dart](https://medium.com/flutter/enums-with-extensions-dart-460c42ea51f7)
-   [Managing issues in a large-scale open source project](https://medium.com/flutter/managing-issues-in-a-large-scale-open-source-project-b3be6eecae2b)
-   [What we learned from the Flutter Q2 2020 survey](https://medium.com/flutter/what-we-learned-from-the-flutter-q2-2020-survey-a4f1fc8faac9)
-   [Building performant Flutter widgets](https://medium.com/flutter/building-performant-flutter-widgets-3b2558aa08fa)
-   [How to debug layout issues with the Flutter Inspector](https://medium.com/flutter/how-to-debug-layout-issues-with-the-flutter-inspector-87460a7b9db)
-   [Going deeper with Flutter’s web support](https://medium.com/flutter/going-deeper-with-flutters-web-support-66d7ad95eb52)
-   [Flutter Performance Updates in 2019](https://medium.com/flutter/going-deeper-with-flutters-web-support-66d7ad95eb5224)

## 06 May 2020: Work-From-Home: 1.17 release

Flutter 1.17 is live!

For more information, see [Announcing Flutter 1.17](https://medium.com/flutter/announcing-flutter-1-17-4182d8af7f8e).

Docs added and updated since the last announcement include:

-   Added a new page on [Understanding constraints](https://docs.flutter.dev/ui/layout/constraints), contributed by Marcelo Glasberg, a Flutter community member.
-   The [animations landing page](https://docs.flutter.dev/ui/animations) has been re-written. This page now includes the animation decision tree that helps you figure out which animation approach is right for your needs. It also includes information on the new [package for pre-canned Material widget animations](https://pub.dev/packages/animations).
-   The [hot reload](https://docs.flutter.dev/tools/hot-reload) page has been re-written. We hope you find it to be clearer!
-   The [Desktop](https://docs.flutter.dev/platform-integration/desktop) page has been updated and now includes information on setting up entitlements and using the App Sandbox on macOS.
-   The plugin docs are updated to cover the new Android Plugin APIs and also to describe Federated Plugins. Affected pages include:
    -   [Developing packages and plugins](https://docs.flutter.dev/packages-and-plugins/developing-packages)
    -   [Developing plugin packages](https://docs.flutter.dev/packages-and-plugins/developing-packages#federated-plugins)
    -   [Supporting the new Android plugin APIs](https://docs.flutter.dev/release/breaking-changes/plugin-api-migration)
    -   [Writing custom platform-specific code](https://docs.flutter.dev/platform-integration/platform-channels)
-   Added an [Obfuscating Dart code](https://docs.flutter.dev/deployment/obfuscate) page. (Moved from the wiki and updated as of 1.16.2.)
-   Added a page on using Xcode 11.4 and how to manually update your project. The tooling, which automatically updates your configuration when possible, might direct you to this page if it detects that it’s needed.
-   Added a page on [Managing plugins and dependencies in add-to-app](https://docs.flutter.dev/add-to-app/android/plugin-setup) when developing for Android.

Other newness:

-   We’ve published a number of articles on the [Flutter Medium](https://medium.com/flutter) publication since the last stable release:
    -   [Custom implicit animations in Flutter…with TweenAnimationBuilder](https://medium.com/flutter/custom-implicit-animations-in-flutter-with-tweenanimationbuilder-c76540b47185)
    -   [Directional animations with build-in explicit animations](https://medium.com/flutter/directional-animations-with-built-in-explicit-animations-3e7c5e6fbbd7)
    -   [When should I use AnimatedBuilder or AnimatedWidget?](https://medium.com/flutter/when-should-i-useanimatedbuilder-or-animatedwidget-57ecae0959e8)
    -   [Improving Flutter with your opinion - Q4 2019 survey results](https://medium.com/flutter/improving-flutter-with-your-opinion-q4-2019-survey-results-ba0e6721bf23)
    -   [How to write a Flutter web plugin, Part 2](https://medium.com/flutter/how-to-write-a-flutter-web-plugin-part-2-afdddb69ece6)
    -   [It’s Time: The Flutter Clock contest results](https://medium.com/flutter/its-time-the-flutter-clock-contest-results-dcebe2eb3957)
    -   [How to float an overlay widget over a (possibly transformed) UI widget](https://medium.com/flutter/how-to-float-an-overlay-widget-over-a-possibly-transformed-ui-widget-1d15ca7667b6)
    -   [How to embed a Flutter application in a website using DartPad](https://medium.com/flutter/how-to-embed-a-flutter-application-in-a-website-using-dartpad-b8fd0ee8c4b9)
    -   [Flutter web: Navigating URLs using named routes](https://medium.com/flutter/web-navigating-urls-using-named-routes-307e1b1e2050)
    -   [How to choose which Flutter animation widget is right for you?](https://medium.com/flutter/how-to-choose-which-flutter-animation-widget-is-right-for-you-79ecfb7e72b5)
    -   [Announcing a free Flutter introductory course](https://medium.com/flutter/learn-flutter-for-free-c9bc3b898c4d)
    -   [Announcing CodePen support for Flutter](https://medium.com/flutter/announcing-codepen-support-for-flutter-bb346406fe50)
    -   [Animation deep dive](https://medium.com/flutter/animation-deep-dive-39d3ffea111f)
    -   [Flutter Spring 2020 update](https://medium.com/flutter/spring-2020-update-f723d898d7af)
    -   [Introducing Google Fonts for Flutter v 1.0.0!](https://medium.com/flutter/introducing-google-fonts-for-flutter-v-1-0-0-c0e993617118)
    -   [Flutter web support updates](https://medium.com/flutter/web-support-updates-8b14bfe6a908)
    -   [Modern Flutter plugin development](https://medium.com/flutter/modern-flutter-plugin-development-4c3ee015cf5a)

## 11 Dec 2019: Flutter Interact: 1.12 release

Flutter 1.12 is live!

For more information, see [Flutter: the first UI platform designed for ambient computing](https://developers.googleblog.com/2019/12/flutter-ui-ambient-computing.html?m=1), [Announcing Flutter 1.12: What a year!](https://medium.com/flutter/announcing-flutter-1-12-what-a-year-22c256ba525d) and the [Flutter 1.12.13](https://docs.flutter.dev/release/release-notes/release-notes-1.12.13) release notes.

Docs added and updated since the last announcement include:

-   To accompany an updated implementation of add-to-app, we have added documentation on how to [add Flutter to an existing app](https://docs.flutter.dev/add-to-app) for both iOS and Android.
-   If you own plugin code, we encourage you to update to the new plugin APIs for Android. For more information, see [Migrating your plugin to the new Android APIs](https://docs.flutter.dev/release/breaking-changes/plugin-api-migration).
-   Web support has moved to the beta channel. For more information, see [Web support for Flutter](https://docs.flutter.dev/platform-integration/web) and [Web support for Flutter goes beta](https://medium.com/flutter/web-support-for-flutter-goes-beta-35b64a1217c0) on the Medium publication. Also, the [building a web app with Flutter](https://docs.flutter.dev/platform-integration/web/building) page is updated.
-   A new [write your first Flutter app on the web](https://docs.flutter.dev/get-started/codelab-web) codelab is added to the [Get started](https://docs.flutter.dev/get-started/install) docs, and includes instructions on setting breakpoints in DevTools!
-   We’ve introduced a program for recommending particular Dart and Flutter plugins and packages. Learn more about the [Flutter Favorite program](https://docs.flutter.dev/packages-and-plugins/favorites).
-   A new [implicit animations](https://docs.flutter.dev/codelabs/implicit-animations) codelab is available featuring DartPad. (To run it, you don’t need to download any software!)
-   Alpha support for MacOS (desktop) is now available in release 1.13 on the master and dev channels. For more information, see [Desktop support for Flutter](https://docs.flutter.dev/platform-integration/desktop).
-   The iOS section of the [app size](https://docs.flutter.dev/perf/app-size#ios) page is updated to reflect the inclusion of bitcode.
-   An alpha release of Flutter Layout Explorer, a new feature (and part of the Flutter inspector) that allows you to explore a visual representation of your layout is available. For more information, see the [Flutter Layout Explorer](https://docs.flutter.dev/tools/devtools/inspector#flutter-layout-explorer) docs.

Other newness:

-   A brand new version of [Flutter Gallery](https://flutter.github.io/samples/#/). There’s a link to the runnable sample in the side nav under **Samples & Tutorials**.

Happy Fluttering!

## 10 Sep 2019: 1.9 release

Flutter 1.9 is live!

For more information, see [Flutter news from GDD China: uniting Flutter on web and mobile, and introducing Flutter 1.9](https://developers.googleblog.com/2019/09/flutter-news-from-gdd-china-flutter1.9.html?m=1) and the [1.9.1 release notes](https://docs.flutter.dev/release/release-notes/release-notes-1.9.1).

For the 1.9 release, Flutter’s web support has been merged (“unforked”) into the main repo. **Web support hasn’t reached beta, and is not ready to be used in production.** Web and desktop support (which is also coming), will impact the website, which was originally written exclusively for developing Flutter mobile apps. Some website updates are available now (and listed below), but more will be coming.

New and updated docs on the site include:

-   We’ve revamped the [Showcase](https://flutter.dev/showcase) page.
-   The Flutter layout codelab has been rewritten and uses the updated DartPad, the browser-based tool for running Dart code. DartPad now supports Flutter! [Try it out](https://dartpad.dev/) and let us know what you think.
-   A new page on [using the dart:ffi library](https://docs.flutter.dev/platform-integration/android/c-interop) to bind your app to native code (a feature currently under development).
-   The Performance view tool, which allows you to record and profile a session from your Dart/Flutter application, has been enabled in DevTools. For more information, see the [Performance view](https://docs.flutter.dev/tools/devtools/performance) page.
-   A new page on [building a web application](https://docs.flutter.dev/platform-integration/web/building).
-   A new page on [creating responsive apps](https://docs.flutter.dev/ui/layout/responsive/adaptive-responsive) in Flutter.
-   A new page on [preparing a web app for release](https://docs.flutter.dev/deployment/web).
-   A new [web FAQ](https://docs.flutter.dev/platform-integration/web/faq).
-   The [Flutter for web](https://docs.flutter.dev/platform-integration/web) page is updated.

Other relevant docs:

-   Error messages have been improved in SDK 1.9. For more information, read [Improving Flutter’s Error Messages](https://medium.com/flutter/improving-flutters-error-messages-e098513cecf9) on the [Flutter Medium publication](https://medium.com/flutter).
-   If you already have a web app that depends on the flutter\_web package, the following instructions tell you how to migrate to the flutter package: [Upgrading from package:flutter\_web to the Flutter SDK](https://github.com/flutter/flutter/wiki/Upgrading-from-package:flutter_web-to-the-Flutter-SDK).
-   A new [`ToggleButtons`](https://api.flutter.dev/flutter/material/ToggleButtons-class.html) widget, described in the API docs. [ToggleButtons demo](https://github.com/csells/flutter_toggle_buttons)
-   A new [`ColorFiltered`](https://api.flutter.dev/flutter/widgets/ColorFiltered-class.html) widget, also described in the API docs. [ColorFiltered demo](https://github.com/csells/flutter_color_filter)
-   New behavior for the [`SelectableText`](https://api.flutter.dev/flutter/material/SelectableText-class.html) widget.

Happy Fluttering!

## 09 Jul 2019: 1.7 release

Flutter 1.7 is live!

For more information, see [Announcing Flutter 1.7](https://medium.com/flutter/announcing-flutter-1-7-9cab4f34eacf) on the [Flutter Medium Publication](https://medium.com/flutter), and the [1.7.8 release notes](https://docs.flutter.dev/release/release-notes/release-notes-1.7.8).

New and updated docs on the site include:

-   The [Preparing an Android app for release](https://docs.flutter.dev/deployment/android) page is updated to discuss how to build an Android release using an app bundle, as well as how to create separate APK files for both 32-bit and 64-bit devices.
-   The [DevTools](https://docs.flutter.dev/tools/devtools/overview) docs are migrated to flutter.dev. If you haven’t tried this browser-based suite of debugging, performance, memory, and inspection tools that work with both Flutter and Dart apps and can be launched from Android Studio/IntelliJ _and_ VS Code, please check it out!
-   The [Simple app state management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple) page is updated. The example code in the page now uses the 3.0 release of the Provider package.
-   A new animation recipe, [Animate a page route transition](https://docs.flutter.dev/cookbook/animation/page-route-animation) has been added to the [Cookbook](https://docs.flutter.dev/cookbook).
-   The [Debugging](https://docs.flutter.dev/testing/debugging), [Flutter’s build modes](https://docs.flutter.dev/testing/build-modes), [Performance best practices](https://docs.flutter.dev/perf/best-practices), and [Performance profiling](https://docs.flutter.dev/perf/ui-performance) pages are updated to reflect DevTools. A [Debugging apps programmatically](https://docs.flutter.dev/testing/code-debugging) page has also been added.

The Flutter 1.7 release includes the new [`RangeSlider`](https://api.flutter.dev/flutter/material/RangeSlider-class.html) component, which allows the user to select both the upper and lower endpoints in a range of values. For information about this component and how to customize it, see [Material RangeSlider in Flutter](https://medium.com/flutter/material-range-slider-in-flutter-a285c6e3447d).

## 07 May 2019: Google I/O 2019: 1.5 release

[Flutter 1.5](https://developers.googleblog.com/2019/05/Flutter-io19.html) is live!

For more information on updates, see the [1.5.4 release notes](https://docs.flutter.dev/release/release-notes/release-notes-1.5.4) or [download the release](https://docs.flutter.dev/release/archive).

We are updating DartPad to work with Flutter. Try the new Basic Flutter layout codelab and tell us what you think!

## 26 Feb 2019: 1.2 release

Flutter released [version 1.2](https://developers.googleblog.com/2019/02/launching-flutter-12-at-mobile-world.html) at Mobile World Congress (MWC) in Barcelona. For more information, see the [1.2.1 release notes](https://docs.flutter.dev/release/release-notes/release-notes-1.2.1) or [download the release](https://docs.flutter.dev/release/archive).

In addition, here are some recent new and updated docs:

-   We’ve updated our [state management advice](https://docs.flutter.dev/data-and-backend/state-mgmt/intro). New pages include an [introduction](https://docs.flutter.dev/data-and-backend/state-mgmt/intro), [thinking declaratively](https://docs.flutter.dev/data-and-backend/state-mgmt/declarative), [ephemeral vs app state](https://docs.flutter.dev/data-and-backend/state-mgmt/ephemeral-vs-app), [simple app state management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple), and [different state management options](https://docs.flutter.dev/data-and-backend/state-mgmt/options). Documenting state management is a tricky thing, as there is no one-size-fits-all approach. We’d love your feedback on these new docs!
-   A new page on [Performance best practices](https://docs.flutter.dev/perf/best-practices).
-   Also at MWC, we announced a preview version of the new Dart DevTools for profiling and debugging Dart and Flutter apps. You can find the docs on the DevTools wiki (Note: since moved to [this site](https://docs.flutter.dev/tools/devtools).) In particular, check out the DevTool’s [widget inspector](https://docs.flutter.dev/tools/devtools/inspector) for debugging your UI, or the [timeline view](https://docs.flutter.dev/tools/devtools/performance) for profiling your Flutter application. Try them out and let us know what you think!
-   An update to the [Performance profiling](https://docs.flutter.dev/perf/ui-performance) page that incorporates the new Dart DevTools UI.
-   Updates to the [Android Studio/IntelliJ](https://docs.flutter.dev/tools/android-studio) and [VS Code](https://docs.flutter.dev/tools/vs-code) pages incorporating info from the new Dart DevTools UI.

If you have questions or comments about any of these docs, [file an issue](https://github.com/flutter/website/issues).

## 05 Nov 2018: new website

Welcome to the revamped Flutter website!

We’ve spent the last few months redesigning the website and how its information is organized. We hope you can more easily find the docs you are looking for. Some of the changes to the website include:

-   Revised [front](https://docs.flutter.dev/) page
-   Revised [showcase](https://flutter.dev/showcase) page
-   Revised [community](https://flutter.dev/community) page
-   Revised navigation in the left side bar
-   Table of contents on the right side of most pages

Some of the new content includes:

-   Deep dive on Flutter internals, [Inside Flutter](https://docs.flutter.dev/resources/inside-flutter)
-   [Technical videos](https://docs.flutter.dev/resources/videos)
-   [State management](https://docs.flutter.dev/data-and-backend/state-mgmt)
-   [Background Dart processes](https://docs.flutter.dev/packages-and-plugins/background-processes)
-   [Flutter’s build modes](https://docs.flutter.dev/testing/build-modes)

If you have questions or comments about the revamped site, [file an issue](https://github.com/flutter/website/issues).