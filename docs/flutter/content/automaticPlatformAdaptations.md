1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Automatic platform adaptations](https://docs.flutter.dev/platform-integration/platform-adaptations)

## Adaptation philosophy

In general, two cases of platform adaptiveness exist:

1.  Things that are behaviors of the OS environment (such as text editing and scrolling) and that would be ‘wrong’ if a different behavior took place.
2.  Things that are conventionally implemented in apps using the OEM’s SDKs (such as using parallel tabs on iOS or showing an [android.app.AlertDialog](https://developer.android.com/reference/android/app/AlertDialog.html) on Android).

This article mainly covers the automatic adaptations provided by Flutter in case 1 on Android and iOS.

For case 2, Flutter bundles the means to produce the appropriate effects of the platform conventions but doesn’t adapt automatically when app design choices are needed. For a discussion, see [issue #8410](https://github.com/flutter/flutter/issues/8410#issuecomment-468034023) and the [Material/Cupertino adaptive widget problem definition](http://bit.ly/flutter-adaptive-widget-problem).

For an example of an app using different information architecture structures on Android and iOS but sharing the same content code, see the [platform\_design code samples](https://github.com/flutter/samples/tree/main/platform_design).

## Page navigation

Flutter provides the navigation patterns seen on Android and iOS and also automatically adapts the navigation animation to the current platform.

### Navigation transitions

On **Android**, the default [`Navigator.push()`](https://api.flutter.dev/flutter/widgets/Navigator/push.html) transition is modeled after [`startActivity()`](https://developer.android.com/reference/android/app/Activity.html#startActivity(android.content.Intent), which generally has one bottom-up animation variant.

On **iOS**:

-   The default [`Navigator.push()`](https://api.flutter.dev/flutter/widgets/Navigator/push.html) API produces an iOS Show/Push style transition that animates from end-to-start depending on the locale’s RTL setting. The page behind the new route also parallax-slides in the same direction as in iOS.
-   A separate bottom-up transition style exists when pushing a page route where [`PageRoute.fullscreenDialog`](https://api.flutter.dev/flutter/widgets/PageRoute-class.html) is true. This represents iOS’s Present/Modal style transition and is typically used on fullscreen modal pages.

### Platform-specific transition details

On **Android**, Flutter uses the [`ZoomPageTransitionsBuilder`](https://api.flutter.dev/flutter/material/ZoomPageTransitionsBuilder-class.html) animation. When the user taps on an item, the UI zooms in to a screen that features that item. When the user taps to go back, the UI zooms out to the previous screen.

On **iOS** when the push style transition is used, Flutter’s bundled [`CupertinoNavigationBar`](https://api.flutter.dev/flutter/cupertino/CupertinoNavigationBar-class.html) and [`CupertinoSliverNavigationBar`](https://api.flutter.dev/flutter/cupertino/CupertinoSliverNavigationBar-class.html) nav bars automatically animate each subcomponent to its corresponding subcomponent on the next or previous page’s `CupertinoNavigationBar` or `CupertinoSliverNavigationBar`.

Android

![An animation of the nav bar transitions during a page transition on iOS](https://docs.flutter.dev/assets/images/docs/platform-adaptations/navigation-ios-nav-bar.gif)

iOS Nav Bar

### Back navigation

On **Android**, the OS back button, by default, is sent to Flutter and pops the top route of the [`WidgetsApp`](https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html)’s Navigator.

On **iOS**, an edge swipe gesture can be used to pop the top route.

Scrolling is an important part of the platform’s look and feel, and Flutter automatically adjusts the scrolling behavior to match the current platform.

### Physics simulation

Android and iOS both have complex scrolling physics simulations that are difficult to describe verbally. Generally, iOS’s scrollable has more weight and dynamic friction but Android has more static friction. Therefore iOS gains high speed more gradually but stops less abruptly and is more slippery at slow speeds.

### Overscroll behavior

On **Android**, scrolling past the edge of a scrollable shows an [overscroll glow indicator](https://api.flutter.dev/flutter/widgets/GlowingOverscrollIndicator-class.html) (based on the color of the current Material theme).

On **iOS**, scrolling past the edge of a scrollable [overscrolls](https://api.flutter.dev/flutter/widgets/BouncingScrollPhysics-class.html) with increasing resistance and snaps back.

### Momentum

On **iOS**, repeated flings in the same direction stacks momentum and builds more speed with each successive fling. There is no equivalent behavior on _Android_.

![Repeated scroll flings building momentum on iOS](https://docs.flutter.dev/assets/images/docs/platform-adaptations/scroll-momentum-ios.gif)

iOS scroll momentum

### Return to top

On **iOS**, tapping the OS status bar scrolls the primary scroll controller to the top position. There is no equivalent behavior on **Android**.

![Tapping the status bar scrolls the primary scrollable back to the top](https://docs.flutter.dev/assets/images/docs/platform-adaptations/scroll-tap-to-top-ios.gif)

iOS status bar tap to top

## Typography

When using the Material package, the typography automatically defaults to the font family appropriate for the platform. Android uses the Roboto font. iOS uses the San Francisco font.

When using the Cupertino package, the [default theme](https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/cupertino/text_theme.dart) uses the San Francisco font.

The San Francisco font license limits its usage to software running on iOS, macOS, or tvOS only. Therefore a fallback font is used when running on Android if the platform is debug-overridden to iOS or the default Cupertino theme is used.

You might choose to adapt the text styling of Material widgets to match the default text styling on iOS. You can see widget-specific examples in the [UI Component section](https://api.flutter.dev/platform-integration/platform-adaptations/#ui-components).

## Iconography

When using the Material package, certain icons automatically show different graphics depending on the platform. For instance, the overflow button’s three dots are horizontal on iOS and vertical on Android. The back button is a simple chevron on iOS and has a stem/shaft on Android.

The material library also provides a set of platform-adaptive icons through [`Icons.adaptive`](https://api.flutter.dev/flutter/material/PlatformAdaptiveIcons-class.html).

## Haptic feedback

The Material and Cupertino packages automatically trigger the platform appropriate haptic feedback in certain scenarios.

For instance, a word selection via text field long-press triggers a ‘buzz’ vibrate on Android and not on iOS.

Scrolling through picker items on iOS triggers a ‘light impact’ knock and no feedback on Android.

## Text editing

Flutter also makes the below adaptations while editing the content of text fields to match the current platform.

### Keyboard gesture navigation

On **Android**, horizontal swipes can be made on the soft keyboard’s space key to move the cursor in Material and Cupertino text fields.

On **iOS** devices with 3D Touch capabilities, a force-press-drag gesture could be made on the soft keyboard to move the cursor in 2D via a floating cursor. This works on both Material and Cupertino text fields.

### Text selection toolbar

With **Material on Android**, the Android style selection toolbar is shown when a text selection is made in a text field.

With **Material on iOS** or when using **Cupertino**, the iOS style selection toolbar is shown when a text selection is made in a text field.

### Single tap gesture

With **Material on Android**, a single tap in a text field puts the cursor at the location of the tap.

A collapsed text selection also shows a draggable handle to subsequently move the cursor.

With **Material on iOS** or when using **Cupertino**, a single tap in a text field puts the cursor at the nearest edge of the word tapped.

Collapsed text selections don’t have draggable handles on iOS.

### Long-press gesture

With **Material on Android**, a long press selects the word under the long press. The selection toolbar is shown upon release.

With **Material on iOS** or when using **Cupertino**, a long press places the cursor at the location of the long press. The selection toolbar is shown upon release.

### Long-press drag gesture

With **Material on Android**, dragging while holding the long press expands the words selected.

With **Material on iOS** or when using **Cupertino**, dragging while holding the long press moves the cursor.

### Double tap gesture

On both Android and iOS, a double tap selects the word receiving the double tap and shows the selection toolbar.

## UI components

This section includes preliminary recommendations on how to adapt Material widgets to deliver a natural and compelling experience on iOS. Your feedback is welcomed on [issue #8427](https://github.com/flutter/website/issues/8427).

### Widgets with .adaptive() constructors

Several widgets support `.adaptive()` constructors. The following table lists these widgets. Adaptive constructors substitute the corresponding Cupertino components when the app is run on an iOS device.

Widgets in the following table are used primarily for input, selection, and to display system information. Because these controls are tightly integrated with the operating system, users have been trained to recognize and respond to them. Therefore, we recommend that you follow platform conventions.

| Material Widget | Cupertino Widget | Adaptive Constructor |
| --- | --- | --- |
| ![Switch in Material 3](https://docs.flutter.dev/assets/images/docs/platform-adaptations/m3-switch.png)  
`Switch` | ![Switch in HIG](https://docs.flutter.dev/assets/images/docs/platform-adaptations/hig-switch.png)  
`CupertinoSwitch` | [`Switch.adaptive()`](https://api.flutter.dev/flutter/material/Switch/Switch.adaptive.html) |
| ![Slider in Material 3](https://docs.flutter.dev/assets/images/docs/platform-adaptations/m3-slider.png)  
`Slider` | ![Slider in HIG](https://docs.flutter.dev/assets/images/docs/platform-adaptations/hig-slider.png)  
`CupertinoSlider` | [`Slider.adaptive()`](https://api.flutter.dev/flutter/material/Slider/Slider.adaptive.html) |
| ![Circular progress indicator in Material 3](https://docs.flutter.dev/assets/images/docs/platform-adaptations/m3-progress.png)  
`CircularProgressIndicator` | ![Activity indicator in HIG](https://docs.flutter.dev/assets/images/docs/platform-adaptations/hig-progress.png)  
`CupertinoActivityIndicator` | [`CircularProgressIndicator.adaptive()`](https://api.flutter.dev/flutter/material/CircularProgressIndicator/CircularProgressIndicator.adaptive.html) |
| ![ Checkbox in Material 3](https://docs.flutter.dev/assets/images/docs/platform-adaptations/m3-checkbox.png)  
`Checkbox` | ![Checkbox in HIG](https://docs.flutter.dev/assets/images/docs/platform-adaptations/hig-checkbox.png)  
`CupertinoCheckbox` | [`Checkbox.adaptive()`](https://api.flutter.dev/flutter/material/Checkbox/Checkbox.adaptive.html) |
| ![Radio in Material 3](https://docs.flutter.dev/assets/images/docs/platform-adaptations/m3-radio.png)  
`Radio` | ![Radio in HIG](https://docs.flutter.dev/assets/images/docs/platform-adaptations/hig-radio.png)  
`CupertinoRadio` | [`Radio.adaptive()`](https://api.flutter.dev/flutter/material/Radio/Radio.adaptive.html) |

### Top app bar and navigation bar

Since Android 12, the default UI for top app bars follows the design guidelines defined in [Material 3](https://m3.material.io/components/top-app-bar/overview). On iOS, an equivalent component called “Navigation Bars” is defined in [Apple’s Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/navigation-bars/) (HIG).

Certain properties of app bars in Flutter apps should be adapted, like system icons and page transitions. These are already automatically adapted when using the Material `AppBar` and `SliverAppBar` widgets. You can also further customize the properties of these widgets to better match iOS platform styles, as shown below.

```
<span>// Map the text theme to iOS styles</span>
<span>TextTheme</span> <span>cupertinoTextTheme</span> <span>=</span> <span>TextTheme</span><span>(</span>
    <span>headlineMedium:</span> <span>CupertinoThemeData</span><span>()</span>
        <span>.</span><span>textTheme</span>
        <span>.</span><span>navLargeTitleTextStyle</span>
         <span>// fixes a small bug with spacing</span>
        <span>.</span><span>copyWith</span><span>(</span><span>letterSpacing:</span> <span>-</span><span>1.5</span><span>),</span>
    <span>titleLarge:</span> <span>CupertinoThemeData</span><span>()</span><span>.</span><span>textTheme</span><span>.</span><span>navTitleTextStyle</span><span>)</span>
<span>...</span>

<span>// Use iOS text theme on iOS devices</span>
<span>ThemeData</span><span>(</span>
      <span>textTheme:</span> <span>Platform</span><span>.</span><span>isIOS</span> <span>?</span> <span>cupertinoTextTheme</span> <span>:</span> <span>null</span><span>,</span>
      <span>...</span>
<span>)</span>
<span>...</span>

<span>// Modify AppBar properties</span>
<span>AppBar</span><span>(</span>
        <span>surfaceTintColor:</span> <span>Platform</span><span>.</span><span>isIOS</span> <span>?</span> <span>Colors</span><span>.</span><span>transparent</span> <span>:</span> <span>null</span><span>,</span>
        <span>shadowColor:</span> <span>Platform</span><span>.</span><span>isIOS</span> <span>?</span> <span>CupertinoColors</span><span>.</span><span>darkBackgroundGray</span> <span>:</span> <span>null</span><span>,</span>
        <span>scrolledUnderElevation:</span> <span>Platform</span><span>.</span><span>isIOS</span> <span>?</span> <span>.</span><span>1</span> <span>:</span> <span>null</span><span>,</span>
        <span>toolbarHeight:</span> <span>Platform</span><span>.</span><span>isIOS</span> <span>?</span> <span>44</span> <span>:</span> <span>null</span><span>,</span>
        <span>...</span>
      <span>),</span>

```

But, because app bars are displayed alongside other content in your page, it’s only recommended to adapt the styling so long as its cohesive with the rest of your application. You can see additional code samples and a further explanation in [the GitHub discussion on app bar adaptations](https://github.com/flutter/uxr/discussions/93).

### Bottom navigation bars

Since Android 12, the default UI for bottom navigation bars follow the design guidelines defined in [Material 3](https://m3.material.io/components/navigation-bar/overview). On iOS, an equivalent component called “Tab Bars” is defined in [Apple’s Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/tab-bars/) (HIG).

Since tab bars are persistent across your app, they should match your own branding. However, if you choose to use Material’s default styling on Android, you might consider adapting to the default iOS tab bars.

To implement platform-specific bottom navigation bars, you can use Flutter’s `NavigationBar` widget on Android and the `CupertinoTabBar` widget on iOS. Below is a code snippet you can adapt to show a platform-specific navigation bars.

```
<span>final</span> <span>Map</span><span>&lt;</span><span>String</span><span>,</span> <span>Icon</span><span>&gt;</span> <span>_navigationItems</span> <span>=</span> <span>{</span>
    <span>'Menu'</span><span>:</span> <span>Platform</span><span>.</span><span>isIOS</span> <span>?</span> <span>Icon</span><span>(</span><span>CupertinoIcons</span><span>.</span><span>house_fill</span><span>)</span> <span>:</span> <span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>home</span><span>),</span>
    <span>'Order'</span><span>:</span> <span>Icon</span><span>(</span><span>Icons</span><span>.</span><span>adaptive</span><span>.</span><span>share</span><span>),</span>
  <span>};</span>

<span>...</span>

<span>Scaffold</span><span>(</span>
  <span>body:</span> <span>_currentWidget</span><span>,</span>
  <span>bottomNavigationBar:</span> <span>Platform</span><span>.</span><span>isIOS</span>
          <span>?</span> <span>CupertinoTabBar</span><span>(</span>
              <span>currentIndex:</span> <span>_currentIndex</span><span>,</span>
              <span>onTap:</span> <span>(</span><span>index</span><span>)</span> <span>{</span>
                <span>setState</span><span>(()</span> <span>=</span><span>&gt;</span> <span>_currentIndex</span> <span>=</span> <span>index</span><span>);</span>
                <span>_loadScreen</span><span>();</span>
              <span>},</span>
              <span>items:</span> <span>_navigationItems</span><span>.</span><span>entries</span>
                  <span>.</span><span>map</span><span>&lt;</span><span>BottomNavigationBarItem</span><span>&gt;(</span>
                      <span>(</span><span>entry</span><span>)</span> <span>=</span><span>&gt;</span> <span>BottomNavigationBarItem</span><span>(</span>
                            <span>icon:</span> <span>entry</span><span>.</span><span>value</span><span>,</span>
                            <span>label:</span> <span>entry</span><span>.</span><span>key</span><span>,</span>
                          <span>))</span>
                  <span>.</span><span>toList</span><span>(),</span>
            <span>)</span>
          <span>:</span> <span>NavigationBar</span><span>(</span>
              <span>selectedIndex:</span> <span>_currentIndex</span><span>,</span>
              <span>onDestinationSelected:</span> <span>(</span><span>index</span><span>)</span> <span>{</span>
                <span>setState</span><span>(()</span> <span>=</span><span>&gt;</span> <span>_currentIndex</span> <span>=</span> <span>index</span><span>);</span>
                <span>_loadScreen</span><span>();</span>
              <span>},</span>
              <span>destinations:</span> <span>_navigationItems</span><span>.</span><span>entries</span>
                  <span>.</span><span>map</span><span>&lt;</span><span>Widget</span><span>&gt;((</span><span>entry</span><span>)</span> <span>=</span><span>&gt;</span> <span>NavigationDestination</span><span>(</span>
                        <span>icon:</span> <span>entry</span><span>.</span><span>value</span><span>,</span>
                        <span>label:</span> <span>entry</span><span>.</span><span>key</span><span>,</span>
                      <span>))</span>
                  <span>.</span><span>toList</span><span>(),</span>
            <span>));</span>
```

### Text fields

Since Android 12, text fields follow the [Material 3](https://m3.material.io/components/text-fields/overview) (M3) design guidelines. On iOS, Apple’s [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/text-fields) (HIG) define an equivalent component.

Since text fields require user input,  
their design should follow platform conventions.

To implement a platform-specific `TextField` in Flutter, you can adapt the styling of the Material `TextField`.

```
<span>Widget</span> <span>_createAdaptiveTextField</span><span>()</span> <span>{</span>
  <span>final</span> <span>_border</span> <span>=</span> <span>OutlineInputBorder</span><span>(</span>
    <span>borderSide:</span> <span>BorderSide</span><span>(</span><span>color:</span> <span>CupertinoColors</span><span>.</span><span>lightBackgroundGray</span><span>),</span>
  <span>);</span>

  <span>final</span> <span>iOSDecoration</span> <span>=</span> <span>InputDecoration</span><span>(</span>
    <span>border:</span> <span>_border</span><span>,</span>
    <span>enabledBorder:</span> <span>_border</span><span>,</span>
    <span>focusedBorder:</span> <span>_border</span><span>,</span>
    <span>filled:</span> <span>true</span><span>,</span>
    <span>fillColor:</span> <span>CupertinoColors</span><span>.</span><span>white</span><span>,</span>
    <span>hoverColor:</span> <span>CupertinoColors</span><span>.</span><span>white</span><span>,</span>
    <span>contentPadding:</span> <span>EdgeInsets</span><span>.</span><span>fromLTRB</span><span>(</span><span>10</span><span>,</span> <span>0</span><span>,</span> <span>0</span><span>,</span> <span>0</span><span>),</span>
  <span>);</span>

  <span>return</span> <span>Platform</span><span>.</span><span>isIOS</span>
      <span>?</span> <span>SizedBox</span><span>(</span>
          <span>height:</span> <span>36.0</span><span>,</span>
          <span>child:</span> <span>TextField</span><span>(</span>
            <span>decoration:</span> <span>iOSDecoration</span><span>,</span>
          <span>),</span>
        <span>)</span>
      <span>:</span> <span>TextField</span><span>();</span>
<span>}</span>
```

To learn more about adapting text fields, check out [the GitHub discussion on text fields](https://github.com/flutter/uxr/discussions/95). You can leave feedback or ask questions in the discussion.

### Alert dialog

Since Android 12, the default UI of alert dialogs (also known as a “basic dialog”) follows the design guidelines defined in [Material 3](https://m3.material.io/components/dialogs/overview) (M3). On iOS, an equivalent component called “alert” is defined in Apple’s [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/presentation/alerts/) (HIG).

Since alert dialogs are often tightly integrated with the operating system, their design generally needs to follow the platform conventions. This is especially important when a dialog is used to request user input about security, privacy, and destructive operations (e.g., deleting files permanently). As an exception, a branded alert dialog design can be used on non-critical user flows to highlight specific information or messages.

To implement platform-specific alert dialogs, you can use Flutter’s `AlertDialog` widget on Android and the `CupertinoAlertDialog` widget on iOS. Below is a code snippet you can adapt to show a platform-specific alert dialog.

```
<span>void</span> <span>_showAdaptiveDialog</span><span>(</span>
  <span>context</span><span>,</span> <span>{</span>
  <span>required</span> <span>Text</span> <span>title</span><span>,</span>
  <span>required</span> <span>Text</span> <span>content</span><span>,</span>
  <span>required</span> <span>List</span><span>&lt;</span><span>Widget</span><span>&gt;</span> <span>actions</span><span>,</span>
<span>})</span> <span>{</span>
  <span>Platform</span><span>.</span><span>isIOS</span> <span>||</span> <span>Platform</span><span>.</span><span>isMacOS</span>
      <span>?</span> <span>showCupertinoDialog</span><span>&lt;</span><span>String</span><span>&gt;(</span>
          <span>context:</span> <span>context</span><span>,</span>
          <span>builder:</span> <span>(</span><span>BuildContext</span> <span>context</span><span>)</span> <span>=</span><span>&gt;</span> <span>CupertinoAlertDialog</span><span>(</span>
            <span>title:</span> <span>title</span><span>,</span>
            <span>content:</span> <span>content</span><span>,</span>
            <span>actions:</span> <span>actions</span><span>,</span>
          <span>),</span>
        <span>)</span>
      <span>:</span> <span>showDialog</span><span>(</span>
          <span>context:</span> <span>context</span><span>,</span>
          <span>builder:</span> <span>(</span><span>BuildContext</span> <span>context</span><span>)</span> <span>=</span><span>&gt;</span> <span>AlertDialog</span><span>(</span>
            <span>title:</span> <span>title</span><span>,</span>
            <span>content:</span> <span>content</span><span>,</span>
            <span>actions:</span> <span>actions</span><span>,</span>
          <span>),</span>
        <span>);</span>
<span>}</span>
```

To learn more about adapting alert dialogs, check out [the GitHub discussion on dialog adaptations](https://github.com/flutter/uxr/discussions/92). You can leave feedback or ask questions in the discussion.