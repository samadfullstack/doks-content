[![Google Codelabs](https://www.gstatic.com/devrel-devsite/prod/v42640c93f7fab57c4283b9dae6637d7a9b0c9c398ce5fff015a4cf8de65e6ed5/codelabs/images/lockup.svg)](https://codelabs.developers.google.com/)

## 1\. Introduction

**Last Updated:** 2023-07-11

Adding in-app purchases to a Flutter app requires correctly setting up the App and Play stores, verifying the purchase, and granting the necessary permissions, such as subscription perks.

In this codelab you'll add three types of in-app purchases to an app (provided for you), and verify these purchases using a Dart backend with Firebase. The provided app, Dash Clicker, contains a game that uses the Dash mascot as currency. You will add the following purchase options:

1.  A repeatable purchase option for 2000 Dashes at once.
2.  A one-time upgrade purchase to make the old style Dash into a modern style Dash.
3.  A subscription that doubles the automatically generated clicks.

The first purchase option gives the user a direct benefit of 2000 Dashes. These are directly available to the user and can be bought many times. This is called a consumable as it is directly consumed and can be consumed multiple times.

The second option upgrades the Dash to a more beautiful Dash. This only has to be purchased once and is available forever. Such a purchase is called non-consumable because it cannot be consumed by the app but is valid forever.

The third and last purchase option is a subscription. While the subscription is active the user will get Dashes more quickly, but when he stops paying for the subscription the benefits also go away.

The backend service (also provided for you) runs as a Dart app, verifies that the purchases are made, and stores them using Firestore. Firestore is used to make the process easier, but in your production app, you can use any type of backend service.

![300123416ebc8dc1.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/300123416ebc8dc1.png) ![7145d0fffe6ea741.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/7145d0fffe6ea741.png) ![646317a79be08214.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/646317a79be08214.png)

## What you'll build

-   You will extend an app to support consumable purchases and subscriptions.
-   You will also extend a Dart backend app to verify and store the purchased items.

## **What you'll** **learn**

-   How to configure the App Store and Play Store with purchasable products.
-   How to communicate with the stores to verify purchases and store them in Firestore.
-   How to manage purchases in your app.

## What you'll need

-   Android Studio 4.1 or later
-   Xcode 12 or later (for iOS development)
-   [Flutter SDK](https://flutter.dev/docs/get-started/install)

## 2\. Set up the development environment

To start this codelab, download the code and change the bundle identifier for iOS and the package name for Android.

## Download the code

To clone the [GitHub repository](https://github.com/flutter/codelabs) from the command line, use the following command:

```
git clone https://github.com/flutter/codelabs.git flutter-codelabs
```

Or, if you have [GitHub's cli](https://github.com/cli/cli) tool installed, use the following command:

```
gh repo clone flutter/codelabs flutter-codelabs
```

The sample code is cloned into a `flutter-codelabs` directory that contains the code for a collection of codelabs. The code for this codelab is in `flutter-codelabs/in_app_purchases`.

The directory structure under `flutter-codelabs/in_app_purchases` contains a series of snapshots of where you should be at the end of each named step. The starter code is in step 0, so locating the matching files is as easy as:

```
cd flutter-codelabs/in_app_purchases/step_00
```

If you want to skip forward or see what something should look like after a step, look in the directory named after the step you are interested in. The code of the last step is under the folder `complete`.

## **Set up the starter project**

Open the starter project from `step_00` in your favorite IDE. We used Android Studio for the screenshots, but Visual Studio Code is also a great option. With either editor, ensure that the latest Dart and Flutter plugins are installed.

The apps you are going to make need to communicate with the App Store and Play Store to know which products are available and for what price. Every app is identified by a unique ID. For the iOS App Store this is called the bundle identifier and for the Android Play Store this is the application ID. These identifiers are usually made using a reverse domain name notation. For example when making an in app purchase app for flutter.dev we would use `dev.flutter.inapppurchase`. Think of an identifier for your app, you are now going to set that in the project settings.

First, set up the bundle identifier for iOS.

With the project open in Android Studio, right-click the iOS folder, click **Flutter**, and open the module in the Xcode app.

![942772eb9a73bfaa.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/942772eb9a73bfaa.png)

In Xcode's folder structure, the **Runner project** is at the top, and the **Flutter**, **Runner**, and **Products** targets are beneath the Runner project. Double-click **Runner** to edit your project settings, and click **Signing & Capabilities**. Enter the bundle identifier you've just chosen under the **Team** field to set your team.

![812f919d965c649a.jpeg](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/812f919d965c649a.jpeg)

You can now close Xcode and go back to Android Studio to finish the configuration for Android. To do so open the `build.gradle` file under `android/app,` and change your `applicationId` (on line 37 in the screenshot below) to the application ID, the same as the iOS bundle identifier. Note that the IDs for the iOS and Android stores don't have to be identical, however keeping them identical is less error prone and therefore in this codelab we will also use identical identifiers.

![5c4733ac560ae8c2.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/5c4733ac560ae8c2.png)

## 3\. Install the plugin

In this part of the codelab you'll install the in\_app\_purchase plugin.

## **Add dependency in pubspec**

Add `in_app_purchase` to the pubspec by adding `in_app_purchase` to the dependencies in your pubspec:

```
$ cd app
$ flutter pub add in_app_purchase
```

### [pubspec.yaml](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_07/app/pubspec.yaml#L23-L29)

```
dependencies:
  ..
  cloud_firestore: ^4.0.3
  firebase_auth: ^4.2.2
  firebase_core: ^2.5.0
  google_sign_in: ^6.0.1
  http: ^0.13.4
  in_app_purchase: ^3.0.1
  intl: ^0.18.0
  provider: ^6.0.2
  ..
```

Click **pub get** to download the package or run `flutter pub get` in the command line.

## 4\. Set up the App Store

To set up in-app purchases and test them on iOS, you need to create a new app in the App Store and create purchasable products there. You don't have to publish anything or send the app to Apple for review. You need a developer account to do this. If you don't have one, [enroll in the Apple developer program](https://developer.apple.com/programs/enroll/).

## **Paid Apps Agreements**

To use in-app purchases, you also need to have an active agreement for paid apps in App Store Connect. Go to [https://appstoreconnect.apple.com/](https://appstoreconnect.apple.com/), and click **Agreements, Tax, and Banking**.

![6e373780e5e24a6f.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/6e373780e5e24a6f.png)

You will see agreements here for free and paid apps. The status of free apps should be active, and the status for paid apps is new. Make sure that you view the terms, accept them, and enter all required information.

![74c73197472c9aec.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/74c73197472c9aec.png)

When everything is set correctly, the status for paid apps will be active. This is very important because you won't be able to try in-app purchases without an active agreement.

![4a100bbb8cafdbbf.jpeg](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/4a100bbb8cafdbbf.jpeg)

## **Register App ID**

Create a new identifier in the Apple developer portal.

![55d7e592d9a3fc7b.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/55d7e592d9a3fc7b.png)

Choose App IDs

![13f125598b72ca77.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/13f125598b72ca77.png)

Choose App

![41ac4c13404e2526.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/41ac4c13404e2526.png)

Provide some description and set the bundle ID to match the bundle ID to the same value as previously set in XCode.

![9d2c940ad80deeef.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/9d2c940ad80deeef.png)

For more guidance about how to create a new app ID, see the [Developer Account Help](https://help.apple.com/developer-account/#/dev1b35d6f83) .

## **Creating a new app**

Create a new app in App Store Connect with your unique bundle identifier.

![10509b17fbf031bd.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/10509b17fbf031bd.png)

![5b7c0bb684ef52c7.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/5b7c0bb684ef52c7.png)

For more guidance about how to create a new app and manage agreements, see the [App Store Connect help](https://help.apple.com/app-store-connect/).

To test the in-app purchases, you need a sandbox test user. This test user shouldn't be connected to iTunes—it's only used for testing in-app purchases. You can't use an email address that is already used for an Apple account. In **Users and Access**, go to **Testers** under **Sandbox** to create a new sandbox account or to manage the existing sandbox Apple IDs.

![3ca2b26d4e391a4c.jpeg](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/3ca2b26d4e391a4c.jpeg)

Now you can set up your sandbox user on your iPhone by going to **Settings > App Store > Sandbox-account.**

![c7dadad2c1d448fa.jpeg](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/c7dadad2c1d448fa.jpeg) ![5363f87efcddaa4.jpeg](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/5363f87efcddaa4.jpeg)

## **Configuring your in-app purchases**

Now you'll configure the three purchasable items:

-   `dash_consumable_2k`: A consumable purchase that can be purchased many times over, which grants the user 2000 Dashes (the in-app currency) per purchase.
-   `dash_upgrade_3d`: A non-consumable "upgrade" purchase that can only be purchased once, and gives the user a cosmetically different Dash to click.
-   `dash_subscription_doubler`: A subscription that grants the user twice as many Dashes per click for the duration of the subscription.

![d156b2f5bac43ca8.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/d156b2f5bac43ca8.png)

Go to **In-App Purchases > Manage**.

Create your in-app purchases with the specified IDs:

1.  Set up `dash_consumable_2k` as a **Consumable**.

Use `dash_consumable_2k` as the Product ID. The reference name is only used in app store connect, just set it to `dash consumable 2k` and add your localizations for the purchase. Call the purchase `Spring is in the air` with `2000 dashes fly out` as the description.

![ec1701834fd8527.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/ec1701834fd8527.png)

2.  Set up `dash_upgrade_3d` as a **Non-consumable**.

Use `dash_upgrade_3d` as the Product ID. Set the reference name to `dash upgrade 3d` and add your localizations for the purchase. Call the purchase `3D Dash` with `Brings your dash back to the future` as the description.

![6765d4b711764c30.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/6765d4b711764c30.png)

3.  Set up `dash_subscription_doubler` as an **Auto-renewing subscription**.

The flow for subscriptions is a bit different. First you'll have to set the Reference Name and Product ID:

![6d29e08dae26a0c4.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/6d29e08dae26a0c4.png)

Next, you have to create a subscription group. When multiple subscriptions are part of the same group, a user can only subscribe to one of these at the same time, but can easily upgrade or downgrade between these subscriptions. Just call this group `subscriptions`.

![5bd0da17a85ac076.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/5bd0da17a85ac076.png)

Next, enter the subscription duration and the localizations. Name this subscription `Jet Engine` with the description `Doubles your clicks`. Click **Save**.

![bd1b1d82eeee4cb3.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/bd1b1d82eeee4cb3.png)

After you've clicked the **Save** button, add a subscription price. Pick any price you desire.

![d0bf39680ef0aa2e.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/d0bf39680ef0aa2e.png)

You should now see the three purchases in the list of purchases:

![99d5c4b446e8fecf.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/99d5c4b446e8fecf.png)

## 5\. Set up the Play Store

As with the App Store, you'll also need a developer account for the Play Store. If you don't have one yet, [register an account](https://support.google.com/googleplay/android-developer/answer/6112435#zippy=%2Cstep-sign-up-for-a-google-play-developer-account).

## **Create a new app**

Create a new app in the Google Play Console:

1.  Open the [Play Console](https://play.google.com/console).
2.  Select **All apps > Create app.**
3.  Select a default language and add a title for your app. Type the name of your app as you want it to appear on Google Play. You can change the name later.
4.  Specify that your application is a game. You can change this later.
5.  Specify whether your application is free or paid.
6.  Add an email address that Play Store users can use to contact you about this application.
7.  Complete the Content guidelines and US export laws declarations.
8.  Select **Create app**.

After your app is created, go to the dashboard, and complete all the tasks in the **Set up your app** section. Here, you provide some information about your app, such as content ratings and screenshots. ![13845badcf9bc1db.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/13845badcf9bc1db.png)

## **Sign the application**

To be able to test in-app purchases, you need at least one build uploaded to Google Play.

For this, you need your release build to be signed with something other than the debug keys.

### Create a keystore

If you have an existing keystore, skip to the next step. If not, create one by running the following at the command line.

On Mac/Linux, use the following command:

```
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

On Windows, use the following command:

```
keytool -genkey -v -keystore c:\Users\USER_NAME\key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

This command stores the `key.jks` file in your home directory. If you want to store the file elsewhere, then change the argument you pass to the `-keystore` parameter. **Keep the**

**`keystore`**

**file private; don't check it into public source control!**

### Reference the keystore from the app

Create a file named `<your app dir>/android/key.properties` that contains a reference to your keystore:

```
storePassword=&lt;password from previous step&gt;
keyPassword=&lt;password from previous step&gt;
keyAlias=key
storeFile=&lt;location of the key store file, such as /Users/&lt;user name&gt;/key.jks&gt;
```

### Configure signing in Gradle

Configure signing for your app by editing the `<your app dir>/android/app/build.gradle` file.

Add the keystore information from your properties file before the `android` block:

```
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
         // omitted
   }
```

Load the `key.properties` file into the `keystoreProperties` object.

Add the following code before the `buildTypes` block:

```
   buildTypes {
       release {
           // TODO: Add your own signing config for the release build.
           // Signing with the debug keys for now,
           // so `flutter run --release` works.
           signingConfig signingConfigs.debug
       }
   }
```

Configure the `signingConfigs` block in your module's `build.gradle` file with the signing configuration information:

```
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
```

Release builds of your app will now be signed automatically.

For more information about signing your app, see [Sign your app](https://developer.android.com/studio/publish/app-signing.html#generate-key) on [developer.android.com](http://developer.android.com/).

## **Upload your first build**

After your app is configured for signing, you should be able to build your application by running:

```
flutter build appbundle
```

This command generates a release build by default and the output can be found at `<your app dir>/build/app/outputs/bundle/release/`

From the dashboard in the Google Play Console, go to **Release > Testing > Closed testing,** and create a new, closed testing release.

For this codelab, you'll stick to Google signing the app, so go ahead and press **Continue** under **Play App Signing** to opt in.

![ba98446d9c5c40e0.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/ba98446d9c5c40e0.png)

Next, upload the `app-release.aab` app bundle that was generated by the build command.

Click **Save** and then click **Review release.**

Finally, click **Start rollout to Internal testing** to activate the internal testing release.

## **Set up test users**

To be able to test in-app purchases, Google accounts of your testers must be added in the Google Play console in two locations:

1.  To the specific test track (Internal testing)
2.  As a license tester

First, start with adding the tester to the internal testing track. Go back to **Release > Testing > Internal testing** and click the **Testers** tab.

![a0d0394e85128f84.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/a0d0394e85128f84.png)

Create a new email list by clicking **Create email list**. Give the list a name, and add the email addresses of the Google accounts that need access to testing in-app purchases.

Next, select the checkbox for the list, and click **Save changes**.

Then, add the license testers:

1.  Go back to the **All apps** view of the Google Play Console.
2.  Go to **Settings > License testing**.
3.  Add the same email addresses of the testers who need to be able to test in-app purchases.
4.  Set **License response** to `RESPOND_NORMALLY`.
5.  Click **Save changes.**

![a1a0f9d3e55ea8da.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/a1a0f9d3e55ea8da.png)

## **Configuring your in-app purchases**

Now you'll configure the items that are purchasable within the app.

Just like in the App Store, you have to define three different purchases:

-   `dash_consumable_2k`: A consumable purchase that can be purchased many times over, which grants the user 2000 Dashes (the in-app currency) per purchase.
-   `dash_upgrade_3d`: A non-consumable "upgrade" purchase that can only be purchased once, which gives the user a cosmetically different Dash to click.
-   `dash_subscription_doubler`: A subscription that grants the user twice as many Dashes per click for the duration of the subscription.

First, add the consumable and non-consumable.

1.  Go to the Google Play Console, and select your application.
2.  Go to **Monetize > Products > In-app products**.
3.  Click **Create product**![c8d66e32f57dee21.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/c8d66e32f57dee21.png)
4.  Enter all the required information for your product. Make sure the product ID matches the ID that you intend to use exactly.
5.  Click **Save.**
6.  Click **Activate**.
7.  Repeat the process for the non-consumable "upgrade" purchase.

Next, add the subscription:

1.  Go to the Google Play Console, and select your application.
2.  Go to **Monetize > Products > Subscriptions**.
3.  Click **Create subscription**![32a6a9eefdb71dd0.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/32a6a9eefdb71dd0.png)
4.  Enter all the required information for your subscription. Make sure the product ID matches the ID you intend to use exactly.
5.  Click **Save**

Your purchases should now be set up in the Play Console.

## 6\. Set up Firebase

In this codelab, you'll use a backend service to verify and track users' purchases.

Using a backend service has several benefits:

-   You can securely verify transactions.
-   You can react to billing events from the app stores.
-   You can keep track of the purchases in a database.
-   Users won't be able to fool your app into providing premium features by rewinding their system clock.

While there are many ways to set up a backend service, you'll do this using cloud functions and Firestore, using Google's own Firebase.

Writing the backend is considered out of scope for this codelab, so the starter code already includes a Firebase project that handles basic purchases to get you started.

Firebase plugins are also included with the starter app.

What's left for you to do is to create your own Firebase project, configure both the app and backend for Firebase, and finally deploy the backend.

## **Create a Firebase project**

Go to the [Firebase console](https://firebase.google.com/), and create a new Firebase project. For this example, call the project Dash Clicker.

In the backend app, you tie purchases to a specific user, therefore, you need authentication. For this, leverage Firebase's authentication module with Google sign-in.

1.  From the Firebase dashboard, go to **Authentication** and enable it, if needed.
2.  Go to the **Sign-in method** tab, and enable the **Google** sign-in provider.

![7babb48832fbef29.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/7babb48832fbef29.png)

Because you'll also use Firebases's Firestore database, enable this too.

![e20553e0de5ac331.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/e20553e0de5ac331.png)

Set Cloud Firestore rules like this:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /purchases/{purchaseId} {
      allow read: if request.auth != null &amp;&amp; request.auth.uid == resource.data.userId
    }
  }
}
```

## **Set up Firebase for Flutter**

The recommended way to install Firebase on the Flutter app is to use the FlutterFire CLI. Follow the instructions as explained in the [setup page](https://firebase.google.com/docs/flutter/setup).

When running flutterfire configure, select the project you just created in the previous step.

```
$ flutterfire configure

i Found 5 Firebase projects.                                                                                                  
? Select a Firebase project to configure your Flutter application with ›                                                      
❯ in-app-purchases-1234 (in-app-purchases-1234)                                                                         
  other-flutter-codelab-1 (other-flutter-codelab-1)                                                                           
  other-flutter-codelab-2 (other-flutter-codelab-2)                                                                      
  other-flutter-codelab-3 (other-flutter-codelab-3)                                                                           
  other-flutter-codelab-4 (other-flutter-codelab-4)                                                                                                                                                               
  &lt;create a new project&gt;  
```

Next, enable **iOS** and **Android** by selecting the two platforms.

```
? Which platforms should your configuration support (use arrow keys &amp; space to select)? ›                                     
✔ android                                                                                                                     
✔ ios                                                                                                                         
  macos                                                                                                                       
  web                                                                                                                          
```

When prompted about overriding firebase\_options.dart, select yes.

```
? Generated FirebaseOptions file lib/firebase_options.dart already exists, do you want to override it? (y/n) › yes                                                                                                                         
```

## **Set up Firebase for Android: Further steps**

From the Firebase dashboard, go to **Project Overview,** choose **Settings** and select the **General** tab.

Scroll down to **Your apps**, and select the **dashclicker (android)** app.

![b22d46a759c0c834.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/b22d46a759c0c834.png)

To allow Google sign-in in debug mode, you must provide the SHA-1 hash fingerprint of your debug certificate.

### Get your debug signing certificate hash

In the root of your Flutter app project, change directory to the `android/` folder then generate a signing report.

```
cd android
./gradlew :app:signingReport
```

You'll be presented with a large list of signing keys. Because you're looking for the hash for the debug certificate, look for the certificate with the `Variant` and `Config` properties set to `debug`. It's likely for the keystore to be in your home folder under `.android/debug.keystore`.

```
&gt; Task :app:signingReport
Variant: debug
Config: debug
Store: /&lt;USER_HOME_FOLDER&gt;/.android/debug.keystore
Alias: AndroidDebugKey
MD5: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
SHA1: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
SHA-256: XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX:XX
Valid until: Tuesday, January 19, 2038
```

Copy the SHA-1 hash, and fill in the last field in the app submission modal dialog.

## **Set up Firebase for iOS: Further steps**

Open the `ios/Runnder.xcworkspace` with `Xcode`. Or with your IDE of choice.

On VSCode right click on the `ios/` folder and then `open in xcode`.

On Android Studio right click on the `ios/` folder then click on `flutter` followed by the `open iOS module in Xcode` option.

To allow for Google sign-in on iOS, add the `CFBundleURLTypes` configuration option to your build `plist` files. (Check the [`google_sign_in` package](https://pub.dev/packages/google_sign_in#ios-integration) docs for more information.) In this case, the files are `ios/Runner/Info-Debug.plist` and `ios/Runner/Info-Release.plist`.

The key-value pair was already added, but their values must be replaced:

1.  Get the value for `REVERSED_CLIENT_ID` from the `GoogleService-Info.plist` file, without the `<string>..</string>` element surrounding it.
2.  Replace the value in both your `ios/Runner/Info-Debug.plist` and `ios/Runner/Info-Release.plist` files under the `CFBundleURLTypes` key.

```
&lt;key&gt;CFBundleURLTypes&lt;/key&gt;
&lt;array&gt;
    &lt;dict&gt;
        &lt;key&gt;CFBundleTypeRole&lt;/key&gt;
        &lt;string&gt;Editor&lt;/string&gt;
        &lt;key&gt;CFBundleURLSchemes&lt;/key&gt;
        &lt;array&gt;
            &lt;!-- TODO Replace this value: --&gt;
            &lt;!-- Copied from GoogleService-Info.plist key REVERSED_CLIENT_ID --&gt;
            &lt;string&gt;com.googleusercontent.apps.REDACTED&lt;/string&gt;
        &lt;/array&gt;
    &lt;/dict&gt;
&lt;/array&gt;
```

You are now done with the Firebase setup.

## 7\. Listen to purchase updates

In this part of the codelab you'll prepare the app for purchasing the products. This process includes listening to purchase updates and errors after the app starts.

## **Listen to purchase updates**

In `main.dart,` find the widget `MyHomePage` that has a `Scaffold` with a `BottomNavigationBar` containing two pages. This page also creates three `Provider`s for `DashCounter`, `DashUpgrades,` and `DashPurchases`. `DashCounter` tracks the current count of Dashes and auto increments them. `DashUpgrades` manages the upgrades that you can buy with Dashes. This codelab focuses on `DashPurchases`.

By default, the object of a provider is defined when that object is first requested. This object listens to purchase updates directly when the app starts, so disable lazy loading on this object with `lazy: false`:

### [lib/main.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_07/app/lib/main.dart#L79-L84)

```
ChangeNotifierProvider&lt;DashPurchases&gt;(
  create: (context) =&gt; DashPurchases(
    context.read&lt;DashCounter&gt;(),
  ),
  lazy: false,
),
```

You also need an instance of the `InAppPurchaseConnection`. However, to keep the app testable you need some way to mock the connection. To do this, create an instance method that can be overridden in the test, and add it to `main.dart`.

### [lib/main.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_07/app/lib/main.dart#L12-L24)

```
// Gives the option to override in tests.
class IAPConnection {
  static InAppPurchase? _instance;
  static set instance(InAppPurchase value) {
    _instance = value;
  }

  static InAppPurchase get instance {
    _instance ??= InAppPurchase.instance;
    return _instance!;
  }
}
```

You must slightly update the test if you want the test to keep working. Check [widget\_test.dart](https://github.com/flutter/codelabs/blob/master/in_app_purchases/step_07/app/test/widget_test.dart) on GitHub for the full code for `TestIAPConnection`.

### [test/widget\_test.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_07/app/test/widget_test.dart#L7-L13)

```
void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    IAPConnection.instance = TestIAPConnection();
    await tester.pumpWidget(const MyApp());
    expect(find.text('Tim Sneath'), findsOneWidget);
  });
}
```

In `lib/logic/dash_purchases.dart`, go to the code for `DashPurchases ChangeNotifier`. Currently, there is only a `DashCounter` that you can add to your purchased Dashes.

Add a stream subscription property, `_subscription` (of type `StreamSubscription<List<PurchaseDetails>> _subscription;`), the `IAPConnection.instance,` and the imports. The resulting code should look at follows:

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_07/app/lib/logic/dash_purchases.dart#L14)

```
import 'package:in_app_purchase/in_app_purchase.dart';

class DashPurchases extends ChangeNotifier {
  late StreamSubscription&lt;List&lt;PurchaseDetails&gt;&gt; _subscription;
  final iapConnection = IAPConnection.instance;

  DashPurchases(this.counter);
}
```

The `late` keyword is added to `_subscription` because the `_subscription` is initialized in the constructor. This project is set up to be non-nullable by default (NNBD), which means that properties that aren't declared nullable must have a non-null value. The `late` qualifier lets you delay defining this value.

In the constructor, get the `purchaseUpdatedStream` and start listening to the stream. In the `dispose()` method, cancel the stream subscription.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_07/app/lib/logic/dash_purchases.dart#L31-L69)

```
class DashPurchases extends ChangeNotifier {
  DashCounter counter;
  late StreamSubscription&lt;List&lt;PurchaseDetails&gt;&gt; _subscription;
  final iapConnection = IAPConnection.instance;

  DashPurchases(this.counter) {
    final purchaseUpdated =
        iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future&lt;void&gt; buy(PurchasableProduct product) async {
    // omitted
  }

  void _onPurchaseUpdate(List&lt;PurchaseDetails&gt; purchaseDetailsList) {
    // Handle purchases here
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    //Handle error here
  }
}
```

Now, the app receives the purchase updates so, in the next section, you'll make a purchase!

Before you proceed, run the tests with "`flutter test"` to verify everything is set up correctly.

```
$ flutter test

00:01 +1: All tests passed!                                                                                   
```                                                                                   
## 8\. Make purchases

In this part of the codelab, you'll replace the currently existing mock products with real purchasable products. These products are loaded from the stores, shown in a list, and are purchased when tapping the product.

## **Adapt PurchasableProduct**

`PurchasableProduct` displays a mock product. Update it to show actual content by replacing the `PurchasableProduct` class in `purchasable_product.dart` with the following code:

### [lib/model/purchasable\_product.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/model/purchasable_product.dart)

```
import 'package:in_app_purchase/in_app_purchase.dart';

enum ProductStatus {
  purchasable,
  purchased,
  pending,
}

class PurchasableProduct {
  String get id =&gt; productDetails.id;
  String get title =&gt; productDetails.title;
  String get description =&gt; productDetails.description;
  String get price =&gt; productDetails.price;
  ProductStatus status;
  ProductDetails productDetails;

  PurchasableProduct(this.productDetails) : status = ProductStatus.purchasable;
}
```

In `dash_purchases.dart,` remove the dummy purchases and replace them with an empty list, `List<PurchasableProduct> products = [];`

## **Load available purchases**

To give a user the ability to make a purchase, load the purchases from the store. First, check whether the store is available. When the store isn't available, setting `storeState` to `notAvailable` displays an error message to the user.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/logic/dash_purchases.dart#L32-L38)

```
  Future&lt;void&gt; loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      storeState = StoreState.notAvailable;
      notifyListeners();
      return;
    }
  }
```

When the store is available, load the available purchases. Given the previous Firebase setup, expect to see `storeKeyConsumable`, `storeKeySubscription,` and `storeKeyUpgrade`. When an expected purchase isn't available, print this information to the console; you might also want to send this info to the backend service.

The `await iapConnection.queryProductDetails(ids)` method returns both the IDs that aren't found and the purchasable products that are found. Use the `productDetails` from the response to update the UI, and set the `StoreState` to `available`.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/logic/dash_purchases.dart#L32-L52)

```
import '../constants.dart';

  Future&lt;void&gt; loadPurchases() async {
    final available = await iapConnection.isAvailable();
    if (!available) {
      storeState = StoreState.notAvailable;
      notifyListeners();
      return;
    }
    const ids = &lt;String&gt;{
      storeKeyConsumable,
      storeKeySubscription,
      storeKeyUpgrade,
    };
    final response = await iapConnection.queryProductDetails(ids);
    for (var element in response.notFoundIDs) {
      debugPrint('Purchase $element not found');
    }
    products = response.productDetails.map((e) =&gt; PurchasableProduct(e)).toList();
    storeState = StoreState.available;
    notifyListeners();
  }
```

Call the `loadPurchases()` function in the constructor:

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/logic/dash_purchases.dart#L29)

```
  DashPurchases(this.counter) {
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    loadPurchases();
  }
```

Finally, change the value of `storeState` field from `StoreState.available` to `StoreState.loading:`

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/logic/dash_purchases.dart#L14)

```
StoreState storeState = StoreState.loading;
```

## **Show the purchasable products**

Consider the `purchase_page.dart` file. The `PurchasePage` widget shows `_PurchasesLoading`, `_PurchaseList,` or `_PurchasesNotAvailable,` depending on the `StoreState`. The widget also shows the user's past purchases which is used in the next step.

The `_PurchaseList` widget shows the list of purchasable products and sends a buy request to the `DashPurchases` object.

### [lib/pages/purchase\_page.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/pages/purchase_page.dart#L53-L68)

```
class _PurchaseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var purchases = context.watch&lt;DashPurchases&gt;();
    var products = purchases.products;
    return Column(
      children: products
          .map((product) =&gt; _PurchaseWidget(
              product: product,
              onPressed: () {
                purchases.buy(product);
              }))
          .toList(),
    );
  }
}
```

You should be able to see the available products on the Android and iOS stores if they are configured correctly. Note that it can take some time before the purchases are available when entered into the respective consoles.

![ca1a9f97c21e552d.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/ca1a9f97c21e552d.png)

Go back to `dash_purchases.dart`, and implement the function to buy a product. You only need to separate the consumables from the non-consumables. The upgrade and the subscription products are non-consumables.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/logic/dash_purchases.dart#L60-L74)

```
  Future&lt;void&gt; buy(PurchasableProduct product) async {
    final purchaseParam = PurchaseParam(productDetails: product.productDetails);
    switch (product.id) {
      case storeKeyConsumable:
        await iapConnection.buyConsumable(purchaseParam: purchaseParam);
        break;
      case storeKeySubscription:
      case storeKeyUpgrade:
        await iapConnection.buyNonConsumable(purchaseParam: purchaseParam);
        break;
      default:
        throw ArgumentError.value(
            product.productDetails, '${product.id} is not a known product');
    }
  }
```

Before continuing, create the variable `_beautifiedDashUpgrade` and update the `beautifiedDash` getter to reference it.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/logic/dash_purchases.dart#L76-L99)

```
  bool get beautifiedDash =&gt; _beautifiedDashUpgrade;
  bool _beautifiedDashUpgrade = false;
```

The `_onPurchaseUpdate` method receives the purchase updates, updates the status of the product that is shown in the purchase page, and applies the purchase to the counter logic. It's important to call `completePurchase` after handling the purchase so the store knows the purchase is handled correctly.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_08/app/lib/logic/dash_purchases.dart#L76-L99)

```
  Future&lt;void&gt; _onPurchaseUpdate(
      List&lt;PurchaseDetails&gt; purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    notifyListeners();
  }

  Future&lt;void&gt; _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      switch (purchaseDetails.productID) {
        case storeKeySubscription:
          counter.applyPaidMultiplier();
          break;
        case storeKeyConsumable:
          counter.addBoughtDashes(2000);
          break;
        case storeKeyUpgrade:
          _beautifiedDashUpgrade = true;
          break;
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iapConnection.completePurchase(purchaseDetails);
    }
  }
```

## 9\. Set up the backend

Before moving on to tracking and verifying purchases, set up a Dart backend to support doing so.

In this section, work from the `dart-backend/` folder as the root.

Make sure that you have the following tools installed:

-   Dart
-   [Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)

## **Base project overview**

Because some parts of this project are considered out of scope for this codelab, they are included in the starter code. It's a good idea to go over what is already in the starter code before you get started, to get an idea of how you're going to structure things.

This backend code can run locally on your machine, you don't need to deploy it to use it. However, you need to be able to connect from your development device (Android or iPhone) to the machine where the server will run. For that, they have to be in the same network, and you need to know the IP address of your machine.

Try to run the server using the following command:

```
$ dart ./bin/server.dart

Serving at http://0.0.0.0:8080
```

The Dart backend uses [`shelf`](https://pub.dev/packages/shelf) and [`shelf_router`](https://pub.dev/packages/shelf_router) to serve API endpoints. By default, the server doesn't provide any routes. Later on you will create a route to handle the purchase verification process.

One part that is already included in the starter code is the `IapRepository` in `lib/iap_repository.dart`. Because learning how to interact with Firestore, or databases in general, isn't considered to be relevant to this codelab, the starter code contains functions for you to create or update purchases in the Firestore, as well as all the classes for those purchases.

## **Set up Firebase access**

To access Firebase Firestore, you need a service account access key. Generate one opening the Firebase project settings and navigate to the **Service accounts** section, then select **Generate new private key**.

![27590fc77ae94ad4.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/27590fc77ae94ad4.png)

Copy the downloaded JSON file to the `assets/` folder, and rename it to `service-account-firebase.json`.

## **Set up Google Play access**

To access the Play Store for verifying purchases, you must generate a service account with these permissions, and download the JSON credentials for it.

1.  Go to the Google Play Console, and start from the **All apps** page.
2.  Go to **Setup > API access**. ![317fdfb54921f50e.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/317fdfb54921f50e.png) In case the Google Play Console requests that you create or link to an existing project, do so first and then come back to this page.
3.  Find the section where you can define service accounts, and click **Create new service account.**![1e70d3f8d794bebb.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/1e70d3f8d794bebb.png)
4.  Click the **Google Cloud Platform** link in the dialog that pops up. ![7c9536336dd9e9b4.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/7c9536336dd9e9b4.png)
5.  Select your project. If you don't see it, make sure that you are signed in to the correct Google account under the **Account** drop-down list in the top right. ![3fb3a25bad803063.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/3fb3a25bad803063.png)
6.  After selecting your project, click **\+ Create Service Account** in the top menu bar. ![62fe4c3f8644acd8.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/62fe4c3f8644acd8.png)
7.  Provide a name for the service account, optionally provide a description so that you'll remember what it's for, and go to the next step. ![8a92d5d6a3dff48c.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/8a92d5d6a3dff48c.png)
8.  Assign the service account the **Editor** role. ![6052b7753667ed1a.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/6052b7753667ed1a.png)
9.  Finish the wizard, go back to the **API Access** page within the developer console, and click **Refresh service accounts.** You should see your newly created account in the list. ![5895a7db8b4c7659.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/5895a7db8b4c7659.png)
10.  Click **Grant access** for your new service account.
11.  Scroll down the next page, to the **Financial data** block. Select both **View financial data, orders, and cancellation survey responses** and **Manage orders and subscriptions**. ![75b22d0201cf67e.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/75b22d0201cf67e.png)
12.  Click **Invite user**. ![70ea0b1288c62a59.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/70ea0b1288c62a59.png)
13.  Now that the account is set up, you just need to generate some credentials. Back in the cloud console, find your service account in the list of service accounts, click the three vertical dots, and choose **Manage keys**. ![853ee186b0e9954e.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/853ee186b0e9954e.png)
14.  Create a new JSON key and download it. ![2a33a55803f5299c.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/2a33a55803f5299c.png) ![cb4bf48ebac0364e.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/cb4bf48ebac0364e.png)
15.  Rename the downloaded file to `service-account-google-play.json,` and move it into the `assets/` directory.

One more thing we need to do is open `lib/constants.dart,` and replace the value of `androidPackageId` with the package ID that you chose for your Android app.

## **Set up Apple App Store access**

To access the App Store for verifying purchases, you have to set up a shared secret:

1.  Open [App Store Connect](https://appstoreconnect.apple.com/).
2.  Go to **My Apps,** and select your app.
3.  In the sidebar navigation, go to **In-App Purchases > Manage**.
4.  At the top right of the list, click **App-Specific Shared Secret.**
5.  Generate a new secret, and copy it.
6.  Open `lib/constants.dart,` and replace the value of `appStoreSharedSecret` with the shared secret you just generated.

![d8b8042470aaeff.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/d8b8042470aaeff.png)

![b72f4565750e2f40.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/b72f4565750e2f40.png)

**Constants configuration file**

Before proceeding, make sure that the following constants are configured in the `lib/constants.dart` file:

-   `androidPackageId`: Package ID used on Android. e.g. `com.example.dashclicker`
-   `appStoreSharedSecret`: Shared secret to access App Store Connect to perform purchase verification.
-   `bundleId`: Bundle ID used on iOS. e.g. `com.example.dashclicker`

You can ignore the rest of the constants for the time being.

## 10\. Verify purchases

The general flow for verifying purchases is similar for iOS and Android.

For both stores, your application receives a token when a purchase is made.

This token is sent by the app to your backend service, which then, in turn, verifies the purchase with the respective store's servers using the provided token.

The backend service can then choose to store the purchase, and reply to the application whether the purchase was valid or not.

By having the backend service do the validation with the stores rather than the application running on your user's device, you can prevent the user gaining access to premium features by, for example, rewinding their system clock.

## Set up the Flutter side

### **Set up authentication**

As you are going to send the purchases to your backend service, you want to make sure the user is authenticated while making a purchase. Most of the authentication logic is already added for you in the starter project, you just have to make sure the `PurchasePage` shows the login button when the user is not logged in yet. Add the following code to the beginning of the build method of `PurchasePage`:

### [lib/pages/purchase\_page.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/app/lib/pages/purchase_page.dart#L15-L27)

```
import '../logic/firebase_notifier.dart';
import '../model/firebase_state.dart';
import 'login_page.dart';

class PurchasePage extends StatelessWidget {  
  const PurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firebaseNotifier = context.watch&lt;FirebaseNotifier&gt;();
    if (firebaseNotifier.state == FirebaseState.loading) {
      return _PurchasesLoading();
    } else if (firebaseNotifier.state == FirebaseState.notAvailable) {
      return _PurchasesNotAvailable();
    }

    if (!firebaseNotifier.loggedIn) {
      return const LoginPage();
    }
    // omitted
```

### **Call verification endpoint from the app**

In the app, create the `_verifyPurchase(PurchaseDetails purchaseDetails)` function that calls the `/verifypurchase` endpoint on your Dart backend using an http post call.

Send the selected store (`google_play` for the Play Store or `app_store` for the App Store), the `serverVerificationData`, and the `productID`. The server returns status code indicating whether the purchase is verified.

In the app constants, configure the server IP to your local machine IP address.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/app/lib/logic/dash_purchases.dart#L16-L25)

```
  FirebaseNotifier firebaseNotifier;

  DashPurchases(this.counter, this.firebaseNotifier) {
    // omitted
  }
```

Add the `firebaseNotifier` with the creation of `DashPurchases` in `main.dart:`

### [lib/main.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/app/lib/main.dart#L79-L85)

```
        ChangeNotifierProvider&lt;DashPurchases&gt;(
          create: (context) =&gt; DashPurchases(
            context.read&lt;DashCounter&gt;(),
            context.read&lt;FirebaseNotifier&gt;(),
          ),
          lazy: false,
        ),
```

Add a getter for the User in the FirebaseNotifier, so you can pass the user ID to the verify purchase function.

### [lib/logic/firebase\_notifier.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/app/lib/logic/firebase_notifier.dart#L32-L33)

```
  User? get user =&gt; FirebaseAuth.instance.currentUser;
```

Add the function `_verifyPurchase` to the `DashPurchases` class. This `async` function returns a boolean indicating whether the purchase is validated.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/app/lib/logic/dash_purchases.dart#L119-L130)

```
  Future&lt;bool&gt; _verifyPurchase(PurchaseDetails purchaseDetails) async {
    final url = Uri.parse('http://$serverIp:8080/verifypurchase');
    const headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(
      url,
      body: jsonEncode({
        'source': purchaseDetails.verificationData.source,
        'productId': purchaseDetails.productID,
        'verificationData':
            purchaseDetails.verificationData.serverVerificationData,
        'userId': firebaseNotifier.user?.uid,
      }),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print('Successfully verified purchase');
      return true;
    } else {
      print('failed request: ${response.statusCode} - ${response.body}');
      return false;
    }
  }
```

Call the `_verifyPurchase` function in `_handlePurchase` just before you apply the purchase. You should only apply the purchase when it's verified. In a production app, you can specify this further to, for example, apply a trial subscription when the store is temporarily unavailable. However, for this example, keep it simple, and only apply the purchase when the purchase is verified successfully.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/app/lib/logic/dash_purchases.dart#L86-L117)

```
  Future&lt;void&gt; _onPurchaseUpdate(
      List&lt;PurchaseDetails&gt; purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      await _handlePurchase(purchaseDetails);
    }
    notifyListeners();
  }

  Future&lt;void&gt; _handlePurchase(PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.purchased) {
      // Send to server
      var validPurchase = await _verifyPurchase(purchaseDetails);

      if (validPurchase) {
        // Apply changes locally
        switch (purchaseDetails.productID) {
          case storeKeySubscription:
            counter.applyPaidMultiplier();
            break;
          case storeKeyConsumable:
            counter.addBoughtDashes(1000);
            break;
        }
      }
    }

    if (purchaseDetails.pendingCompletePurchase) {
      await iapConnection.completePurchase(purchaseDetails);
    }
  }
```

In the app everything is now ready to validate the purchases.

## **Set up the backend service**

Next, set up the cloud function for verifying purchases on the backend.

### **Build purchase handlers**

Because the verification flow for both stores is close to identical, set up an abstract `PurchaseHandler` class with separate implementations for each store.

![be50c207c5a2a519.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/be50c207c5a2a519.png)

Start by adding a `purchase_handler.dart` file to the `lib/` folder, where you define an abstract `PurchaseHandler` class with two abstract methods for verifying two different kinds of purchases: subscriptions and non-subscriptions.

### [lib/purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/purchase_handler.dart)

```
import 'products.dart';

/// Generic purchase handler,
/// must be implemented for Google Play and Apple Store
abstract class PurchaseHandler {

  /// Verify if non-subscription purchase (aka consumable) is valid
  /// and update the database
  Future&lt;bool&gt; handleNonSubscription({
    required String userId,
    required ProductData productData,
    required String token,
  });

  /// Verify if subscription purchase (aka non-consumable) is valid
  /// and update the database
  Future&lt;bool&gt; handleSubscription({
    required String userId,
    required ProductData productData,
    required String token,
  });
}

```

As you can see, each method requires three parameters:

-   `userId:` The ID of the logged-in user, so you can tie purchases to the user.
-   `productData:` Data about the product. You are going to define this in a minute.
-   `token:` The token provided to the user by the store.

Additionally, to make these purchase handlers easier to use, add a `verifyPurchase()` method that can be used for both subscriptions and non-subscriptions:

### [lib/purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/purchase_handler.dart)

```
  /// Verify if purchase is valid and update the database
  Future&lt;bool&gt; verifyPurchase({
    required String userId,
    required ProductData productData,
    required String token,
  }) async {
    switch (productData.type) {
      case ProductType.subscription:
        return handleSubscription(
          userId: userId,
          productData: productData,
          token: token,
        );
      case ProductType.nonSubscription:
        return handleNonSubscription(
          userId: userId,
          productData: productData,
          token: token,
        );
    }
  }
```

Now, you can just call `verifyPurchase` for both cases, but still have separate implementations!

The `ProductData` class contains basic information about the different purchasable products, which includes the product ID (sometimes also referred to as SKU) and the `ProductType`.

### [lib/products.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/products.dart)

```
class ProductData {
  final String productId;
  final ProductType type;

  const ProductData(this.productId, this.type);
}
```

The `ProductType` can either be a subscription or a non-subscription.

### [lib/products.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/products.dart)

```
enum ProductType {
  subscription,
  nonSubscription,
}
```

Finally, the list of products is defined as a map in the same file.

### [lib/products.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/products.dart)

```
const productDataMap = {
  'dash_consumable_2k': ProductData(
    'dash_consumable_2k',
    ProductType.nonSubscription,
  ),
  'dash_upgrade_3d': ProductData(
    'dash_upgrade_3d',
    ProductType.nonSubscription,
  ),
  'dash_subscription_doubler': ProductData(
    'dash_subscription_doubler',
    ProductType.subscription,
  ),
};
```

Next, define some placeholder implementations for the Google Play Store and the Apple App Store. Start with Google Play:

Create `lib/google_play_purchase_handler.dart`, and add a class that extends the `PurchaseHandler` you just wrote:

### [lib/google\_play\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/master/in_app_purchases/step_09/dart-backend/lib/google_play_purchase_handler.dart)

```
import 'dart:async';

import 'package:googleapis/androidpublisher/v3.dart' as ap;

import 'constants.dart';
import 'iap_repository.dart';
import 'products.dart';
import 'purchase_handler.dart';

class GooglePlayPurchaseHandler extends PurchaseHandler {
  final ap.AndroidPublisherApi androidPublisher;
  final IapRepository iapRepository;

  GooglePlayPurchaseHandler(
    this.androidPublisher,
    this.iapRepository,
  );

  @override
  Future&lt;bool&gt; handleNonSubscription({
    required String? userId,
    required ProductData productData,
    required String token,
  }) async {
    return true;
  }

  @override
  Future&lt;bool&gt; handleSubscription({
    required String? userId,
    required ProductData productData,
    required String token,
  }) async {
    return true;
  }
}
```

For now, it returns `true` for the handler methods; you'll get to them later.

As you might have noticed, the constructor takes an instance of the `IapRepository`. The purchase handler uses this instance to store information about purchases in Firestore later on. To communicate with Google Play, you use the provided `AndroidPublisherApi`.

Next, do the same for the app store handler. Create `lib/app_store_purchase_handler.dart`, and add a class that extends the `PurchaseHandler` again:

### [lib/app\_store\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/master/in_app_purchases/step_09/dart-backend/lib/app_store_purchase_handler.dart)

```
import 'dart:async';

import 'package:app_store_server_sdk/app_store_server_sdk.dart';

import 'constants.dart';
import 'iap_repository.dart';
import 'products.dart';
import 'purchase_handler.dart';

class AppStorePurchaseHandler extends PurchaseHandler {
  final IapRepository iapRepository;

  AppStorePurchaseHandler(
    this.iapRepository,
  );

  @override
  Future&lt;bool&gt; handleNonSubscription({
    required String userId,
    required ProductData productData,
    required String token,
  }) {
    return true;
  }

  @override
  Future&lt;bool&gt; handleSubscription({
    required String userId,
    required ProductData productData,
    required String token,
  }) {
    return true;
  }
}
```

Great! Now you have two purchase handlers. Next, let's create the purchase verification API endpoint.

### **Use purchase handlers**

Open `bin/server.dart` and create an API endpoint using `shelf_route`:

### [bin/server.dart](https://github.com/flutter/codelabs/blob/master/in_app_purchases/step_09/dart-backend/bin/server.dart)

```
Future&lt;void&gt; main() async {
  final router = Router();

  final purchaseHandlers = await _createPurchaseHandlers();

  router.post('/verifypurchase', (Request request) async {
    final dynamic payload = json.decode(await request.readAsString());

    final (:userId, :source, :productData, :token) = getPurchaseData(payload);

    final result = await purchaseHandlers[source]!.verifyPurchase(
      userId: userId,
      productData: productData,
      token: token,
    );

    if (result) {
      return Response.ok('all good!');
    } else {
      return Response.internalServerError();
    }
  });

  await serveHandler(router);
}

({
  String userId,
  String source,
  ProductData productData,
  String token,
}) getPurchaseData(dynamic payload) {
  if (payload
      case {
        'userId': String userId,
        'source': String source,
        'productId': String productId,
        'verificationData': String token,
      }) {
    return (
      userId: userId,
      source: source,
      productData: productDataMap[productId]!,
      token: token,
    );
  } else {
    throw const FormatException('Unexpected JSON');
  }
}
```

The above code is doing the following:

1.  Define a POST endpoint that will be called from the app you created previously.
2.  Decode the JSON payload and extract the following information:
3.  `userId`: Currently logged in user ID
4.  `source`: Store used, either `app_store` or `google_play`.
5.  `productData`: Obtained from the `productDataMap` you created previously.
6.  `token`: Contains the verification data to send to the stores.
7.  Call to the `verifyPurchase` method, either for the `GooglePlayPurchaseHandler` or the `AppStorePurchaseHandler`, depending on the source.
8.  If the verification was successful, the method returns a `Response.ok` to the client.
9.  If the verification fails, the method returns a `Response.internalServerError` to the client.

After creating the API endpoint, you need to configure the two purchase handlers. This requires you to load the service account keys you obtained in the previous step and configure the access to the different services, including the Android Publisher API and the Firebase Firestore API. Then, create the two purchase handlers with the different dependencies:

### [bin/server.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/bin/server.dart)

```
Future&lt;Map&lt;String, PurchaseHandler&gt;&gt; _createPurchaseHandlers() async {
  // Configure Android Publisher API access
  final serviceAccountGooglePlay =
      File('assets/service-account-google-play.json').readAsStringSync();
  final clientCredentialsGooglePlay =
      auth.ServiceAccountCredentials.fromJson(serviceAccountGooglePlay);
  final clientGooglePlay =
      await auth.clientViaServiceAccount(clientCredentialsGooglePlay, [
    ap.AndroidPublisherApi.androidpublisherScope,
  ]);
  final androidPublisher = ap.AndroidPublisherApi(clientGooglePlay);

  // Configure Firestore API access
  final serviceAccountFirebase =
      File('assets/service-account-firebase.json').readAsStringSync();
  final clientCredentialsFirebase =
      auth.ServiceAccountCredentials.fromJson(serviceAccountFirebase);
  final clientFirebase =
      await auth.clientViaServiceAccount(clientCredentialsFirebase, [
    fs.FirestoreApi.cloudPlatformScope,
  ]);
  final firestoreApi = fs.FirestoreApi(clientFirebase);
  final dynamic json = jsonDecode(serviceAccountFirebase);
  final projectId = json['project_id'] as String;
  final iapRepository = IapRepository(firestoreApi, projectId);

  return {
    'google_play': GooglePlayPurchaseHandler(
      androidPublisher,
      iapRepository,
    ),
    'app_store': AppStorePurchaseHandler(
      iapRepository,
    ),
  };
}
```

**Verify Android purchases: Implement the purchase hander**

Next, continue implementing the Google Play purchase handler.

Google already provides Dart packages for interacting with the APIs you need to verify purchases. You initialized them in the `server.dart` file and now use them in the `GooglePlayPurchaseHandler` class.

Implement the handler for non-subscription-type purchases:

### [lib/google\_play\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/google_play_purchase_handler.dart)

```
  @override
  Future&lt;bool&gt; handleNonSubscription({
    required String? userId,
    required ProductData productData,
    required String token,
  }) async {
    print(
      'GooglePlayPurchaseHandler.handleNonSubscription'
      '($userId, ${productData.productId}, ${token.substring(0, 5)}...)',
    );

    try {
      // Verify purchase with Google
      final response = await androidPublisher.purchases.products.get(
        androidPackageId,
        productData.productId,
        token,
      );

      print('Purchases response: ${response.toJson()}');

      // Make sure an order id exists
      if (response.orderId == null) {
        print('Could not handle purchase without order id');
        return false;
      }
      final orderId = response.orderId!;

      final purchaseData = NonSubscriptionPurchase(
        purchaseDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(response.purchaseTimeMillis ?? '0'),
        ),
        orderId: orderId,
        productId: productData.productId,
        status: _nonSubscriptionStatusFrom(response.purchaseState),
        userId: userId,
        iapSource: IAPSource.googleplay,
      );

      // Update the database
      if (userId != null) {
        // If we know the userId,
        // update the existing purchase or create it if it does not exist.
        await iapRepository.createOrUpdatePurchase(purchaseData);
      } else {
        // If we do not know the user id, a previous entry must already
        // exist, and thus we'll only update it.
        await iapRepository.updatePurchase(purchaseData);
      }
      return true;
    } on ap.DetailedApiRequestError catch (e) {
      print(
        'Error on handle NonSubscription: $e\n'
        'JSON: ${e.jsonResponse}',
      );
    } catch (e) {
      print('Error on handle NonSubscription: $e\n');
    }
    return false;
  }
```

You can update the subscription purchase handler in a similar way:

### [lib/google\_play\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/google_play_purchase_handler.dart)

```
  /// Handle subscription purchases.
  ///
  /// Retrieves the purchase status from Google Play and updates
  /// the Firestore Database accordingly.
  @override
  Future&lt;bool&gt; handleSubscription({
    required String? userId,
    required ProductData productData,
    required String token,
  }) async {
    print(
      'GooglePlayPurchaseHandler.handleSubscription'
      '($userId, ${productData.productId}, ${token.substring(0, 5)}...)',
    );

    try {
      // Verify purchase with Google
      final response = await androidPublisher.purchases.subscriptions.get(
        androidPackageId,
        productData.productId,
        token,
      );

      print('Subscription response: ${response.toJson()}');

      // Make sure an order id exists
      if (response.orderId == null) {
        print('Could not handle purchase without order id');
        return false;
      }
      final orderId = extractOrderId(response.orderId!);

      final purchaseData = SubscriptionPurchase(
        purchaseDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(response.startTimeMillis ?? '0'),
        ),
        orderId: orderId,
        productId: productData.productId,
        status: _subscriptionStatusFrom(response.paymentState),
        userId: userId,
        iapSource: IAPSource.googleplay,
        expiryDate: DateTime.fromMillisecondsSinceEpoch(
          int.parse(response.expiryTimeMillis ?? '0'),
        ),
      );

      // Update the database
      if (userId != null) {
        // If we know the userId,
        // update the existing purchase or create it if it does not exist.
        await iapRepository.createOrUpdatePurchase(purchaseData);
      } else {
        // If we do not know the user id, a previous entry must already
        // exist, and thus we'll only update it.
        await iapRepository.updatePurchase(purchaseData);
      }
      return true;
    } on ap.DetailedApiRequestError catch (e) {
      print(
        'Error on handle Subscription: $e\n'
        'JSON: ${e.jsonResponse}',
      );
    } catch (e) {
      print('Error on handle Subscription: $e\n');
    }
    return false;
  }
}
```

Add the following method to facilitate the parsing of order IDs, as well as two methods to parse the purchase status.

### [lib/google\_play\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/google_play_purchase_handler.dart)

```
/// If a subscription suffix is present (..#) extract the orderId.
String extractOrderId(String orderId) {
  final orderIdSplit = orderId.split('..');
  if (orderIdSplit.isNotEmpty) {
    orderId = orderIdSplit[0];
  }
  return orderId;
}

NonSubscriptionStatus _nonSubscriptionStatusFrom(int? state) {
  return switch (state) {
    0 =&gt; NonSubscriptionStatus.completed,
    2 =&gt; NonSubscriptionStatus.pending,
    _ =&gt; NonSubscriptionStatus.cancelled,
  };
}

SubscriptionStatus _subscriptionStatusFrom(int? state) {
  return switch (state) {
    // Payment pending
    0 =&gt; SubscriptionStatus.pending,
    // Payment received
    1 =&gt; SubscriptionStatus.active,
    // Free trial
    2 =&gt; SubscriptionStatus.active,
    // Pending deferred upgrade/downgrade
    3 =&gt; SubscriptionStatus.pending,
    // Expired or cancelled
    _ =&gt; SubscriptionStatus.expired,
  };
}
```

Your Google Play purchases should now be verified and stored in the database.

Next, move on to App Store purchases for iOS.

### **Verify iOS purchases: Implement the purchase handler**

For verifying purchases with the App Store, a third-party Dart package exists named [`app_store_server_sdk`](https://pub.dev/packages/app_store_server_sdk) that makes the process easier.

Start by creating the `ITunesApi` instance. Use the sandbox configuration, as well as enable logging to facilitate error debugging.

### [lib/app\_store\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/app_store_purchase_handler.dart)

```
  final _iTunesAPI = ITunesApi(
    ITunesHttpClient(
      ITunesEnvironment.sandbox(),
      loggingEnabled: true,
    ),
  );
```

Now, unlike the Google Play APIs, the App Store uses the same API endpoints for both subscriptions and non-subscriptions. This means that you can use the same logic for both handlers. Merge them together so they call the same implementation:

### [lib/app\_store\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/app_store_purchase_handler.dart)

```
  @override
  Future&lt;bool&gt; handleNonSubscription({
    required String userId,
    required ProductData productData,
    required String token,
  }) {
    return handleValidation(userId: userId, token: token);
  }

  @override
  Future&lt;bool&gt; handleSubscription({
    required String userId,
    required ProductData productData,
    required String token,
  }) {
    return handleValidation(userId: userId, token: token);
  }

  /// Handle purchase validation.
  Future&lt;bool&gt; handleValidation({
    required String userId,
    required String token,
  }) async {
   //..
  }
```

Now, implement `handleValidation`:

### [lib/app\_store\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/step_09/dart-backend/lib/app_store_purchase_handler.dart)

```
  /// Handle purchase validation.
  Future&lt;bool&gt; handleValidation({
    required String userId,
    required String token,
  }) async {
    print('AppStorePurchaseHandler.handleValidation');
    final response = await _iTunesAPI.verifyReceipt(
      password: appStoreSharedSecret,
      receiptData: token,
    );
    print('response: $response');
    if (response.status == 0) {
      print('Successfully verified purchase');
      final receipts = response.latestReceiptInfo ?? [];
      for (final receipt in receipts) {
        final product = productDataMap[receipt.productId];
        if (product == null) {
          print('Error: Unknown product: ${receipt.productId}');
          continue;
        }
        switch (product.type) {
          case ProductType.nonSubscription:
            await iapRepository.createOrUpdatePurchase(NonSubscriptionPurchase(
              userId: userId,
              productId: receipt.productId ?? '',
              iapSource: IAPSource.appstore,
              orderId: receipt.originalTransactionId ?? '',
              purchaseDate: DateTime.fromMillisecondsSinceEpoch(
                  int.parse(receipt.originalPurchaseDateMs ?? '0')),
              type: product.type,
              status: NonSubscriptionStatus.completed,
            ));
            break;
          case ProductType.subscription:
            await iapRepository.createOrUpdatePurchase(SubscriptionPurchase(
              userId: userId,
              productId: receipt.productId ?? '',
              iapSource: IAPSource.appstore,
              orderId: receipt.originalTransactionId ?? '',
              purchaseDate: DateTime.fromMillisecondsSinceEpoch(
                  int.parse(receipt.originalPurchaseDateMs ?? '0')),
              type: product.type,
              expiryDate: DateTime.fromMillisecondsSinceEpoch(
                  int.parse(receipt.expiresDateMs ?? '0')),
              status: SubscriptionStatus.active,
            ));
            break;
        }
      }
      return true;
    } else {
      print('Error: Status: ${response.status}');
      return false;
    }
  }
```

Your App Store purchases should now be verified and stored in the database!

### **Run the backend**

At this point, you can run `dart bin/server.dart` to serve the `/verifypurchase` endpoint.

```
$ dart bin/server.dart 
Serving at http://0.0.0.0:8080
```

## 11\. Keep track of purchases

The recommended way to track your users' purchases is in the backend service. This is because your backend can respond to events from the store and thus is less prone to running into outdated information due to caching, as well as being less susceptible to being tampered with.

First, set up the processing of store events on the backend with the Dart backend you've been building.

## **Process store events on the backend**

Stores have the ability to inform your backend of any billing events that happen, such as when subscriptions renew. You can process these events in your backend to keep the purchases in your database current. In this section, set this up for both the Google Play Store and the Apple App Store.

### **Process Google Play billing events**

Google Play provides billing events through what they call a _cloud pub/sub topic_. These are essentially message queues that messages can be published on, as well as consumed from.

Because this is functionality specific to Google Play, you include this functionality in the `GooglePlayPurchaseHandler`.

Start by opening up `lib/google_play_purchase_handler.dart`, and adding the PubsubApi import:

### [lib/google\_play\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/lib/google_play_purchase_handler.dart)

```
import 'package:googleapis/pubsub/v1.dart' as pubsub;
```

Then, pass the `PubsubApi` to the `GooglePlayPurchaseHandler`, and modify the class constructor to create a `Timer` as follows:

### [lib/google\_play\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/lib/google_play_purchase_handler.dart)

```
class GooglePlayPurchaseHandler extends PurchaseHandler {
  final ap.AndroidPublisherApi androidPublisher;
  final IapRepository iapRepository;
  final pubsub.PubsubApi pubsubApi; // new

  GooglePlayPurchaseHandler(
    this.androidPublisher,
    this.iapRepository,
    this.pubsubApi, // new
  ) {
    // Poll messages from Pub/Sub every 10 seconds
    Timer.periodic(Duration(seconds: 10), (_) {
      _pullMessageFromPubSub();
    });
  }
```

The `Timer` is configured to call the `_pullMessageFromSubSub` method every ten seconds. You can adjust the Duration to your own preference.

Then, create the `_pullMessageFromSubSub`

### [lib/google\_play\_purchase\_handler.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/lib/google_play_purchase_handler.dart)

```
  /// Process messages from Google Play
  /// Called every 10 seconds
  Future&lt;void&gt; _pullMessageFromPubSub() async {
    print('Polling Google Play messages');
    final request = pubsub.PullRequest(
      maxMessages: 1000,
    );
    final topicName =
        'projects/$googlePlayProjectName/subscriptions/$googlePlayPubsubBillingTopic-sub';
    final pullResponse = await pubsubApi.projects.subscriptions.pull(
      request,
      topicName,
    );
    final messages = pullResponse.receivedMessages ?? [];
    for (final message in messages) {
      final data64 = message.message?.data;
      if (data64 != null) {
        await _processMessage(data64, message.ackId);
      }
    }
  }

  Future&lt;void&gt; _processMessage(String data64, String? ackId) async {
    final dataRaw = utf8.decode(base64Decode(data64));
    print('Received data: $dataRaw');
    final dynamic data = jsonDecode(dataRaw);
    if (data['testNotification'] != null) {
      print('Skip test messages');
      if (ackId != null) {
        await _ackMessage(ackId);
      }
      return;
    }
    final dynamic subscriptionNotification = data['subscriptionNotification'];
    final dynamic oneTimeProductNotification =
        data['oneTimeProductNotification'];
    if (subscriptionNotification != null) {
      print('Processing Subscription');
      final subscriptionId =
          subscriptionNotification['subscriptionId'] as String;
      final purchaseToken = subscriptionNotification['purchaseToken'] as String;
      final productData = productDataMap[subscriptionId]!;
      final result = await handleSubscription(
        userId: null,
        productData: productData,
        token: purchaseToken,
      );
      if (result &amp;&amp; ackId != null) {
        await _ackMessage(ackId);
      }
    } else if (oneTimeProductNotification != null) {
      print('Processing NonSubscription');
      final sku = oneTimeProductNotification['sku'] as String;
      final purchaseToken =
          oneTimeProductNotification['purchaseToken'] as String;
      final productData = productDataMap[sku]!;
      final result = await handleNonSubscription(
        userId: null,
        productData: productData,
        token: purchaseToken,
      );
      if (result &amp;&amp; ackId != null) {
        await _ackMessage(ackId);
      }
    } else {
      print('invalid data');
    }
  }

  /// ACK Messages from Pub/Sub
  Future&lt;void&gt; _ackMessage(String id) async {
    print('ACK Message');
    final request = pubsub.AcknowledgeRequest(
      ackIds: [id],
    );
    final subscriptionName =
        'projects/$googlePlayProjectName/subscriptions/$googlePlayPubsubBillingTopic-sub';
    await pubsubApi.projects.subscriptions.acknowledge(
      request,
      subscriptionName,
    );
  }
```

The code you just added communicates with the Pub/Sub Topic from Google Cloud every ten seconds and asks for new messages. Then, processes each message in the `_processMessage` method.

This method decodes the incoming messages and obtains the updated information about each purchase, both subscriptions and non-subscriptions, calling the existing `handleSubscription` or `handleNonSubscription` if necessary.

Each message needs to be acknowledged with the `_askMessage` method.

Next, add the required dependencies to the `server.dart` file. Add the PubsubApi.cloudPlatformScope to the credentials configuration:

### [bin/server.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/bin/server.dart)

```
 final clientGooglePlay =
      await auth.clientViaServiceAccount(clientCredentialsGooglePlay, [
    ap.AndroidPublisherApi.androidpublisherScope,
    pubsub.PubsubApi.cloudPlatformScope, // new
  ]);
```

Then, create the PubsubApi instance:

### [bin/server.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/bin/server.dart)

```
  final pubsubApi = pubsub.PubsubApi(clientGooglePlay);
```

And finally, pass it to the `GooglePlayPurchaseHandler` constructor:

### [bin/server.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/bin/server.dart)

```
  return {
    'google_play': GooglePlayPurchaseHandler(
      androidPublisher,
      iapRepository,
      pubsubApi, // new
    ),
    'app_store': AppStorePurchaseHandler(
      iapRepository,
    ),
  };
```

### **Google Play setup**

You've written the code to consume billing events from the pub/sub topic, but you haven't created the pub/sub topic, nor are you publishing any billing events. It's time to set this up.

First, create a pub/sub topic:

1.  Visit the [Cloud Pub/Sub page](https://console.cloud.google.com/cloudpubsub/topic/list) on the Google Cloud Console.
2.  Ensure that you're on your Firebase project, and click **\+ Create Topic**. ![d5ebf6897a0a8bf5.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/d5ebf6897a0a8bf5.png)
3.  Give the new topic a name, identical to the value set for `GOOGLE_PLAY_PUBSUB_BILLING_TOPIC` in `constants.ts`. In this case, name it `play_billing`. If you choose something else, make sure to update `constants.ts`. Create the topic. ![20d690fc543c4212.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/20d690fc543c4212.png)
4.  In the list of your pub/sub topics, click the three vertical dots for the topic you just created, and click **View permissions**. ![ea03308190609fb.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/ea03308190609fb.png)
5.  In the sidebar on the right, choose **Add principal**.
6.  Here, add `google-play-developer-notifications@system.gserviceaccount.com`, and grant it the role of **Pub/Sub Publisher**. ![55631ec0549215bc.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/55631ec0549215bc.png)
7.  Save the permission changes.
8.  Copy the **Topic name** of the topic you've just created.
9.  Open the Play Console again, and choose your app from the **All Apps** list.
10.  Scroll down and go to **Monetize > Monetization Setup**.
11.  Fill in the full topic and save your changes. ![7e5e875dc6ce5d54.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/7e5e875dc6ce5d54.png)

All Google Play billing events will now be published on the topic.

### **Process App Store billing events**

Next, do the same for the App Store billing events. There are two effective ways to implement handling updates in purchases for the App Store. One is by implementing a webhook that you provide to Apple and they use to communicate with your server. The second way, which is the one you will find in this codelab, is by connecting to the App Store Server API and obtaining the subscription information manually.

The reason why this codelab focuses on the second solution is because you would have to expose your server to the Internet in order to implement the webhook.

In a production environment, ideally you would like to have both. The webhook to obtain events from the App Store, and the Server API in case you missed an event or need to double check a subscription status.

Start by opening up `lib/app_store_purchase_handler.dart`, and adding the AppStoreServerAPI dependency:

[**lib/app\_store\_purchase\_handler.dart**](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/lib/app_store_purchase_handler.dart)

```
final AppStoreServerAPI appStoreServerAPI;

AppStorePurchaseHandler(
  this.iapRepository,
  this.appStoreServerAPI, // new
)
```

Modify the constructor to add a timer that will call to the `_pullStatus` method. This timer will be calling the `_pullStatus` method every 10 seconds. You can adjust this timer duration to your needs.

[**lib/app\_store\_purchase\_handler.dart**](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/lib/app_store_purchase_handler.dart)

```
  AppStorePurchaseHandler(
    this.iapRepository,
    this.appStoreServerAPI,
  ) {
    // Poll Subscription status every 10 seconds.
    Timer.periodic(Duration(seconds: 10), (_) {
      _pullStatus();
    });
  }
```

Then, create the \_pullStatus method as follows:

[**lib/app\_store\_purchase\_handler.dart**](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/lib/app_store_purchase_handler.dart)

```
  Future&lt;void&gt; _pullStatus() async {
    print('Polling App Store');
    final purchases = await iapRepository.getPurchases();
    // filter for App Store subscriptions
    final appStoreSubscriptions = purchases.where((element) =&gt;
        element.type == ProductType.subscription &amp;&amp;
        element.iapSource == IAPSource.appstore);
    for (final purchase in appStoreSubscriptions) {
      final status =
          await appStoreServerAPI.getAllSubscriptionStatuses(purchase.orderId);
      // Obtain all subscriptions for the order id.
      for (final subscription in status.data) {
        // Last transaction contains the subscription status.
        for (final transaction in subscription.lastTransactions) {
          final expirationDate = DateTime.fromMillisecondsSinceEpoch(
              transaction.transactionInfo.expiresDate ?? 0);
          // Check if subscription has expired.
          final isExpired = expirationDate.isBefore(DateTime.now());
          print('Expiration Date: $expirationDate - isExpired: $isExpired');
          // Update the subscription status with the new expiration date and status.
          await iapRepository.updatePurchase(SubscriptionPurchase(
            userId: null,
            productId: transaction.transactionInfo.productId,
            iapSource: IAPSource.appstore,
            orderId: transaction.originalTransactionId,
            purchaseDate: DateTime.fromMillisecondsSinceEpoch(
                transaction.transactionInfo.originalPurchaseDate),
            type: ProductType.subscription,
            expiryDate: expirationDate,
            status: isExpired
                ? SubscriptionStatus.expired
                : SubscriptionStatus.active,
          ));
        }
      }
    }
  }
```

This method works as follow:

1.  Obtains the list of active subscriptions from Firestore using the IapRepository.
2.  For each order, it requests the subscription status to the App Store Server API.
3.  Obtains the last transaction for that subscription purchase.
4.  Checks the expiration date.
5.  Updates the subscription status on Firestore, if it is expired it will be marked as such.

Finally, add all the necessary code to configure the App Store Server API access:

### [bin/server.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/dart-backend/bin/server.dart)

```
  // add from here
  final subscriptionKeyAppStore =
      File('assets/SubscriptionKey.p8').readAsStringSync();

  // Configure Apple Store API access
  var appStoreEnvironment = AppStoreEnvironment.sandbox(
    bundleId: bundleId,
    issuerId: appStoreIssuerId,
    keyId: appStoreKeyId,
    privateKey: subscriptionKeyAppStore,
  );

  // Stored token for Apple Store API access, if available
  final file = File('assets/appstore.token');
  String? appStoreToken;
  if (file.existsSync() &amp;&amp; file.lengthSync() &gt; 0) {
    appStoreToken = file.readAsStringSync();
  }

  final appStoreServerAPI = AppStoreServerAPI(
    AppStoreServerHttpClient(
      appStoreEnvironment,
      jwt: appStoreToken,
      jwtTokenUpdatedCallback: (token) {
        file.writeAsStringSync(token);
      },
    ),
  );
  // to here


  return {
    'google_play': GooglePlayPurchaseHandler(
      androidPublisher,
      iapRepository,
      pubsubApi,
    ),
    'app_store': AppStorePurchaseHandler(
      iapRepository,
      appStoreServerAPI, // new
    ),
  };
```

### **App Store setup**

Next, set up the App Store:

1.  Log in to [App Store Connect](https://appstoreconnect.apple.com/), and select **Users and Access**.
2.  Go to **Key Type > In-App Purchase**.
3.  Tap on the "plus" icon to add a new one.
4.  Give it a name, e.g. "Codelab key".
5.  Download the p8 file containing the key.
6.  Copy it to the assets folder, with the name `SubscriptionKey.p8`.
7.  Copy the key ID from the newly created key and set it to `appStoreKeyId` constant in the `lib/constants.dart` file.
8.  Copy the Issuer ID right at the top of the keys list, and set it to `appStoreIssuerId` constant in the `lib/constants.dart` file.

![9540ea9ada3da151.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/9540ea9ada3da151.png)

## **Track purchases on the device**

The most secure way to track your purchases is on the server side because the client is hard to secure, but you need to have some way to get the information back to the client so the app can act on the subscription status information. By storing the purchases in Firestore, you can easily sync the data to the client and keep it updated automatically.

You already included the [IAPRepo](https://github.com/flutter/codelabs/blob/master/in_app_purchases/complete/app/lib/repo/iap_repo.dart) in the app, which is the Firestore repository that contains all of the user's purchase data in `List<PastPurchase> purchases`. The repository also contains `hasActiveSubscription,` which is true when there is a purchase with `productId storeKeySubscription` with a status that is not expired. When the user isn't logged in, the list is empty.

### [lib/repo/iap\_repo.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/app/lib/repo/iap_repo.dart#L40-L70)

```
  void updatePurchases() {
    _purchaseSubscription?.cancel();
    var user = _user;
    if (user == null) {
      purchases = [];
      hasActiveSubscription = false;
      hasUpgrade = false;
      return;
    }
    var purchaseStream = _firestore
        .collection('purchases')
        .where('userId', isEqualTo: user.uid)
        .snapshots();
    _purchaseSubscription = purchaseStream.listen((snapshot) {
      purchases = snapshot.docs.map((DocumentSnapshot document) {
        var data = document.data();
        return PastPurchase.fromJson(data);
      }).toList();

      hasActiveSubscription = purchases.any((element) =&gt;
          element.productId == storeKeySubscription &amp;&amp;
          element.status != Status.expired);

      hasUpgrade = purchases.any(
        (element) =&gt; element.productId == storeKeyUpgrade,
      );

      notifyListeners();
    });
  }
```

All purchase logic is in the `DashPurchases` class and is where subscriptions should be applied or removed. So, add the `iapRepo` as a property in the class and assign the `iapRepo` in the constructor. Next, directly add a listener in the constructor, and remove the listener in the `dispose()` method. At first, the listener can just be an empty function. Because the `IAPRepo` is a `ChangeNotifier` and you call `notifyListeners()` every time the purchases in Firestore change, the `purchasesUpdate()` method is always called when the purchased products change.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/app/lib/logic/dash_purchases.dart#L26-L35)

```
  IAPRepo iapRepo;

  DashPurchases(this.counter, this.firebaseNotifier, this.iapRepo) {
    final purchaseUpdated =
        iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
    iapRepo.addListener(purchasesUpdate);
    loadPurchases();
  }

  @override
  void dispose() {
    iapRepo.removeListener(purchasesUpdate);
    _subscription.cancel();
    super.dispose();
  }

  void purchasesUpdate() {
    //TODO manage updates
  }
```

Next, supply the `IAPRepo` to the constructor in `main.dart.` You can get the repository by using `context.read` because it's already created in a `Provider`.

### [lib/main.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/app/lib/main.dart#L79-L86)

```
        ChangeNotifierProvider&lt;DashPurchases&gt;(
          create: (context) =&gt; DashPurchases(
            context.read&lt;DashCounter&gt;(),
            context.read&lt;FirebaseNotifier&gt;(),
            context.read&lt;IAPRepo&gt;(),
          ),
          lazy: false,
        ),
```

Next, write the code for the `purchaseUpdate()` function. In `dash_counter.dart,` the `applyPaidMultiplier` and `removePaidMultiplier` methods set the multiplier to 10 or 1, respectively, so you don't have to check whether the subscription is already applied. When the subscription status changes, you also update the status of the purchasable product so you can show in the purchase page that it's already active. Set the `_beautifiedDashUpgrade` property based on whether the upgrade is bought.

### [lib/logic/dash\_purchases.dart](https://github.com/flutter/codelabs/blob/main/in_app_purchases/complete/app/lib/logic/dash_purchases.dart#L146-L190)

```
void purchasesUpdate() {
    var subscriptions = &lt;PurchasableProduct&gt;[];
    var upgrades = &lt;PurchasableProduct&gt;[];
    // Get a list of purchasable products for the subscription and upgrade.
    // This should be 1 per type.
    if (products.isNotEmpty) {
      subscriptions = products
          .where((element) =&gt; element.productDetails.id == storeKeySubscription)
          .toList();
      upgrades = products
          .where((element) =&gt; element.productDetails.id == storeKeyUpgrade)
          .toList();
    }

    // Set the subscription in the counter logic and show/hide purchased on the
    // purchases page.
    if (iapRepo.hasActiveSubscription) {
      counter.applyPaidMultiplier();
      for (var element in subscriptions) {
        _updateStatus(element, ProductStatus.purchased);
      }
    } else {
      counter.removePaidMultiplier();
      for (var element in subscriptions) {
        _updateStatus(element, ProductStatus.purchasable);
      }
    }

    // Set the Dash beautifier and show/hide purchased on
    // the purchases page.
    if (iapRepo.hasUpgrade != _beautifiedDashUpgrade) {
      _beautifiedDashUpgrade = iapRepo.hasUpgrade;
      for (var element in upgrades) {
        _updateStatus(
          element,
          _beautifiedDashUpgrade
              ? ProductStatus.purchased
              : ProductStatus.purchasable);
      }
      notifyListeners();
    }
  }

  void _updateStatus(PurchasableProduct product, ProductStatus status) {
    if (product.status != ProductStatus.purchased) {
      product.status = ProductStatus.purchased;
      notifyListeners();
    }
  }
```

You have now ensured that the subscription and upgrade status is always current in the backend service and synchronized with the app. The app acts accordingly and applies the subscription and upgrade features to your Dash clicker game.

## 12\. All done!

Congratulations!!! You have completed the codelab. You can find the completed code for this codelab in the ![android_studio_folder.png](https://codelabs.developers.google.com/static/codelabs/flutter-in-app-purchases/img/a1beacb239657647.png)complete folder.

To learn more, try the other [Flutter codelabs](https://flutter.dev/docs/codelabs).

Except as otherwise noted, the content of this page is licensed under the [Creative Commons Attribution 4.0 License](https://creativecommons.org/licenses/by/4.0/), and code samples are licensed under the [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0). For details, see the [Google Developers Site Policies](https://developers.google.com/site-policies). Java is a registered trademark of Oracle and/or its affiliates.