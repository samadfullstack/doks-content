1.  [UI](https://docs.flutter.dev/ui)
2.  [a11y & i18n](https://docs.flutter.dev/ui/accessibility-and-internationalization)
3.  [Accessibility](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility)

Ensuring apps are accessible to a broad range of users is an essential part of building a high-quality app. Applications that are poorly designed create barriers to people of all ages. The [UN Convention on the Rights of Persons with Disabilities](https://www.un.org/development/desa/disabilities/convention-on-the-rights-of-persons-with-disabilities/article-9-accessibility.html) states the moral and legal imperative to ensure universal access to information systems; countries around the world enforce accessibility as a requirement; and companies recognize the business advantages of maximizing access to their services.

We strongly encourage you to include an accessibility checklist as a key criteria before shipping your app. Flutter is committed to supporting developers in making their apps more accessible, and includes first-class framework support for accessibility in addition to that provided by the underlying operating system, including:

[**Large fonts**](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#large-fonts)

Render text widgets with user-specified font sizes

[**Screen readers**](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#screen-readers)

Communicate spoken feedback about UI contents

[**Sufficient contrast**](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#sufficient-contrast)

Render widgets with colors that have sufficient contrast

Details of these features are discussed below.

## Inspecting accessibility support

In addition to testing for these specific topics, we recommend using automated accessibility scanners:

-   For Android:
    1.  Install the [Accessibility Scanner](https://play.google.com/store/apps/details?id=com.google.android.apps.accessibility.auditor&hl=en) for Android
    2.  Enable the Accessibility Scanner from **Android Settings > Accessibility > Accessibility Scanner > On**
    3.  Navigate to the Accessibility Scanner ‘checkbox’ icon button to initiate a scan
-   For iOS:
    1.  Open the `iOS` folder of your Flutter app in Xcode
    2.  Select a Simulator as the target, and click **Run** button
    3.  In Xcode, select **Xcode > Open Developer Tools > Accessibility Inspector**
    4.  In the Accessibility Inspector, select **Inspection > Enable Point to Inspect**, and then select the various user interface elements in running Flutter app to inspect their accessibility attributes
    5.  In the Accessibility Inspector, select **Audit** in the toolbar, and then select **Run Audit** to get a report of potential issues
-   For web:
    1.  Open Chrome DevTools (or similar tools in other browsers)
    2.  Inspect the HTML tree containing the ARIA attributes generated by Flutter.
    3.  In Chrome, the “Elements” tab has a “Accessibility” sub-tab that can be used to inspect the data exported to semantics tree

## Large fonts

Both Android and iOS contain system settings to configure the desired font sizes used by apps. Flutter text widgets respect this OS setting when determining font sizes.

Font sizes are calculated automatically by Flutter based on the OS setting. However, as a developer you should make sure your layout has enough room to render all its contents when the font sizes are increased. For example, you can test all parts of your app on a small-screen device configured to use the largest font setting.

### Example

The following two screenshots show the standard Flutter app template rendered with the default iOS font setting, and with the largest font setting selected in iOS accessibility settings.

![Default font setting](https://docs.flutter.dev/assets/images/docs/a18n/app-regular-fonts.png)

Default font setting

![Largest accessibility font setting](https://docs.flutter.dev/assets/images/docs/a18n/app-large-fonts.png)

Largest accessibility font setting

## Screen readers

For mobile, screen readers ([TalkBack](https://support.google.com/accessibility/android/answer/6283677?hl=en), [VoiceOver](https://www.apple.com/lae/accessibility/iphone/vision/)) enable visually impaired users to get spoken feedback about the contents of the screen and interact with the UI by using gestures on mobile and keyboard shortcuts on desktop. Turn on VoiceOver or TalkBack on your mobile device and navigate around your app.

**To turn on the screen reader on your device, complete the following steps:**

-   [TalkBack on Android](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#talkback)
-   [VoiceOver on iPhone](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#voiceover)
-   [Browsers](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#browsers)
-   [Desktop](https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility#desktop)

1.  On your device, open **Settings**.
2.  Select **Accessibility** and then **TalkBack**.
3.  Turn ‘Use TalkBack’ on or off.
4.  Select Ok.

To learn how to find and customize Android’s accessibility features, view the following video.

<iframe width="560" height="315" src="https://www.youtube.com/embed/FQyj_XTl01w?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Customize your accessibility features" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" id="133400461" data-gtm-yt-inspected-9257802_51="true" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

Check out the following [video demo](https://www.youtube.com/watch?v=A6Sx0lBP8PI) to see Victor Tsaran, who leads the Accessibility program for Material Design, using VoiceOver with the Flutter Gallery web app.

Flutter’s standard widgets generate an accessibility tree automatically. However, if your app needs something different, it can be customized using the [`Semantics` widget](https://api.flutter.dev/flutter/widgets/Semantics-class.html).

When there is text in your app that should be voiced with a specific voice, inform the screen reader which voice to use by calling [`TextSpan.locale`](https://api.flutter.dev/flutter/painting/TextSpan/locale.html). Note that `MaterialApp.locale` and `Localizations.override` don’t affect which voice the screen reader uses. Usually, the screen reader uses the system voice except where you explicitly set it with `TextSpan.locale`.

## Sufficient contrast

Sufficient color contrast makes text and images easier to read. Along with benefitting users with various visual impairments, sufficient color contrast helps all users when viewing an interface on devices in extreme lighting conditions, such as when exposed to direct sunlight or on a display with low brightness.

The [W3C recommends](https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html):

-   At least 4.5:1 for small text (below 18 point regular or 14 point bold)
-   At least 3.0:1 for large text (18 point and above regular or 14 point and above bold)

## Building with accessibility in mind

Ensuring your app can be used by everyone means building accessibility into it from the start. For some apps, that’s easier said than done. In the video below, two of our engineers take a mobile app from a dire accessibility state to one that takes advantage of Flutter’s built-in widgets to offer a dramatically more accessible experience.

<iframe width="560" height="315" src="https://www.youtube.com/embed/bWbBgbmAdQs?enablejsapi=1&amp;origin=https%3A%2F%2Fdocs.flutter.dev" title="Learn about building Flutter apps with Accessibility in mind" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen="" loading="lazy" data-gtm-yt-inspected-5="true" data-gtm-yt-inspected-9257802_51="true" id="305800716" data-gtm-yt-inspected-9257802_75="true" data-gtm-yt-inspected-9257802_114="true"></iframe>

## Testing accessibility on mobile

Test your app using Flutter’s [Accessibility Guideline API](https://api.flutter.dev/flutter/flutter_test/AccessibilityGuideline-class.html). This API checks if your app’s UI meets Flutter’s accessibility recommendations. These cover recommendations for text contrast, target size, and target labels.

The following example shows how to use the Guideline API on Name Generator. You created this app as part of the [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab) codelab. Each button on the app’s main screen serves as a tappable target with text represented in 18 point.

```
<span>final</span><span> </span><span>SemanticsHandle</span><span> handle </span><span>=</span><span> tester</span><span>.</span><span>ensureSemantics</span><span>();</span><span>
</span><span>await</span><span> tester</span><span>.</span><span>pumpWidget</span><span>(</span><span>MyApp</span><span>());</span><span>

</span><span>// Checks that tappable nodes have a minimum size of 48 by 48 pixels</span><span>
</span><span>// for Android.</span><span>
</span><span>await</span><span> expectLater</span><span>(</span><span>tester</span><span>,</span><span> meetsGuideline</span><span>(</span><span>androidTapTargetGuideline</span><span>));</span><span>

</span><span>// Checks that tappable nodes have a minimum size of 44 by 44 pixels</span><span>
</span><span>// for iOS.</span><span>
</span><span>await</span><span> expectLater</span><span>(</span><span>tester</span><span>,</span><span> meetsGuideline</span><span>(</span><span>iOSTapTargetGuideline</span><span>));</span><span>

</span><span>// Checks that touch targets with a tap or long press action are labeled.</span><span>
</span><span>await</span><span> expectLater</span><span>(</span><span>tester</span><span>,</span><span> meetsGuideline</span><span>(</span><span>labeledTapTargetGuideline</span><span>));</span><span>

</span><span>// Checks whether semantic nodes meet the minimum text contrast levels.</span><span>
</span><span>// The recommended text contrast is 3:1 for larger text</span><span>
</span><span>// (18 point and above regular).</span><span>
</span><span>await</span><span> expectLater</span><span>(</span><span>tester</span><span>,</span><span> meetsGuideline</span><span>(</span><span>textContrastGuideline</span><span>));</span><span>
handle</span><span>.</span><span>dispose</span><span>();</span>
```

You can add Guideline API tests in `test/widget_test.dart` of your app directory, or as a separate test file (such as `test/a11y_test.dart` in the case of the Name Generator).

## Testing accessibility on web

You can debug accessibility by visualizing the semantic nodes created for your web app using the following command line flag in profile and release modes:

```
<span>flutter run -d chrome --profile --dart-define=FLUTTER_WEB_DEBUG_SHOW_SEMANTICS=true
</span>
```

With the flag activated, the semantic nodes appear on top of the widgets; you can verify that the semantic elements are placed where they should be. If the semantic nodes are incorrectly placed, please [file a bug report](https://goo.gle/flutter_web_issue).

## Accessibility release checklist

Here is a non-exhaustive list of things to consider as you prepare your app for release.

-   **Active interactions**. Ensure that all active interactions do something. Any button that can be pushed should do something when pushed. For example, if you have a no-op callback for an `onPressed` event, change it to show a `SnackBar` on the screen explaining which control you just pushed.
-   **Screen reader testing**. The screen reader should be able to describe all controls on the page when you tap on them, and the descriptions should be intelligible. Test your app with [TalkBack](https://support.google.com/accessibility/android/answer/6283677?hl=en) (Android) and [VoiceOver](https://www.apple.com/lae/accessibility/iphone/vision/) (iOS).
-   **Contrast ratios**. We encourage you to have a contrast ratio of at least 4.5:1 between controls or text and the background, with the exception of disabled components. Images should also be vetted for sufficient contrast.
-   **Context switching**. Nothing should change the user’s context automatically while typing in information. Generally, the widgets should avoid changing the user’s context without some sort of confirmation action.
-   **Tappable targets**. All tappable targets should be at least 48x48 pixels.
-   **Errors**. Important actions should be able to be undone. In fields that show errors, suggest a correction if possible.
-   **Color vision deficiency testing**. Controls should be usable and legible in colorblind and grayscale modes.
-   **Scale factors**. The UI should remain legible and usable at very large scale factors for text size and display scaling.

## Learn more

To learn more about Flutter and accessibility, check out the following articles written by community members:

-   [A deep dive into Flutter’s accessibility widgets](https://medium.com/flutter-community/a-deep-dive-into-flutters-accessibility-widgets-eb0ef9455bc)
-   [Semantics in Flutter](https://www.didierboelens.com/2018/07/semantics/)
-   [Flutter: Crafting a great experience for screen readers](https://blog.gskinner.com/archives/2022/09/flutter-crafting-a-great-experience-for-screen-readers.html)