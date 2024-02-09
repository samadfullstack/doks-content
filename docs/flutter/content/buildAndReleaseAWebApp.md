1.  [Deployment](https://docs.flutter.dev/deployment)
2.  [Web](https://docs.flutter.dev/deployment/web)

During a typical development cycle, you test an app using `flutter run -d chrome` (for example) at the command line. This builds a _debug_ version of your app.

This page helps you prepare a _release_ version of your app and covers the following topics:

-   [Building the app for release](https://docs.flutter.dev/deployment/web#building-the-app-for-release)
-   [Deploying to the web](https://docs.flutter.dev/deployment/web#deploying-to-the-web)
-   [Deploying to Firebase Hosting](https://docs.flutter.dev/deployment/web#deploying-to-firebase-hosting)
-   [Handling images on the web](https://docs.flutter.dev/deployment/web#handling-images-on-the-web)
-   [Choosing a web renderer](https://docs.flutter.dev/deployment/web#choosing-a-web-renderer)
-   [Minification](https://docs.flutter.dev/deployment/web#minification)

## Building the app for release

Build the app for deployment using the `flutter build web` command. You can also choose which renderer to use by using the `--web-renderer` option (See [Web renderers](https://docs.flutter.dev/platform-integration/web/renderers)). This generates the app, including the assets, and places the files into the `/build/web` directory of the project.

The release build of a simple app has the following structure:

```none
/build/web assets AssetManifest.json FontManifest.json NOTICES fonts MaterialIcons-Regular.ttf <other font files> <image files> packages cupertino_icons assets CupertinoIcons.ttf shaders ink_sparkle.frag canvaskit canvaskit.js canvaskit.wasm profiling canvaskit.js canvaskit.wasm favicon.png flutter.js flutter_service_worker.js index.html main.dart.js manifest.json version.json
```

Launch a web server (for example, `python -m http.server 8000`, or by using the [dhttpd](https://pub.dev/packages/dhttpd) package), and open the /build/web directory. Navigate to `localhost:8000` in your browser (given the python SimpleHTTPServer example) to view the release version of your app.

## Deploying to the web

When you are ready to deploy your app, upload the release bundle to Firebase, the cloud, or a similar service. Here are a few possibilities, but there are many others:

-   [Firebase Hosting](https://firebase.google.com/docs/hosting/frameworks/flutter)
-   [GitHub Pages](https://pages.github.com/)
-   [Google Cloud Hosting](https://cloud.google.com/solutions/web-hosting)

## Deploying to Firebase Hosting

You can use the Firebase CLI to build and release your Flutter app with Firebase Hosting.

### Before you begin

To get started, [install or update](https://firebase.google.com/docs/cli#install_the_firebase_cli) the Firebase CLI:

```
npm install -g firebase-tools
```

### Initialize Firebase

1.  Enable the web frameworks preview to the [Firebase framework-aware CLI](https://firebase.google.com/docs/hosting/frameworks/frameworks-overview):
    
    ```
     firebase experiments:enable webframeworks
    ```
    
2.  In an empty directory or an existing Flutter project, run the initialization command:
    
3.  Answer `yes` when asked if you want to use a web framework.
    
4.  If you’re in an empty directory, you’ll be asked to choose your web framework. Choose `Flutter Web`.
    
5.  Choose your hosting source directory; this could be an existing flutter app.
    
6.  Select a region to host your files.
    
7.  Choose whether to set up automatic builds and deploys with GitHub.
    
8.  Deploy the app to Firebase Hosting:
    
    Running this command automatically runs `flutter build web --release`, so you don’t have to build your app in a separate step.
    

To learn more, visit the official [Firebase Hosting](https://firebase.google.com/docs/hosting/frameworks/flutter) documentation for Flutter on the web.

## Handling images on the web

The web supports the standard `Image` widget to display images. By design, web browsers run untrusted code without harming the host computer. This limits what you can do with images compared to mobile and desktop platforms.

For more information, see [Displaying images on the web](https://docs.flutter.dev/platform-integration/web/web-images).

## Choosing a web renderer

By default, the `flutter build` and `flutter run` commands use the `auto` choice for the web renderer. This means that your app runs with the HTML renderer on mobile browsers and CanvasKit on desktop browsers. We recommend this combination to optimize for the characteristics of each platform.

For more information, see [Web renderers](https://docs.flutter.dev/platform-integration/web/renderers).

## Minification

Minification is handled for you when you create a release build.

| Type of web app build | Code minified? | Tree shaking performed? |
| --- | --- | --- |
| debug | No | No |
| profile | No | Yes |
| release | Yes | Yes |

## Embedding a Flutter app into an HTML page

### `hostElement`

_Added in Flutter 3.10_  
You can embed a Flutter web app into any HTML element of your web page, with `flutter.js` and the `hostElement` engine initialization parameter.

To tell Flutter web in which element to render, use the `hostElement` parameter of the `initializeEngine` function:

```
<span>&lt;html&gt;</span>
  <span>&lt;head&gt;</span>
    <span>&lt;!-- ... --&gt;</span>
    <span>&lt;script </span><span>src=</span><span>"flutter.js"</span> <span>defer</span><span>&gt;&lt;/script&gt;</span>
  <span>&lt;/head&gt;</span>
  <span>&lt;body&gt;</span>

    <span>&lt;!-- Ensure your flutter target is present on the page... --&gt;</span>
    <span>&lt;div</span> <span>id=</span><span>"flutter_host"</span><span>&gt;</span>Loading...<span>&lt;/div&gt;</span>

    <span>&lt;script&gt;</span>
      <span>window</span><span>.</span><span>addEventListener</span><span>(</span><span>"</span><span>load</span><span>"</span><span>,</span> <span>function </span><span>(</span><span>ev</span><span>)</span> <span>{</span>
        <span>_flutter</span><span>.</span><span>loader</span><span>.</span><span>loadEntrypoint</span><span>({</span>
          <span>onEntrypointLoaded</span><span>:</span> <span>async</span> <span>function</span><span>(</span><span>engineInitializer</span><span>)</span> <span>{</span>
            <span>let</span> <span>appRunner</span> <span>=</span> <span>await</span> <span>engineInitializer</span><span>.</span><span>initializeEngine</span><span>({</span>
              <span>// Pass a reference to "div#flutter_host" into the Flutter engine.</span>
              <span>hostElement</span><span>:</span> <span>document</span><span>.</span><span>querySelector</span><span>(</span><span>"</span><span>#flutter_host</span><span>"</span><span>)</span>
            <span>});</span>
            <span>await</span> <span>appRunner</span><span>.</span><span>runApp</span><span>();</span>
          <span>}</span>
        <span>});</span>
      <span>});</span>
    <span>&lt;/script&gt;</span>
  <span>&lt;/body&gt;</span>
<span>&lt;/html&gt;</span>
```

To learn more, check out [Customizing web app initialization](https://docs.flutter.dev/platform-integration/web/initialization).

### Iframe

You can embed a Flutter web app, as you would embed other content, in an [`iframe`](https://html.com/tags/iframe/) tag of an HTML file. In the following example, replace “URL” with the location of your HTML page:

```
<span>&lt;iframe</span> <span>src=</span><span>"URL"</span><span>&gt;&lt;/iframe&gt;</span>
```

## PWA Support

As of release 1.20, the Flutter template for web apps includes support for the core features needed for an installable, offline-capable PWA app. Flutter-based PWAs can be installed in the same way as any other web-based PWA; the settings signaling that your Flutter app is a PWA are provided by `manifest.json`, which is produced by `flutter create` in the `web` directory.

PWA support remains a work in progress, so please [give us feedback](https://github.com/flutter/flutter/issues/new?title=%5Bweb%5D:+%3Cdescribe+issue+here%3E&labels=%E2%98%B8+platform-web&body=Describe+your+issue+and+include+the+command+you%27re+running,+flutter_web%20version,+browser+version) if you see something that doesn’t look right.