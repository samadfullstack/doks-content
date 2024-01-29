## Introduction

With the Google Maps for Flutter package, you can add maps based on Google maps data to your iOS or Android application. The SDK automatically handles access to the Google Maps servers, map display, and response to user gestures such as clicks and drags. You can also add markers, polylines, ground overlays, and info windows to your map. These objects provide additional information for map locations, and allow user interaction with the map.

When using the SDK you need to comply with the [Google Maps Platform Terms of Service](https://cloud.google.com/maps-platform/terms) and ensure that your app complies with applicable laws.

![Flutter Plugin Model](https://developers.google.com/static/maps/flutter-package/images/flutter-plugin-model.png)

Flutter plugins use Dart channels to call platform-specific APIs. Flutter developers interact with a single, app-facing package. This package recognizes the platform that the app is running on and federates the API calls to the appropriate native code

## Audience

This documentation is designed for people familiar with [Flutter development](https://flutter.dev/?utm_source=devsite&utm_medium=maps_docs&utm_campaign=maps_docs) concepts. You should also be familiar with [Google Maps](https://maps.google.com/) from a user's point of view. With this guide, you can start exploring and developing applications with the Google Maps for Flutter package. To learn about specific details of classes and methods, check out the [reference documentation](https://api.flutter.dev/index.html?utm_source=devsite&utm_medium=maps_docs&utm_campaign=maps_docs).

## Attribution requirements

If you use the Google Maps for Flutter package in your application, you must include the attribution text as part of a legal notices section in your application. Google recommend including legal notices as an independent menu item, or as part of an "About" menu item.

To get the attribution text, call the [`showLicensePage`](https://api.flutter.dev/flutter/material/showLicensePage.html?utm_source=devsite&utm_medium=maps_docs&utm_campaign=maps_docs) endpoint.

## Supported platforms

With the Google Maps for Flutter package, you can build apps that target iOS, Android and the Web.

Refer to the Flutter documentation for the development environments requirements and current versions of [target platforms](https://docs.flutter.dev/reference/supported-platforms%0A?utm_source=devsite&utm_medium=maps_docs&utm_campaign=maps_docs).

To use [Maps URLs](https://developers.google.com/maps/documentation/ios-sdk/urlscheme), your target device needs the appropriate Google Maps app installed. For mobile devices, this includes [Google Maps for iOS](https://itunes.apple.com/app/id585027354) or [Google Maps for Android](https://play.google.com/store/apps/details?id=com.google.android.apps.maps&hl=en_US&gl=US&pli=1).