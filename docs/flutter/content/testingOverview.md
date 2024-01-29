1.  [Testing & debugging](https://docs.flutter.dev/testing)
2.  [Testing Flutter apps](https://docs.flutter.dev/testing/overview)

The more features your app has, the harder it is to test manually. Automated tests help ensure that your app performs correctly before you publish it, while retaining your feature and bug fix velocity.

Automated testing falls into a few categories:

-   A [_unit test_](https://docs.flutter.dev/testing/overview#unit-tests) tests a single function, method, or class.
-   A [_widget test_](https://docs.flutter.dev/testing/overview#widget-tests) (in other UI frameworks referred to as _component test_) tests a single widget.
-   An [_integration test_](https://docs.flutter.dev/testing/overview#integration-tests) tests a complete app or a large part of an app.

Generally speaking, a well-tested app has many unit and widget tests, tracked by [code coverage](https://en.wikipedia.org/wiki/Code_coverage), plus enough integration tests to cover all the important use cases. This advice is based on the fact that there are trade-offs between different kinds of testing, seen below.

|   | Unit | Widget | Integration |
| --- | --- | --- | --- |
| **Confidence** | Low | Higher | Highest |
| **Maintenance cost** | Low | Higher | Highest |
| **Dependencies** | Few | More | Most |
| **Execution speed** | Quick | Quick | Slow |

## Unit tests

A _unit test_ tests a single function, method, or class. The goal of a unit test is to verify the correctness of a unit of logic under a variety of conditions. External dependencies of the unit under test are generally [mocked out](https://docs.flutter.dev/cookbook/testing/unit/mocking). Unit tests generally don’t read from or write to disk, render to screen, or receive user actions from outside the process running the test. For more information regarding unit tests, you can view the following recipes or run `flutter test --help` in your terminal.

### Recipes

-   [An introduction to unit testing](https://docs.flutter.dev/cookbook/testing/unit/introduction/)
    
-   [Mock dependencies using Mockito](https://docs.flutter.dev/cookbook/testing/unit/mocking/)
    

A _widget test_ (in other UI frameworks referred to as _component test_) tests a single widget. The goal of a widget test is to verify that the widget’s UI looks and interacts as expected. Testing a widget involves multiple classes and requires a test environment that provides the appropriate widget lifecycle context.

For example, the Widget being tested should be able to receive and respond to user actions and events, perform layout, and instantiate child widgets. A widget test is therefore more comprehensive than a unit test. However, like a unit test, a widget test’s environment is replaced with an implementation much simpler than a full-blown UI system.

### Recipes

-   [An introduction to widget testing](https://docs.flutter.dev/cookbook/testing/widget/introduction/)
    
-   [Find widgets](https://docs.flutter.dev/cookbook/testing/widget/finders/)
    
-   [Handle scrolling](https://docs.flutter.dev/cookbook/testing/widget/scrolling/)
    
-   [Tap, drag, and enter text](https://docs.flutter.dev/cookbook/testing/widget/tap-drag/)
    

## Integration tests

An _integration test_ tests a complete app or a large part of an app. The goal of an integration test is to verify that all the widgets and services being tested work together as expected. Furthermore, you can use integration tests to verify your app’s performance.

Generally, an _integration test_ runs on a real device or an OS emulator, such as iOS Simulator or Android Emulator. The app under test is typically isolated from the test driver code to avoid skewing the results.

For more information on how to write integration tests, see the [integration testing page](https://docs.flutter.dev/testing/integration-tests).

### Recipes

-   [An introduction to integration testing](https://docs.flutter.dev/cookbook/testing/integration/introduction/)
    
-   [Performance profiling](https://docs.flutter.dev/cookbook/testing/integration/profiling/)
    

## Continuous integration services

Continuous integration (CI) services allow you to run your tests automatically when pushing new code changes. This provides timely feedback on whether the code changes work as expected and do not introduce bugs.

For information on running tests on various continuous integration services, see the following:

-   [Continuous delivery using fastlane with Flutter](https://docs.flutter.dev/deployment/cd#fastlane)
-   [Test Flutter apps on Appcircle](https://blog.appcircle.io/article/flutter-ci-cd-github-ios-android-web#)
-   [Test Flutter apps on Travis](https://medium.com/flutter/test-flutter-apps-on-travis-3fd5142ecd8c)
-   [Test Flutter apps on Cirrus](https://cirrus-ci.org/examples/#flutter)
-   [Codemagic CI/CD for Flutter](https://blog.codemagic.io/getting-started-with-codemagic/)
-   [Flutter CI/CD with Bitrise](https://devcenter.bitrise.io/en/getting-started/getting-started-with-flutter-apps)