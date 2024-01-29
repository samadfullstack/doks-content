[_description_](https://github.com/flutter/website/tree/main/src/platform-integration/ios/ios-debugging.md "View page source") [_bug\_report_](https://github.com/flutter/website/issues/new?template=1_page_issue.yml&title=[PAGE%20ISSUE]:%20%27iOS%20debugging%27&page-url=https://docs.flutter.dev/platform-integration/ios/ios-debugging/&page-source=https://github.com/flutter/website/tree/main/src/platform-integration/ios/ios-debugging.md "Report an issue with this page")

1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [iOS](https://docs.flutter.dev/platform-integration/ios)
3.  [iOS debugging](https://docs.flutter.dev/platform-integration/ios/ios-debugging)

Due to security around [local network permissions in iOS 14 or later](https://developer.apple.com/news/?id=0oi77447), you must accept a permission dialog box to enable Flutter debugging functionalities such as hot-reload and DevTools.

![Screenshot of "allow network connections" dialog](https://docs.flutter.dev/assets/images/docs/development/device-connect.png)

This affects debug and profile builds only and won’t appear in release builds. You can also allow this permission by enabling **Settings > Privacy > Local Network > Your App**.