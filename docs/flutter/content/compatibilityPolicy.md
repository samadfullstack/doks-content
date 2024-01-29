1.  [Stay up to date](https://docs.flutter.dev/release)
2.  [Flutter compatibility policy](https://docs.flutter.dev/release/compatibility-policy)

The Flutter team tries to balance the need for API stability with the need to keep evolving APIs to fix bugs, improve API ergonomics, and provide new features in a coherent manner.

To this end, we have created a test registry where you can provide unit tests for your own applications or libraries that we run on every change to help us track changes that would break existing applications. Our commitment is that we won’t make any changes that break these tests without working with the developers of those tests to (a) determine if the change is sufficiently valuable, and (b) provide fixes for the code so that the tests continue to pass.

If you would like to provide tests as part of this program, please submit a PR to the [flutter/tests repository](https://github.com/flutter/tests). The [README](https://github.com/flutter/tests#adding-more-tests) on that repository describes the process in detail.

## Announcements and migration guides

If we do make a breaking change (defined as a change that caused one or more of these submitted tests to require changes), we will announce the change on our [flutter-announce](https://groups.google.com/forum/#!forum/flutter-announce) mailing list as well as in our release notes.

We provide a list of [guides for migrating code](https://docs.flutter.dev/release/breaking-changes) affected by breaking changes.

## Deprecation policy

We will, on occasion, deprecate certain APIs rather than outright break them overnight. This is independent of our compatibility policy which is exclusively based on whether submitted tests fail, as described above.

Deprecated APIs are removed after a migration grace period. This grace period is one calendar year after being released on the stable channel, or after 4 stable releases, whichever is longer.

When a deprecation does reach end of life, we follow the same procedures listed above for making breaking changes in removing the deprecated API.

## Dart and other libraries used by Flutter

The Dart language itself has a [separate breaking-change policy](https://github.com/dart-lang/sdk/blob/main/docs/process/breaking-changes.md), with announcements on [Dart announce](https://groups.google.com/a/dartlang.org/g/announce).

In general, the Flutter team doesn’t currently have any commitment regarding breaking changes for other dependencies. For example, it’s possible that a new version of Flutter using a new version of Skia (the graphics engine used by some platforms on Flutter) or Harfbuzz (the font shaping engine used by Flutter) would have changes that affect contributed tests. Such changes wouldn’t necessarily be accompanied by a migration guide.