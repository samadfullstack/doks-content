1.  [Deployment](https://docs.flutter.dev/deployment)
2.  [Continuous delivery with Flutter](https://docs.flutter.dev/deployment/cd)

Follow continuous delivery best practices with Flutter to make sure your application is delivered to your beta testers and validated on a frequent basis without resorting to manual workflows.

## CI/CD Options

There are a number of continuous integration (CI) and continuous delivery (CD) options available to help automate the delivery of your application.

### All-in-one options with built-in Flutter functionality

-   [Codemagic](https://blog.codemagic.io/getting-started-with-codemagic/)
-   [Bitrise](https://devcenter.bitrise.io/en/getting-started/getting-started-with-flutter-apps)
-   [Appcircle](https://appcircle.io/blog/guide-to-automated-mobile-ci-cd-for-flutter-projects-with-appcircle/)

### Integrating fastlane with existing workflows

You can use fastlane with the following tooling:

-   [GitHub Actions](https://github.com/features/actions)
    -   Example: Flutter Gallery’s [Github Actions workflows](https://github.com/flutter/gallery/tree/main/.github/workflows)
    -   Example: [Github Action in Flutter Project](https://github.com/nabilnalakath/flutter-githubaction)
-   [Cirrus](https://cirrus-ci.org/)
-   [Travis](https://travis-ci.org/)
-   [GitLab](https://docs.gitlab.com/ee/ci/README.html#doc-nav)
-   [CircleCI](https://circleci.com/)
    -   [Building and deploying Flutter apps with Fastlane](https://circleci.com/blog/deploy-flutter-android)

This guide shows how to set up fastlane and then integrate it with your existing testing and continuous integration (CI) workflows. For more information, see “Integrating fastlane with existing workflow”.

## fastlane

[fastlane](https://docs.fastlane.tools/) is an open-source tool suite to automate releases and deployments for your app.

### Local setup

It’s recommended that you test the build and deployment process locally before migrating to a cloud-based system. You could also choose to perform continuous delivery from a local machine.

1.  Install fastlane `gem install fastlane` or `brew install fastlane`. Visit the [fastlane docs](https://docs.fastlane.tools/) for more info.
2.  Create an environment variable named `FLUTTER_ROOT`, and set it to the root directory of your Flutter SDK. (This is required for the scripts that deploy for iOS.)
3.  Create your Flutter project, and when ready, make sure that your project builds via
4.  Initialize the fastlane projects for each platform.
5.  Edit the `Appfile`s to ensure they have adequate metadata for your app.
6.  Set up your local login credentials for the stores.
7.  Set up code signing.
8.  Create a `Fastfile` script for each platform.
    -   ![Android](https://docs.flutter.dev/assets/images/docs/cd/android.png) On Android, follow the [fastlane Android beta deployment guide](https://docs.fastlane.tools/getting-started/android/beta-deployment/). Your edit could be as simple as adding a `lane` that calls `upload_to_play_store`. Set the `aab` argument to `../build/app/outputs/bundle/release/app-release.aab` to use the app bundle `flutter build` already built.
    -   ![iOS](https://docs.flutter.dev/assets/images/docs/cd/ios.png) On iOS, follow the [fastlane iOS beta deployment guide](https://docs.fastlane.tools/getting-started/ios/beta-deployment/). You can specify the archive path to avoid rebuilding the project. For example:
        
        ```
        <span>build_app</span><span>(</span>
          <span>skip_build_archive: </span><span>true</span><span>,</span>
          <span>archive_path: </span><span>"../build/ios/archive/Runner.xcarchive"</span><span>,</span>
        <span>)</span>
        <span>upload_to_testflight</span>
        ```
        

You’re now ready to perform deployments locally or migrate the deployment process to a continuous integration (CI) system.

### Running deployment locally

1.  Build the release mode app.
2.  Run the Fastfile script on each platform.

### Cloud build and deploy setup

First, follow the local setup section described in ‘Local setup’ to make sure the process works before migrating onto a cloud system like Travis.

The main thing to consider is that since cloud instances are ephemeral and untrusted, you won’t be leaving your credentials like your Play Store service account JSON or your iTunes distribution certificate on the server.

Continuous Integration (CI) systems generally support encrypted environment variables to store private data. You can pass these environment variables using `--dart-define MY_VAR=MY_VALUE` while building the app.

**Take precaution not to re-echo those variable values back onto the console in your test scripts**. Those variables are also not available in pull requests until they’re merged to ensure that malicious actors cannot create a pull request that prints these secrets out. Be careful with interactions with these secrets in pull requests that you accept and merge.

1.  Make login credentials ephemeral.
    -   ![Android](https://docs.flutter.dev/assets/images/docs/cd/android.png) On Android:
        -   Remove the `json_key_file` field from `Appfile` and store the string content of the JSON in your CI system’s encrypted variable. Read the environment variable directly in your `Fastfile`.
            
            ```
            upload_to_play_store(
              ...
              json_key_data: ENV['&lt;variable name&gt;']
            )
            ```
            
        -   Serialize your upload key (for example, using base64) and save it as an encrypted environment variable. You can deserialize it on your CI system during the install phase with
            
            ```
            <span>echo</span> <span>"</span><span>$PLAY_STORE_UPLOAD_KEY</span><span>"</span> | <span>base64</span> <span>--decode</span> <span>&gt;</span> <span>[</span>path to your upload keystore]
            ```
            
    -   ![iOS](https://docs.flutter.dev/assets/images/docs/cd/ios.png) On iOS:
        -   Move the local environment variable `FASTLANE_PASSWORD` to use encrypted environment variables on the CI system.
        -   The CI system needs access to your distribution certificate. fastlane’s [Match](https://docs.fastlane.tools/actions/match/) system is recommended to synchronize your certificates across machines.
2.  It’s recommended to use a Gemfile instead of using an indeterministic `gem install fastlane` on the CI system each time to ensure the fastlane dependencies are stable and reproducible between local and cloud machines. However, this step is optional.
    -   In both your `[project]/android` and `[project]/ios` folders, create a `Gemfile` containing the following content:
        
        ```
          source "https://rubygems.org"
        
          gem "fastlane"
        ```
        
    -   In both directories, run `bundle update` and check both `Gemfile` and `Gemfile.lock` into source control.
    -   When running locally, use `bundle exec fastlane` instead of `fastlane`.
3.  Create the CI test script such as `.travis.yml` or `.cirrus.yml` in your repository root.
    -   See [fastlane CI documentation](https://docs.fastlane.tools/best-practices/continuous-integration) for CI specific setup.
    -   Shard your script to run on both Linux and macOS platforms.
    -   During the setup phase of the CI task, do the following:
        -   Ensure Bundler is available using `gem install bundler`.
        -   Run `bundle install` in `[project]/android` or `[project]/ios`.
        -   Make sure the Flutter SDK is available and set in `PATH`.
        -   For Android, ensure the Android SDK is available and the `ANDROID_SDK_ROOT` path is set.
        -   For iOS, you might have to specify a dependency on Xcode (for example, `osx_image: xcode9.2`).
    -   In the script phase of the CI task:
        -   Run `flutter build appbundle` or `flutter build ios --release --no-codesign`, depending on the platform.
        -   `cd android` or `cd ios`
        -   `bundle exec fastlane [name of the lane]`

## Xcode Cloud

[Xcode Cloud](https://developer.apple.com/xcode-cloud) is a continuous integration and delivery service for building, testing, and distributing apps and frameworks for Apple platforms.

### Requirements

-   Xcode 13.4.1 or higher.
-   Be enrolled in the [Apple Developer Program](https://developer.apple.com/programs).

### Custom build script

Xcode Cloud recognizes [custom build scripts](https://developer.apple.com/documentation/xcode/writing-custom-build-scripts) that can be used to perform additional tasks at a designated time. It also includes a set of [predefined environment variables](https://developer.apple.com/documentation/xcode/environment-variable-reference), such as `$CI_WORKSPACE`, which is the location of your cloned repository.

#### Post-clone script

Leverage the post-clone custom build script that runs after Xcode Cloud clones your Git repository using the following instructions:

Create a file at `ios/ci_scripts/ci_post_clone.sh` and add the content below.

```
<span>#!/bin/sh</span><span>

</span><span># Fail this script if any subcommand fails.</span><span>
</span><span>set</span><span> </span><span>-</span><span>e

</span><span># The default execution directory of this script is the ci_scripts directory.</span><span>
cd $CI_PRIMARY_REPOSITORY_PATH </span><span># change working directory to the root of your cloned repo.</span><span>

</span><span># Install Flutter using git.</span><span>
git clone https</span><span>://</span><span>github</span><span>.</span><span>com</span><span>/</span><span>flutter</span><span>/</span><span>flutter</span><span>.</span><span>git </span><span>--</span><span>depth </span><span>1</span><span> </span><span>-</span><span>b stable $HOME</span><span>/</span><span>flutter
export PATH</span><span>=</span><span>"$PATH:$HOME/flutter/bin"</span><span>

</span><span># Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.</span><span>
flutter precache </span><span>--</span><span>ios

</span><span># Install Flutter dependencies.</span><span>
flutter pub get

</span><span># Install CocoaPods using Homebrew.</span><span>
HOMEBREW_NO_AUTO_UPDATE</span><span>=</span><span>1</span><span> </span><span># disable homebrew's automatic updates.</span><span>
brew install cocoapods

</span><span># Install CocoaPods dependencies.</span><span>
cd ios </span><span>&amp;&amp;</span><span> pod install </span><span># run `pod install` in the `ios` directory.</span><span>

exit </span><span>0</span>
```

This file should be added to your git repository and marked as executable.

```
<span>$</span><span> </span>git add <span>--chmod</span><span>=</span>+x ios/ci_scripts/ci_post_clone.sh
```

### Workflow configuration

An [Xcode Cloud workflow](https://developer.apple.com/documentation/xcode/xcode-cloud-workflow-reference) defines the steps performed in the CI/CD process when your workflow is triggered.

To create a new workflow in Xcode, use the following instructions:

1.  Choose **Product > Xcode Cloud > Create Workflow** to open the **Create Workflow** sheet.
    
2.  Select the product (app) that the workflow should be attached to, then click the **Next** button.
    
3.  The next sheet displays an overview of the default workflow provided by Xcode, and can be customized by clicking the **Edit Workflow** button.
    

#### Branch changes

By default Xcode suggests the Branch Changes condition that starts a new build for every change to your Git repository’s default branch.

For your app’s iOS variant, it’s reasonable that you would want Xcode Cloud to trigger your workflow after you’ve made changes to your flutter packages, or modified either the Dart or iOS source files within the `lib\` and `ios\` directories.

This can be achieved by using the following Files and Folders conditions:

![Xcode Workflow Branch Changes](https://docs.flutter.dev/assets/images/docs/releaseguide/xcode_workflow_branch_changes.png)

### Next build number

Xcode Cloud defaults the build number for new workflows to `1` and increments it per successful build. If you’re using an existing app with a higher build number, you’ll need to configure Xcode Cloud to use the correct build number for it’s builds by simply specifying the `Next Build Number` in your iteration.

Check out [Setting the next build number for Xcode Cloud builds](https://developer.apple.com/documentation/xcode/setting-the-next-build-number-for-xcode-cloud-builds#Set-the-next-build-number-to-a-custom-value) for more information.